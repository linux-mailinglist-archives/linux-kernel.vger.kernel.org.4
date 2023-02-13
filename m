Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E569502F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBMTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjBMTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:08 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9361227B2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t17so8639722pfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STZigHHyNhqv/GnxfesbmPhkyAgKL79hhcVjuALeJ+Y=;
        b=MQSEHor7avrH5PtAvYzrSNDTpsrer8kinK5Bg4MIFzRidPbwpY3fXtazgvUJxpoJ79
         XcsVektVIbJpJuJ8CyRyKglJnUIuyq3rAfPHYgMsf5fS3sQeJmE3B6aErRynQEVNPqcU
         qzS4PsqLCWr4N17FXW91bEibCb3zRDRLdinkwHcGQD5vBQ6DhEERsbqZN0LmmxllvRRn
         7qT44eIfo4xRELVZGJitL7M2Dp0dzKJYlDr54uT1hTX2MmzNZ09HUFjdDwm4yWwYXwnM
         C7YQaAz3edFB4/avHjlSmXLP8kvviYW6cCjdJIJB+VFhr9gisYTc0QFYpRGRWYHezY1z
         XhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STZigHHyNhqv/GnxfesbmPhkyAgKL79hhcVjuALeJ+Y=;
        b=U4svoL0QLL4GMII07yb/TkUJmUlS5FPc+623v+qnwYghZr0IlaZB7DVXiMoKXjDpXd
         dQu6NjXHTAFDzmXxEbeX83hLwRahupWimIdFHWRfHZGeGoWv6WAFmsisPBXe7jUgR1XB
         aDamjz0Qf+NzkJZh+T477u7kmHbtSlccEXUUxgdVuDJTuMYuOFUkILpMxiXAG1pSuaIb
         B5m2v3FRwtc0Y2WtIctT1wMhuRCvuwPW6GF4GMkv9gpWcdj3sIV4Bc8KOLJMp3Dgt20U
         3j9b4FyZALkCHhzMokDbWwyDeDP3Ep+Y8Z/7vfa/J4nZCJbMTKZNvAjNzPJOe7qHbwg2
         9k4Q==
X-Gm-Message-State: AO0yUKXQ6ndxzvM/sX5b86w3MiDHgIkHZvCnK6J0n87b3Av2f2cI9N1Y
        u7TgL3L5E7JqqoMUlg8bKyIJKUCoWdzBAA==
X-Google-Smtp-Source: AK7set8+k8o7dXXDLpDUbGX6WymomHiHz2Z9VtmVVtqE2a9FF0GCtL9rOcppgX4pi9PsjZClIf36jA==
X-Received: by 2002:a62:3044:0:b0:58b:9473:7ae0 with SMTP id w65-20020a623044000000b0058b94737ae0mr18763110pfw.32.1676314843019;
        Mon, 13 Feb 2023 11:00:43 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:42 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 4/6] sign-file: cosmetic fix
Date:   Tue, 14 Feb 2023 00:30:32 +0530
Message-Id: <20230213190034.57097-4-sshedi@vmware.com>
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

In the previous patch for adding bulk modules support, this was not done
because it will add a lot to review in one patch.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 174 ++++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7ad330b47d64..b48832d54f45 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -395,114 +395,114 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
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

