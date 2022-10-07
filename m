Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261F5F7E89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJGUOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJGUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:14:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501992F4C;
        Fri,  7 Oct 2022 13:14:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so8793679wrm.6;
        Fri, 07 Oct 2022 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjdN1epbudHoaDX5Gr5XqTwUr3l144UmXNmf4GtxBoI=;
        b=BWBRco55gV0LI0BR1nirpeNjoMeGJTijQyiOupBMskuQ5qLAFzj3N3FY3m2f4KuhkR
         Va4t1ghG33YZEzh7OXqYrwK8P2CQqcr3c9vQZFdxmjdleRlNUnp1jwMrfca2DA5qj6ab
         HwGdEHLjiaSvk775c0uEkbC/FxzSYQTbbXOV8Hu04LNX6s19oic45lP4gtSoy1dFymOj
         6oq7gCxXVgN9o7CnxI9LU9BUrQ2mCyolqJsBDMVoCQgRSw//UlM2yvrxRsyywPhwdsUU
         f/7lBv1CIWHYakpb7B3OkRcMQeXqj6i3dtVzHnb5dKrNKHFTjXu9RIllG0bFOWofM20x
         rB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjdN1epbudHoaDX5Gr5XqTwUr3l144UmXNmf4GtxBoI=;
        b=4j5RC6McYKgHXXO+dQpvp4tOvMZzHxN7W3rlQGmWxUPOqqUnQanoEsjO9OtYQYRcj+
         B2hxe8LB/ewJzpNi7i/Z+/AzPBS8WJ5nNrXLCif4AR7xcg7lrFWld+PD3twMCnsPmz0P
         sUV6ysgLudeNUb8d+CsivsbJPst+VTRcQTFryZ3c0tueNagrD6jOKZ75ipnt9tDk9p7u
         kfiTllzIfxEKTxSbexvTHTjZtr9Bec/XwqN+8Xsvg1SOajhfC2Cj1z1+xUEETzMetPeD
         OYkx9czNp4QVCuUtiG/EsLvUflMAQW4r33gzEjkbbGcBjyxi2gnkRthN8jGAEU502vXT
         yuxg==
X-Gm-Message-State: ACrzQf1CeBnyLoSZeW2WU5jGJinCQMguU+44XRgx2wGOMAfeXwODjh5w
        //uRMLJQet1sqhNpwlyuKI1wVIs/nW+QFVcz
X-Google-Smtp-Source: AMsMyM46UJngVAxlex3V8qf2T2q/ZM5NoKaXqteSiHNlEpo5QYJyQJz4Mnw58UI+nqhedJcq5NanLw==
X-Received: by 2002:a05:6000:154a:b0:22a:b8eb:ba53 with SMTP id 10-20020a056000154a00b0022ab8ebba53mr4340652wry.594.1665173671712;
        Fri, 07 Oct 2022 13:14:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003c1b492daa4sm7670147wms.36.2022.10.07.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:14:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mm/Kconfig: Fix spelling mistake Endianess -> "Endianness
Date:   Fri,  7 Oct 2022 21:14:30 +0100
Message-Id: <20221007201430.2754917-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a Kconfig prompt message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index fc439c2c16f8..c5bbae86f725 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -743,7 +743,7 @@ config SWP_EMULATE
 	  If unsure, say Y.
 
 choice
-	prompt "CPU Endianess"
+	prompt "CPU Endianness"
 	default CPU_LITTLE_ENDIAN
 
 config CPU_LITTLE_ENDIAN
-- 
2.37.3

