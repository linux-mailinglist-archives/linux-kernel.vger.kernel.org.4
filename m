Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91E64E494
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLOXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOXRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:17:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036E22BFD;
        Thu, 15 Dec 2022 15:17:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i9so1401012edj.4;
        Thu, 15 Dec 2022 15:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na6VNdVHdyvAKfL71djiErCbTUOkgn1z0PYMYev3UCw=;
        b=IlXVoNLI9hpWFxEkhHb1L03k/1GNwjxuocwbZipeg89PuvxJyk4/oSFN6752xV+A1M
         pP37tcGT7wHcw+oSOE6w+BsuDE6e1/81yynMcdgDvP75aGzEoR6pYUiREGxpZ/k1fNDp
         W6Ld8CsfV7PXvvi1q0SWCbOEwt0JFtZqmJ8Gr21FoGZdDylxTfFZqqdan48wirMm4HRP
         cJW4tizfOmEW2/qcD2uT45bTRo1i3e/Cm9ONsJ/7pTaGdrTSwpOo7gd/Z3r9VlX8GPmb
         UmyOz8IzTPddLJKiNbWin05q1OXMGe4eyAAUEIhqdpST/6YIsqCd6XENKdM6RHfSeEFN
         pIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Na6VNdVHdyvAKfL71djiErCbTUOkgn1z0PYMYev3UCw=;
        b=TXSxDzthVcD1DAXZaFJWx6/JpQt0bfNEVKHUA8PN5Jjf4KKwT4weWhdlxcX9w2oCJZ
         rCJUA86xfJwIUgjrLxWvEPkOtZ0yANpNpwBEPopII5g0H097aKhz6bfZhAH/FQzNaIn+
         yvR+PBsZgAkHCLqb4pjGSnHqngC21CrFVnX6GnN2GCI/Cyi2So26A55zf6qZbjRe4QkO
         tt/Ib25eBz5CG/W1HTJGAI/EHLhqZSQgiY7Skk5g6IZqMAGr4iO4az0S9EnFWV0RZTiO
         //qj0+oevEzJ02awDQBv8JkTp7joV5GpQic7PL8IORYrMIqfB9E7/JBxF+T/ic0VsyGb
         EB3w==
X-Gm-Message-State: ANoB5plZAiqjY1vMcwB8UnaTNTwQTW2267UCI8e9am/Y0CkMqHKHTb6v
        aRfaCPmc1RA0WL+sSsb1E0Q=
X-Google-Smtp-Source: AA0mqf62x7/46Xb5777xQvxUBzJolKIRYpoC5k0dmvDaTdgfUK67gNT7wAKj7D3WZUO663oTf5ufbQ==
X-Received: by 2002:a05:6402:249c:b0:464:5ec3:c46 with SMTP id q28-20020a056402249c00b004645ec30c46mr29378919eda.16.1671146265811;
        Thu, 15 Dec 2022 15:17:45 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d154000000b0047013a9cd76sm228036edo.56.2022.12.15.15.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 15:17:45 -0800 (PST)
Message-ID: <b3c7f1d7-47fd-90e4-badb-e8ceb8901e27@gmail.com>
Date:   Fri, 16 Dec 2022 00:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: add brcmf node to rk3066a-mk808.dts
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

The MK808 board has a wifi chip called RK901.
Add a somewhat brcmf compatible node to the rk3066a-mk808.dts file.
That's what's available as driver in the mainline kernel in relation
to this Rockchip wifi product that is able to load the firmware.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 2db5ba706..5b9e8026c 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -157,7 +157,14 @@
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
 	pinctrl-names = "default";
 	vmmc-supply = <&vcc_wifi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
 };

 &nfc {
--
2.20.1

