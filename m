Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2069E58F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjBURI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjBURIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920726CCE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g14so5753646pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5YnbVhIsrhqUArt5FEu+tfNMyO/9CJDQK2nD3tFrnE=;
        b=f4YzRPKLP+Zio3ozAL0gcjuYhTyTfaa1TCNewMUng3VTuWQU74XbPlZ5z1gLpddC+6
         D/YH3umzEenUbCfzL0/Mb31hGEWO24I/DVhmYqffT302nUfzTPopfU0Ay18BenPsTCsk
         e45gJW+9IcHyDejNrZkZIxVGAVI1WhLH4y1+/+gGJEld0HCHj3oIp8/PLgJQqVLaS6HG
         tUATxzvYIQmP2insxtIH2rFAzhn1YXoLNlKYUsfgGKso0RHC8wnZPyithjfUTLwgzIQw
         7VxUOmp+++uYw7v9rZIA53JizqPYnAeuTg/PjJF9FOFH9qU4ef5QUy+u/ukuyfVbdfzE
         9YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5YnbVhIsrhqUArt5FEu+tfNMyO/9CJDQK2nD3tFrnE=;
        b=h28KTmGz4qGklPRKyH8H3TttemrRtOty5eyfZ+JpAHiknBywsO7j4pEo+qRt08T9b/
         RshtnWl+bgkmfhsU36eW7zCLoiydk08qi0Fe9ocWROJtrfoG/chXnYdBR/+y7j/ePVNz
         lHM2RNlgAo8Y3TjKKcPAoUwBYqpBPxIs1YF0pVYKTFXbqY3glljuex3ANnswmGsRkNKO
         qPXub5sc7BI7UBmDLp3Im/jq6YcywFRk2FzBrpcEPud1yFfIXpuxicylt8vC8yrWpvoY
         aC6Yb2AS4q7OY0GT+99W4kY35951GCGXUKClcCPB54OakeemqQ2D5Wwe8PGFUBVXmm/r
         EIGQ==
X-Gm-Message-State: AO0yUKW/gaIOHw7+madJkGNfUHU861dsCMjnXuqLWVi+DKJ7dSpeqtE7
        lapQ7UWm2snB0Z8xlBmkzTA=
X-Google-Smtp-Source: AK7set8BM54d0z8y2c54ociEHocXTl/6bfq8C3IrUeBGIvx90IZSnfkHqvF8wtEUl8uXf8i7MlE8gA==
X-Received: by 2002:a17:90b:4b0b:b0:233:bc73:a926 with SMTP id lx11-20020a17090b4b0b00b00233bc73a926mr7890257pjb.20.1676999296844;
        Tue, 21 Feb 2023 09:08:16 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:16 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 6/6] sign-file: improve help message
Date:   Tue, 21 Feb 2023 22:38:04 +0530
Message-Id: <20230221170804.3267242-6-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Add a proper help message with examples on how to use this tool.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 49 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b6d6bcbf5a04..f8e2424ed835 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -74,13 +74,44 @@ struct module_signature {
 static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
-void format(void)
+void print_usage(int retval)
 {
-	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
-	fprintf(stderr,
-		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
-	exit(2);
+	fprintf(stderr, "Usage: scripts/sign-file [OPTIONS]... [MODULE]...\n");
+	fprintf(stderr, "Available options:\n");
+	fprintf(stderr, "-h, --help		Print this help message and exit\n");
+
+	fprintf(stderr, "\nOptional args:\n");
+	fprintf(stderr, "-s, --savesig		Save signature\n");
+	fprintf(stderr, "-o, --signonly		Sign only\n");
+	fprintf(stderr, "-b, --bulksign		Sign modules in bulk\n");
+	fprintf(stderr, "-l, --replaceorig	Replace original\n");
+#ifndef USE_PKCS7
+	fprintf(stderr, "-k, --usekeyid		Use key ID\n");
+#endif
+	fprintf(stderr, "-r, --rawsig <sig>	Raw signature\n");
+	fprintf(stderr, "-d, --dest <dest>	Destination path ");
+	fprintf(stderr, "(Exclusive with bulk option)\n");
+
+	fprintf(stderr, "\nMandatory args:\n");
+	fprintf(stderr, "-p, --privkey <key>	Private key\n");
+	fprintf(stderr, "-a, --hashalgo <alg>	Hash algorithm\n");
+	fprintf(stderr, "-x, --x509 <x509>	X509\n");
+
+	fprintf(stderr, "\nExamples:\n");
+
+	fprintf(stderr, "\nRegular signing:\n");
+	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module>\n");
+
+	fprintf(stderr, "\nSigning with destination path:\n");
+	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module> -d <path>\n");
+
+	fprintf(stderr, "\nSigning modules in bulk:\n");
+	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 -b <module1> <module2> ...\n");
+
+	exit(retval);
 }
 
 static void display_openssl_errors(int l)
@@ -264,7 +295,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #endif
 		switch (opt) {
 		case 'h':
-			format();
+			print_usage(0);
 			break;
 
 		case 'r':
@@ -315,7 +346,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 
 		default:
-			format();
+			print_usage(2);
 			break;
 		}
 	} while (opt != -1);
@@ -355,7 +386,7 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 #endif
 
 	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
-		format();
+		print_usage(2);
 
 	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
-- 
2.39.1

