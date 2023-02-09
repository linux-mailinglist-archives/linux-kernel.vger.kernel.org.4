Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1242D690DED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBIQGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBIQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:06:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C4663DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:05:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d8so2086577plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUoXpMWjy0LjmD/q6WT+yIP2GHxBl2GI5Eeo4fd+3vE=;
        b=ZhkELgVyfpp57sqO9hBY8eIIART2+q1p9MUrFQOa0wSHLo8IJxS0mg48FUrMIvKJmG
         bgl+JrGKhTVJyEVKL07VpwJdNlOxGfNIp8eKuehdGiCCqO3gPRywUZt/9NHziUKcWQrX
         j42CCgwNjZqJn6cS2EBkFPSoAWARPVfmTOcsbErxr75euf7Udx1+vnih1+1S62blIDmt
         AlNw0Dx2msH4zqTux3W6nPaana9nwpM0vfCzWlAox1cIHyVS2pU2ScRDneeBu5RBu+0p
         HO00j77c21kCLIws5xe2cM0U7c/3LFb8EjWtSPo7Ws8t448Y/Duf6S2aj7EEhfrKPaaF
         yS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUoXpMWjy0LjmD/q6WT+yIP2GHxBl2GI5Eeo4fd+3vE=;
        b=jQKfH2eYQIr5anHjShImiuMFpJlptW1IaVKjR/KVZm6skmeV5Q8y+caufITBSIsEi5
         eh2G/15XFkqMMT27jwQVpP9vUdZSpcSPdiu5XCGwoLpGFSTsI999aLwOU+lAvjdJWHBL
         aKaIHuupHtptqX8NRkVQtpXJXMqTzI/3d1O+mfnCXDvTrs0XdDLNlrMFA9SqvO5EzY/z
         X3tBeGMTTzY9GJrns305l5o/2nIINljLXDu0px5bz1J/yeK+BZ+4AmSVnlYiszOqr51x
         HTnzh3WI5HuYraZOB+9TnvIfZGAW9cyOQ9H8gu34eOnH8sOIp3LHnmZMuKIJvD6iyRjc
         wZww==
X-Gm-Message-State: AO0yUKWLZWpYwM74gjr1A5drM40l8Vzf1nj2B65CJ7q+BV/FkUqd+NaX
        2aMao9qe7BJCRBMyTjQLp40=
X-Google-Smtp-Source: AK7set8vRBjTX+U/gBcXGt9hO7P8MDbbvvljef0i2kbjyYO82HttbYmvGbc0ShQyaUJDVgXjFiiw8g==
X-Received: by 2002:a17:90b:2250:b0:230:c41b:4d87 with SMTP id hk16-20020a17090b225000b00230c41b4d87mr13424320pjb.6.1675958744782;
        Thu, 09 Feb 2023 08:05:44 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p22-20020a17090a0e5600b001fde655225fsm7080135pja.2.2023.02.09.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:05:44 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 4/4] sign-file: improve help message
Date:   Thu,  9 Feb 2023 21:35:23 +0530
Message-Id: <20230209160523.858502-4-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209160523.858502-1-sshedi@vmware.com>
References: <20230209160523.858502-1-sshedi@vmware.com>
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

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 sign-file.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/sign-file.c b/sign-file.c
index 2faf302..0c41a5a 100644
--- a/sign-file.c
+++ b/sign-file.c
@@ -76,13 +76,44 @@ struct module_signature {
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
@@ -266,7 +297,7 @@ void parse_args(int *argc, char **argv, struct cmd_opts *opts)
 #endif
 		switch (opt) {
 		case 'h':
-			format();
+			print_usage(0);
 			break;
 
 		case 'r':
@@ -317,7 +348,7 @@ void parse_args(int *argc, char **argv, struct cmd_opts *opts)
 			break;
 
 		default:
-			format();
+			print_usage(2);
 			break;
 		}
 	} while (opt != -1);
@@ -374,7 +405,7 @@ int main(int argc, char **argv)
 #endif
 
 	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
-		format();
+		print_usage(2);
 
 	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
-- 
2.39.0

