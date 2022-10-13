Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA805FDC86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJMOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJMOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEDF88DB;
        Thu, 13 Oct 2022 07:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9511461802;
        Thu, 13 Oct 2022 14:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B302DC433D6;
        Thu, 13 Oct 2022 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665672243;
        bh=L9DE9hBwSLM5JaCXLcIlpoE+HBbeeBOPZnvRaO3Xm6Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ATTjg0D++1erKR3/yxxiCKG2pC05PSr82NXb+ee8J/UX4PDGpGnzNtIqylpHJU7UY
         zg600oHG2xMXRNXSEIBpC2x1s+0fVJOUEdS3gs+4nMjfG7CG1z0fRRJESngiKqwAoN
         3WXi+eHvhiVul6L26RhRGuIZoe7xp/yqD6kEwUWYlF546FKrSKJ3JmHBmfZgUQ9itd
         /t7BZnV4OvZSD+aZhjHFoSHtokQyrazMa9mnIpxBD4lKdHX4wbNgvU06Qx5PkjeJ2y
         YEQ6IjQs+CMCBuqwWw2n3jS6zDafjR+jK2wNZAgSOE0RMfkdicWjrKoL/IzDYs08zz
         jy89jPOery59Q==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, quic_rohkumar@quicinc.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org, agross@kernel.org,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        quic_plai@quicinc.com, perex@perex.cz,
        linux-arm-msm@vger.kernel.org, bgoswami@quicinc.com
In-Reply-To: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
Message-Id: <166567223944.170727.7516803650460275929.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 15:43:59 +0100
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

On Thu, 13 Oct 2022 10:38:31 +0530, Srinivasa Rao Mandadapu wrote:
> Update HDMI volatile registers list as DMA, Channel Selection registers,
> vbit control registers are being reflected by hardware DP port
> disconnection.
> 
> This update is required to fix no display and no sound issue observed
> after reconnecting TAMA/SANWA DP cables.
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
