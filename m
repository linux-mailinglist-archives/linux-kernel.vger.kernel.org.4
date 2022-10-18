Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC6602B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJRMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJRMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59D2B632
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798B861536
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80746C433B5;
        Tue, 18 Oct 2022 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666095221;
        bh=FB5kirTisbqaD2j4n/GmaPm6mX+02J8TFDx+9tOPa/E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FHiNLNJXS1Xj2Sj/3cFmdeY/oQsqrnoI4MEp1+lWi6wYQMjlunlyjaCnJWmplnOJA
         gmrEzD9nXDEjPcwgZX6AS/dOuqEK3NNdXXRjZJvGJJ6RInMO04BiOLSrJRcheph8D5
         rVpbZQ8T1o34cGRoHrGu2kiceFaS2wUf9b0s8QM0q1M222Qalp9gA0cp8oeSAFyqQa
         CTSuqhcxUCd0mUf3LgCoqlD9SAhmx82hkVj2NTFNGdQ+Z/iK8ednzKdvPv63gW10sJ
         9yT1k50tR/6gQy1EQwvK0a3ZqPIzMA6HlbhmxnVr9NvqO+Iz3N/+I8DHsxB2VGHFL3
         /SecK3bkaWzVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ricard Wanderlof <ricardw@axis.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
References: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in __exit_p()
Message-Id: <166609522025.371929.16598407249350844860.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 13:13:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 10:33:50 +0200, Geert Uytterhoeven wrote:
> If CONFIG_SND_SOC_TLV320ADC3XXX=y:
> 
>     `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
> 
> Fix this by wrapping the adc3xxx_i2c_remove() pointer in __exit_p().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in __exit_p()
      commit: 4e8ff35878685291978b93543d6b9e9290be770a

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
