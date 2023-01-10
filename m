Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56E6645DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjAJQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjAJQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:17:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484795BA03;
        Tue, 10 Jan 2023 08:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEFFAB81888;
        Tue, 10 Jan 2023 16:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E24C43398;
        Tue, 10 Jan 2023 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673367451;
        bh=x9I82pXd2TKCRFPebHSm9mOpA1bNLdyYPpT6g+/oemQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxIyYItOd7deZNIhpC1wJnDChhkBDaFEc5Askx/22nbvMM+g7pBRfv4y0bffM0y84
         FBcQDZUVOmnsnml37KNgEkyvyDhS/QsasloiQipqWTXPTtEQ2Ypzh9sc0efAI6KnwT
         wo/z63FI/AwPYAsMxkeC0+jIWbG47arizbZNVFFpxLHgw9r1h/jPvX6XiROggcgxQX
         1A/MWoAHug/uc5ymwoWosZr+Y4el5fO4Ii8SoEB/MQBV52SqDtE6jqJWoi/9X+8kzZ
         V1BjJWqqwVcGVf2YuUoumDPLEGomgo3a7Fr60ccbzolD9AteIqxE/NrbbhSETspqIk
         OZJqXF+6bIThg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, vkoul@kernel.org,
        joelselvaraj.oss@gmail.com, caleb@connolly.tech,
        marijn.suijten@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     dianders@chromium.org
Subject: Re: (subset) [PATCH v4 1/4] arm64: dts: qcom: sdm845-db845c: fix audio codec interrupt pin name
Date:   Tue, 10 Jan 2023 10:17:22 -0600
Message-Id: <167336743966.2134489.12332082150856336295.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
References: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 22 Dec 2022 16:13:16 +0100, Krzysztof Kozlowski wrote:
> The pin config entry should have a string, not number, for the GPIO used
> as WCD9340 audio codec interrupt.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sdm845-db845c: fix audio codec interrupt pin name
      commit: 740862bb5f59b93efb390a417995f88a64bdc323
[2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: fix audio codec interrupt pin name
      commit: e5011447376e1b050847ccb2ef7933176ce4de41
[3/4] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
      commit: d05e342882e4fb2ccd8e4b6af00b0b82e22ad325
[4/4] arm64: dts: qcom: sdm845: do not customize SPI0 pin drive/bias
      commit: 0cbc0b1c5838b02c67a768392bb34732f0d384b0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
