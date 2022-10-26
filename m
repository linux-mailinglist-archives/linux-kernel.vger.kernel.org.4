Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB260ECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiJZXbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiJZXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:31:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448452801;
        Wed, 26 Oct 2022 16:31:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i21so23149118edj.10;
        Wed, 26 Oct 2022 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blkh6ovMYUp3pDOL1MPn2xwiUyXrUXCvpPiJ5Ef5AB8=;
        b=OT8jb3uEhHe2gH4MVt3ES3GKG5GA6wEA15RnpL0RqD0/IqFJ9xhYBvs+/zV29yvHDg
         29M5erUKfU/f48kN2FRDIIYpW6BrA8QAvRz1oX6WxwCUvdci/yjjhVal7Y/Vz/Gtn9KA
         /u6do+KHnL1xn5chjUngY2dJsuVUbIEdh/gSbqtCYbB343gFb7ehD5wytJ6U/dXorTaW
         Y3tHWpiu8k0K+5O2z3fY/ljNoph1Ic/JYyf7in/+gX42TOVxKvDUYYU2jJTDIbaGY1nW
         e6FcCSNc3m3Y2b1CP4PKhduEaP1j3jCU82gqRrZbkPpTeBb3XdtontGzuhekliz8yZE9
         YG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=blkh6ovMYUp3pDOL1MPn2xwiUyXrUXCvpPiJ5Ef5AB8=;
        b=w2d9oJiT4/4vdu/BwwSgnkOINWWq3rH/lY2gsQ0/effvtHM3noLNImaHKUWNloqz46
         0uuDjUfGu1/8juja8igYcmiHaNkVZ2CFQWaCbzKDguNIqBHsFcDpButWuy/GGzhAQoxt
         6SwypsLSSjoF3R08DtOONiwoNrpLfVZgeEz4ZA2KfiDQ8xfbOfrSzlRc1k+dOitOH+m5
         IpZuM+V9919L9eeVOV0UikY6WBck43Y4cv/TEn0rFV6XO608JBK9z11nvaKcL53kRLTu
         b9CxtvDPaJzgIcRkNgDF0lHf0RWxmWGP/0DSrWdOz1Pn7asXcuuGnzdHabqzMNJ71j7v
         CdDg==
X-Gm-Message-State: ACrzQf08f/7E5O8H8+rUgr8eg6gdzn9e2svnzcDhwdz6LzyAV6HLHJld
        p0cDW64p98dmwkeRTqq/b/qQTHaJyes=
X-Google-Smtp-Source: AMsMyM6j7UmHt71hAUz0A38U4asV5X3C3kp7uoTAz6TSkechcXsi82zhOJ0sbad1evndrvSZ1GLvhQ==
X-Received: by 2002:aa7:d996:0:b0:461:88b8:c581 with SMTP id u22-20020aa7d996000000b0046188b8c581mr22335651eds.111.1666827098764;
        Wed, 26 Oct 2022 16:31:38 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i26-20020a05640200da00b00456d2721d93sm4397040edu.64.2022.10.26.16.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 16:31:38 -0700 (PDT)
Message-ID: <7b9c0a6f-626b-07e8-ae74-7e0f08b8d241@gmail.com>
Date:   Thu, 27 Oct 2022 01:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdc1-rgb24 node name is out of line with the rest
of the rk3188 lcdc1 node, so fix it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index cdd4a0bd5..b8f34bef0 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -379,7 +379,7 @@
 				rockchip,pins = <2 RK_PD3 1 &pcfg_pull_none>;
 			};

-			lcdc1_rgb24: ldcd1-rgb24 {
+			lcdc1_rgb24: lcdc1-rgb24 {
 				rockchip,pins = <2 RK_PA0 1 &pcfg_pull_none>,
 						<2 RK_PA1 1 &pcfg_pull_none>,
 						<2 RK_PA2 1 &pcfg_pull_none>,
--
2.20.1

