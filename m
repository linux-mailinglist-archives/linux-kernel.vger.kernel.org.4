Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E16696C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBNSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBNSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75E2ED6B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F923B81EA0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3351C433D2;
        Tue, 14 Feb 2023 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397703;
        bh=awND0EjP9fvq4Q94FyZHVMCMXE5R653wqzWUUQcPrvU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OmWRfV2dbTxL/dWS2cmyjsmPHj85akQ8rTAJ7SkqXLf7ZYH/S23CTmCjuExwRGVTj
         fIbl8QKEB6hJBE75qfnwe7mND/XRVLhVn98hvlloz5+HVbJIzGoc9LG7UlsXJdqDU1
         0LDtlE7g6Apa8YiD6ZbEAT8PC7vnv+39ZuRBzmb6umIqwQ6MbqZ1ikjsIv/lnMg/ej
         dbgVRB12k9eLYev4SgJOVZW9IUrG8svEVdKoBGKvGvM50sS9gzP6nx7czG+5FaOTOs
         8aqe2itpUl56SAzbXhdGM6jDuvAu1ViOVk2dImmQX467vN90o4BiB/TApC4tlribmV
         PTKIasa2v/tow==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <Y+p9r5y9DPSJkPVf@ubun2204.myguest.virtualbox.org>
References: <Y+p9r5y9DPSJkPVf@ubun2204.myguest.virtualbox.org>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Remove unused variable
Message-Id: <167639769854.3067697.826075385352580657.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 18:01:38 +0000
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

On Mon, 13 Feb 2023 23:43:03 +0530, Deepak R Varma wrote:
> Variable ret is initialed but is never modified or used except for
> returning the initial value 0. The value can be directly returned
> instead and the variable definition can be dropped.
> Issue identified using returnvar.cocci Coccinelle semantic patch.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Remove unused variable
      commit: 88541443497d47313ec4de1ecc1946288ae0ed16

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

