Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFF695030
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBMTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB46227A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:46 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h7so3527415pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/XMzJ+L5J3d0/+ssV6BRnN4NRVloomzU3VBGcZ4wik=;
        b=B2oo9JtKPuCMqnexOkaN17of2ytk8Wp1YanSBTpSmCnrv4q3mIWJN2tkJSZvhjfPbA
         JztrmyTfnUhiyhQ41EdNexk6idH/evJzhOeBlCSMsAkmgFXFzBBPiUj5hinfQ7DwRxjM
         EQMjRB7Ebyyr2ZVVnKbZYjSviZHoWhnqzNu7+YvJcqG5yGoAvfqcUPXwAPiRe8CcSdvc
         Ci4yU7o4zxkDktPIYmPtE0xDFwcRpTGz9vG3lZqb+w9EFXfKjRBEzVd43/tT4BzB89Eo
         j/Eyr1VhesxNONqXZaUZ3enp+nan/wBjUSMc6dCZwXkqG9OeqM4AbE/LGbbco4UJBTqH
         Vdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/XMzJ+L5J3d0/+ssV6BRnN4NRVloomzU3VBGcZ4wik=;
        b=HRPyqCxAfThfPqJfJ2bx0OCT13QwkfUI3O7yRd00WDXen3lIw+YvmdJHsR+HsVItyw
         E6NhIdCFiMcyYgUHNKmxtlB7y+pQ7GrpAvZSX7tw3p6JtNlzEQmlV0j1WmVso7W5o2wc
         1nsF4hMrj27MpW5VaBn9ibE6DfEFqkSMqXTriJIpHVk9xsFxa1gAFoyDf3REsBc8kS9B
         vLb3Vzybk6oT6wDlAvknCrXQPqqhaFRBjTn5fphrj0+meEh+JOmL1PZ6413sDmPmi+a5
         /C6z8EyseqoiODwfWL85xIVLlotxN0S9lZsrnF0WwxU6n2MElW8c0FUqpPJGGj2qmYH8
         GHMw==
X-Gm-Message-State: AO0yUKW/lBKJVVJ23fgxYfLKJkeet9xoJsKNCW7cMEUFsIv6aI2IKrdN
        DeNW19fs0mWvNAbfyTTi360=
X-Google-Smtp-Source: AK7set+lQtUuBbRSmF0g9nEANq1SsHbU6LEgUm2Fi0jqkqYFGHqm38WqxI2f/zCq/YQdZtQ85LOeLQ==
X-Received: by 2002:aa7:9d1a:0:b0:5a8:aa1d:30e9 with SMTP id k26-20020aa79d1a000000b005a8aa1d30e9mr5735620pfp.18.1676314845819;
        Mon, 13 Feb 2023 11:00:45 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:45 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 6/6] sign-file: improve help message
Date:   Tue, 14 Feb 2023 00:30:34 +0530
Message-Id: <20230213190034.57097-6-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213190034.57097-1-sshedi@vmware.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a proper help message with examples on how to use this tool.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 49 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 0729d8df5660..d9499ea5c8cc 100644
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
@@ -355,7 +386,7 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
 #endif
 
 	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
-		format();
+		print_usage(2);
 
 	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
-- 
2.39.1

