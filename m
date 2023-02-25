Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB56A27AE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 08:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBYHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 02:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBYHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 02:12:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538265310;
        Fri, 24 Feb 2023 23:12:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l1so1341086wry.10;
        Fri, 24 Feb 2023 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0UVr4TwixNmfPAgEyIxYa6BqMtNmMF1rg/E2Nd5LV0=;
        b=ZO/V4DQl1SHp0wRos6XiUnRGU+CMruSmCrq7umACuSqpql9zkXBcqjSh5VOtqGjVwB
         7eCu1dQCxEO+L5ygEl0F2r/828J2zU/sIl07eQnnHlUoiwk/0Wbp2SzWqUcH2A6HO6sO
         3eYdvRxmgDyq2ZU7luacTYvMvm/SnBDuVJmX9lcJUVYFRb4IxIMncw7zTXGKWvRblQnA
         KK+xEeTKOU5ScHYUVB9Gv56++o+uEw4WWEfzFYdwu3cDQUwnGjiFEq61Q82x0bUwbFOw
         HPbkrd5RJSryePuAQEoO0hbDztNLLZdJ7cFZjOAFXH9xZwdhwe/dWc/lT2NhfaT7jw7r
         buLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0UVr4TwixNmfPAgEyIxYa6BqMtNmMF1rg/E2Nd5LV0=;
        b=WvQPdIGPJmgM8dOOJjulnELHfFmPgBc58ZRrJn3Z1CzphL4i86o0fpX2/UTtOeHtAH
         popIfO3ZAqrimgZnmpfMh754Zv6EEJSOzfFlhEEPLSVNhr/9WXyoX/eg5Yg0QGY5chu0
         xqb4qal9HlniH0xusmuIL1tQTXmv/IPjKmuIY/h5by6+tQWA2cvSg2ch/KcGk1DzAvtC
         5duP5YP0RFvijktYdEr8lDGnz65I6mxfYfbRI4cUdzMY9KMRh8QLgY436zfZrsHGpYwx
         hXclx58rFlXYZKp+W+QghnABJw5moMqgemWuhFipXnLOO0QVBUtF9VnC0KT6ixtuC4AR
         nOPg==
X-Gm-Message-State: AO0yUKVbpZloupYWR+eU9Cu61dYWrV4DcUsdAglm/Ettv3lhdOqeYu1O
        53b16KWzgMGRPQiAbTfV7OM=
X-Google-Smtp-Source: AK7set8Fjo2IY1138oM9Sy9xeSHLLXNyNMYb226aG2fdN/6L7NDwrl6u8rwyIemJvIE4NtMbbXqXsw==
X-Received: by 2002:a05:6000:144e:b0:2c9:8795:388e with SMTP id v14-20020a056000144e00b002c98795388emr348340wrx.26.1677309164249;
        Fri, 24 Feb 2023 23:12:44 -0800 (PST)
Received: from localhost.localdomain ([20.208.58.248])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4521000000b002c573cff730sm913798wra.68.2023.02.24.23.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 23:12:43 -0800 (PST)
From:   Nikita Romanyuk <ufh8945@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvium@yahoo.com, Nikita Romanyuk <ufh8945@gmail.com>
Subject: [PATCH 1/2] drivers: video: logo: fix code style issues in pnmtologo.c
Date:   Sat, 25 Feb 2023 10:12:28 +0300
Message-Id: <20230225071230.11494-1-ufh8945@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nikita Romanyuk <ufh8945@gmail.com>
---
 drivers/video/logo/pnmtologo.c | 667 +++++++++++++++++----------------
 1 file changed, 334 insertions(+), 333 deletions(-)

diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
index 4718d7895..7e7cb4210 100644
--- a/drivers/video/logo/pnmtologo.c
+++ b/drivers/video/logo/pnmtologo.c
@@ -1,4 +1,3 @@
-
 /*
  *  Convert a logo in ASCII PNM format to C source suitable for inclusion in
  *  the Linux kernel
@@ -34,37 +33,37 @@ static FILE *out;
 #define LINUX_LOGO_GRAY256	4	/* 256 levels grayscale */
 
 static const char *logo_types[LINUX_LOGO_GRAY256+1] = {
-    [LINUX_LOGO_MONO] = "LINUX_LOGO_MONO",
-    [LINUX_LOGO_VGA16] = "LINUX_LOGO_VGA16",
-    [LINUX_LOGO_CLUT224] = "LINUX_LOGO_CLUT224",
-    [LINUX_LOGO_GRAY256] = "LINUX_LOGO_GRAY256"
+	[LINUX_LOGO_MONO] = "LINUX_LOGO_MONO",
+	[LINUX_LOGO_VGA16] = "LINUX_LOGO_VGA16",
+	[LINUX_LOGO_CLUT224] = "LINUX_LOGO_CLUT224",
+	[LINUX_LOGO_GRAY256] = "LINUX_LOGO_GRAY256"
 };
 
 #define MAX_LINUX_LOGO_COLORS	224
 
 struct color {
-    unsigned char red;
-    unsigned char green;
-    unsigned char blue;
+	unsigned char red;
+	unsigned char green;
+	unsigned char blue;
 };
 
 static const struct color clut_vga16[16] = {
-    { 0x00, 0x00, 0x00 },
-    { 0x00, 0x00, 0xaa },
-    { 0x00, 0xaa, 0x00 },
-    { 0x00, 0xaa, 0xaa },
-    { 0xaa, 0x00, 0x00 },
-    { 0xaa, 0x00, 0xaa },
-    { 0xaa, 0x55, 0x00 },
-    { 0xaa, 0xaa, 0xaa },
-    { 0x55, 0x55, 0x55 },
-    { 0x55, 0x55, 0xff },
-    { 0x55, 0xff, 0x55 },
-    { 0x55, 0xff, 0xff },
-    { 0xff, 0x55, 0x55 },
-    { 0xff, 0x55, 0xff },
-    { 0xff, 0xff, 0x55 },
-    { 0xff, 0xff, 0xff },
+	{ 0x00, 0x00, 0x00 },
+	{ 0x00, 0x00, 0xaa },
+	{ 0x00, 0xaa, 0x00 },
+	{ 0x00, 0xaa, 0xaa },
+	{ 0xaa, 0x00, 0x00 },
+	{ 0xaa, 0x00, 0xaa },
+	{ 0xaa, 0x55, 0x00 },
+	{ 0xaa, 0xaa, 0xaa },
+	{ 0x55, 0x55, 0x55 },
+	{ 0x55, 0x55, 0xff },
+	{ 0x55, 0xff, 0x55 },
+	{ 0x55, 0xff, 0xff },
+	{ 0xff, 0x55, 0x55 },
+	{ 0xff, 0x55, 0xff },
+	{ 0xff, 0xff, 0x55 },
+	{ 0xff, 0xff, 0xff },
 };
 
 
@@ -77,438 +76,440 @@ static unsigned int logo_clutsize;
 static int is_plain_pbm = 0;
 
 static void die(const char *fmt, ...)
