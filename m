Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DC660F15
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjAGNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:31:35 -0500
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C8435933;
        Sat,  7 Jan 2023 05:31:35 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673098293; x=1673357493;
        bh=4DQEtRHdE0lzwvqZvBx3CJOvd+MWSeUso2OjhL2rdw8=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=vv+YIvkqYFPa2Y+BlgEvqBI/eIwIhlda9oOK+I/14h8nQKg2f14Ez1qnl8+bI+7Yx
         G8tIbVlmHvSKdY0kukKVOHeCrCeZk4j9A5p3v3ugf/rPwjUwxtgvLj9+JLb2Pp24KO
         x4GUAOObJuy8miSuJrFK3RR0MqYJCbsG2p51ZgPzGIUJnl2wJVdjhlnczjsnwl4bRs
         lAOa/pOc4BiiqtF/uC6vbz5u9uaulR7dKr2zh+sYb3OiAF2nXo/I7gDscfU02cu3wW
         VJZae1xcvmIqpOXKJTp7BSaDRvEVvgHz12MM13Xtp7lmh6zw1/nOAfnSMUeGgwypUa
         ToKalZqFCU2nw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 0/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add initial device tree
Message-ID: <20230107132932.139669-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: Sort pinctrl properties and remove stray newlines in pinctrl.
v5: Reword the flash LEDs patch.
v4: Fix missing Makefile entry in v3.
v3: Sort properties in l11 and nodes in touchscreen pinctrl.
v2: Set property status =3D "okay"; as the last property.
Reword the bindings patch.

GPLUS FL8005A is a tablet using the MSM8916 SoC released in 2015.

Add a device tree for with initial support for:

- GPIO keys
- GPIO LEDs
- pm8916-vibrator
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- WCNSS (WiFi/BT)
- Regulators
- Focaltech FT5402 touchscreen
- Qualcomm GPIO flash LEDs

