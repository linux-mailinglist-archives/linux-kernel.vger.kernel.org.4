Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11406625712
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiKKJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE02654E3;
        Fri, 11 Nov 2022 01:43:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso4254438pjc.5;
        Fri, 11 Nov 2022 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy9kRwEDKOwzUuzNDwbNK6Ls9wmAWU8wrTb8CY1ASBM=;
        b=UrYniHryQrt1oClRFAxO4NM+NTyxw9xTdQt/tkBzCt0JXKQGCjW0kEvDc+g/dhWFxA
         kTju6QYgbkEEWUEXYgQ4ASkeuc+fcO/hG8ZLC8HfcQka1+ymUzo8avwj5iUAU6UFlTBZ
         SSG9U27np35cWvCXoFcrJIrIFlLmwdf9qTSmPTL1vnD3ZSN0LDFxJuD8GUz/+d0+IYN0
         qBgLo1yxsMiSAqS4gh06lPjWLswAlUjSSHP8oxMWb+lkBXfna77cBoSED+JUk9gUQWsG
         2220ENr9ojjkMaxJlcRDFuTNaMvyu5jCO61MBbmrkF7vbu5sU8/OVXNoxH5KWGI1sm6w
         ZnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy9kRwEDKOwzUuzNDwbNK6Ls9wmAWU8wrTb8CY1ASBM=;
        b=p6QeYZi04IZrpIx3QzWBro2kUqruG/iC8Q3sV+zosIpz8n9Do/d5Da7wVPid89Plqm
         82GbDwfGp3OhJHXMvRXFZEuDFAgOWmjnKS3RBcsyXSjI9B2sLbMjP1wQva/xppRcF3bg
         1KA+Y5+NvwjLIG0QZOf+d7d4vBn/ynrhd8js2zG19mCGiTYyWeL91yqL8h1vcZnR0s5l
         SMSKG/MTDe+fq79ATuNwbyDTPj7x+pme9IhFnxdw06uQqEzsTsW2J81QfWpT0mk1DzaC
         pblCCbQt6Ox+WWWul8CaPnKaflU4Y6fhR4ll8iebgn0ggZN0siINiWZ1wjeXJSaf3zfX
         f+2A==
X-Gm-Message-State: ANoB5pkBxuTWI+iawC2JfvG6IIekQHhyX4pZiQQPOlBB7hS6psnTBHPB
        SPt8bbJdoF70aDZOGPGOShA=
X-Google-Smtp-Source: AA0mqf5h6rFIEUsgsGftthsKMgAP7sfBcKl6GMZWDSIXy4cjabS77++RvLmXzawJJwNT6veT27xS/g==
X-Received: by 2002:a17:902:d18b:b0:186:8568:be82 with SMTP id m11-20020a170902d18b00b001868568be82mr1510898plb.110.1668159782097;
        Fri, 11 Nov 2022 01:43:02 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.74])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b002086ac07041sm1188450pjb.44.2022.11.11.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:43:01 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v1 1/3] arm64: dts: rockchip: Fix gmac phy mode to rgmii on Rock 3A sbc
Date:   Fri, 11 Nov 2022 09:42:33 +0000
Message-Id: <20221111094238.1640-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

On rk356x ethernet phy support reduced media independent interface (RMII)
and reduced gigabit media independent interface (RGMII).
So set the phy mode to rgmii.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index ea74ba32fbbd..72e410e3aca8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -253,7 +253,7 @@ &gmac1 {
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1m1_miim
 		     &gmac1m1_tx_bus2
-- 
2.38.1

