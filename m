Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A36D89C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjDEVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDEVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:48:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395A4C03
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:48:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94706a972f3so6872566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731284; x=1683323284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOZBenPjCQElNBV9GC58Q3qKs5/Fllkis9cJIxphAWQ=;
        b=mNUK5sOtttLZfKBNZM2tGZvdtvWYZCi/DnyFtaxmPQB43zb8poHNgldRs20Ns2x/+8
         NcYR46166zF7r6ZSTFAqqmVQs5Fi+xyT+IdIIr4lL48NwmuQtidNzScSnXcu0DpuoLFt
         FAO5lVFsiTnL+6uR4BtwJAk0AbIiI3XDTziLIHLsI22xYhx1op0T8ccXE1fsIw/t1SJg
         8xbwJ8gUZDm5k1SgPLCDZCgyos0ymEWNRduotWj6V9WWMlHWPwLHZEKqeB9NV7lNt0jY
         9zJjTKxUiKezYFAWKabvEmAHnUrpJlxBseIu90twrrVblVQ2X7T3at9syByq6K01CJoI
         7E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731284; x=1683323284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOZBenPjCQElNBV9GC58Q3qKs5/Fllkis9cJIxphAWQ=;
        b=CsoDPaQJGdFnOFhyu7r9A0+4WsL+3fKgyd0wj9eirbjb7nL4Z2A+62qXIM9Qh6wVAb
         wOOb27LTFNs8DCefLwpJbwG42XuriW08DDyk9DPIHaC3jpSliq3fU6Ybw8y+QRYLqqvH
         C84XLxnI7pfNskD9bKHWf5IEHDofgwKxCalReHJfVx6Aaak4ox1vMEXsv69ZHnQhT44o
         09Ft/XssXvuVrlT65qdmooN49GeVV2BFLPJH2ie75fQj6SD37QLN0tyJM9GbZXzvJYIj
         yODG48WEbIc9STGJewNy+kcN21kZ1deb4joP5vqcsKs/keO8gZIAzd0CippZOjyqFfL5
         l/pA==
X-Gm-Message-State: AAQBX9dt0aXYp5Hwd8Jdvg478rnI5CMQImIlJCqjripRVwyFtU86Zy35
        /7dxqudntH9CxoE6o7n+I3T1e7WGxaQ=
X-Google-Smtp-Source: AKy350aZL+LtplhvFrytwP0+UngaZUt0frcaj0hQk2LZGzxc/dZ1+8TRMb5g742bf8gkEbQokA32xA==
X-Received: by 2002:a05:6402:1e8e:b0:502:1f7b:f069 with SMTP id f14-20020a0564021e8e00b005021f7bf069mr3427551edf.2.1680731284278;
        Wed, 05 Apr 2023 14:48:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id j26-20020a50d01a000000b004c4eed3fe20sm7853521edf.5.2023.04.05.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:48:03 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:48:01 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: rtl8192e: Remove macro IS_HARDWARE_TYPE_8192SE
Message-ID: <c3df7831f519ae4718a52c05d9db9bdb05aaa22b.1680729715.git.philipp.g.hortmann@gmail.com>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro IS_HARDWARE_TYPE_8192SE as it is used only in code
areas that are not executed when 8192SE hardware is found.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 7 +------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 2b2d8af4cf6e..b0aa76574738 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -52,9 +52,6 @@
 #define DRV_AUTHOR  "<wlanfae@realtek.com>"
 #define DRV_VERSION  "0014.0401.2010"
 
-#define IS_HARDWARE_TYPE_8192SE(_priv)		\
-	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
-
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index cde41111012a..50486f2a6f3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -214,8 +214,6 @@ void rtl92e_dm_init(struct net_device *dev)
 	_rtl92e_dm_init_fsync(dev);
 	_rtl92e_dm_init_rx_path_selection(dev);
 	_rtl92e_dm_init_cts_to_self(dev);
-	if (IS_HARDWARE_TYPE_8192SE(dev))
-		_rtl92e_dm_init_wa_broadcom_iot(dev);
 
 	INIT_DELAYED_WORK(&priv->gpio_change_rf_wq, (void *)_rtl92e_dm_check_rf_ctrl_gpio);
 }
@@ -816,10 +814,7 @@ static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
 	static u8	TM_Trigger;
 	u8		TxPowerCheckCnt = 0;
 
-	if (IS_HARDWARE_TYPE_8192SE(dev))
-		TxPowerCheckCnt = 5;
-	else
-		TxPowerCheckCnt = 2;
+	TxPowerCheckCnt = 2;
 	if (!priv->btxpower_tracking)
 		return;
 
-- 
2.40.0

