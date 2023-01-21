Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C686767FD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAUSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:07:37 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E3112F06;
        Sat, 21 Jan 2023 10:07:36 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674323933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AmtCc8t9CHBsb1LMNqV7KWtscMyB6VCsQ0QK4PPIMFw=;
        b=aSpHwl4nfa3jgckrY4s/AD+fHrbYcDcjzJE6b3Eljfk77FkD7R4Dqhyrk8zx215FbSoWeE
        HF88jTSpqhsoxo6yCL6zKkbZMRtI5ppIZ92GLDe05e6R4B4JrZqP8S9iMWthfdZEfPQid5
        jm/hDH+su97be2ucDcETwcHwjuce7qY=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 0/3] Add XO clocks for MSM8226/MSM8974
Date:   Sat, 21 Jan 2023 17:58:34 +0000
Message-Id: <20230121175838.755636-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Base off linux-next
- Add correct XO clock to MSM8974 as well

Rayyan Ansari (3):
  clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
  ARM: dts: qcom: msm8226: add clocks and clock-names to GCC node
  ARM: dts: qcom: msm8974: add correct XO clock source to GCC node

 arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 drivers/clk/qcom/clk-smd-rpm.c      | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.39.0

