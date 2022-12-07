Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A73645686
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiLGJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:33:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8D20E;
        Wed,  7 Dec 2022 01:33:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg10so13143784wmb.1;
        Wed, 07 Dec 2022 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/Q6kvRFfdVCMvD/9KspZyMV4JmhJENHyXiGZYFDk44=;
        b=fGvVgz/qLTD3VEZDyt0R79HKaMueP/MoJWsyBHUwQi8OkgR6+KCU6nDmoFMopvR3T7
         L47YKFDIIbN+1PBNVuJIRY2y2sBhXYbp+WdEV03RNxbEMnrPE685neASGJWiaY1gOvhY
         +OjTKux0yGwNj+htnlJ1vUL0Vb4ZBDwxovlNX1PzDo9cBHQAQGGIw7vlm0821idOlYXf
         YYwSQDP6rPV3Uy1xXqVobWc2boYm1b4GO988NLxFWaqeE+mv4dsMuo46qAAwHODWZkAW
         +pUpbqyVKe3qFbrq2+LelY9V4zzKwA9FIhRSzY8nPZQb5E8Iomf+wo8JR7BPFRVSNcwG
         eDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/Q6kvRFfdVCMvD/9KspZyMV4JmhJENHyXiGZYFDk44=;
        b=kPdcwoR8hAfUSpGomgICFUykpJnYymmwF3vh9dg3reoa1T5NX78iv8jACgqp/it3KU
         gIZYboBz/9apy/QcM6IdPFadbRzFVykyBUFXEPIcVfmY3vi+Ev/aUIoZSxcxCd/+pd5z
         920/HkqVQGKKg6qy8V+2xydmRFqOKnXwg+EnLUrR2DIrRwGMg7DKpZorckr3iYcv3RF2
         TR9Lg7Pi1GNgP+p9W9/zjOumpbYRbeS1m+EpDV7XAZvZx+OV1rPjSlYgcGUl4qmiNWkH
         bhLIQeTi3sibt5COEviD3rKPj1zXQ65m0o3JfFtENF49/+DpWiKBO6/rpl4eLdbjBtpC
         PzwQ==
X-Gm-Message-State: ANoB5pm49XOqhMIrW3nkGbH7qUInc3oQfazLdyCsfUcepJ7X+w+Ehw50
        ZqC+rTq3AwLwsKMTbW0DPBQ=
X-Google-Smtp-Source: AA0mqf65Hayvxx6HW4BpL6shqMfP5P+7WL8Kx9rrVd0hJaGecXER7SpcxDy/P4CdKLK5k/ZFAtBVDA==
X-Received: by 2002:a05:600c:2d45:b0:3d0:8c4c:f681 with SMTP id a5-20020a05600c2d4500b003d08c4cf681mr14114048wmg.37.1670405612599;
        Wed, 07 Dec 2022 01:33:32 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b40-20020a05600c4aa800b003cf6a55d8e8sm1078481wmp.7.2022.12.07.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 01:33:32 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix spelling mistake "ContryIE" -> "CountryIE"
Date:   Wed,  7 Dec 2022 09:33:31 +0000
Message-Id: <20221207093331.2280355-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a netdev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f8965afab767..669e74a67190 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1776,7 +1776,7 @@ static inline void rtllib_extract_country_ie(
 				if (rtllib_act_scanning(ieee, false) &&
 				    ieee->FirstIe_InScan)
 					netdev_info(ieee->dev,
-						    "Received beacon ContryIE, SSID: <%s>\n",
+						    "Received beacon CountryIE, SSID: <%s>\n",
 						    network->ssid);
 				dot11d_update_country(ieee, addr2,
 						       info_element->len,
-- 
2.38.1

