FROM perl:latest
WORKDIR /app
COPY app/legacy.pl .
RUN chmod +x legacy.pl
EXPOSE 8080
CMD ["./legacy.pl"]