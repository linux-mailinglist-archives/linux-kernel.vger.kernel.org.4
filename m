Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2964F8E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 13:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLQMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 07:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 07:05:37 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B496542;
        Sat, 17 Dec 2022 04:05:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz12so11807824ejc.9;
        Sat, 17 Dec 2022 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKhTX89WL/mXEZGpHtSl2I9i5/jLZsHst59ffE4s6Dw=;
        b=FdgHMlHhYMxeoL6VIqy3u3sr39KP3FDbAXf/AUxUfK/COxVCb3PG7ebsXpu1MrnFzx
         DXJZNSo1adODSbShtB2ICu4gfQhJimoqn2cVZQMgxyEKoC6A2nIuYNXRz+HpQamcxoan
         rvOaBtaT5oCGVKOCTBoM6raRBC5op3eWxyNCgtTiuRGTJIzE5tT3329qpMpVPN95Xi2s
         OrVbZBgc//AoUUGSGLUygV2gNNyJilGZUVBekXslb32EoNHeK4LFhYM9pGilzdkBcMPZ
         yKLmVPAFL5hmIkpfifYthDFwlq/nwVc5QSszSeFcB4RFG7nV0wRsAp42herBrVK+Bu0k
         bV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKhTX89WL/mXEZGpHtSl2I9i5/jLZsHst59ffE4s6Dw=;
        b=2wYyEhghIt/6KyrZ0TIeNKt/TwY/ndmHBFkh8eW4zXgK/ZI4KNP/md7DHC8uK+rJ+U
         WqPyuFTp/E1pLoeykUoojsskh0frovPTNxNDEC/pa1RBlpxBU3GLsNq9TI8b6+yKdxEn
         A01eiIQ76ZyMGGjfRbk15yYmS1K/tfsYe+2NnGatPSH2K+3LRlBr64F9lfjD87JttUPX
         p8KRUi95kGfjeULTSaWszaK/EmUHcBPhk31GeaiLEKP43aLyDzAGTlMY+qkqnb2STPtm
         b0saHfHgLTcnLNrszN0eRYzdLk7XewOTSLnc2L1HuQvuKuagMroOP08OAoaypStOCzhh
         0Rag==
X-Gm-Message-State: ANoB5pl0+fyP2kVOEEuYjV8qVf28Lmx5ff5Ys4MY5uk3HhB/5R942bgV
        JoE3zOibUpyhKsQBskJoh3A=
X-Google-Smtp-Source: AA0mqf4AJwwmy3iN1fgs0JeUZXimC2yzWZ2WjNbRBiwjp7TTKaXbB4edm7IG1cZ6LpePKKsyxOtasQ==
X-Received: by 2002:a17:906:5a66:b0:7c0:d833:5ea8 with SMTP id my38-20020a1709065a6600b007c0d8335ea8mr29585382ejc.5.1671278734232;
        Sat, 17 Dec 2022 04:05:34 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906318900b0077a8fa8ba55sm1895977ejy.210.2022.12.17.04.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 04:05:33 -0800 (PST)
Message-ID: <67675d28-87c5-0df1-4b93-2f1233918a1e@gmail.com>
Date:   Sat, 17 Dec 2022 13:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3128: add space between label and
 nodename nfc pinctrl node
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

Add space between label and nodename nfc pinctrl node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3128.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
index 0480144c1..b63bd4ad3 100644
--- a/arch/arm/boot/dts/rk3128.dtsi
+++ b/arch/arm/boot/dts/rk3128.dtsi
@@ -694,31 +694,31 @@
 		};

 		nfc {
-			flash_ale:flash-ale {
+			flash_ale: flash-ale {
 				rockchip,pins = <2 RK_PA0 1 &pcfg_pull_none>;
 			};

-			flash_cle:flash-cle {
+			flash_cle: flash-cle {
 				rockchip,pins = <2 RK_PA1 1 &pcfg_pull_none>;
 			};

-			flash_wrn:flash-wrn {
+			flash_wrn: flash-wrn {
 				rockchip,pins = <2 RK_PA2 1 &pcfg_pull_none>;
 			};

-			flash_rdn:flash-rdn {
+			flash_rdn: flash-rdn {
 				rockchip,pins = <2 RK_PA3 1 &pcfg_pull_none>;
 			};

-			flash_rdy:flash-rdy {
+			flash_rdy: flash-rdy {
 				rockchip,pins = <2 RK_PA4 1 &pcfg_pull_none>;
 			};

-			flash_cs0:flash-cs0 {
+			flash_cs0: flash-cs0 {
 				rockchip,pins = <2 RK_PA6 1 &pcfg_pull_none>;
 			};

-			flash_dqs:flash-dqs {
+			flash_dqs: flash-dqs {
 				rockchip,pins = <2 RK_PA7 1 &pcfg_pull_none>;
 			};

--
2.20.1

