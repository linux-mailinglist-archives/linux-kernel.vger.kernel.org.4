Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92433612CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ3U4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3U4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:56:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DB69595;
        Sun, 30 Oct 2022 13:56:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a5so14966895edb.11;
        Sun, 30 Oct 2022 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFcRfWRyXi5vlxA7mDVUDb68ztcKVUII1OhMaUKoMY0=;
        b=mtBfSG9FABE66AWdcsxYQUCjkoyaplzytMcS9Lq3YCTKyHVnQ7Qi2+fR/khu+LsDDB
         MntqbxYZxYfxj3SpABiOn71tJ3WvCRyMBc51UkPmliSpp0UkMb/O2WjGR4OoVzjoRPqk
         NrQTrJ10nSr+NsMdiXAPsWsVhQacgsGJHClA42CrtmgtIKC7Kf5yAbeWBm7gpB8x9ZoG
         WEw/Oyh22oW1Th4wselPl+flAM/7SW70t9cPHAqdL7gJl8VU7rfsfOfDtYa2OJmteOBk
         PT5P3bWNdS8+I/ZLOBN/uLf62iD07/vryem2unJLA/J3tO6bo9GKTUxmQw7nL2BZkFgi
         PCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFcRfWRyXi5vlxA7mDVUDb68ztcKVUII1OhMaUKoMY0=;
        b=OLiLGD4RRwNr4YsikpZwnR2VStgcGyAYQUEHziz52Jv8Jc90K8QPe6GZekMHHBBIAh
         OTA7xX2maMAdwRTBiDfFjYZhmEIfbeX5IAZJLzJvcrwesDzFI3ZKECTdtExKx/w5CL+6
         3L7hwQhdwEKKVIwHMSdY7moiwC+FW/VaHQC1ygQjmpG35Mf2WvfNQXVjSmjGvEJu/3Km
         Z2I/JX+bxlMmX2vi5m7/HC3BmhrI16KMq3uVS5D+pjyuQWKeRe3tDQZpGt2eUiqk3CIW
         530sGzeKgti9XBxt1rQGc9DXRWCwZx9sxxYhPh3RoNn1vI2m7SRa0w/gv6K/bIgttUJh
         80+w==
X-Gm-Message-State: ACrzQf1wJgfNNLGlpbqLDy2NiHKa86iUv0z4iRcq8J/Dg6DxJeQEBRpc
        x/o2dfIOvmq8yJ0D5PrmstGhoE5L/X0=
X-Google-Smtp-Source: AMsMyM4nJ5rQBJWIcEkeQiP60ZzilqtOq785QEX5fls9YhzQE7qcm3GocrP/NsQEEcdGzobAqft/+Q==
X-Received: by 2002:a05:6402:11c7:b0:462:549d:fbbe with SMTP id j7-20020a05640211c700b00462549dfbbemr10320925edw.199.1667163390852;
        Sun, 30 Oct 2022 13:56:30 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a170906698e00b0078defb88b0dsm2211923ejr.73.2022.10.30.13.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 13:56:30 -0700 (PDT)
Message-ID: <f275ca8d-fd0a-26e5-b978-b7f3df815e0a@gmail.com>
Date:   Sun, 30 Oct 2022 21:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] ARM: dts: rockchip: rk3xx: disable arm_global_timer
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

The clock source and the sched_clock provided by the arm_global_timer
on Rockchip rk3066a/rk3188 are quite unstable because their rates
depend on the CPU frequency.

Recent changes to the arm_global_timer driver makes it impossible to use.

On the other side, the arm_global_timer has a higher rating than the
ROCKCHIP_TIMER, it will be selected by default by the time framework
while we want to use the stable Rockchip clock source.

Keep the arm_global_timer disabled in order to have the
DW_APB_TIMER (rk3066a) or ROCKCHIP_TIMER (rk3188) selected by default.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

ARM: dts: rockchip: disable arm-global-timer for rk3188
https://lore.kernel.org/linux-rockchip/1492374441-23336-26-git-send-email-daniel.lezcano@linaro.org/

clocksource: arm_global_timer: implement rate compensation whenever source clock changes
https://lore.kernel.org/all/20210406130045.15491-2-andrea.merello@gmail.com/
---
 arch/arm/boot/dts/rk3188.dtsi | 1 -
 arch/arm/boot/dts/rk3xxx.dtsi | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index cdd4a0bd5..486a96ce2 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -607,7 +607,6 @@

 &global_timer {
 	interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
-	status = "disabled";
 };

 &local_timer {
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index bf285091a..b0ec459ff 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -76,6 +76,13 @@
 		reg = <0x1013c200 0x20>;
 		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&cru CORE_PERI>;
+		status = "disabled";
+		/* The clock source and the sched_clock provided by the arm_global_timer
+		 * on Rockchip rk3066a/rk3188 are quite unstable because their rates
+		 * depend on the CPU frequency.
+		 * Keep the arm_global_timer disabled in order to have the
+		 * DW_APB_TIMER (rk3066a) or ROCKCHIP_TIMER (rk3188) selected by default.
+		 */
 	};

 	local_timer: local-timer@1013c600 {
--
2.20.1

