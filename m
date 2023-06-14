Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49E72F5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbjFNHRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbjFNHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DC1FE5;
        Wed, 14 Jun 2023 00:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726978; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JGaVQqE6t0TUX8HwOBAeU2nE/dBLD8ftlyl+DUw+2sOP9bbozHcolAhTmKIrbwtEyQ
    WB986fGwmfu4nHixJ5MfWFZhYTPXv6VM7WP29Cp5LheQeEV0vZVryBJEMLRj8YE9rOPV
    tvNCg/MrBXkD9SZ0I1xYtlpzgR0n5IrxOCWQU9NRJXeeRNPmlTnVCWyzOzOe8E5z0tr6
    gopeAzhLByguUgTdTWZn5k6xli65wxz/XcCjLQ2u6YIwY32784mc3dtAZ9JLxl6ncbgF
    ZcN2jQAKpwK5pH5wjsbhcCuW5pagNB1noyhwF9dDNdLGMKLFA69TVmQ/F46m3Xqa9iQ6
    gMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n1QwpBKhx2xV2lQyfawqqn478D1c1Rjobt5H25DdQ0E=;
    b=bIXNzUDXINO0bC4ka2nRZiUNCaWH7wH/H5Y6hvvyJC7Yyv0D4uaSJMpQyLNOK2Es2B
    NAlIbRdsWK4Z73L+3WWy89dj7lNDDXY86lvjDrG790V/4mggRv6f7auKauRizdKFjjkm
    TXglKDbo4kK1QoWBPkd5xFGhNPPZaCiLTGefdAGgiEX/2geBDNv2C/KDFHne7TEwaPA3
    8vjuiDcxjS6MWN6j1WUnbU3c6guFkzsa3NDJWQ9Doxi8KwPW/ZoS9GzIyVBX7xgDIcc/
    lTlAIn/DjUfnIdP3GzowYVOc9DsMcqE4EZsL5qBJ3yKep/5mXmMqMzaSH+4NxE27Onta
    3nTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n1QwpBKhx2xV2lQyfawqqn478D1c1Rjobt5H25DdQ0E=;
    b=YBLCM9YWOIsGc5dJiI9psjLWs0KaRTwNyHBlmqdzQSZHKY11Ag34500L4glH0ic22P
    rx09s8+QIQMtvTori7i29koQwKO54m+a9b2UDA+6aZJkuH09tEuQgml6wxQC1c4lXYkE
    tUMHqefpsXM3l2EXRjhpj60raix5d4Sl1oGl1GDX5LhT6RRon1csK4ohbcAdWYzhSr/r
    BX3/mmmdRljYCuTbmSV5PlruKAUHujQHAtEo0nUGZw66SCdMonkrrwr+0cS6lJbG3fc4
    fjCokOLlAkCiDWJ96b3EmKJRPcQD4qBznBc+DIQWzsO/cWjN9/G+dMRvGDsYvDi7V/QE
    hTxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n1QwpBKhx2xV2lQyfawqqn478D1c1Rjobt5H25DdQ0E=;
    b=gP9XAUWQ4wl6h8ki71N9DFFBCMttwL6TI83CrCt/0UcXBks5UyTQlQa7OYaZKgGsZw
    qv8DI1J+ZiulejJW+XBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GIb2h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:18 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:04 +0200
Subject: [PATCH 6/8] arm64: dts: qcom: msm8939-pm8916: Clarify purpose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-6-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the same comment to msm8939-pm8916.dtsi that was added for the
MSM8916 variant in commit f193264986b5 ("arm64: dts: qcom:
msm8916-pm8916: Clarify purpose").

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index 503c2dd5fe47..3bede1a23603 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -1,4 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * msm8939-pm8916.dtsi describes common properties (e.g. regulator connections)
+ * that apply to most devices that make use of the MSM8939 SoC and PM8916 PMIC.
+ * Many regulators have a fixed purpose in the original reference design and
+ * were rarely re-used for different purposes. Devices that deviate from the
+ * typical reference design should not make use of this include and instead add
+ * the necessary properties in the board-specific device tree.
+ */
 
 #include "msm8939.dtsi"
 #include "pm8916.dtsi"

-- 
2.40.1

