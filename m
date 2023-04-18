Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D26E6D39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjDRUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjDRUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:02:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCB44A6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:02:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50671ef0c48so664942a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681848124; x=1684440124;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsFVuXE61PbLw9YtM+jxEDcHooXCuW3K6esrr2BCHUs=;
        b=RJSd8ztUkMXfjKj2IFMPJud3LXOVWy9ZT+F1FDzl/BveJrXCo7/SuFeiZtjIEV6v1l
         JLvipWe+etghOYMPkO1N4WGyAsDjtyY8zagft20AJAomxd5uYUtpBfVExN5sCgCewMcL
         WPhPxa0i3pN/23Dmj2tqxL3Z2xZdfrpkcreZte53NtKrhNSqhfoZic2eIn0KuRsfk8mg
         ks+vQlGhdXKNOrUoF/EgWy6EOKzIlAKGqxCGeM9vn+Iu93/vVeHpW7yGx6TpxbzfBa8y
         SZTpEZ3ohNPRjz3VUjM0rRPCW79jPnsSPHhLYi5EWDmgjfsCpIz7lbWcp3uuwvkQVv3v
         UAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681848124; x=1684440124;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsFVuXE61PbLw9YtM+jxEDcHooXCuW3K6esrr2BCHUs=;
        b=TZGlbFI0HuIhzBdK4OtHgrebkCzLE6zgw7lXQzoLvAERGqTEwbBmq3LMJMMob8oqmh
         C+6XcEV+ANmW864Sx5BG8neSj+kx/QO7ZNKUxKs1H/Gi7QXxhwzvLc1pBGgmIZuZhILh
         CyadBRNstV6HjGt1Ug/5VJXCRVCmXIhphA3K9CbccG0KcDHVTGpTTiB8baQ7UVuxGFyd
         Sxt2GYStbJ3m55nZDo+YC32umgxj3JnzX+vTFHsO1GKVxISg8tPC/LUhsTIWpjAj9LI2
         6A6GNIEuXVUhPXfFfqarGlR/epNnY2UO4zQ3dBRUMMQNd9PMwZV7EfmHihczOab2oLVv
         y9HQ==
X-Gm-Message-State: AAQBX9dgHL8ZsuokcVZsiGtSeM8oItOL7X5OxoRVxbzVyaqWQkmbq/0y
        uuJ/MWTRjDSJFx+A7Q4Y9I4=
X-Google-Smtp-Source: AKy350ZwNs3E8lPGplBIvyWZE2u91zV7h78+pgwfvhHLpZndxunn86Wb3edvlIvy4Il+7UWVtUYaOg==
X-Received: by 2002:a17:906:19c:b0:94f:66af:b1f7 with SMTP id 28-20020a170906019c00b0094f66afb1f7mr7316763ejb.1.1681848124259;
        Tue, 18 Apr 2023 13:02:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ay18-20020a056402203200b0050504648fc4sm7394370edb.80.2023.04.18.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:02:03 -0700 (PDT)
Date:   Tue, 18 Apr 2023 22:02:01 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
Message-ID: <20230418200201.GA17398@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading the driver for rtl8192e, the W_DISABLE# switch is working as
intended. But when the WLAN is turned off in software and then turned on
again the W_DISABLE# does not work anymore. Reason for this is that in
the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
checked and returned when true. bfirst_after_down is set true when
switching the WLAN off in software. But it is not set to false again
when WLAN is turned on again.

Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
above described bug.

Fixes: 94a799425eee ("From: wlanfae <wlanfae@realtek.com> [PATCH 1/8] rtl8192e: Import new version of driver from realtek")
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Added Fixes Tag
v2->v3: Changed Fixes Tag from https to git commit id

Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4cf84b5666a7..27040d1e3230 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -645,6 +645,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
-- 
2.40.0

