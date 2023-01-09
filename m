Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43666292C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjAIOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjAIOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:52:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630725E1;
        Mon,  9 Jan 2023 06:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 494A1B80DFB;
        Mon,  9 Jan 2023 14:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77021C433EF;
        Mon,  9 Jan 2023 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673275909;
        bh=rtqlm7a55WTBEGFP7RFDOv4Gy1EqcDD3WhvBsTOHcTU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SNC5IayHplZ7eClBcJG5kR8lFBMJ2iqOylUBkV66SfusUKCYAXfGrvzLHM8dRslgJ
         tD0aerVmciqu7QCBsQUSDbW5wy803BF3D2ggVKidzBKOfk3qIEQqKJ2GKoLKUrQTOB
         kCJbK5G4sPiHIu8BuGZCfyrMfUALJwoXdInB6UnAMlXUWW8XDflkA5EUBNLR2gAkjo
         RNNgwwRn+Axo41AphGA/yZkfkSEzdBPfMkiBfGZEQXHLISCvnC9TpdYPtchRE3rBOz
         uGYp3/X9PMJCxt/UNj7WI0J58zIB/Y79asi+jFFv2fDnK5VW0iXXMXIh+AXlVbcx7H
         cyO7X1/OpgEbw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass-wsa-macro: correct
 clocks on SM8250
Message-Id: <167327590621.170440.11249846867635800211.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 14:51:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2022 12:59:06 +0100, Krzysztof Kozlowski wrote:
> SM8250 DTS uses additional "va" clock in WSA macro device node:
> 
>   sm8250-sony-xperia-edo-pdx203.dtb: codec@3240000: clock-names: ['mclk', 'npl', 'macro', 'dcodec', 'va', 'fsgen'] is too long
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,lpass-wsa-macro: correct clocks on SM8250
      commit: 69568267c5b624eaa86afcafbca1c4765f63e112
[2/2] ASoC: dt-bindings: qcom,lpass-tx-macro: correct clocks on SC7280
      commit: c9fb35f685b2f8a2ead98e3f1b249a1d4e9c040e

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
