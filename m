Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056BA67FFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjA2O7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjA2O7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80325F750
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so7468581wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyvKP4txQ13hA3WgepX6K+C6nDjIWuymKszT6lxk42U=;
        b=SqTC1lH9c+quHuDgGjFZOwgvbXTCJGzGUtee6cQENP2LMMrrqgbzbMqwDWWPcXZiI+
         2LE2M+NFydezoE4SyPVKtdGQUaEvtDYgkm3/KWdGLgERRc25WA+LLrBjvko6qGwYacBS
         6UpgSqicII3V5ehThNEZe5K97HD9NEiF5E+Z5ielQnsBjThnqiscfVoG7CWlwgKH67zB
         TtBGQa/8CPiBhkDgMBieJmNa+tHqwT4sojmHhkv5R0/Q1Vi4WpTFJv+sk+nh83MgHKxz
         Nv1IzhYJY+Vw59y5c0i6wbwOzamg0DdG0bjbsRFrU/VzQU2moIP1dLAUwbPm0TfaJCQs
         jMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyvKP4txQ13hA3WgepX6K+C6nDjIWuymKszT6lxk42U=;
        b=LEWOUbS0lfGEsO0m+S8M0hHahvFKLYAFI1fw6HSooW+wNleZEhp/vuNpJpzf2DlNlP
         NTz0zcrys5F/zFCeLwOrACiREmYjgC9DJ+s6bZm86Fm7sPAgBt9lh9a5PluRRM610lFB
         92FsF2e+01vHsAfipPP+ce7iju16VieVs8Zdbd9M+3ec2dr7u1ba8drEXR4MsHNQqHjq
         qjZuwyFRLVMgpn6r/+YQa9U1Sf2VUSzsBXFV5BCxT8+Dd4/gNoeP/nwoPkOxpYsXETh1
         40wbXu0pW6brRTXZtWN76D2ml0UjlDtt2FgadBdlCpjyD7Xw87Wv3E322zI2nxows+Kn
         ti9g==
X-Gm-Message-State: AO0yUKX2xwMs5ZjK1fTBkKJndVp/RcBqCI5cTOAECuyCGvduNRNTk7+/
        88MN9lSFww3R8sDGi/lMiTQ=
X-Google-Smtp-Source: AK7set+PZCcyiCmeYuSRg30WqJc7QgxR+F2xwdzL5dzChR+UQMuHUKi1gcVCqqCFxb/4UF7Qgj2z3w==
X-Received: by 2002:a05:600c:5008:b0:3dc:557f:6122 with SMTP id n8-20020a05600c500800b003dc557f6122mr386081wmr.1.1675004319099;
        Sun, 29 Jan 2023 06:58:39 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c099000b003daf681d05dsm10048927wmp.26.2023.01.29.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:38 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:36 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove unused constants at
 beginning of r8192E_hw.h
Message-ID: <d01232f5ef10eac02abb3f31f2ac6f53614fa954.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constants at beginning of r8192E_hw.h. A part of the
constants would need to be renamed because of CamelCase on others spaces
are missing before and after "<<".

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 38 +------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 858cfc203f13..cc1e62f7074d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -12,63 +12,27 @@ enum baseband_config {
 	BB_CONFIG_AGC_TAB = 1,
 };
 
-#define	RTL8187_REQT_READ	0xc0
-#define	RTL8187_REQT_WRITE	0x40
-#define	RTL8187_REQ_GET_REGS	0x05
-#define	RTL8187_REQ_SET_REGS	0x05
-
-#define MAX_TX_URB 5
-#define MAX_RX_URB 16
-#define RX_URB_SIZE 9100
-
-#define BB_ANTATTEN_CHAN14	0x0c
-#define BB_ANTENNA_B 0x40
-
-#define BB_HOST_BANG (1<<30)
-#define BB_HOST_BANG_EN (1<<2)
-#define BB_HOST_BANG_CLK (1<<1)
-#define BB_HOST_BANG_RW (1<<3)
-#define BB_HOST_BANG_DATA	 1
-
 #define RTL8190_EEPROM_ID	0x8129
 #define EEPROM_VID		0x02
 #define EEPROM_DID		0x04
 #define EEPROM_NODE_ADDRESS_BYTE_0	0x0C
 
-#define EEPROM_TxPowerDiff	0x1F
-
-
-#define EEPROM_PwDiff		0x21
-#define EEPROM_CrystalCap	0x22
-
-
-
-#define EEPROM_TxPwIndex_CCK_V1		0x29
-#define EEPROM_TxPwIndex_OFDM_24G_V1	0x2C
-#define EEPROM_TxPwIndex_Ver		0x27
-
-#define EEPROM_Default_TxPowerDiff		0x0
 #define EEPROM_Default_ThermalMeter		0x77
 #define EEPROM_Default_AntTxPowerDiff		0x0
 #define EEPROM_Default_TxPwDiff_CrystalCap	0x5
-#define EEPROM_Default_PwDiff			0x4
-#define EEPROM_Default_CrystalCap		0x5
 #define EEPROM_Default_TxPower			0x1010
 #define EEPROM_ICVersion_ChannelPlan	0x7C
 #define EEPROM_Customer_ID			0x7B
 #define EEPROM_RFInd_PowerDiff			0x28
+
 #define EEPROM_ThermalMeter			0x29
 #define EEPROM_TxPwDiff_CrystalCap		0x2A
 #define EEPROM_TxPwIndex_CCK			0x2C
 #define EEPROM_TxPwIndex_OFDM_24G	0x3A
-#define EEPROM_Default_TxPowerLevel		0x10
-#define EEPROM_IC_VER				0x7d
-#define EEPROM_CRC				0x7e
 
 #define EEPROM_CID_DEFAULT			0x0
 #define EEPROM_CID_CAMEO				0x1
 #define EEPROM_CID_RUNTOP				0x2
-#define EEPROM_CID_Senao				0x3
 #define EEPROM_CID_TOSHIBA				0x4
 #define EEPROM_CID_NetCore				0x5
 #define EEPROM_CID_Nettronix			0x6
-- 
2.39.1