-    __attribute__ ((noreturn)) __attribute ((format (printf, 1, 2)));
-static void usage(void) __attribute ((noreturn));
+__attribute__((noreturn)) __attribute((format (printf, 1, 2)));
+static void usage(void) __attribute((noreturn));
 
 
 static unsigned int get_number(FILE *fp)
 {
-    int c, val;
-
-    /* Skip leading whitespace */
-    do {
-	c = fgetc(fp);
-	if (c == EOF)
-	    die("%s: end of file\n", filename);
-	if (c == '#') {
-	    /* Ignore comments 'till end of line */
-	    do {
+	int c, val;
+
+	/* Skip leading whitespace */
+	do {
+		c = fgetc(fp);
+		if (c == EOF)
+			die("%s: end of file\n", filename);
+		if (c == '#') {
+			/* Ignore comments 'till end of line */
+			do {
+				c = fgetc(fp);
+				if (c == EOF)
+					die("%s: end of file\n", filename);
+			} while (c != '\n');
+		}
+	} while (isspace(c));
+
+	/* Parse decimal number */
+	val = 0;
+	while (isdigit(c)) {
+		val = 10*val+c-'0';
+		/* some PBM are 'broken'; GiMP for example exports a PBM without space
+		 * between the digits. This is Ok cause we know a PBM can only have a '1'
+		 * or a '0' for the digit.
+		 */
+		if (is_plain_pbm)
+			break;
 		c = fgetc(fp);
 		if (c == EOF)
-		    die("%s: end of file\n", filename);
-	    } while (c != '\n');
+			die("%s: end of file\n", filename);
 	}
-    } while (isspace(c));
-
-    /* Parse decimal number */
-    val = 0;
-    while (isdigit(c)) {
-	val = 10*val+c-'0';
-	/* some PBM are 'broken'; GiMP for example exports a PBM without space
-	 * between the digits. This is Ok cause we know a PBM can only have a '1'
-	 * or a '0' for the digit. */
-	if (is_plain_pbm)
-		break;
-	c = fgetc(fp);
-	if (c == EOF)
-	    die("%s: end of file\n", filename);
-    }
-    return val;
+	return val;
 }
 
 static unsigned int get_number255(FILE *fp, unsigned int maxval)
 {
-    unsigned int val = get_number(fp);
-    return (255*val+maxval/2)/maxval;
+	unsigned int val = get_number(fp);
+
+	return (255*val+maxval/2)/maxval;
 }
 
 static void read_image(void)
 {
-    FILE *fp;
-    unsigned int i, j;
-    int magic;
-    unsigned int maxval;
-
-    /* open image file */
-    fp = fopen(filename, "r");
-    if (!fp)
-	die("Cannot open file %s: %s\n", filename, strerror(errno));
-
-    /* check file type and read file header */
-    magic = fgetc(fp);
-    if (magic != 'P')
-	die("%s is not a PNM file\n", filename);
-    magic = fgetc(fp);
-    switch (magic) {
+	FILE *fp;
+	unsigned int i, j;
+	int magic;
+	unsigned int maxval;
+
+	/* open image file */
+	fp = fopen(filename, "r");
+	if (!fp)
+		die("Cannot open file %s: %s\n", filename, strerror(errno));
+
+	/* check file type and read file header */
+	magic = fgetc(fp);
+	if (magic != 'P')
+		die("%s is not a PNM file\n", filename);
+	magic = fgetc(fp);
+	switch (magic) {
 	case '1':
 	case '2':
 	case '3':
-	    /* Plain PBM/PGM/PPM */
-	    break;
+		/* Plain PBM/PGM/PPM */
+		break;
 
 	case '4':
 	case '5':
 	case '6':
-	    /* Binary PBM/PGM/PPM */
-	    die("%s: Binary PNM is not supported\n"
+		/* Binary PBM/PGM/PPM */
+		die("%s: Binary PNM is not supported\n"
 		"Use pnmnoraw(1) to convert it to ASCII PNM\n", filename);
 
 	default:
-	    die("%s is not a PNM file\n", filename);
-    }
-    logo_width = get_number(fp);
-    logo_height = get_number(fp);
-
-    /* allocate image data */
-    logo_data = (struct color **)malloc(logo_height*sizeof(struct color *));
-    if (!logo_data)
-	die("%s\n", strerror(errno));
-    for (i = 0; i < logo_height; i++) {
-	logo_data[i] = malloc(logo_width*sizeof(struct color));
+		die("%s is not a PNM file\n", filename);
+	}
+	logo_width = get_number(fp);
+	logo_height = get_number(fp);
+
+	/* allocate image data */
+	logo_data = (struct color **)malloc(logo_height*sizeof(struct color *));
+	if (!logo_data)
+		die("%s\n", strerror(errno));
+	for (i = 0; i < logo_height; i++) {
+		logo_data[i] = malloc(logo_width*sizeof(struct color));
 	if (!logo_data[i])
-	    die("%s\n", strerror(errno));
-    }
+		die("%s\n", strerror(errno));
+	}
 
-    /* read image data */
-    switch (magic) {
+	/* read image data */
+	switch (magic) {
 	case '1':
-	    /* Plain PBM */
-	    is_plain_pbm = 1;
-	    for (i = 0; i < logo_height; i++)
-		for (j = 0; j < logo_width; j++)
-		    logo_data[i][j].red = logo_data[i][j].green =
-			logo_data[i][j].blue = 255*(1-get_number(fp));
-	    break;
+		/* Plain PBM */
+		is_plain_pbm = 1;
+		for (i = 0; i < logo_height; i++)
+			for (j = 0; j < logo_width; j++)
+				logo_data[i][j].red = logo_data[i][j].green =
+					logo_data[i][j].blue = 255*(1-get_number(fp));
+		break;
 
 	case '2':
-	    /* Plain PGM */
-	    maxval = get_number(fp);
-	    for (i = 0; i < logo_height; i++)
-		for (j = 0; j < logo_width; j++)
-		    logo_data[i][j].red = logo_data[i][j].green =
-			logo_data[i][j].blue = get_number255(fp, maxval);
-	    break;
+		/* Plain PGM */
+		maxval = get_number(fp);
+		for (i = 0; i < logo_height; i++)
+			for (j = 0; j < logo_width; j++)
+				logo_data[i][j].red = logo_data[i][j].green =
+					logo_data[i][j].blue = get_number255(fp, maxval);
+		break;
 
 	case '3':
-	    /* Plain PPM */
-	    maxval = get_number(fp);
-	    for (i = 0; i < logo_height; i++)
-		for (j = 0; j < logo_width; j++) {
-		    logo_data[i][j].red = get_number255(fp, maxval);
-		    logo_data[i][j].green = get_number255(fp, maxval);
-		    logo_data[i][j].blue = get_number255(fp, maxval);
-		}
-	    break;
-    }
+		/* Plain PPM */
+		maxval = get_number(fp);
+		for (i = 0; i < logo_height; i++)
+			for (j = 0; j < logo_width; j++) {
+				logo_data[i][j].red = get_number255(fp, maxval);
+				logo_data[i][j].green = get_number255(fp, maxval);
+				logo_data[i][j].blue = get_number255(fp, maxval);
+			}
+		break;
+	}
 
-    /* close file */
-    fclose(fp);
+	/* close file */
+	fclose(fp);
 }
 
 static inline int is_black(struct color c)
 {
-    return c.red == 0 && c.green == 0 && c.blue == 0;
+	return c.red == 0 && c.green == 0 && c.blue == 0;
 }
 
 static inline int is_white(struct color c)
 {
-    return c.red == 255 && c.green == 255 && c.blue == 255;
+	return c.red == 255 && c.green == 255 && c.blue == 255;
 }
 
 static inline int is_gray(struct color c)
 {
-    return c.red == c.green && c.red == c.blue;
+	return c.red == c.green && c.red == c.blue;
 }
 
 static inline int is_equal(struct color c1, struct color c2)
 {
-    return c1.red == c2.red && c1.green == c2.green && c1.blue == c2.blue;
+	return c1.red == c2.red && c1.green == c2.green && c1.blue == c2.blue;
 }
 
 static void write_header(void)
 {
-    /* open logo file */
-    if (outputname) {
-	out = fopen(outputname, "w");
-	if (!out)
-	    die("Cannot create file %s: %s\n", outputname, strerror(errno));
-    } else {
-	out = stdout;
-    }
-
-    fputs("/*\n", out);
-    fputs(" *  DO NOT EDIT THIS FILE!\n", out);
-    fputs(" *\n", out);
-    fprintf(out, " *  It was automatically generated from %s\n", filename);
-    fputs(" *\n", out);
-    fprintf(out, " *  Linux logo %s\n", logoname);
-    fputs(" */\n\n", out);
-    fputs("#include <linux/linux_logo.h>\n\n", out);
-    fprintf(out, "static unsigned char %s_data[] __initdata = {\n",
-	    logoname);
+	/* open logo file */
+	if (outputname) {
+		out = fopen(outputname, "w");
+		if (!out)
+			die("Cannot create file %s: %s\n", outputname, strerror(errno));
+	} else {
+		out = stdout;
+	}
+
+	fputs("/*\n", out);
+	fputs(" *  DO NOT EDIT THIS FILE!\n", out);
+	fputs(" *\n", out);
+	fprintf(out, " *  It was automatically generated from %s\n", filename);
+	fputs(" *\n", out);
+	fprintf(out, " *  Linux logo %s\n", logoname);
+	fputs(" */\n\n", out);
+	fputs("#include <linux/linux_logo.h>\n\n", out);
+	fprintf(out, "static unsigned char %s_data[] __initdata = {\n",
+		logoname);
 }
 
 static void write_footer(void)
 {
-    fputs("\n};\n\n", out);
-    fprintf(out, "const struct linux_logo %s __initconst = {\n", logoname);
-    fprintf(out, "\t.type\t\t= %s,\n", logo_types[logo_type]);
-    fprintf(out, "\t.width\t\t= %d,\n", logo_width);
-    fprintf(out, "\t.height\t\t= %d,\n", logo_height);
-    if (logo_type == LINUX_LOGO_CLUT224) {
-	fprintf(out, "\t.clutsize\t= %d,\n", logo_clutsize);
-	fprintf(out, "\t.clut\t\t= %s_clut,\n", logoname);
-    }
-    fprintf(out, "\t.data\t\t= %s_data\n", logoname);
-    fputs("};\n\n", out);
-
-    /* close logo file */
-    if (outputname)
-	fclose(out);
+	fputs("\n};\n\n", out);
+	fprintf(out, "const struct linux_logo %s __initconst = {\n", logoname);
+	fprintf(out, "\t.type\t\t= %s,\n", logo_types[logo_type]);
+	fprintf(out, "\t.width\t\t= %d,\n", logo_width);
+	fprintf(out, "\t.height\t\t= %d,\n", logo_height);
+	if (logo_type == LINUX_LOGO_CLUT224) {
+		fprintf(out, "\t.clutsize\t= %d,\n", logo_clutsize);
+		fprintf(out, "\t.clut\t\t= %s_clut,\n", logoname);
+	}
+	fprintf(out, "\t.data\t\t= %s_data\n", logoname);
+	fputs("};\n\n", out);
+
+	/* close logo file */
+	if (outputname)
+		fclose(out);
 }
 
 static int write_hex_cnt;
 
 static void write_hex(unsigned char byte)
 {
-    if (write_hex_cnt % 12)
-	fprintf(out, ", 0x%02x", byte);
-    else if (write_hex_cnt)
-	fprintf(out, ",\n\t0x%02x", byte);
-    else
-	fprintf(out, "\t0x%02x", byte);
-    write_hex_cnt++;
+	if (write_hex_cnt % 12)
+		fprintf(out, ", 0x%02x", byte);
+	else if (write_hex_cnt)
+		fprintf(out, ",\n\t0x%02x", byte);
+	else
+		fprintf(out, "\t0x%02x", byte);
+	write_hex_cnt++;
 }
 
 static void write_logo_mono(void)
 {
-    unsigned int i, j;
-    unsigned char val, bit;
-
-    /* validate image */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++)
-	    if (!is_black(logo_data[i][j]) && !is_white(logo_data[i][j]))
-		die("Image must be monochrome\n");
-
-    /* write file header */
-    write_header();
-
-    /* write logo data */
-    for (i = 0; i < logo_height; i++) {
-	for (j = 0; j < logo_width;) {
-	    for (val = 0, bit = 0x80; bit && j < logo_width; j++, bit >>= 1)
-		if (logo_data[i][j].red)
-		    val |= bit;
-	    write_hex(val);
+	unsigned int i, j;
+	unsigned char val, bit;
+
+	/* validate image */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++)
+			if (!is_black(logo_data[i][j]) && !is_white(logo_data[i][j]))
+				die("Image must be monochrome\n");
+
+	/* write file header */
+	write_header();
+
+	/* write logo data */
+	for (i = 0; i < logo_height; i++) {
+		for (j = 0; j < logo_width;) {
+			for (val = 0, bit = 0x80; bit && j < logo_width; j++, bit >>= 1)
+				if (logo_data[i][j].red)
+					val |= bit;
+			write_hex(val);
+		}
 	}
-    }
 
-    /* write logo structure and file footer */
-    write_footer();
+	/* write logo structure and file footer */
+	write_footer();
 }
 
 static void write_logo_vga16(void)
 {
-    unsigned int i, j, k;
-    unsigned char val;
-
-    /* validate image */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++) {
-	    for (k = 0; k < 16; k++)
-		if (is_equal(logo_data[i][j], clut_vga16[k]))
-		    break;
-	    if (k == 16)
-		die("Image must use the 16 console colors only\n"
-		    "Use ppmquant(1) -map clut_vga16.ppm to reduce the number "
-		    "of colors\n");
-	}
+	unsigned int i, j, k;
+	unsigned char val;
 
-    /* write file header */
-    write_header();
-
-    /* write logo data */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++) {
-	    for (k = 0; k < 16; k++)
-		if (is_equal(logo_data[i][j], clut_vga16[k]))
-		    break;
-	    val = k<<4;
-	    if (++j < logo_width) {
-		for (k = 0; k < 16; k++)
-		    if (is_equal(logo_data[i][j], clut_vga16[k]))
-			break;
-		val |= k;
-	    }
-	    write_hex(val);
-	}
+	/* validate image */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++) {
+			for (k = 0; k < 16; k++)
+				if (is_equal(logo_data[i][j], clut_vga16[k]))
+					break;
+			if (k == 16)
+				die("Image must use the 16 console colors only\n"
+				    "Use ppmquant(1) -map clut_vga16.ppm to reduce the number "
+				    "of colors\n");
+		}
+
+	/* write file header */
+	write_header();
 
