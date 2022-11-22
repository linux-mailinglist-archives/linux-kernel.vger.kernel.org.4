Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC5634A41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKVWqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiKVWq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B4CB9F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x5so22932239wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLjjlcGTaW2VPVbDaaDB7cRE9v4ZMit0fR2VgDn30QM=;
        b=HTTkiYlIc9Ku+jNrHublAdad+nJaZNuUMCLWS0dq7OdKjZjk8DQKouCO+fBmIJXUr1
         6Gj+FOHaPiWkfl2lUWAM0X5349dLz0y6ZkgASzs3o8LKGrcVIcRwK4o/scaGira1Jbn5
         G2HZx9wQ2AU3FpjfYm33eUHPqhlQY0QfjMYrV7jfTLWgTkNWvTFwScR3b+cXfXXaX+JX
         cPKke3t2xd/1eg2v3Aj2lPFEOqzt1PpEQOuAFtrU/ZG6205y4XYsQG8tUKAwuwVPMHKa
         b17lcPfd6pnV6vbPWrda9dPDYfx8xHx/my+i13j16wQkMD3Nj28y515hKjQywLUqFYsl
         viHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLjjlcGTaW2VPVbDaaDB7cRE9v4ZMit0fR2VgDn30QM=;
        b=Fc5o+/gZWKeKFGZqhvOBvOGBlN5vE0Qozh0Tasi9Ll8JRouGlq9XCu9YOBvDztKK+1
         dqS9JFgwbLYtbxwYfUqt2hfc/VupEaJai8l91BLTcvXBdoe/knmorXvLd8QblWsYjymp
         Sek6RwzkwI5FqDJyCXLq9IUOsVr2Yhp22VL038TBNbcdhC8X4njvOAJql5RsXWSTLlKn
         R/U7Dn7dGFOSUeme+6tb5VuHKYwa170pyrawcHKzNVEW0aS7hcn5YAefauzUz8X/5bmc
         2KhCzTza3D+GwkstkrXkARKBoc02yOuGuI2NgSqeXJUmFSPm5K/Jl5tXbq2h8uZk7HQ2
         M4KQ==
X-Gm-Message-State: ANoB5pnR4zXax5ZH4CM3n0FKcnTxUro2XKItuSomdGpiCixeBwpU36Gq
        HI4Pf3lZxHQloFdCGwAoKj8=
X-Google-Smtp-Source: AA0mqf5XugPomKIinxu2xA5lQFggHnOmjU9XgebG8dPdPCVUfTH53hlM8f4GVwCweODBIXv/4e9sRQ==
X-Received: by 2002:adf:ea52:0:b0:241:b999:9e8f with SMTP id j18-20020adfea52000000b00241b9999e8fmr14552580wrn.151.1669157183435;
        Tue, 22 Nov 2022 14:46:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c7705000000b003cfd4e6400csm154351wmi.19.2022.11.22.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:46:22 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:46:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8192e: Remove unused variable
 ChannelAccessSetting
Message-ID: <b88a31954532f47a4caf9abfcad8e20b32a618cc.1669156825.git.philipp.g.hortmann@gmail.com>
References: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChannelAccessSetting is never used. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1c00ad709a3c..ca2e685148d4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -234,15 +234,6 @@ struct rt_stats {
 	u32	CurrentShowTxate;
 };
 
-struct channel_access_setting {
-	u16 SIFS_Timer;
-	u16 DIFS_Timer;
-	u16 SlotTimeTimer;
-	u16 EIFS_Timer;
-	u16 CWminIndex;
-	u16 CWmaxIndex;
-};
-
 struct init_gain {
 	u8	xaagccore1;
 	u8	xbagccore1;
@@ -321,9 +312,6 @@ struct r8192_priv {
 	struct delayed_work		txpower_tracking_wq;
 	struct delayed_work		rfpath_check_wq;
 	struct delayed_work		gpio_change_rf_wq;
-
-	struct channel_access_setting ChannelAccessSetting;
-
 	struct rtl819x_ops			*ops;
 	struct rtllib_device			*rtllib;
 
-- 
2.37.3

