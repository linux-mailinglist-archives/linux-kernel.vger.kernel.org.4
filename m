Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FFA5FDC81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJMOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84562B1DCA;
        Thu, 13 Oct 2022 07:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD5E61806;
        Thu, 13 Oct 2022 14:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4D2C433C1;
        Thu, 13 Oct 2022 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665672234;
        bh=NvwyE1DUE80ntZaLJ5MtSrUAvFGAB1vF7A51Xc8PXhM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g9R9GJtTg7FFJe6055C6CXI223Xhi9OyC0wc4IfG8ju3WBbgExL1Y99c+NAPi5nZu
         nLHQkx3d9C6lKkMPiOJBxsM4vEwpbY1ODj4KLv7z+VR2kAZ9npSM3/Q5yWP8e2wAcJ
         2yb9ot6OFf1BkgRmt/PwVCD+V7URzOw4/n2n3FSEHk6QB0+vOpSACKOpS6BQT0bcz4
         Ke5Im2DGZ6bMaSDE1dxCjK4e/ODNqTm6CeCkQop/vOWoSo9Ih1JZN9oB2TOabe5MKq
         hWyWh0N8sXN769affI4Mr8+G6Z4g+cMF+91d5u1W6Go4+rr+uHnyqG4XlWbE78D55f
         kr6M1X0C1OZQw==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, quic_rohkumar@quicinc.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        swboyd@chromium.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com, agross@kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        quic_plai@quicinc.com, bgoswami@quicinc.com, perex@perex.cz,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu 
        <srivasam@qualcomm.corp-partner.google.com>
In-Reply-To: <1665569560-28943-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665569560-28943-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
Message-Id: <166567223036.170727.7011980883912234789.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 15:43:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 15:42:40 +0530, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@qualcomm.corp-partner.google.com>
> 
> Update HDMI volatile registers list as DMA, Channel Selection registers
> , vbit control registers are being reflected by hardware DP port
> disconnection.
> This update is required to fix no display and no sound issue
> observed after reconnecting TAMA/SANWA DP cables.
> Once DP cable is unplugged, DMA control registers are being reset by
> hardware, however at second plugin, new dma control values does not
> updated to the dma hardware registers since new register value and
> cached values at the time of first plugin are same.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
      commit: c9a3545b1d771fb7b06a487796c40288c02c41c5

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
