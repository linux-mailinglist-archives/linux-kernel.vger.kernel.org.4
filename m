Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCF69E58D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjBURIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjBURIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFACC15B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c1so6015255plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE4nih69nrdmZKfmnHLFWiIcQJ5ahzu4ncWmY9XCQQ0=;
        b=KM8RlmGPE2qg7VYtCJDCXh0DroZQQX+yfuEbVKJ4w9Yn6IqYhU14qMBa08rvKUlm4c
         Y+p/+lRiAo9U8ehzNuMDolRqeg0AozFZ8GT9+O4FLG9Y+wLPgGT2Vs3nPUeKNaGnZ/IA
         E+iA1+tJxeQKj17wnb8BmgcoVT+ReZzHLhij94sSO6RO6vnPUJGXhLWxZUPFfm5kcyiN
         904pnCCWi1LK5HctK7M5xf+bOv8uw3N9dJ+9YmjhwkMUpZxxg16Te+NwTMYZwklgQFbw
         exkP/lInljI/T4NgerXV1sZuqp9jjiMBes/N+krpT3jgzmAAu1k/bAo5Ls/ZW8zLgjE2
         LoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE4nih69nrdmZKfmnHLFWiIcQJ5ahzu4ncWmY9XCQQ0=;
        b=uVGVLIWQrKnJRAgTC3NerWPJWJOHOSiSp3mxqzb+QjTo389UDWV6mJYXSMsIUW2UZe
         xl0WRR7KzpGwEOWcP/+obG04wT3hAVj49s67Uc8E4zgqTjeOa4wa3aDfk5I2or5ffKmc
         V2aJ1tXJaGJDlJ7zWIFctQqluN2LYTNjFxk7lcoTXmGKibBQyt2F3312+ieVYe/13HuU
         Tco+njrPfZodcM1CEjapiVILP8rwyw25cUzkDtVMPfBwUpiSwxgRZzD8l2nqWkakLEQE
         nZKGktKM+Wak+RMnd5LC/73JJZfzi6IkecnLG/LAD+KqgoXU9d2wc7EwPv5fKaq6qjwD
         3u8w==
X-Gm-Message-State: AO0yUKUnau/Xz2Zil0ZTfuyFuxjblqeyPRiSuMcLXFeJQ7PwPYW+kTrd
        CHXGvCzFlXyvIOgv0rhO5FQ=
X-Google-Smtp-Source: AK7set8f3Q9pYnAP+9vyqxcevG2M+TvlqeuoTpWU44fnu2iuiav1vCD0XsmqRoJo/BQzsp8OO1kSBw==
X-Received: by 2002:a17:90b:3808:b0:234:8950:6d1f with SMTP id mq8-20020a17090b380800b0023489506d1fmr5778850pjb.11.1676999294170;
        Tue, 21 Feb 2023 09:08:14 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:13 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 4/6] sign-file: cosmetic fix
Date:   Tue, 21 Feb 2023 22:38:02 +0530
Message-Id: <20230221170804.3267242-4-sshedi@vmware.com>
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

Indent the body of for loop properly

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 174 ++++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 97a2aaf8e323..b6856fd5cb10 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -395,114 +395,114 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 				replace_orig = true;
 		}
 
-	/* Open the module file */
-	bm = BIO_new_file(module_name, "rb");
-	ERR(!bm, "%s", module_name);
-
-	if (!raw_sig) {
-		/* Read the private key and the X.509 cert the PKCS#7 message
-		 * will point to.
-		 */
-		private_key = read_private_key(private_key_name);
-		x509 = read_x509(x509_name);
-
-		/* Digest the module data. */
-		OpenSSL_add_all_digests();
-		display_openssl_errors(__LINE__);
-		digest_algo = EVP_get_digestbyname(hash_algo);
-		ERR(!digest_algo, "EVP_get_digestbyname");
+		/* Open the module file */
+		bm = BIO_new_file(module_name, "rb");
+		ERR(!bm, "%s", module_name);
+
+		if (!raw_sig) {
+			/* Read the private key and the X.509 cert the PKCS#7 message
+			 * will point to.
+			 */
+			private_key = read_private_key(private_key_name);
+			x509 = read_x509(x509_name);
+
+			/* Digest the module data. */
+			OpenSSL_add_all_digests();
+			display_openssl_errors(__LINE__);
+			digest_algo = EVP_get_digestbyname(hash_algo);
+			ERR(!digest_algo, "EVP_get_digestbyname");
 
 #ifndef USE_PKCS7
-		/* Load the signature message from the digest buffer. */
-		cms = CMS_sign(NULL, NULL, NULL, NULL,
-			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
-			       CMS_DETACHED | CMS_STREAM);
-		ERR(!cms, "CMS_sign");
-
-		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
-				     CMS_NOCERTS | CMS_BINARY |
-				     CMS_NOSMIMECAP | use_keyid |
-				     use_signed_attrs),
-		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
-		    "CMS_final");
+			/* Load the signature message from the digest buffer. */
+			cms = CMS_sign(NULL, NULL, NULL, NULL,
+					CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
+					CMS_DETACHED | CMS_STREAM);
+			ERR(!cms, "CMS_sign");
+
+			ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
+						CMS_NOCERTS | CMS_BINARY |
+						CMS_NOSMIMECAP | use_keyid |
+						use_signed_attrs),
+					"CMS_add1_signer");
+			ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+					"CMS_final");
 
 #else
