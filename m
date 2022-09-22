Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8205E60FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIVL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIVL2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:28:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A203DF3B2;
        Thu, 22 Sep 2022 04:27:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so684933pgb.6;
        Thu, 22 Sep 2022 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kkfx7Fevmf9ZuILb+byihiERfjDZD0PuCn1s3gjuL4I=;
        b=WoOxf7cWwNlJN6Lk6O8ZjbQq20/N9c13Ufw6DEN+6C1oPUT2WNqr3s5hVsKtFiP9AR
         BTmBhvl2pYdOCNxSDhabQd6aoPPNsRqu9G3wl0JMnvrhCyP85uxYABNk3ix+Zu6Vpz8S
         mgCDSvIf6bh3ThSdLy1xeNPrhRmj8a7LDr0AV9bvHrEVFwW7MXhNiERvpweRfUsZVBCv
         zBBiU16tbJMm8YcuGYk8/xR6bRoRtu/RwpRcHTDu83NKATIf9yPh5KSQ3HygD51J6mzy
         gi0pKkGuw1fK0VmO1VonD9T/i/7Y/LitpFDA6b/qzCVnGJgKorCaXIqhc0RrncyFD8yi
         N5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kkfx7Fevmf9ZuILb+byihiERfjDZD0PuCn1s3gjuL4I=;
        b=sVAcAOYFln/rFtZ5Vntia8uyqopOPqEI4wa/1+eR7omhHT8KMZLIQm76tW3kVu8dmp
         89MlWSmLNELEe8YLsFltBZV44Ec7QFkI0vv9sc5JJKuz5CNQrckCTUTly3FdpUw7HiMF
         QiL6WpjGRa+2e5UQ1YgsMhan/IAWWRS0rnV3u6YnXjdHGWqm5iNWspX4LkU+Pn58xaZx
         WjTET/QF4/SCuvR6Vuj+S0NAq2cDNPCKH+CJNLhlYDmr2qbJJETQUo2hiloGU/q2o+JJ
         ROYhnOmwQ88TnVaWx5yb53mUDA+oCS0kLD/CAs4fDSCodIMHn/jQnFwgk7ACJmNkrsko
         LyTg==
X-Gm-Message-State: ACrzQf2zBd9S0SLF579oxV0sjUn5wdM65pg9NOZs0nEw/5LJlqrlPW3B
        PpQX/0SPlRzIzGNItgYyy8jDfnJRFoY=
X-Google-Smtp-Source: AMsMyM45zgWaG9FK2QT0v34YBHhIAhx5q6fXw7CMlhT9AFIOiNSfiN/qCn/rR1vf80BiTXn5gQMN9w==
X-Received: by 2002:a63:a14:0:b0:439:e41a:6646 with SMTP id 20-20020a630a14000000b00439e41a6646mr2605351pgk.513.1663846078282;
        Thu, 22 Sep 2022 04:27:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b0016c0b0fe1c6sm3871321plf.73.2022.09.22.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:27:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: zip - remove the unneeded result variable
Date:   Thu, 22 Sep 2022 11:27:53 +0000
Message-Id: <20220922112753.236815-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value directly instead of storing it in another redundant
variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/cavium/zip/zip_crypto.c | 30 ++++++--------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
index 7df71fcebe8f..1046a746d36f 100644
--- a/drivers/crypto/cavium/zip/zip_crypto.c
+++ b/drivers/crypto/cavium/zip/zip_crypto.c
@@ -198,22 +198,16 @@ static int zip_decompress(const u8 *src, unsigned int slen,
 /* Legacy Compress framework start */
 int zip_alloc_comp_ctx_deflate(struct crypto_tfm *tfm)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
 
-	ret = zip_ctx_init(zip_ctx, 0);
-
-	return ret;
+	return zip_ctx_init(zip_ctx, 0);
 }
 
 int zip_alloc_comp_ctx_lzs(struct crypto_tfm *tfm)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
 
-	ret = zip_ctx_init(zip_ctx, 1);
-
-	return ret;
+	return zip_ctx_init(zip_ctx, 1);
 }
 
 void zip_free_comp_ctx(struct crypto_tfm *tfm)
@@ -227,24 +221,18 @@ int  zip_comp_compress(struct crypto_tfm *tfm,
 		       const u8 *src, unsigned int slen,
 		       u8 *dst, unsigned int *dlen)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
 
-	ret = zip_compress(src, slen, dst, dlen, zip_ctx);
-
-	return ret;
+	return zip_compress(src, slen, dst, dlen, zip_ctx);
 }
 
 int  zip_comp_decompress(struct crypto_tfm *tfm,
 			 const u8 *src, unsigned int slen,
 			 u8 *dst, unsigned int *dlen)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
 
-	ret = zip_decompress(src, slen, dst, dlen, zip_ctx);
-
-	return ret;
+	return zip_decompress(src, slen, dst, dlen, zip_ctx);
 } /* Legacy compress framework end */
 
 /* SCOMP framework start */
@@ -298,22 +286,16 @@ int zip_scomp_compress(struct crypto_scomp *tfm,
 		       const u8 *src, unsigned int slen,
 		       u8 *dst, unsigned int *dlen, void *ctx)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx  = ctx;
 
-	ret = zip_compress(src, slen, dst, dlen, zip_ctx);
-
-	return ret;
+	return zip_compress(src, slen, dst, dlen, zip_ctx);
 }
 
 int zip_scomp_decompress(struct crypto_scomp *tfm,
 			 const u8 *src, unsigned int slen,
 			 u8 *dst, unsigned int *dlen, void *ctx)
 {
-	int ret;
 	struct zip_kernel_ctx *zip_ctx = ctx;
 
-	ret = zip_decompress(src, slen, dst, dlen, zip_ctx);
-
-	return ret;
+	return zip_decompress(src, slen, dst, dlen, zip_ctx);
 } /* SCOMP framework end */
-- 
2.25.1
