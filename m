Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98E172786D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjFHHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjFHHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:30 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014E2694;
        Thu,  8 Jun 2023 00:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AcDMLQgJrf928xP1VMewakE7nlCxK5jYcbbzUUPpomm4zxtq0mH3S6VrBajHy52DXS
    IYb0JcKzArcNJgVz3OWsgfmtyOi/ekzbMTI/iw22+EiE/TpeqbTcUhaYBT3xJeLsq0q8
    uwbudcydiikSIs4Xrj6OpQC5ecD0vn8lxXhGmOhVnyyYpiDrTx4qEtQMkd7n0oizsVYq
    pJa7yIB7MuYIlj4Rj2ffmeGVJgTg6GvbXp38cE7jQMMebuLr1TPSgDj0M56J+IrT8qQB
    R0ZN9XufK7Leqz5P6U6svUS6Ne9aDwcuhcrX4WiIILJ7lBgtLE5BChmr1bNZTT4BQzTR
    swpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=ahAKDrPg5wZfzX93wrwW3bQIuTGiN+loR8hNa2C02smNl9T8dYa6ZNxQbLTffqor2q
    NpuzmvLbQSGMKhC3squCyY+3UxzZzA2KAvUk8iGm02scfd55WnXWWi02D/U10YmA8MVg
    t2eGerKqCvu4WwbGT7YX+4cOtsNtIM8Vx3hsCzlb+NJUW/AeSXZ+RNxoJaRDvURMWwF8
    NNj2VgRK5PjTb8VPRdMQkFj6gY2xg5Zxtvgq4Q5l6e9BNv9us54uopZ6IUk1oxMpMZeF
    oRNqwxAj5l0uQz0+TVLtJGnu0h3lPMxVM0Ae4SlkoVWHtkRE3sZtXC4ML41OW/N7hNIW
    GBGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=SrymmMk1wFsWcBzbETLYZzA5qdTaHHEiVqDKU6cQJx3xQd4xpuQdt5WbgnPARZykSy
    UsGi0YjsZFIiVbpUAToCVGIsrNw0tyoqxE1T9uXmGyyhNEAMwMTuICoLS0tLm+baaFwp
    jaGVpZSx/PKxw7v6o1cGk0RH9p68Ec03PH7GDdJv7JfAAyl4MIV6m+qXW/b2Wfnjg7w1
    2SBD5yvGNylcnfMY4M46jG3tvDfCs/hBQjGFY2OCwXAWT8sHc2p+y84dCGCriIPM4ilD
    LTYkBm4ziN44nIBJsgb5+I6DXFLub3WMycHM2uED18Bj/31u9O6LS+seLQCOuKG91UYD
    ZHdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=v5ey92iIJCO/+NL+GNQsUuqvQwHNpXT5yRg24wRnXANkZgRoaz5zPXcI/1wiXsf035
    eLFXALlDUYxM4BKxgDDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BFKI5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:32 +0200
Subject: [PATCH v2 12/12] ARM: dts: qcom: apq8064: Drop redundant /smd node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-12-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
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

The "smd-edge"s for remote processors are typically specified below the
remoteproc nodes. For some reason apq8064 also has them all listed in a
top-level /smd node, disabled by default. None of the boards enable them.

Right now apq8064 only has support for WCNSS/riva, but there the
smd-edge is already defined with the same interrupt etc below the
riva-pil node.

Drop these redundant definitions since the /smd top-level node is now
deprecated.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 40 -------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d2289205ff81..e0adf237fc5c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -226,46 +226,6 @@ smem {
 		hwlocks = <&sfpb_mutex 3>;
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		modem-edge {
-			interrupts = <0 37 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&l2cc 8 3>;
-			qcom,smd-edge = <0>;
-
-			status = "disabled";
-		};
-
-		q6-edge {
-			interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&l2cc 8 15>;
-			qcom,smd-edge = <1>;
-
-			status = "disabled";
-		};
-
-		dsps-edge {
-			interrupts = <0 138 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&sps_sic_non_secure 0x4080 0>;
-			qcom,smd-edge = <3>;
-
-			status = "disabled";
-		};
-
-		riva-edge {
-			interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&l2cc 8 25>;
-			qcom,smd-edge = <6>;
-
-			status = "disabled";
-		};
-	};
-
 	smsm {
 		compatible = "qcom,smsm";
 

-- 
2.40.1

