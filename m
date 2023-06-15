Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E71731E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbjFOQwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjFOQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:14 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA12978;
        Thu, 15 Jun 2023 09:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847859; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C2MFh3Nl8ySHEwkt+v9B/pLF1JcBLKtutcWC9OiPC/bCibrN5lkkkTzp49/4SykZBs
    KgyUgbw4Z4ph4LTyJ7jlD2696Vh8H5ZGLBqQyi1aTh6+74gCZQ1bNKUVTLIxNaAKpf7x
    fiIQUsOWukCzLnnLbdvw2qtBYYuwb2y7vR2Aq1L7doo37Jv1MReNRp3FP49GCEzBGz3t
    xIcyLZRVXXCQWPdnviIVN4Y+ErZ8+yYyxIOeScMhNIsYNy/zk4AVwKALZT1Z3WOwbjgy
    5xQzh7m+WdDqE4EounwbhT9RjKNaGE96UwKcbVQa6LaGTvKvnB5IyzeKZ9Ve4w9pizCZ
    ZOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=fZUfb8AQnoOE0tkl35f7Ar+JSvF1pBm2x6IMPCIbJttTFxLtFt6JdaTiSBJjc13SBf
    Wza2FHcCa5PHfTKs6EvmPp8X3as3ACbY9YGyvjb+f+5u3A8kRCOGEqc046p7iosD4A6z
    xH3OqTs47mV1G+cSt6/BbPvuDI2HmZfwpPlcN38+cD8p+7iW5F9ET07FzpKx/DYGPB11
    4ox3n4JqZYxfKFKK5q2SgkaiGD5QOPDFMBDsfmb9q1uYOxlvkGxrnPTqJxOAC2Ekpa9N
    /9SzqsTEwdjwGt+62BZbaPgnx4q1JtaMVt1NBGJAHY8BKELtXbC1evtuDwz8VmypzmIx
    VFDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=gcWZ53fNE/QS2POK0QH3S/bL2YfH7Wsdpv0atmEE5oOp4/fYpK6dmqB/zW6bxobkZk
    vUoYB1nfBZT0HqkyF6tza8zRibywJoYmqNj/ezDuAsfwTuuW1HtXlvmlEQFmsKH1OXP/
    UqBMlwQZFQSPobzkVKZXleQp8zgqHmde25ZCQyvGqXXXerRIIAKDB1tmviNOfTWxsORJ
    jL/htI0ijf/EjKvFFs2tSozJAdOe+rX82fUAQ0iKkl8/uDkIno+IyzDk5HDOtchr5ysg
    rMygKwDMZDZjGBmW5mltnx2OD9GiM/X1WYKbRSQn/W7DIrAg9QpPQU9fGRucpRQm7/MS
    0qlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HZV9aVwyvKPAu680AA1+pBj60E1yrRK6tgCJfx+g4+I=;
    b=fwOIT1RYgqTGXoPQNDvu8mELjjgHM3iBnqixt3m6Qsjl5vmOtq2ENGwS0m4lH4RW6n
    JX2LvHf8b8QrKf4HtsCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGox42o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:59 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:46 +0200
Subject: [PATCH v3 13/13] ARM: dts: qcom: apq8064: Drop redundant /smd node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-13-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
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

