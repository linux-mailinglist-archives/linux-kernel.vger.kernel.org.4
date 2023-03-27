Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD76CB166
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC0WBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0WBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:01:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D1D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:01:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r29so10219245wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679954460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdiIli5OjsdHxX+rOzIAzeZXPbcJtKma85dtenqz7jU=;
        b=Gb+bMr/okLK4tE4wt4lNEBPFK5YmhZBgv6sL1nomRfeF78hwGOCCGlnjMZwbag8It9
         UDc8QgVMpcgEIa5qOnbYLH0lFJfGyMOW98FDysVamaKTFhJTLdtOi9WDFx2pe0m2QXf5
         /tQoa0QGQMF5S3eLpqyrEhcxjD3yuDo3w2MOwOTJKoPm9bjNF+sf3AOMY7CED51Tzvqw
         aVKgZYg52lfECZmEFRp0uwGyyW/5CswsZCA/uzSq2Sz8D41hxqUqZ4NwGlihLlhugREd
         axBBF0fSOWqOR9yhtNH0nCdaVapLq2QuObG0dPeu352DHXvJrWbZVFERRDyJ1ZrzEjHA
         H3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679954460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdiIli5OjsdHxX+rOzIAzeZXPbcJtKma85dtenqz7jU=;
        b=UxW9ZoCH+tqZC8ruibPPgubHEP1RZ034ojNIxLRiV2veE3bGZjeaDfKdViXbJVz4TE
         7pEf+v1pFtg2cHtlhJbF9AzRDom7gK0919ExseiQ7rOBD9XCrblD24ci45fmlFJN+cYJ
         KEq7Rynk9AoWx5IwLj04J3w4zHizqDy+iylC41n1iVdt2Ib26cBjcuP5m0dCb1F08I5G
         SudTdHDBAlKwCibcMQxjj6zGIbCBQYhFnmlwmUter8MiND/xgObHU7/EtI/mkZ1xIgNS
         C8Dujn3iX88w9MhhDCO9HTX2RVQKgQDOQUDKpnfA6nxugOvZiCik7BM4jkee+MuPoMMn
         OHaw==
X-Gm-Message-State: AAQBX9eZ5UgfiblISJfyJKKkCqEoUCuYtUpc/fuhQeKfHUPX+KQfgtss
        A4dPhwR+4GEPWEazf1WbBYGN+nS3QWbRVi/S
X-Google-Smtp-Source: AKy350Y6z+kZIPfxCiNTo8D29iT7O3uTjPdPIjIp9B5Q/49Po3j1UxBK+eU5ylmIttX7kVbgmQ2xVA==
X-Received: by 2002:a05:6000:7:b0:2cd:e0a8:f2dc with SMTP id h7-20020a056000000700b002cde0a8f2dcmr10815996wrx.7.1679954460246;
        Mon, 27 Mar 2023 15:01:00 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002cfe687fc7asm25906455wru.67.2023.03.27.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:00:59 -0700 (PDT)
Date:   Tue, 28 Mar 2023 03:00:57 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix unbalanced braces around else
Message-ID: <ZCISGaFELBfDyGRT@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balance if/else braces as recommended by checkpatch.pl

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 68c131afc2ba..c61fdf73c572 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -517,6 +517,7 @@ void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 			netdev_dbg(ieee->dev, "Immediately Start ADDBA\n");
 			mod_timer(&pTxTS->TsAddBaTimer, jiffies + 10);
 		}
-	} else
+	} else {
 		netdev_dbg(ieee->dev, "BA timer is already added\n");
+	}
 }
-- 
2.34.1

