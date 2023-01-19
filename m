Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BB67423B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjASTHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjASTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:06:41 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0795169;
        Thu, 19 Jan 2023 11:06:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674155160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=181+U7hoXVEs3PRIvqYL+aOou8nlMGYT2aXfPxxQmfE=;
        b=SVFT3h+iVwGSJPqr9uMhGC8e45HMg8aZgrcCWkxLToyEmmtgt2uYx6HvpAOdmsxOYXz0nB
        od+kCgfJm1ZFNfEFZbdEsrguMX47byaSLwA1I4U5LyuBWH8vWV3oLCsX1cDSSqdHu9VyYh
        WEto3ccFLdJDlas1TtgPLjHQmVPPTzE=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add XO clocks for MSM8226
Date:   Thu, 19 Jan 2023 19:05:32 +0000
Message-Id: <20230119190534.317041-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rayyan Ansari (2):
  clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
  ARM: dts: qcom: msm8226: add clocks and clock-names to gcc node

 arch/arm/boot/dts/qcom-msm8226.dtsi | 6 ++++++
 drivers/clk/qcom/clk-smd-rpm.c      | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.39.0