-		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
-				   PKCS7_NOCERTS | PKCS7_BINARY |
-				   PKCS7_DETACHED | use_signed_attrs);
-		ERR(!pkcs7, "PKCS7_sign");
+			pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
+					PKCS7_NOCERTS | PKCS7_BINARY |
+					PKCS7_DETACHED | use_signed_attrs);
+			ERR(!pkcs7, "PKCS7_sign");
 #endif
 
-		if (save_sig) {
-			char *sig_file_name;
-			BIO *b;
+			if (save_sig) {
+				char *sig_file_name;
+				BIO *b;
 
-			ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
-			    "asprintf");
-			b = BIO_new_file(sig_file_name, "wb");
-			ERR(!b, "%s", sig_file_name);
+				ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
+						"asprintf");
+				b = BIO_new_file(sig_file_name, "wb");
+				ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
-			    "%s", sig_file_name);
+				ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+						"%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
-			    "%s", sig_file_name);
+				ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+						"%s", sig_file_name);
 #endif
-			BIO_free(b);
-		}
+				BIO_free(b);
+			}
 
-		if (sign_only) {
-			BIO_free(bm);
-			return 0;
+			if (sign_only) {
+				BIO_free(bm);
+				return 0;
+			}
 		}
-	}
 
-	/* Open the destination file now so that we can shovel the module data
-	 * across as we read it.
-	 */
-	bd = BIO_new_file(dest_name, "wb");
-	ERR(!bd, "%s", dest_name);
-
-	/* Append the marker and the PKCS#7 message to the destination file */
-	ERR(BIO_reset(bm) < 0, "%s", module_name);
-	while ((n = BIO_read(bm, buf, sizeof(buf))),
-	       n > 0) {
-		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
-	}
-	BIO_free(bm);
-	ERR(n < 0, "%s", module_name);
-	module_size = BIO_number_written(bd);
+		/* Open the destination file now so that we can shovel the module data
+		 * across as we read it.
+		 */
+		bd = BIO_new_file(dest_name, "wb");
+		ERR(!bd, "%s", dest_name);
 
-	if (!raw_sig) {
+		/* Append the marker and the PKCS#7 message to the destination file */
+		ERR(BIO_reset(bm) < 0, "%s", module_name);
+		while ((n = BIO_read(bm, buf, sizeof(buf))),
+				n > 0) {
+			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+		}
+		BIO_free(bm);
+		ERR(n < 0, "%s", module_name);
+		module_size = BIO_number_written(bd);
+
+		if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+			ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+			ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
 #endif
-	} else {
-		BIO *b;
+		} else {
+			BIO *b;
 
-		/* Read the raw signature file and write the data to the
-		 * destination file
-		 */
-		b = BIO_new_file(raw_sig_name, "rb");
-		ERR(!b, "%s", raw_sig_name);
-		while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
-			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
-		BIO_free(b);
-	}
+			/* Read the raw signature file and write the data to the
+			 * destination file
+			 */
+			b = BIO_new_file(raw_sig_name, "rb");
+			ERR(!b, "%s", raw_sig_name);
+			while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
+				ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+			BIO_free(b);
+		}
 
-	sig_size = BIO_number_written(bd) - module_size;
-	sig_info.sig_len = htonl(sig_size);
-	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
-	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
+		sig_size = BIO_number_written(bd) - module_size;
+		sig_info.sig_len = htonl(sig_size);
+		ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
+		ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+		ERR(BIO_free(bd) < 0, "%s", dest_name);
 
-	/* Finally, if we're signing in place, replace the original. */
-	if (replace_orig)
-		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+		/* Finally, if we're signing in place, replace the original. */
+		if (replace_orig)
+			ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
 	}
 
 	return 0;
-- 
2.39.1

