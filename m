Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5D701399
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 03:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbjEMBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjEMBFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 21:05:24 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45862D46;
        Fri, 12 May 2023 18:05:23 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QJ6r300PXzDqnX;
        Sat, 13 May 2023 01:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683939923; bh=2oweJp6Hr+Uo6qwno1dL993aPAf2d22HZWUcT7L58os=;
        h=From:Subject:Date:To:Cc:From;
        b=aFZ4xFKvWwfb3+UjG6bgqIAnvXY4vm1bjff6y3ecyAVD4nnbbitNFl5lMYEH37gl7
         qwEgh01Mk31Lj5BTashTuj5rs6qfPXKxTyddw6zR1SwWCN+N6SOTRhngeiYfLRpwNK
         OZiERO5MIMZQG/yV1364fhAa4PvdSlYmoNPUCOx0=
X-Riseup-User-ID: 347695993C9D69120884A090CCC9FD4D1D8B0B1DFFDD83A0621DD0E17CFDD13B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QJ6r02pXhzJp1Q;
        Sat, 13 May 2023 01:05:20 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Subject: [PATCH v3 0/2] Add F(x)tec Pro1X (QX1050) DTS
Date:   Sat, 13 May 2023 08:05:03 +0700
Message-Id: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/iXmQC/42OwQ7CIBBEf8Vwdg0FaltP/ofxAO1iuVACtME0/
 XehevFizJ5mM/NmVhLQGwzkcliJx8UEM9ks+PFA+lHaB4IZsiaMMk5rWoNOEXtwfqoShNm5yUd
 odNMyTUVLsSM5qWRAUF7afizZt9liih+KKCbnUZu0V9/uWY8mxMk/9yVLVb6/S5cK8g2daLgSw
 xnF1ZuAsztZjKQAF/YHhAEFipLxplWyk/gF2bbtBcST5hghAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=danct12@riseup.net;
 h=from:subject:message-id; bh=2oweJp6Hr+Uo6qwno1dL993aPAf2d22HZWUcT7L58os=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkXuJPYW1Oo7TM2wnt1zK96wylKsdme7cuoPo4/
 2m/kclmxvSJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZF7iTwAKCRBmyrfqpF3X
 geUTD/4qkcikDYp53hXKK6W4c1SoUgBRPCocVD5NgPVX/93Bk1zhZnc7x88vbOwC2gTmbcdq1fB
 YlO97A6PC9BuBMhVkSDMOr33HmMC3vLx4RpUrz5XZi22yGM2inK90rkWBZ4xu3tCcaoXG519HEK
 evpyyt0IE5SldxTSjHsrtgJ6vurmJXPeWN8023dES4Ttg9tbPvwwb6Ew8pyeav4OQJihoJkCuBp
 c3YIBKxY8+/Lx1xFms1AC1ptQqUeArfw7ETZ3Jwk9vcYSg3iv7vfwYqot/EUw8+A0a9itIpva9c
 YYMjavkmk9flH1Z6Xdwv+CQcearsg5chzpjVLCh6G9GKBYJrpzfyEMmEWVn5QA6srzknJVERJ9d
 PMkmE46cPLw0ZYqGmCmHHXSoU3HApq8xFvlgdcsF+Spca1MjmiOARhJpR8bBH7ElHngCWp2Zt/3
 Gifej/UcbdcUQ6P0bbNoWp5F16xHgItECOTROz4t5YtQhhSaJiQvbZjbQpRk4O1Qt9T4HbveaOE
 a85TMnjwx+t3W2b+v/UZOeXtL5J9CaiLveZpYSuiLg2Y3jwBZdd9ALHtbo9BVaz+N9mM+Ep5tkD
 //AabAcvQvofWTJS3ZXOrwoksWpjturplk5vROxRCgawinPL1oF6AbKTfF3G7V0v0G2Kog7ILd0
 0SOGfJB0bleaVDw==
X-Developer-Key: i=danct12@riseup.net; a=openpgp;
 fpr=F09A933C0FE0331E558CA4E166CAB7EAA45DD781
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
in 2022.

The phone is exactly the same as the Pro1 released in 2019 with some
changes:
- MSM8998 -> SM6115
- Camera button is no longer multistate
- Only one 48MP back camera
- A new keyboard layout picked by the community.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Changes in v3:
- Corrected changes from previous version
- DTS is now licensed under GPL2+ & BSD3 
- Regulators now uses pm6125_* alias
- Link to v2: https://lore.kernel.org/r/20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net

Changes in v2:
- Corrected model property in DTS. 
- Changes requested by Caleb and Krzysztof. 
- Link to v1: https://lore.kernel.org/r/20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net

---
Dang Huynh (2):
      dt-bindings: arm: qcom: Add Fxtec Pro1X
      arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS

 Documentation/devicetree/bindings/arm/qcom.yaml |   5 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 250 ++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
---
base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
change-id: 20230505-fxtec-pro1x-support-7f782f0480e9

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

