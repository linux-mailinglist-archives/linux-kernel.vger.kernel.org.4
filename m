Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7442694FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBMSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA720D37
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bx22so12818552pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STZigHHyNhqv/GnxfesbmPhkyAgKL79hhcVjuALeJ+Y=;
        b=dnwgzW+cTXs23t15J2n+Pu/SgSKfrZk9FwkAsqjFdfplA4CRNFwwUlfjkT4F+jEQmm
         /kZp9jrHtpm31QTytsiG1ixlFTODIpX9UqRQ+ud0FZ+X+9OMaMEdR8fkfT6xFRg7yui5
         evRJiIQ3STb1LAy5r1JEGBgGpYe2hhy0MTntDYJV2AHqQczHkZHGDE3sFsJCyQupYUqQ
         4ZaTlRs+sg+QfLe4EXfWoOxXzaHbvtuSG6UljOLIphs4HgEsI+zMhUu+R91KdAsyveRl
         fz0mcH9qinJGdpsrZyQqbIuUfsQnz8/A6J6cmqPmaZnwJWBsRkO60sC0xt6m0sKnV2ny
         pK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STZigHHyNhqv/GnxfesbmPhkyAgKL79hhcVjuALeJ+Y=;
        b=zH5weH4h3fQLyJkXPRvgxB5Thz3JuWhxu21GApxKD8SmU0OffoxQZSXhuMZMc4OQ+C
         AAAkQ6VlzceZAIyIsndGGx51BJ75lnWGJzKMfMTaDl4HCxT9GNzwY+dEZCo12fSsDmLw
         OIjP1UCYauvfSwZM3ZYCpJHwVi6z4SnPfywNDxLlGcAOea8WL1foNsOrYqbosNwxxhE1
         Siz5VVzhJtQok8MpHGZ8/fwqrSP+bPzDjgHoEGtypQeZBPLbIM+71Eb4AztwCgp+wtOB
         CRQ+LaXw+mc8X5iJaCwgVPFmRQ/C7X/iLUt+Re5nbCgBpG5caPUbCnvqinstOMTXiJos
         l9gw==
X-Gm-Message-State: AO0yUKUqh8QPhEUwpwgureVolcbfQLPnytmvnQxgAq5Ic74+lCttA/Kb
        eWHh99ICU/6jkZPbJI621vA=
X-Google-Smtp-Source: AK7set+oYFRM82Nk+LEhtJR28xPFu5cd4p2HWGvvYH73g8fVAm5VKeDN6LqOyGH9yxt1uGkQuA2osA==
X-Received: by 2002:a17:903:2306:b0:19a:aaac:f4d1 with SMTP id d6-20020a170903230600b0019aaaacf4d1mr2342583plh.13.1676314228365;
        Mon, 13 Feb 2023 10:50:28 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:28 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 4/6] sign-file: cosmetic fix
Date:   Tue, 14 Feb 2023 00:20:16 +0530
Message-Id: <20230213185019.56902-4-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213185019.56902-1-sshedi@vmware.com>
References: <20230213185019.56902-1-sshedi@vmware.com>
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

