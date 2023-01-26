Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996A67C1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjAZA3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjAZA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A765EDD;
        Wed, 25 Jan 2023 16:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE2AB81C76;
        Thu, 26 Jan 2023 00:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CECC433EF;
        Thu, 26 Jan 2023 00:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692951;
        bh=+X7IZsXvCYbpuPeCa2h6DxvcsySzQEe1Kfi3Nqp6O1s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j6G85m+ULe65NHEQDxekpiCalWEuIdk7iJgD5oBT5JFQFXTMfv03XNHyKO/kslG+S
         6SDzqCPyYcUjn3lpusaqiryBMTa/YM4g/KHRwOPC/eEnBPi25tSvB3tCmG6a7ZGeJY
         GYSeofcLljUI4+0ujtB/m7vW71To/oPThxTt8+UmXHJ0FKXK+R+vAirapCMh5FWZFq
         pBZz/dW6eL1VYxY5IKFnebiUXDSm3gwbmItGQmyb2AFjMDY3WefzO5QvHytkhel7xE
         FZGQ5MnjkiG0awMqWOwzXFt+3y4JPgZbql4zTnTCSXAmIEqxj149DQ4fa8HexBZ0SB
         CT0h3D18axUOw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/3] regulator: Add Maxim MAX20411 support
Message-Id: <167469294846.2698045.11083009704658424877.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:29:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 10:44:37 -0800, Bjorn Andersson wrote:
> Introduce binding and driver for the Maxim MAX20411, and wire these up
> on the Qualcomm SA8295P ADP.
> 
> Bjorn Andersson (3):
>   regulator: dt-bindings: Describe Maxim MAX20411
>   regulator: Introduce Maxim MAX20411 Step-Down converter
>   arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c12
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: Describe Maxim MAX20411
      commit: c1bf8de25d0aa6e399399d6410b1140d4402c2e0
[2/3] regulator: Introduce Maxim MAX20411 Step-Down converter
      commit: 047ebaffd8171a47eb5462aec0f6006416fbe62e
[3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c12
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

