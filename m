Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F668DFBC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjBGSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBGSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681ED3CE04
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o18so14447732wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmsSrOMQzGqTbxYtpsoEwK2HkdTJeu+/aeeH05/7YqA=;
        b=f+B7pQ4/XQkQ7xXipcWRh+TiWMSG5gm+0GbkQ2PucRVLd5klKA4IccE30Bjb5wfER5
         BdfjS7WfwXh3H+5bYEFO8f8bJOVohx3NPUDuTe93N5OoXwXVKUKKtbPIblo5v616vYZI
         NY6R10SIxVBjSASTKC17GkimZ4C6IeXssgnGvvl+EF3ZEUjHtoZfuhnjJB8Jwwklw9xv
         qMgYTjxjCuwCHqSu09OEsBRxPmkMqkVIsR4x8Q/2PY4Cfg3oYK2re51nZvQ0gRvjWecY
         StpRTtcAEsYZNt1jYkKArxXfMMirP5QTgLrCcmFLVSrNYk3oDqDH7q+7VUYrdsK1u9qv
         T4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmsSrOMQzGqTbxYtpsoEwK2HkdTJeu+/aeeH05/7YqA=;
        b=sJDZzD7xF1QIXUOzA+wH22pysIvj1xNaHAvqYEw0IV/v28MCVeg4BrwJW23j+ErEOt
         LCjRvrr+87QxIfbTiH+/jf2hKb7wR9ZKkF6NsOpA6EChaZJR7XkuktDG/Iu90MfzihZA
         jwPk2gGiGRP2TFQLBKibk1h5/4GSIowW9s4oPh7qiMnnDR7QJul4Zw/CZPU665uqO5Bg
         SMPzcCKbWIsTsva+zjn+uzMJmGigoATq/63jc3IF1hHWqJONfZCkWXp8lY1QaCb3CfGR
         nLXI8ikGSmovT0aT4Ttm1l7GYiU9qsBkm50+vINiI4URqUCmomD0rpGLTNAhnPtZRgpJ
         TGIw==
X-Gm-Message-State: AO0yUKUEHnzDzC0Nasffjxmti0maJUC1lnRPg1R1U2STvb7/IbSJTk//
        VKyyMjeC7Y8RmmUx0GhzBwE=
X-Google-Smtp-Source: AK7set+p+fuc0wTbFgAm+jOkR1yU0wq2yXJQnx5Qk4f0KSjukyV/d8krL0ixVB9BOhyK8r62fIe0Cw==
X-Received: by 2002:a5d:6707:0:b0:2c3:db5b:7277 with SMTP id o7-20020a5d6707000000b002c3db5b7277mr2621584wru.0.1675793803516;
        Tue, 07 Feb 2023 10:16:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5002000000b002c3be6ae0b1sm11756528wrt.65.2023.02.07.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:42 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:39 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Rename MacBlkCtrl and remove double
 definition
Message-ID: <8c0c46860fdb71660183fce567f7bc80e1d1ad36.1675792435.git.philipp.g.hortmann@gmail.com>
References: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constant MacBlkCtrl to MAC_BLK_CTRL to avoid CamelCase which is
not accepted by checkpatch. Remove double definition.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h     | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c        | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index cb455969f5dc..a2587300a47a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1861,7 +1861,7 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 
 
 			rtl92e_writeb(dev, PMR, 0x5);
-			rtl92e_writeb(dev, MacBlkCtrl, 0xa);
+			rtl92e_writeb(dev, MAC_BLK_CTRL, 0xa);
 		}
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 75ef179e28c4..795efa8d3181 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -242,7 +242,7 @@ enum _RTL8192PCI_HW {
 	DRIVER_RSSI		= 0x32c,
 	MCS_TXAGC		= 0x340,
 	CCK_TXAGC		= 0x348,
-	MacBlkCtrl		= 0x403,
+	MAC_BLK_CTRL		= 0x403,
 };
 
 #define GPI 0x108
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 433272a2aae8..f846f109ed98 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -42,8 +42,6 @@
 #define CCK_TXAGC		0x348
 
 /* Mac block on/off control register */
-#define MacBlkCtrl			0x403
-
 #define rFPGA0_RFMOD			0x800 /* RF mode & CCK TxSC */
 #define rFPGA0_TxInfo			0x804
 #define rFPGA0_PSDFunction		0x808
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
index 82b45c61ac75..9c80dc1b6e12 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
@@ -41,7 +41,7 @@ int rtl92e_suspend(struct device *dev_d)
 		rtl92e_writel(dev, WFCRC1, 0xffffffff);
 		rtl92e_writel(dev, WFCRC2, 0xffffffff);
 		rtl92e_writeb(dev, PMR, 0x5);
-		rtl92e_writeb(dev, MacBlkCtrl, 0xa);
+		rtl92e_writeb(dev, MAC_BLK_CTRL, 0xa);
 	}
 out_pci_suspend:
 	netdev_info(dev, "WOL is %s\n", priv->rtllib->bSupportRemoteWakeUp ?
-- 
2.39.1

