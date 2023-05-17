Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43B707123
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjEQStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEQStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215983C2;
        Wed, 17 May 2023 11:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M5GWUMN0EEzPZsLNvNrjnO0io3WTqLo/6vRK8PdlVP19uH0N+L7dBR1QTCLF1aoLos
    iPifJcKiWWJ+XaCqRFCpPZgYSvNyWSYVjNBuwl7fLY8jrs7amEhsErcpeEy0h064Fk1g
    4da34HdjZnZPnFjruU2nGa/jf6kvB2vHmPgOwynBqH+vcGUFDmCDKc5UyxQ7MdPRyIkg
    9SWPOAYGSx0+qvNl1FxfxJQDFvLNw3Sk7HA3q8p8c4fya7yM+ulsOFGcC9gblWxIyU4T
    tuci2ouAwA8Q9UrrQCTOs+CxU+ik59LiVK+Ycje9dFnvrIQcCNrHhlzWFsQSpOBMTDe6
    Z7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fVtyqhrRJ5UbBMQWImjynUVkIpRXG8Ma+YZD4PD5Xk4=;
    b=ZrQjSgU14tTkQLjGaI27JNsEFdquU2ofszinBct+ih8u+m6V+iyH/Iz06a6/0OeiP9
    F2dbtalio7fup8yoP07PJ7bm8NopjWXmn4JSUZ/Pz8FH6CHYn8YcT+NSWyZw33kxOYDc
    by+BUceSVFK3F/WkgjrS/rG8zeoCoY62iXtTad5gGlp2NMZUBj9QYz18DyoTCJekK/vF
    UfByQGfabNDl/daxEcI/lHIKSlaXFq+oOwkAmGe2WlCGsfjjqm3LcXQoyu0ZMZgK5JKb
    7QDa+pZF05dqqldUAdurVFmwLmapTe6bJBNYUHJWcMzdNWwBJEo6/HrHbobTPML0vRl6
    ghIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fVtyqhrRJ5UbBMQWImjynUVkIpRXG8Ma+YZD4PD5Xk4=;
    b=qdGYTiHVtvluXOGpep78DSShguuxZ80kFTKXgo9OTaylv1U8lALmsG90J+iP5TWFS2
    mrR5UJheywZsgPhswC9qNKSV0t6l2tNHcCahOmxbyK22GbYWtTymw1CH6kfaJCoLAZaf
    Pa6Tu6zVmPeKJCIl67j7iLFBSsIk00sFEltEfQN4FmAmzbpl9KZGjoo3gi9CqqRyMEM1
    57W4T9wQ3/vjSXkBWqTqs05KIxTi0thPuDIjXV4CSzoPnxRkbgCpreub9f3FxfQo6C43
    xpvGvZWdAA0NCYuC4xpjVO1aFgIHmzZ1+YfGeUVEd3B2gNbW2AXYHThsjGTT5K9AbMYo
    xVHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fVtyqhrRJ5UbBMQWImjynUVkIpRXG8Ma+YZD4PD5Xk4=;
    b=NWPhlgBodgHN9M+vyxAZFodMqB2pmWiLsFRlYycKbzZ/9U391Mx1bvNqxXdY0hGoum
    ll1dkGM7W/IMtHzmxLBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HIn0BIL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:49:00 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:45 +0200
Subject: [PATCH 6/8] arm64: dts: qcom: msm8916-pm8916: Clarify purpose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-6-54d4960a05fc@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
In-Reply-To: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goal of the msm8916-pm8916.dtsi is to reduce the boilerplate necessary
to create a device tree for a typical board with the MSM8916 SoC
combined with the PM8916 PMIC. > 99% of all MSM8916 boards use the same
standard setup where many of the PM8916 regulators have a fixed purpose
and only some are left up for board-specific use.

While MSM8916 (and perhaps MSM8939 soon) is currently the only platform
with such an include, it has definitely proven useful. With more than
30 boards using it (not all of them upstream yet) it simplifies the
review a lot and reduces the chance of configuring the standard
components incorrectly.

In preparation of extending its scope slightly, add a comment at the
top that clearly explains what the .dtsi represents and when it should
(or should not) be used.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 5b3ed7137e1f..29ef46c33350 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -1,4 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * msm8916-pm8916.dtsi describes common properties (e.g. regulator connections)
+ * that apply to most devices that make use of the MSM8916 SoC and PM8916 PMIC.
+ * Many regulators have a fixed purpose in the original reference design and
+ * were rarely re-used for different purposes. Devices that deviate from the
+ * typical reference design should not make use of this include and instead add
+ * the necessary properties in the board-specific device tree.
+ */
 
 #include "msm8916.dtsi"
 #include "pm8916.dtsi"

-- 
2.40.1

