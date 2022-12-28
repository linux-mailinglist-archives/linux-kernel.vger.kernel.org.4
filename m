Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C76587C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiL1XFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiL1XE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:04:56 -0500
Received: from out-234.mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF7B48E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:04:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1672268691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zhV5gHL52mQvy5x080010uweCovS43cr1TNUoLDpraw=;
        b=HIiq1OoA7Rq4D2vqs2hPPHO2oncb2AMXNg+1CEFxSAnCtvHqgvYLm60/1iv+trl00nK2W6
        ocKStbX/538iPBGo7DkuXINykhe5Q7L+7Yfj/d6aFC79yot0TFTEbYpRTSCreXbfIDLNNf
        DV0y3eTitAWQy989+5xmZTuh2Pmj7do=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/4] ARM: dts: qcom: pm8226: style fixes and new nodes
Date:   Wed, 28 Dec 2022 23:04:15 +0000
Message-Id: <20221228230421.56250-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patches sort the nodes and includes in PM8226's
device tree file, and add new nodes for PON (with the resin sub-node)
and IADC.

Changes since v1:
- Use adc@ generic node name
- Use specific PM8226 IADC compatible with fallback
- Document PM8226 IADC compatible

Rayyan Ansari (4):
  ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by
    address
  ARM: dts: qcom: pm8226: add PON device node along with resin sub-node
  ARM: dts: qcom: pm8226: add IADC node
  dt-bindings: iio/adc: qcom,spmi-iadc: document PM8226 compatible

 .../bindings/iio/adc/qcom,spmi-iadc.yaml      |  1 +
 arch/arm/boot/dts/qcom-pm8226.dtsi            | 46 +++++++++++++------
 2 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.39.0

