Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0825B5873
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiILK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiILK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:29:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494FB3B955;
        Mon, 12 Sep 2022 03:29:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so8152293plo.3;
        Mon, 12 Sep 2022 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oUSmh1gw//zaj+S0sn3ELb0An6DYoYmCrSomQNeQSuo=;
        b=EA1d6WDfsA/I0rOwkkwVViigvWKWbfIoo5lV9xdow/gQFG7q5gIhfauVCgqcfLxGPK
         mFogrEI3GNpF1uhg+EgVRpi/kDQ5jnaEFQpqx+AgeD69pAsPPO0TtW5iyJIN2sayqdT5
         eS+wjU9w7jnI7SCslNOsKtsDP+anHwoJRGCOp82BonPXbXpVpcTuLqu4+Hhsifyv1bIW
         LOjaweGFwVn4VvublGXbfAuauibdvB33aRV8eXMzD8NPtf7NrDj95ML9Fz1+xRyXUXUF
         aQWIaJHMTfqroG93ZqtKm38ovuTHD7195i/10tIlqvMa/rf/hrNRGveUTNl3MKixrAyw
         xADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oUSmh1gw//zaj+S0sn3ELb0An6DYoYmCrSomQNeQSuo=;
        b=naU6S3e5583S/wdERr8Oi+drwOeiauqOAxeUp5BaGjmc9kk2IpUiDmHtQu3NIgSEHg
         w5bSSgV58WAMo1j+LLKE+0K2wm7/pOmuo2WRVWgj//I7En+p9DphOozPQh2XjhNaPQ9X
         LAaxjZBUXzgEjmBzYLcP63gGQ3lNnT6cHL8B4t5S0/vN0jTrIoiUYztLuFhBk12Wg1mk
         v5q+wIikHt1FJtwzsHM3XkKc/eEOxdknRUKOWGNHZ5n459iL6V+vNtMaCy1iAcresTfe
         La5xowam44dWygGSjT+fWoqFUFjYP0JZQsJ57G2wsM+5wTRr0zMlnnGvoP/Ct2YnknRp
         Pb9w==
X-Gm-Message-State: ACgBeo0dwydRPBLOkBQqXGC9/9oPGO8UqMZewv164RANB5XtjR+xOmPg
        sBG6QU6nbUgWWClgAs1NfYI=
X-Google-Smtp-Source: AA6agR6V4RLuMPnEjiL2znn+YMQ6Vt1ZTsSN5ljSQfnyiLsiInyzIy5k4oKF51jCVKJ5b+RWN5/U6w==
X-Received: by 2002:a17:902:b194:b0:176:d229:83bd with SMTP id s20-20020a170902b19400b00176d22983bdmr25286876plr.174.1662978554451;
        Mon, 12 Sep 2022 03:29:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a2-20020aa79702000000b00537aa0fbb57sm5060850pfg.51.2022.09.12.03.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:29:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] usb: dwc3: gadget: remove the unneeded result variable
Date:   Mon, 12 Sep 2022 10:28:55 +0000
Message-Id: <20220912102854.18277-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Return the value power_supply_set_property() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/usb/dwc3/gadget.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3a344ba0b292..762a92470a01 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2868,7 +2868,6 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
        struct dwc3             *dwc = gadget_to_dwc(g);
        union power_supply_propval      val = {0};
-       int                             ret;

        if (dwc->usb2_phy)
                return usb_phy_set_power(dwc->usb2_phy, mA);
@@ -2877,9 +2876,7 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
                return -EOPNOTSUPP;

        val.intval = 1000 * mA;
-       ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-
-       return ret;
+       return power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
 }

 /**
-- 
2.15.2