-    /* write logo structure and file footer */
-    write_footer();
+	/* write logo data */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++) {
+			for (k = 0; k < 16; k++)
+				if (is_equal(logo_data[i][j], clut_vga16[k]))
+					break;
+			val = k<<4;
+			if (++j < logo_width) {
+				for (k = 0; k < 16; k++)
+					if (is_equal(logo_data[i][j], clut_vga16[k]))
+						break;
+				val |= k;
+			}
+			write_hex(val);
+		}
+
+	/* write logo structure and file footer */
+	write_footer();
 }
 
 static void write_logo_clut224(void)
 {
-    unsigned int i, j, k;
-
-    /* validate image */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++) {
-	    for (k = 0; k < logo_clutsize; k++)
-		if (is_equal(logo_data[i][j], logo_clut[k]))
-		    break;
-	    if (k == logo_clutsize) {
-		if (logo_clutsize == MAX_LINUX_LOGO_COLORS)
-		    die("Image has more than %d colors\n"
-			"Use ppmquant(1) to reduce the number of colors\n",
-			MAX_LINUX_LOGO_COLORS);
-		logo_clut[logo_clutsize++] = logo_data[i][j];
-	    }
-	}
+	unsigned int i, j, k;
 
-    /* write file header */
-    write_header();
+	/* validate image */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++) {
+			for (k = 0; k < logo_clutsize; k++)
+				if (is_equal(logo_data[i][j], logo_clut[k]))
+					break;
+			if (k == logo_clutsize) {
+				if (logo_clutsize == MAX_LINUX_LOGO_COLORS)
+					die("Image has more than %d colors\n"
+					    "Use ppmquant(1) to reduce the number of colors\n",
+					    MAX_LINUX_LOGO_COLORS);
+				logo_clut[logo_clutsize++] = logo_data[i][j];
+			}
+		}
 
