Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90146721F42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjFEHNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFEHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:40 -0400
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C696E6A;
        Mon,  5 Jun 2023 00:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UOrMiIL1SF5FAbFXlawSHUMQF+2Fw9+nKZ71MLtbBRI8NxruzB0Zg/0IXZRG5S/CUz
    1PIV23NJVcsMsoEAdMpKWZqfUKaUH1TYSb39He6lJxgGQMbg0ulT2c0WsdsMHdNf2WzE
    bFkD0iFgAlZI+Nua4IPazgg8uuQj65zHQwS17C7/QfKvrCg+ekXg8WvU/E0BWk5zHnv1
    /GoM0UvU274ENFwg5Pw3hiMCrEI9bMjpbvaKa44u7UCrrhAiF/AO4VkJvNeA5sbKzcP7
    uRVR0kP35crUsqsEbxWJ20clGQu3GtRBtDHyfHqM+eXx/9pkmTnm6rD26QzMy1gx7wlq
    aVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GfBDq1/JDZEt7Wx9DVlRP8wb6ffwFP/iSu6DkmVRk0w=;
    b=WXgjRSLv4DmXhq4K2LT6a6mrh55WHcMkfbxkvHvz2kTNI6BwaOOQwSQDo1p+IzjWyk
    fpDSNERwYNQ54PI0wSlcdkzhZLaPXHE+eFf1RVTNWgaFvNurEOPpZmFvyTmRqcXXVXkM
    qROQ53fxMHqTFfs4U40VBhB+0Nm8Kmtc8cS9SU8ZIden+P1HYmMJ27Q/8UoczdTx5vXO
    3s1A1hOGHa6T8I57je/WbFZsWR1EsEY/kfNpa9B03jzA8hkVwmlY3S8wajA1LkbfI7yz
    HGpWetNh/XoLiOvlmkkWp+rcqDuPSgx0gIBHyeZEOPCe29SFgTR3Y+GMUtH1pghqRxqj
    ckEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GfBDq1/JDZEt7Wx9DVlRP8wb6ffwFP/iSu6DkmVRk0w=;
    b=lpO/8cNPAQi8uIltRhXvOO4ApsoqNG+p2gnpkfJGvFendRLq+zR7b0zKCGEUbhWGon
    Uj9Y7jg/KT3WrMF5m9Cz2Gkus/uKOSaRDUbejvyWz5kpJZ8VEDTFLmo7Lry8XLoOqCmL
    PxWG8rpA4yNnAcGRcTK4IL1Rr4DvQmEIf8EJWSQfVAj8IqVreP7G+xcqD2ELLvR6LYq8
    BU7ksc/v+6mahIT/Z9x3Ko9C480gvT97E2NkKLFfS3c5HUCENxBdLqSGnH/9+tAf1422
    BP+qDP7P2HHtiZO1hH05KMjoaGmp2yHEr8O3rKpU6RXk5DfUFJiM7PXpmOm7cBUlwBOf
    bWcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GfBDq1/JDZEt7Wx9DVlRP8wb6ffwFP/iSu6DkmVRk0w=;
    b=IPqLoc5o3c2zU2XSgGbfKJGj13HEGz9lToc1gz8jT1XZM1REiT0a9N/RMB8VHgtqBr
    u4kNh0Xe+U0XNEx12RBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579H8aE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:30 +0200
Subject: [PATCH 14/14] ARM: dts: qcom: apq8064: Drop redundant /smd node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-14-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

