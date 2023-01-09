Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25E6623B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbjAILCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjAILBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:01:52 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F5120B1;
        Mon,  9 Jan 2023 03:01:49 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id CA79A4052B;
        Mon,  9 Jan 2023 16:01:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673262097; bh=mScNUQd0v2jqUcRKMdJbv1EtzSDlYC1hm+AClCBVN3o=;
        h=From:To:Cc:Subject:Date:From;
        b=nwdhIvt/Q/kySrDtigVv18MdrD0P5DWBJJ3fY3LFyVj45dwonRHAFuIu0ZQp1Jm6c
         GOVafK/u7PgHFj+wansP8t5ICFtSMONOzr727GBOBVGyj7dxcxuCXn+13he0QS0i2o
         H7uvT0YXMdzxTDnMNJM4y8yv31c3Sabpa+3DcSeJqVz0CxFy7YVD26vqsh/IMh4VeN
         +bpNrFIqMKu+LuGZ6jJxjiwpNMn8FaIqXST5RgvM3eB73aVoa61LQf4ZDnuKPLWwiN
         +QQdBOxN4scuY5gYX73aXn6f2xwZtOuHTb1/X6JPCWKx//JTlEJ6GHZwP06sP0aBuw
         neta/fpkMZzwQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/4] Minor cleanup in msm8916 dts files
Date:   Mon,  9 Jan 2023 16:01:03 +0500
Message-Id: <20230109110107.3016323-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some minor cleanup on msm8916/apq8016 files to
bring them in line with the current standard and be closer to the new
submissions.

The series is separated into commits by each specific change made across
all files and these commits should not cause any functional difference.

Nikita Travkin (4):
  arm64: dts: qcom: msm/apq8x16-*: Move status property last
  arm64: dts: qcom: msm/apq8x16-*: Reorder the pinctrl properties.
  arm64: dts: qcom: msm/apq8x16-*: Drop empty lines in pinctrl states
  arm64: dts: qcom: msm/apq8x16-*: Reorder some regulator properties

 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 78 +++++++--------
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 15 ++-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 46 ++++-----
 .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 34 +++----
 .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 52 ++++------
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 42 ++++----
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 30 +++---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi    | 96 +++++--------------
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 64 +++++--------
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts | 11 +--
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  5 +-
 .../qcom/msm8916-samsung-e2015-common.dtsi    |  5 +-
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  3 +-
 .../boot/dts/qcom/msm8916-samsung-j5.dts      | 21 ++--
 .../dts/qcom/msm8916-samsung-serranove.dts    | 62 +++++-------
 .../dts/qcom/msm8916-wingtech-wt88047.dts     | 35 +++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 32 +++----
 17 files changed, 245 insertions(+), 386 deletions(-)

-- 
2.38.1

