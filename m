Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7864F747366
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGDN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGDN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E7F2;
        Tue,  4 Jul 2023 06:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D744961268;
        Tue,  4 Jul 2023 13:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A161AC433C7;
        Tue,  4 Jul 2023 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688479178;
        bh=Rz4B8MHS9txQmFz0LcpLJ1buoy3ozqfsNNEcFtPbKqo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dU9DnKCbUtQlsSLXuzeuGgmel6qzYFu9wkqmw6ntxqF9XYeh3Vh4Eb9l67a9s6J2K
         qtPhBaLtyrSyRuIicwn7tX8YgmI7xeBJa1uui19xvDKbjhnmOcLMwC6Rh+WOeVykSW
         V1xY4UuIn8mm5A+B7f+NM1wx9v/WiWXAKviFkyDlHdd6tt87MVcR2hClDZUdY045jD
         Dz44o+wGfumCb1StQXr+mzwy1rbGl6dXtoVNKnaN/3ktCf/RZ4T8nd6v14euCkm+1x
         WQmEFRGCXT5FHTi1B4YjGwyMgMteDjgwqhGl1ro9LTUQwGQHME6NdjZX+bW69Yscms
         XBPuXhl860tSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230703124701.11734-1-johan+linaro@kernel.org>
References: <20230703124701.11734-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix missing mbhc init error
 handling
Message-Id: <168847917636.48984.6400261777618066312.b4-ty@kernel.org>
Date:   Tue, 04 Jul 2023 14:59:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023 14:47:01 +0200, Johan Hovold wrote:
> MBHC initialisation can fail so add the missing error handling to avoid
> dereferencing an error pointer when later configuring the jack:
> 
>     Unable to handle kernel paging request at virtual address fffffffffffffff8
> 
>     pc : wcd_mbhc_start+0x28/0x380 [snd_soc_wcd_mbhc]
>     lr : wcd938x_codec_set_jack+0x28/0x48 [snd_soc_wcd938x]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix missing mbhc init error handling
      commit: 7dfae2631bfbdebecd35fe7b472ab3cc95c9ed66

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

