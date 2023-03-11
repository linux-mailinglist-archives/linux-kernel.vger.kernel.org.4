Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DD6B613C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCKVwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCKVw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E46A43A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j11so34458884edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTTDljF28vO5H18k+KEi+7UKj1Xzue+t1xSVjk5WnDY=;
        b=Pk/oE6M2D/waIVTAwHCuGea9qIaLSfIwfe4ngILjkk3KWDiVrIxMHgBUP0qAUjWQdc
         Fmwp6jM6ObotUih74SJrCNcTfg8RRaaZyZ7H/80HgZE9KK0Q6pnegkYQ0AWPzpdRpxgX
         tTh2zPWZdYvelCMlcmn9L8DGMWlh0Jli4nAPcPpW+wO+Kr8jnMo4nuaVaAa7Mo/QMM9d
         AG9DNMUBWgAq/IH6euX+Vd1gCWbfV6otLmxXKz97ULORq4is5mxWOjJipt5LUdWNMMqr
         366w341BVFUyebGfrgfIOKtOvDz1dWOOP3XIGiGLTEtIa1ONRRkD2J+bXS3V+CYr9Vgt
         dH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTTDljF28vO5H18k+KEi+7UKj1Xzue+t1xSVjk5WnDY=;
        b=EcGXzwdn0LnzSv7YeXsrGfGB3u6F0tEU6ZqfmcjRjXMUsDkFJ2xHCqbh9mrR9H910R
         7CHcHxtnSciiLFoFTVOAZFS4k0U55WuBHX63RSAOzKVIaNlEGIWOyFOg66E2LrwnUJFg
         MgBQRUnNcsSsx8E/qOZlkvZWYud1/PebqV5ASK6j9KNL6fa/U/h3S/q6bDN5P06aKYxP
         053ONxPAtQ8xQPGcxZtPRUMVjoBFNbyrVgUY4NY+zPmrvQjtNoJphn+/MKqwP12KDklI
         kCv8AuxjyhnbI88q5phULPpWpz+11XcVsV80jQTB8l6lRaCpVM16oY9jtRylbSNIxbyv
         AnAA==
X-Gm-Message-State: AO0yUKXelDJDJt5poku0bhEaIiFUUX1TWWaFeZuS5yhqDNUbrMbxX/ZG
        U69wjichZpJimvnVF9SsQ/MVZDPjvWY=
X-Google-Smtp-Source: AK7set+PHiZciZpW3dAVj9Wm59PkUQPLopsZKcnZlvywoLG/k0MX27HZwGyWlmuIlOxvJMx0zLNFTw==
X-Received: by 2002:a17:906:15d:b0:888:346a:fb48 with SMTP id 29-20020a170906015d00b00888346afb48mr7103708ejh.0.1678571524440;
        Sat, 11 Mar 2023 13:52:04 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b008e51a1fd7bfsm1532653ejc.172.2023.03.11.13.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:52:04 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:52:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] staging: rtl8192e: Remove unused variable
 rfAGCControl1 and rfAGCControl2
Message-ID: <0f191930597517cf88eb6effd4c20a46c99571ad.1678569965.git.philipp.g.hortmann@gmail.com>
References: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable rfAGCControl1 and rfAGCControl2 because they are
just once set and not used. Remove unused constants as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  4 ----
 3 files changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index d42eac4b6012..a5d99891688d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -107,8 +107,6 @@ struct bb_reg_definition {
 	u32 rfintfe;
 	u32 rf3wireOffset;
 	u32 rfHSSIPara2;
-	u32 rfAGCControl1;
-	u32 rfAGCControl2;
 	u32 rfRxIQImbalance;
 	u32 rfRxAFE;
 	u32 rfTxIQImbalance;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index add3de156e09..32806bcc953a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -373,16 +373,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
 
-	priv->phy_reg_def[RF90_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
-	priv->phy_reg_def[RF90_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
-	priv->phy_reg_def[RF90_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
-	priv->phy_reg_def[RF90_PATH_D].rfAGCControl1 = rOFDM0_XDAGCCore1;
-
-	priv->phy_reg_def[RF90_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
-	priv->phy_reg_def[RF90_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
-	priv->phy_reg_def[RF90_PATH_C].rfAGCControl2 = rOFDM0_XCAGCCore2;
-	priv->phy_reg_def[RF90_PATH_D].rfAGCControl2 = rOFDM0_XDAGCCore2;
-
 	priv->phy_reg_def[RF90_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
 	priv->phy_reg_def[RF90_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
 	priv->phy_reg_def[RF90_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 5062be507a30..d0ea7e06f0f7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -117,13 +117,9 @@
 #define rOFDM0_CCADropThreshold		0xc48
 #define rOFDM0_ECCAThreshold		0xc4c /* Energy CCA */
 #define rOFDM0_XAAGCCore1		0xc50
-#define rOFDM0_XAAGCCore2		0xc54
 #define rOFDM0_XBAGCCore1		0xc58
-#define rOFDM0_XBAGCCore2		0xc5c
 #define rOFDM0_XCAGCCore1		0xc60
-#define rOFDM0_XCAGCCore2		0xc64
 #define rOFDM0_XDAGCCore1		0xc68
-#define rOFDM0_XDAGCCore2		0xc6c
 #define rOFDM0_AGCParameter1		0xc70
 #define rOFDM0_AGCParameter2		0xc74
 #define rOFDM0_AGCRSSITable		0xc78
-- 
2.39.2

