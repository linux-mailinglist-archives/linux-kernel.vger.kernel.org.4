Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4B694C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBMQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:18:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88E1BAE6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:18:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A11A1B815C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1348CC4339B;
        Mon, 13 Feb 2023 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676305132;
        bh=rHZQyYd1q7ceVtb87uSYWZwLEeTojaFPZF1v1Y82AuE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HK+PgD/YFlXDOJYpXWJPIisORcZGdoyG9M+YD+7Ucgb377TyVp39+xTMZ8EdrHnNb
         slWkiqkjKU+oFfmGBtX/vYsAmGyXCSt1ZbVMB4vBPNg89sX+9Myr+o2XXstyS68x6Z
         D+nm4Yde0P40wUt4MTPYSitCpUGGSsAklFRatwmoUlssVKyYqBPbbxtri+8nPesLId
         WA2HsUpeLsElJb5jGzKT8iGg2SIpnBI++Dwosy9kXB6BbHtv/7cC4mWSy1MAuDgYe4
         4/ZnVbHyah5oM9smiczAhIqUy754Q1SRQerG3vqUnOjWi+SrAvgFxjB9nuSri/gxHV
         nA3JIYcr6bfrw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        ckeepax@opensource.cirrus.com, shumingf@realtek.com,
        herve.codina@bootlin.com, james.schulman@cirrus.com,
        doug@schmorgal.com, yang.lee@linux.alibaba.com, trix@redhat.com,
        colin.i.king@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com
In-Reply-To: <20230213093649.22928-1-wangweidong.a@awinic.com>
References: <20230213093649.22928-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH 0/3][next] ASoC: codecs: Modify error implicit
 declaration of function and misspelling
Message-Id: <167630512772.2770751.214951401916390841.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 16:18:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 17:36:46 +0800, wangweidong.a@awinic.com wrote:
> Change the function name aw88395_plack_event to aw88395_playback_event
> Change hdrlen to hdr_len
> Add select GPIOLIB to the sound/soc/codecs/Kconfig file
> 
> Weidong Wang (3):
>   ASoC: codecs: Fixed a spelling error in the function name
>   ASoC: codecs: Modify the log print statement
>   ASoC: codecs: Modify error: implicit declaration of  function
>     'gpiod_set_value_cansleep'
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: Fixed a spelling error in the function name
      commit: 27db41a1f73ad18ed6540e1f8a7083422e5b53d6
[2/3] ASoC: codecs: Modify the log print statement
      commit: 14d5d454547adae64a76731c90c37fe33f7d1d44
[3/3] ASoC: codecs: Modify error implicit declaration of function 'gpiod_set_value_cansleep'
      commit: 4680716d6a33f50c96eb7ce6ae9cb868baa04438

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

