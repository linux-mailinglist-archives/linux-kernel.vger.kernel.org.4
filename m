Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27C65F4633
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJDPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJDPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:09:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118013DC2;
        Tue,  4 Oct 2022 08:09:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bq9so21801172wrb.4;
        Tue, 04 Oct 2022 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=701Ck6g0QIE4xfCqkzTh43wU8sP3WgE0ebhz4dRse7I=;
        b=NGxUdAlmvvXWbf3Csp+CZ4s5zWfCS7LroYp3XrCNtoPNjOY86HinhBRq9Yd/izp9wo
         +8XexC/kRU80vPXel1zYMeIRk7MPkI+BmzuaOd9dSrf/k2/y/kcj2qgnbw1j8yZ1pUsp
         2sOmFT51r/ZrsF/zJJ/LgHEuw33Oyas0z5llkZIzpybFZogz+pHgChgl1K+gAKeVfQyn
         iI2z+t3n0pISsDomkATFyjgTg3UrVztALvZEXc5qr1o51pSh0mwdtkH32KdUplMW/PTq
         5V2mCOnRk+D62xyU0zX7/zymS7qz2lE7v2ejSG5vnI1aNAdzd900CbTvzLl8wZv8j3td
         eZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=701Ck6g0QIE4xfCqkzTh43wU8sP3WgE0ebhz4dRse7I=;
        b=vy7/aSN1VgyItbaaZ5oXrwBKSKOvMlgALBrpEgZLkBY4YiVFJlgeKAIboL0Kp7pznB
         8mJOx+UawuUEflnembUS9rWUka0hZDu/GYt18ZBCKFbPGoS/pxJWIDnG9IMbK8jcWTs7
         fFw3vAjsUlseiQDLRiYM2BY0uImls0KCVj0rldJ/TmxL8fadH9n1Hipjf5d8ppmX2ULc
         T81OPjO0d31aVoECtpJauvlrwUlK5GUOpCFKCmHB/EUYpyFDAasA8D/THmbcAY6J2bhL
         mKmWZZ6ZgnC7qzBSHL1PYeT9DQfb5U+WqiLDroSkHSVq4zcqZQgeOToaQhoLcseQg5uF
         8Rjw==
X-Gm-Message-State: ACrzQf22yeKhRn93Rti06bcELtj5y9hQ6YSIUUcduYBR3mKO4/v0DZMQ
        P/WNj1+vRdBky+FDG8+cZgZlZKjkyUG4LlSY
X-Google-Smtp-Source: AMsMyM79kJkKnS9UZ7s/T5VFKVsgAHzLaUMWBOgve1YQihaYLsMCgz+9SgHaZ5aqsceJ02e3rc06KQ==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b0:42ca with SMTP id f2-20020a5d64c2000000b0022e41b042camr5546530wri.411.1664896186238;
        Tue, 04 Oct 2022 08:09:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c2cb200b003b51a4c61aasm20434812wmc.40.2022.10.04.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:09:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Fix spelling mistake athros -> Atheros and fix grammer
Date:   Tue,  4 Oct 2022 16:09:44 +0100
Message-Id: <20221004150944.148157-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spellig mistake, correct it and fix capital letter on the
proper noun. Also fix the grammar.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index b58e75932ecd..f142d0986990 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1806,7 +1806,7 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 				info_element->data[0] == 0x00 &&
 				info_element->data[1] == 0x13 &&
 				info_element->data[2] == 0x74)) {
-				netdev_dbg(ieee->dev, "========> athros AP is exist\n");
+				netdev_dbg(ieee->dev, "========> Atheros AP exists\n");
 				network->atheros_cap_exist = true;
 			} else
 				network->atheros_cap_exist = false;
-- 
2.37.1