-    /* write logo data */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++) {
-	    for (k = 0; k < logo_clutsize; k++)
-		if (is_equal(logo_data[i][j], logo_clut[k]))
-		    break;
-	    write_hex(k+32);
+	/* write file header */
+	write_header();
+
+	/* write logo data */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++) {
+			for (k = 0; k < logo_clutsize; k++)
+				if (is_equal(logo_data[i][j], logo_clut[k]))
+					break;
+			write_hex(k+32);
+		}
+	fputs("\n};\n\n", out);
+
+	/* write logo clut */
+	fprintf(out, "static unsigned char %s_clut[] __initdata = {\n",
+		logoname);
+	write_hex_cnt = 0;
+	for (i = 0; i < logo_clutsize; i++) {
+		write_hex(logo_clut[i].red);
+		write_hex(logo_clut[i].green);
+		write_hex(logo_clut[i].blue);
 	}
-    fputs("\n};\n\n", out);
-
-    /* write logo clut */
-    fprintf(out, "static unsigned char %s_clut[] __initdata = {\n",
-	    logoname);
-    write_hex_cnt = 0;
-    for (i = 0; i < logo_clutsize; i++) {
-	write_hex(logo_clut[i].red);
-	write_hex(logo_clut[i].green);
-	write_hex(logo_clut[i].blue);
-    }
-
-    /* write logo structure and file footer */
-    write_footer();
+
+	/* write logo structure and file footer */
+	write_footer();
 }
 
 static void write_logo_gray256(void)
 {
-    unsigned int i, j;
+	unsigned int i, j;
 
-    /* validate image */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++)
-	    if (!is_gray(logo_data[i][j]))
-		die("Image must be grayscale\n");
+	/* validate image */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++)
+			if (!is_gray(logo_data[i][j]))
+				die("Image must be grayscale\n");
 
