Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB862702A50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbjEOKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbjEOKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022E19A4;
        Mon, 15 May 2023 03:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145543; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tkq67o77DSOOySalWTFkTuGf6/bIN0Ir8zF6vP9mkPpNAoqFAC0AbUvaN1UiVyeq5X
    m59+lbX0YZ5Li9Py3kJ5yv3u0P0o2YKIQKW6L7CzSd9iAM3/paDE9ccrT06Z7UbEeyiP
    LUc41qIXch8Ha9fEYE5k8aVOdjYI+mMdeP6xHsTMYSr0A7XUwO1F0l6D1eLJvaidnkqm
    HqwN0LmfWr8JVqSRwGVYweVq5vyY72H+jv9b9jkkymT7XJ8rTqGYlLlhMuziSep/JqXO
    a0+lhq2Xen28B6j2e6KWvLMeL+aCoYHkYxpJ4X0OC8sMpb6mB8PYdrv4wG7CyGYWs353
    bYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145543;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zv1egBp4VF43Uy3k9TsxyBgv1FbKom8ab/az0E+stOE=;
    b=m5KM5ma7u2oxMFenubqzXEFUOIsly0xnM+EAEzJInltm7jGhdSP/nVhOohPfHANop2
    1q2Bvv5ee/7dhM3u65oTLgReJ/8T/tVW6VSiTFIqL6rAb3+Q6xeHICp33TJq+x3kS0Vo
    7f83pTQFaSrIAwCZKzYSLPXm+8ntjpYv0M/OsE12xttETNWstg9jwSMHF/kG9CqyitwF
    Vnh3HpvndrtVAolzcpnWehz+cGSWGl9lW16ETMcbHPbhqbbHn1YDjncUkEa5Uvs3m8dd
    vgbvu/zH/miiku6yP3z7mjcrY/c0C0CzJOzL9vQHkRU1/0MelGkCMi+AskGR60S6rFQD
    KzTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145543;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zv1egBp4VF43Uy3k9TsxyBgv1FbKom8ab/az0E+stOE=;
    b=imfAJaU/zyCIj2aNmPHz+L0wMpozqF4Kf0qRiMUbyl6cxspTG6BvDfetN7+zUAcgar
    uW3tBTZGlugGeFhFKTVTgLDoWghi+sGxtr8SmiS2lDvyM/jGJloI76G3+8gBCntHn/Lh
    4rcSYau61EKSwfLu9NnrNAdb9uD3pHIHx4cbZvywF+tQyyyvGK0BSy+KLelwxxWDTJVY
    CgznmnZnLpLoaH+Q1uYtdSRn5jlbRyeUWrsvlehe2ttumpSKCMIO+2xyJn9COB0YP2Eb
    MRIaXIEOk0x5yavD6NNLecKG2Gd3sUFVUT+nlGoG8ptBFKOHk0pReUViYkMr9AX6+mfJ
    0raA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145543;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=zv1egBp4VF43Uy3k9TsxyBgv1FbKom8ab/az0E+stOE=;
    b=73WOrUXfKDQ/beydx/HNIClkP/a39K12oD4b+YJigg6F4OLW1QjxVN6v7Z2a64biwI
    4ukV4J9P0bsa2OXseuAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACN1JF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:23 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/5] of: reserved_mem: Provide more control about
 allocation behavior
Date:   Mon, 15 May 2023 12:12:15 +0200
Message-Id: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8FYmQC/x2NQQrDIBAAvxL23AW11IZ+pfSgcW32EA27NhRC/
 l7T4zAMs4OSMCk8hh2ENlaupYO9DDDNobwJOXUGZ9zV3KzB1FBIN4y1tbrgZ0U/prvN2Xs3Zuh
 dDEoYJZRpPsslaCM5xSqU+fufPV/H8QMeIu6gfAAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide more control about the allocation behavior for dynamically 
allocated reserved memory by adding a "alloc-bottom-up" and 
"alloc-top-down" option and by making the allocation order 
deterministic.

The motivation for this patch series are the many different reserved 
firmware regions on Qualcomm platforms. Currently it is often necessary 
to duplicate them into each board DT, because minor differences for 
some of the firmware regions (e.g. the firmware size) requires shifting
the base address of all following firmware regions as well.

I propose describing the actual requirements (size, alignment, 
alloc-ranges) instead and allocating the reserved regions at runtime. 
This allows defining only the actual device-specific part in the board 
DT and having everything else shared in the SoC.dtsi.

The series starts with two minor additions to the of_reserved_mem code. 
The last two patches are examples that are meant to show the motivation
more clearly for the MSM8916 SoC. PATCH 4/5 shows the current (static) 
approach, then PATCH 5/5 switches to the dynamic allocation based on
the first 3 patches.

If the first 3 patches are accepted I would send the full MSM8916 DT
changes in a separate series.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (5):
      dt-bindings: reserved-memory: Add alloc-{bottom-up,top-down}
      of: reserved_mem: Implement alloc-{bottom-up,top-down}
      of: reserved_mem: Use stable allocation order
      [RFC] arm64: dts: qcom: msm8916: Enable modem on two phones
      [RFC] arm64: dts: qcom: msm8916: Reserve firmware memory dynamically

 .../bindings/reserved-memory/reserved-memory.yaml  | 39 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 13 +++++++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 31 ++++++++++++++--
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 21 +++++++++++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 29 ++++++++-------
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 42 ++++++++++++++++------
 drivers/of/of_reserved_mem.c                       | 14 +++++++-
 7 files changed, 163 insertions(+), 26 deletions(-)
---
base-commit: 715abedee4cd660ad390659aefa7482f05275bbd
change-id: 20230510-dt-resv-bottom-up-68d71ff6628f

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

