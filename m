Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605E656A36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiL0L60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiL0L5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B161A198;
        Tue, 27 Dec 2022 03:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD53BB80F93;
        Tue, 27 Dec 2022 11:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A93C433F0;
        Tue, 27 Dec 2022 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142269;
        bh=MlbYDyHB2xL8RHMNdHwdmuRIR6U4juvja/JqAIqJOG8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y47OOsgvF+sPnz4oT6xAxGZUQ9UQSvJnD8oEYBZq2LUAuINDtu6bZTEOhv7JyNiEu
         LvXG0I8YRz7RBNzUlBBwAXhgPMr+10UP1MgP1VfU67By5WW/R+8vxX6JmGy+gCY0rW
         Yc27nYK35ki/WuF0Ar5Zh55M+i9Lyk0QCauEXTDUCx/jy06RRYMMxO+eJsE4h5atEV
         +LR+C0UHKyjXyVgHUAQz1E1HEC/y26vOAx+mUKRPS17g9fvF2OmhTYHEyE2MwuXhZV
         wbMTDdWLSigE8ls6+EtqLiV8P4G5K9/JV1YWGeVlP/5RolcMhNAOFff9CdOfWrl8Vc
         HChFeGWZdLEwQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com, vkoul@kernel.org,
        quic_arandive@quicinc.com, quic_ramkri@quicinc.com
In-Reply-To: <1670509544-15977-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1670509544-15977-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [V4] spi: spi-geni-qcom: Add support for SE DMA mode
Message-Id: <167214226629.88639.764160014719387166.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022 19:55:44 +0530, Vijaya Krishna Nivarthi wrote:
> SE DMA mode can be used for larger transfers and FIFO mode
> for smaller transfers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Add support for SE DMA mode
      commit: e5f0dfa78ac77374a3f0817bf427a22f61494246

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
