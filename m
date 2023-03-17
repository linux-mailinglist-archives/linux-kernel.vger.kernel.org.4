Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9326BF183
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCQTNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCQTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DDAFBA9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so24254400edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080402; x=1681672402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/tOVTwHPYMxKxFkN8GBzVBBS/KLVnVcYggCNSJXFWM=;
        b=RVjSi1xlwcd297KIx/onBcV5sHO7ipIEUYocW6s5jq8wBgoF7WpY3fT0US4SJbZrJm
         lkRUFWPSwqtNp92YqK8FMO5Hycg/irXxfVG4YWNsIZsbKjBvEHNxJfNZ3lLvWFZRBJ4q
         YSOFPhGI6bzwww/0gUS2lWrtQXeBL6PhHwpDaNyj5cpdinc6iuKpcHmTvGrIeDXq9IFL
         oLjSpL11E2RjS8XJe8aWBwi70KmxaYKpzJcD+TMwPMs6tavePcQ8v2pU54phJn8UU0cE
         YiHvY3vuw4p9A+iqGXBU6EHjm0Ya8c/pRtFTAGgiFcbkX3YqFzHfHSJ0SsVm+T0a2OiH
         bh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080402; x=1681672402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/tOVTwHPYMxKxFkN8GBzVBBS/KLVnVcYggCNSJXFWM=;
        b=PKFrOXPh1ha1mfAFokRX2b1CTSh7R3UDP2s89kCzQuV5UbDBpuzuGbOzW47vScw8Vq
         EV2iOkqgxTAuRwDPmURhrQN6DYPnoLpqdRO9iiGs8xxQC2BoZO1v9hJoTeS7kwuenHzE
         1flBFRhCt2C7jbce178BXWBncuAT5xagm5eyEEFvvGprQrQQzNKretHBDmKYq/0ojWh6
         63Q5OgQbFTmvzdV7t8WlTlY7iIeRZ+Ty6tCDs6HrsKeeXKITS3U/k+2xKf5jQHKDtvH6
         OtEbX657EmXz6CAW1c1EthbYSljhnqSdqrzH1Fo2f4poJfw8CprRIMYR6zI/irMuhMaq
         MR4w==
X-Gm-Message-State: AO0yUKXeK2lrGvOqSr4SeWDJ1Hd4Wz6WbpC6fKeA4bn4WlYE/6FSyyU2
        0VQshvARWIHF+ZphfmufmTw=
X-Google-Smtp-Source: AK7set/NM5I8jwU6OK/iN27zYtM/IBsgcURe652ZEyUFDnx2xN4V4Xgjs4Tqvcl8yhFPoLCqT5TT3A==
X-Received: by 2002:a17:906:518e:b0:929:b101:937d with SMTP id y14-20020a170906518e00b00929b101937dmr6646857ejk.1.1679080402391;
        Fri, 17 Mar 2023 12:13:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id lx12-20020a170906af0c00b008e57b5e0ce9sm1272413ejb.108.2023.03.17.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:21 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:20 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] staging: rtl8192e: Remove double defined constants
 bMaskBytex and bMask..
Message-ID: <b12364a090a0ff2fd717cfe0e93eefc839cce937.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double defined constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index fd34756e450f..498da6be3e4e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -25,14 +25,6 @@ enum rf90_radio_path {
 	RF90_PATH_MAX
 };
 
-#define bMaskByte0                0xff
-#define bMaskByte1                0xff00
-#define bMaskByte2                0xff0000
-#define bMaskByte3                0xff000000
-#define bMaskHWord                0xffff0000
-#define bMaskLWord                0x0000ffff
-#define bMaskDWord                0xffffffff
-
 void rtl92e_set_bb_reg(struct net_device *dev, u32 dwRegAddr,
 		       u32 dwBitMask, u32 dwData);
 u32 rtl92e_get_bb_reg(struct net_device *dev, u32 dwRegAddr, u32 dwBitMask);
-- 
2.39.2

