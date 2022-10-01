Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009DF5F1B7E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJAJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJAJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:40:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A8476D9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:40:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so13513870ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=1MtTj3cT/5VTPlvXh/pGzQBDICycaSPpTW526Zz8N3w=;
        b=EW8byPsve0k20XTqJ0YLQ5udpxEwQaGE7Wjls6o6hzjAdfhVZnGIxUdxoEsjfrO6Zi
         I+2FS4yKyjIzR0c7yGST3t35VzfblDiZNLi4p9S14aioUTdiUgfL3O0WavMDi+lA1ulg
         0gNq7kMV0EhOsFQBwGdWjHgicBhxbeNiEh6rLXqUMPj668CDgNmYbLoT0ypddf/KwibV
         RZT38zoBNUw17SSDbigfUrRrBTQJLcfcmT1WtgVEOXdj2bnJchJqRDGxaA4Picgex5Kv
         yL2ZwkL8lDvBgMy6iuY8/At/bQ2SqQErwwXRui+XB7ZpnK8UgMAAQTPbJq41ZQ88+VoS
         kVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1MtTj3cT/5VTPlvXh/pGzQBDICycaSPpTW526Zz8N3w=;
        b=XZpPOqB2aDans9mssho3kpO8O8LqxJbe1M2UbDG0rHqrL03dmhAYAx8mBCo/FRvzqy
         OHwb9nHGrQGD93+9bVxdQMeoCeff5FxJHMDV4F57ajONxOdgA+j1Crll7W3DHx/6fgH5
         PYcPde/FslLJx28LtcrkkxVfxJvzPQL9yoGORKJ5sN4S56UtDh7oHa+F/4ArnAIlYPhE
         /o2/aOdTIb2Odw541Ee3QTtWwy/gOgf1awD4W5lXDW+vF0NxUsMFfcXHYzmz/gTYGOmQ
         d6Ha2tUAgZM9TYYwEbdf7Dx4vygV8KeITewoXldyKj6fjkR2U5zHa8EXPUrzXL7LWcr3
         EQZA==
X-Gm-Message-State: ACrzQf2C/1S5lRnyBkdLZnhhnoRa8dLGh1V0wiBwGmFgQTlV1jfEmWWC
        SCxBtT4iYJCf4xG073UU8f4=
X-Google-Smtp-Source: AMsMyM5oFGYyDqHQAUn8E/FsLBHdUUxu5CKP0PRBhzvVZgEc0urh2Gdfke6Zwj6t96mBjfIGd+wI2w==
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr8884418ejc.605.1664617251958;
        Sat, 01 Oct 2022 02:40:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id bq10-20020a170906d0ca00b0073c82539183sm2464476ejb.91.2022.10.01.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:40:51 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:40:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove unused variable
 bIPSModeBackup
Message-ID: <657035f84d266fd5c6f96e9b530a96c2ab4ff900.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bIPSModeBackup is just once initialized and never used. Remove resulting
dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtllib.h            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7c0fd2bce923..cbb65cfea83a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -886,7 +886,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
 	priv->SetRFPowerStateInProgress = false;
-	priv->rtllib->PowerSaveControl.bIPSModeBackup = false;
 	priv->rtllib->PowerSaveControl.bLeisurePs = true;
 	priv->rtllib->LPSDelayCnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d23d1c3ce39b..e0fa87b12ceb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1250,7 +1250,6 @@ enum rt_rf_power_state {
 };
 
 struct rt_pwr_save_ctrl {
-	bool				bIPSModeBackup;
 	bool				bSwRfProcessing;
 	enum rt_rf_power_state eInactivePowerState;
 	enum ips_callback_function ReturnPoint;
-- 
2.37.3

