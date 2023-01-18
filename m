Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F116672D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjARX4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjARX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:56:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02747ED8;
        Wed, 18 Jan 2023 15:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71720B81E12;
        Wed, 18 Jan 2023 23:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE6EC433F2;
        Wed, 18 Jan 2023 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086156;
        bh=p39YQmzwvTewaZI3D6/0zRCXTDpAKg+CbjW+TihiWAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHkzd0ekzf+wE6roo8e0Un9IrVEG9UUd7GcDNnYPr4LJVoSTe0VYINu4N3z52ATqT
         HDMGNoNTFrll3d1C3I+g+PXOdA5wpfdjbG5iWvDxEgt+j4b4wifL5Hp2y3G/F/aQe5
         U3PrGprbdIWJUm1NHYC4Jq2xUmoT3EmT+fMFDiY9e8gLfFY7ikqW5/7x6eWL0I2XLs
         W2igfKAI5dyes+NLaKKif9pr63L5CUOxU/c4WE06vD1fIe+YWbfAYbrEcp+on5fx+6
         Jd+f/a2+rUn8AyIaIsr80vd6w++YrAuyQw6sOyOq/26mDINEVEF/ta9rX2x47P9Pr9
         gt527yOhM8/Wg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: sm8550-mtp: enable DSI panel
Date:   Wed, 18 Jan 2023 17:55:39 -0600
Message-Id: <167408614065.2989059.15531640647728355632.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 15:24:56 +0100, Neil Armstrong wrote:
> Add device tree nodes for MDSS, DPU and DSI devices on Qualcomm SM8550
> platform. Enable these devices and add the DSI panel on the MTP device.
> 
> Dependencies:
> - [1] SM8550 base DT (applied)
> - [2] MDSS/DPU/DSI bindings (applied)
> - [3] DISPCC bindings (build dependency, applied)
> - [4] VTDR6130 Panel bindings (applied)
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8550: add display hardware devices
      commit: d7da51db5b81a04f3d6f36293010ded8bef9e297
[2/3] arm64: dts: qcom: sm8550-mtp: enable display hardware
      commit: 69e6a5e29b3b02ddc5e24228b3c874f266d57b4f
[3/3] arm64: dts: qcom: sm8550-mtp: add DSI panel
      commit: a74c41f6dd83e37e14b07bc6dca795110a6a16d7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
