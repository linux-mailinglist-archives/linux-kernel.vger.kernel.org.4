Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E753E6C1EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCTSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCTSDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1FC14996
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so13335715pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/r1WlIiwVQzbXgHldnF4Wyr/f+kJm7/RhfD8t1T97c=;
        b=VXK/QcBfEEk6YoxqMEA5tWEOZywz5pAP/EdS2TKr49j3/Z0ZVxVVq41cH3Ulfo4yD4
         v7mkDGaikbNLwEmmS+vjRhuqsJgNSu/ERicrwrUGF8Fna5sto/NKPPHqUQvaxh17ck2L
         cHHuDgYPKCrBU3bri+IYPpmBAIbSPD6vpck5vi5eesBX9fdErBAfvF892rv4h4VNdC7B
         R3fF4eyVVIzU1XQGuCxeylJulQaw5YRHnWniIxy6i1tUmeW07poSp+MAlIJvmpvt0/l8
         Ohwc5wV3Vb/Dc2zZbiEDdUIuclT8K9HHQHPpgMb5eHJQBeXR5d16Q2TpgBznHqiNJ2zb
         Blyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/r1WlIiwVQzbXgHldnF4Wyr/f+kJm7/RhfD8t1T97c=;
        b=ohY6dVTR/Mr+M/n8oHjBCv61gwFOstOZVSvpbpdpPKZckwSR30RKvhv0RPX43LEAyH
         VdyUyqZ2zQ+2zMPmXFFS1juliAz8/Eohv3VsayurlxPWgIrKwWX2Be7MS6rJE5eSXwKW
         yZGK4Mv2NnFABd0tvRp/hRY1dj/8AiSg6ou6393Aepq2oSGbbuG333+pWRyXbaHpQ87g
         RXLsMVQppHbguXsvMShpLmq7VD4rkZS1dhI2KbWElPJfjCni85Z77skC8yk15ko4NCXc
         G9qrRF3+5TQkNI8HQbCXolbZayCEvKmv4ya8vDbzgY2bWwxWNq3sZ9VFS47GSzHs6d2e
         j94A==
X-Gm-Message-State: AO0yUKUjcTRiDBQ6NqC2UkvL8wXsE1rIfHvlDiTL9Us+mAFltKKvLiBc
        +2s7AcbP3cR2h7Y/DDydIq/GFh8lefc=
X-Google-Smtp-Source: AK7set8K247Le38RQzUaIokU/yJPSobCPqEgJKQ3LZyxvupZJmtkn8YaG3jTgB0iul1bYOLRYKSsKw==
X-Received: by 2002:a17:903:234f:b0:1a1:be39:ce14 with SMTP id c15-20020a170903234f00b001a1be39ce14mr8594021plh.59.1679335057023;
        Mon, 20 Mar 2023 10:57:37 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:36 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 1/7] sign-file: refactor argument parsing logic - 1
Date:   Mon, 20 Mar 2023 23:27:25 +0530
Message-Id: <20230320175731.79709-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
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

From: Shreenidhi Shedi <yesshedi@gmail.com>

- Use getopt_long_only for parsing input args
- Use more easy to remember command line argument names

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..94228865b6cc 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -213,15 +213,77 @@ static X509 *read_x509(const char *x509_name)
 	return x509;
 }
 
+struct cmd_opts {
+	char *raw_sig_name;
+	bool save_sig;
+	bool replace_orig;
+	bool raw_sig;
+	bool sign_only;
+#ifndef USE_PKCS7
+	unsigned int use_keyid;
+#endif
+};
+
+static void parse_args(int argc, char **argv, struct cmd_opts *opts)
+{
+	struct option cmd_options[] = {
+		{"rawsig",	required_argument,  0,	's'},
+		{"savesig",	no_argument,	    0,	'p'},
+		{"signonly",	no_argument,	    0,	'd'},
+#ifndef USE_PKCS7
+		{"usekeyid",	no_argument,	    0,	'k'},
+#endif
+		{0, 0, 0, 0}
+	};
+
+	int opt;
+	int opt_index = 0;
+
+	do {
+#ifndef USE_PKCS7
+		opt = getopt_long_only(argc, argv, "pds:",
+				cmd_options, &opt_index);
+#else
+		opt = getopt_long_only(argc, argv, "pdks:",
+				cmd_options, &opt_index);
+#endif
+		switch (opt) {
+		case 's':
+			opts->raw_sig = true;
+			opts->raw_sig_name = optarg;
+			break;
+
+		case 'p':
+			opts->save_sig = true;
+			break;
+
+		case 'd':
+			opts->sign_only = true;
+			opts->save_sig = true;
+			break;
+
+#ifndef USE_PKCS7
+		case 'k':
+			opts->use_keyid = CMS_USE_KEYID;
+			break;
+#endif
+
+		case -1:
+			break;
+
+		default:
+			format();
+			break;
+		}
+	} while (opt != -1);
+}
+
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
 	char *hash_algo = NULL;
-	char *private_key_name = NULL, *raw_sig_name = NULL;
+	char *private_key_name = NULL;
 	char *x509_name, *module_name, *dest_name;
-	bool save_sig = false, replace_orig;
-	bool sign_only = false;
-	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -229,13 +291,14 @@ int main(int argc, char **argv)
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
 	CMS_ContentInfo *cms = NULL;
-	unsigned int use_keyid = 0;
 #else
 	PKCS7 *pkcs7 = NULL;
 #endif
 	X509 *x509;
 	BIO *bd, *bm;
-	int opt, n;
+	int n;
+	struct cmd_opts opts = {};
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
@@ -247,23 +310,19 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
 
-	do {
-		opt = getopt(argc, argv, "sdpk");
-		switch (opt) {
-		case 's': raw_sig = true; break;
-		case 'p': save_sig = true; break;
-		case 'd': sign_only = true; save_sig = true; break;
+	const char *raw_sig_name = opts.raw_sig_name;
+	const bool save_sig = opts.save_sig;
+	const bool raw_sig = opts.raw_sig;
+	const bool sign_only = opts.sign_only;
+	bool replace_orig = opts.replace_orig;
 #ifndef USE_PKCS7
-		case 'k': use_keyid = CMS_USE_KEYID; break;
+	const unsigned int use_keyid = opts.use_keyid;
 #endif
-		case -1: break;
-		default: format();
-		}
-	} while (opt != -1);
 
-	argc -= optind;
-	argv += optind;
 	if (argc < 4 || argc > 5)
 		format();
 
-- 
2.39.2
