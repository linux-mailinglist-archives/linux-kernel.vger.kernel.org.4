Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC5712AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjEZQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEZQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D86D8;
        Fri, 26 May 2023 09:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B071764D11;
        Fri, 26 May 2023 16:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DDDC433EF;
        Fri, 26 May 2023 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685118692;
        bh=Wq0/459LQgCKzVhcExDaJx/IJL140NV8zMyWDCNAyys=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f1r9Ylp/MR+OP2Sk4wuk7qHMZzP4Ue+joIbVxlbgeoOUK3uSWgTxSDZQwfjMH5BqG
         NPFkPym1ileruoiqQGom0c06wRigc9BiVHTwfmIuGPtpcV/J4fg3MER8vjiHYcERqb
         egGzxHV39ivyE5TkZUTvthj53xkFedsMZxMykl1lr8Wwbjr7yQCIQx11jc5UeVDw+Y
         5H+9fMWwWJid6t5Ysv++9DGxBf14aZhprJceyKZUeIW32T7QO0W4F79dS/ExXF7B2q
         1uqAHAlYqJZlsE/MvYl9Xp5dJvDbsB3tvlW+kHOF3JmJxp5bdqYJLno/7gqE1yEFAV
         jdEePgv98pBzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Herve Codina <herve.codina@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
Subject: Re: (subset) [PATCH v2 0/9] Add support for IIO devices in ASoC
Message-Id: <168511868876.36455.2854477201745113664.b4-ty@kernel.org>
Date:   Fri, 26 May 2023 17:31:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 17:12:14 +0200, Herve Codina wrote:
> Several weeks ago, I sent a series [1] for adding a potentiometer as an
> auxiliary device in ASoC. The feedback was that the potentiometer should
> be directly handled in IIO (as other potentiometers) and something more
> generic should be present in ASoC in order to have a binding to import
> some IIO devices into sound cards.
> 
> The series related to the IIO potentiometer device is already under
> review [2].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[8/9] ASoC: simple-card: Add missing of_node_put() in case of error
      commit: 8938f75a5e35c597a647c28984a0304da7a33d63

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