-    /* write file header */
-    write_header();
+	/* write file header */
+	write_header();
 
-    /* write logo data */
-    for (i = 0; i < logo_height; i++)
-	for (j = 0; j < logo_width; j++)
-	    write_hex(logo_data[i][j].red);
+	/* write logo data */
+	for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++)
+			write_hex(logo_data[i][j].red);
 
-    /* write logo structure and file footer */
-    write_footer();
+	/* write logo structure and file footer */
+	write_footer();
 }
 
 static void die(const char *fmt, ...)
 {
-    va_list ap;
+	va_list ap;
 
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
 
-    exit(1);
+	exit(1);
 }
 
 static void usage(void)
 {
-    die("\n"
+	die("\n"
 	"Usage: %s [options] <filename>\n"
 	"\n"
 	"Valid options:\n"
-	"    -h          : display this usage information\n"
-	"    -n <name>   : specify logo name (default: linux_logo)\n"
-	"    -o <output> : output to file <output> instead of stdout\n"
-	"    -t <type>   : specify logo type, one of\n"
-	"                      mono    : monochrome black/white\n"
-	"                      vga16   : 16 colors VGA text palette\n"
-	"                      clut224 : 224 colors (default)\n"
-	"                      gray256 : 256 levels grayscale\n"
+	"	-h		  : display this usage information\n"
+	"	-n <name>   : specify logo name (default: linux_logo)\n"
+	"	-o <output> : output to file <output> instead of stdout\n"
+	"	-t <type>   : specify logo type, one of\n"
+	"					  mono	: monochrome black/white\n"
+	"					  vga16   : 16 colors VGA text palette\n"
+	"					  clut224 : 224 colors (default)\n"
+	"					  gray256 : 256 levels grayscale\n"
 	"\n", programname);
 }
 
 int main(int argc, char *argv[])
 {
-    int opt;
+	int opt;
 
-    programname = argv[0];
+	programname = argv[0];
 
-    opterr = 0;
-    while (1) {
-	opt = getopt(argc, argv, "hn:o:t:");
-	if (opt == -1)
-	    break;
+	opterr = 0;
+	while (1) {
+		opt = getopt(argc, argv, "hn:o:t:");
+		if (opt == -1)
+			break;
 
-	switch (opt) {
-	    case 'h':
-		usage();
-		break;
+		switch (opt) {
+		case 'h':
+			usage();
+			break;
 
-	    case 'n':
-		logoname = optarg;
-		break;
+		case 'n':
+			logoname = optarg;
+			break;
 
-	    case 'o':
-		outputname = optarg;
-		break;
+		case 'o':
+			outputname = optarg;
+			break;
 
-	    case 't':
-		if (!strcmp(optarg, "mono"))
-		    logo_type = LINUX_LOGO_MONO;
-		else if (!strcmp(optarg, "vga16"))
-		    logo_type = LINUX_LOGO_VGA16;
-		else if (!strcmp(optarg, "clut224"))
-		    logo_type = LINUX_LOGO_CLUT224;
-		else if (!strcmp(optarg, "gray256"))
-		    logo_type = LINUX_LOGO_GRAY256;
-		else
-		    usage();
-		break;
+		case 't':
+			if (!strcmp(optarg, "mono"))
+				logo_type = LINUX_LOGO_MONO;
+			else if (!strcmp(optarg, "vga16"))
+				logo_type = LINUX_LOGO_VGA16;
+			else if (!strcmp(optarg, "clut224"))
+				logo_type = LINUX_LOGO_CLUT224;
+			else if (!strcmp(optarg, "gray256"))
+				logo_type = LINUX_LOGO_GRAY256;
+			else
+				usage();
+			break;
 
-	    default:
-		usage();
-		break;
+			default:
+			usage();
+			break;
+		}
 	}
-    }
-    if (optind != argc-1)
-	usage();
+	if (optind != argc-1)
+		usage();
 
-    filename = argv[optind];
+	filename = argv[optind];
 
-    read_image();
-    switch (logo_type) {
+	read_image();
+	switch (logo_type) {
 	case LINUX_LOGO_MONO:
-	    write_logo_mono();
-	    break;
+		write_logo_mono();
+		break;
 
 	case LINUX_LOGO_VGA16:
-	    write_logo_vga16();
-	    break;
+		write_logo_vga16();
+		break;
 
 	case LINUX_LOGO_CLUT224:
-	    write_logo_clut224();
-	    break;
+		write_logo_clut224();
+		break;
 
 	case LINUX_LOGO_GRAY256:
-	    write_logo_gray256();
-	    break;
-    }
-    exit(0);
+		write_logo_gray256();
+		break;
+	}
+	exit(0);
 }
-- 
2.39.2

