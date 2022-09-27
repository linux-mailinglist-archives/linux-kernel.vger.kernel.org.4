Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF95EC0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiI0LVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiI0LUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CB7F087
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B1C615DC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C515C433B5;
        Tue, 27 Sep 2022 11:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277608;
        bh=QQYYaQMEZGvzeczjp2ttfiOGEJrYpgRJvX3jpp4RbLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SBJYAlf2n0xdNapfKdhNlJBt1VWw2tH1tLqXsShwzjI5JlYE0Rhyp3z88PvnavvDd
         L4KRYyQA5Bp84f11TxHA0Q5D07STruQIg2NeFwMNTVPfMw39V+JsYptr85cSTerGZ9
         fxZ1BzmhuASWEqOLhZKvXQiVtX2ba80ZwdpWCC4kWB3pAGuDndPXJMajV1CndD7+gG
         v44NUCVsnHv9qriyDOk1FculvZCdVeRsrwmvdT388aEL1K8mv3EKXiNJ9Mjdr9j9zb
         zDjjQEJ0H5S6AFK0VZ3KyqP+rIN7n1WHJfMNnvhZctSakIijOCDmZzQelKYf2DHfn9
         lmpXP2t7h0/Uw==
From:   Mark Brown <broonie@kernel.org>
To:     peter.ujfalusi@linux.intel.com, Chunxu Li <chunxu.li@mediatek.com>,
        angelogioacchino.delregno@collabora.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org,
        project_global_chrome_upstream_group@mediatek.com,
        alsa-devel@alsa-project.org, yc.hung@mediatek.com,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20220924033559.26599-1-chunxu.li@mediatek.com>
References: <20220924033559.26599-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: mediatek: mt8195: Add dsp_ops callback
Message-Id: <166427760496.294040.5707200014534943454.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 12:20:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 11:35:57 +0800, Chunxu Li wrote:
> ASoC: SOF: mediatek: mt8195: Add pcm_{hw_params,pointer} callback
> 
> Chunxu Li (2):
>   ASoC: SOF: mediatek: mt8195: Add pcm_hw_params callback
>   ASoC: SOF: mediatek: mt8195: Add pcm_pointer callback
> 
> sound/soc/sof/mediatek/mt8195/mt8195.c | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: mediatek: mt8195: Add pcm_hw_params callback
      commit: 978a7144ae8497b40d833a3c0110b18810499f95
[2/2] ASoC: SOF: mediatek: mt8195: Add pcm_pointer callback
      commit: f7c91bf65388547f61888b7a67169966fc698ce1

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
