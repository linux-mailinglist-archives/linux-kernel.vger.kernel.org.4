Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4676D29FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjCaV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjCaV2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8221A8E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so94890617edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298110; x=1682890110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ou/EV0dTqA/jTIKJ3wQ2Lp2bM3Hd0avOtCVCqCD0Yds=;
        b=PCSwtAhLBW+9hO7OghdXuhAPmZIkwabNBzILwMsID39DXlNu6UTjh/TjpbPlE2sNHD
         Bk9SN33zk/kBnLF9dKPBXL/DTitZwwCgomOEYvdVPVEoPJidoPvAG6N+CfokSHg6qFXD
         ntM3kur2dYBVsoTvFdv4XeUo+hRmhd2SfK4x16cxxSg1R5tiBodBIgxfHFLGt4RaNaiQ
         QvsTGwjFVlyv1AhPH6cqKi7+VHc/hCZcLjKTUGw5FoNBKUFiEBGo7HaPuPHWXb8I0yQQ
         9h/MmSh9u4wTGXjCWcvOQ3LF6pzShKjDrZuV/xmNJjoZEX5kfnK1JcigQ8Hnlkdtnqoy
         vmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298110; x=1682890110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou/EV0dTqA/jTIKJ3wQ2Lp2bM3Hd0avOtCVCqCD0Yds=;
        b=UIWAMmJ9CNlNz5PFB1sUKE+c0ArX0jSd+o4REjmazGw/cyZchb7edv3Cc6yrSjEhSg
         aIo7nlExa0uFxS8YVRXHr+Dsr578v8oO+izHVCxYig+zjOwUCRijMi8J6rSSCk0Hm97y
         k8BxoIDrEcwbp6qQRkI5TparGDcmN3+AOr+qKPDBuBO3nRkcvi6z8RBqV60+cFCK1Yzd
         JaVf84fMhsDO/9IWluuJiqBE528/JGO5rWItleghFEDOClip1naRcsXf30AeNa7HuYMY
         zL6jFn6r3an/upv6dx7NYCf862kvsjUZ3SaUXiAJ85naFq7jvPRnwmoO1BTI3PH1HCV8
         dc7g==
X-Gm-Message-State: AAQBX9dvFJmQHxWnE9x8CeTjMtbPGjqxDcx1IGLSzIRaT3abOamp4WQF
        GXYSYzc8CqOJL8TzW0gRpl8=
X-Google-Smtp-Source: AKy350ay9EDB9BVpddsn8Gbt3dyTky5cd2zQgtWfTNLnHQvLCKI/uH1KqBJJLNtWFD6exCxLmbRAIg==
X-Received: by 2002:a17:906:28e:b0:947:404b:eb2 with SMTP id 14-20020a170906028e00b00947404b0eb2mr6603384ejf.0.1680298109788;
        Fri, 31 Mar 2023 14:28:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ce13-20020a170906b24d00b008e68d2c11d8sm1354003ejb.218.2023.03.31.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:28:29 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:28:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8192e: Remove case customer_id =
 RT_CID_DEFAULT, ..
Message-ID: <c1db11f9d8b8bb76d9b4244b3ac81432a90f8594.1680297150.git.philipp.g.hortmann@gmail.com>
References: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

customer_id is initialize to zero. Changing customer_id to RT_CID_DEFAULT
will not change customer_id as it is already zero. default and
EEPROM_CID_WHQL contain only a break. Remove useless code lines to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 --------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index df8de35cbe0e..aed53fedeb61 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -432,9 +432,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->chnl_plan = priv->reg_chnl_plan;
 
 	switch (priv->eeprom_customer_id) {
-	case EEPROM_CID_DEFAULT:
-		priv->customer_id = RT_CID_DEFAULT;
-		break;
 	case EEPROM_CID_NetCore:
 		priv->customer_id = RT_CID_819X_NETCORE;
 		break;
@@ -445,11 +442,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		else
 			priv->chnl_plan = 0x0;
 		break;
-
-	case EEPROM_CID_WHQL:
-		break;
-	default:
-		break;
 	}
 
 	if (priv->chnl_plan > CHANNEL_PLAN_LEN - 1)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 4ee78b7a558e..f4d4b01630a2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -30,10 +30,8 @@ enum baseband_config {
 #define EEPROM_TxPwIndex_CCK			0x2C
 #define EEPROM_TxPwIndex_OFDM_24G	0x3A
 
-#define EEPROM_CID_DEFAULT			0x0
 #define EEPROM_CID_TOSHIBA				0x4
 #define EEPROM_CID_NetCore				0x5
-#define EEPROM_CID_WHQL					0xFE
 enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
 	MAC4			= 0x004,
-- 
2.40.0

