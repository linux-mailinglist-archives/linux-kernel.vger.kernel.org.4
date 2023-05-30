Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E52716B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjE3Rkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjE3Rkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33770BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C429C6313B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE6C433EF;
        Tue, 30 May 2023 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468435;
        bh=rJRQG+7pp2ythOpT+U1Yxy5qJud46ffW3tXHC1cJQ18=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g/eaa+VkSqVBJrewcVGbIIwnK1as5OUVU/bykCkf6EDM8TzirjbIbfYJrY0MA+7yL
         akc7keX6WJeHG4v2XTGtgGYbW+92NXga8PTIUotdvYlZu1kdyemGhqj1r39zEw2z3A
         LZnRjYZhmIygPHWUG1ip2I0DzYzEkFJmxUHeF7xdw6mt0A8MXTKFRGx754hzpIPcpa
         qnE/H4R1RR3u8r474THGPb9dsB/xrn11RZO6td7yKJcr4u9LU6w2xAojrbFXqIMSyx
         8EQTvGntHhmbjf1V3On6D9OuKFBLvBiHKqDfC6g43RL34JsZCsGqN9CxxZM7I679Cn
         a7GALizRryUhA==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230519211636.3699-1-minhuadotchen@gmail.com>
References: <20230519211636.3699-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH v2] SoC: ti: davinci-mcasp: Use pcm_for_each_format()
 macro
Message-Id: <168546843313.690777.2915258997696909322.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 05:16:36 +0800, Min-Hua Chen wrote:
> Use pcm_for_each_format for the PCM format iteration and fix the
> following sparse warnings.
> 
> sound/soc/ti/davinci-mcasp.c:1336:26: sparse: warning: restricted snd_pcm_format_t degrades to integer
> sound/soc/ti/davinci-mcasp.c:1358:26: sparse: warning: restricted snd_pcm_format_t degrades to integer
> sound/soc/ti/davinci-mcasp.c:1438:26: sparse: warning: restricted snd_pcm_format_t degrades to integer
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] SoC: ti: davinci-mcasp: Use pcm_for_each_format() macro
      commit: c3079282fdf7285b4133d6d1a7901b7923d6db09

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

