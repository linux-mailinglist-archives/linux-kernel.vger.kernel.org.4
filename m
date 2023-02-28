Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D66A5E84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB1SBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjB1SBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:01:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5FC3345B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:00:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B65B80EA7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC33C4339C;
        Tue, 28 Feb 2023 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607240;
        bh=wRw9hM9vMLvaScT9V1h83YT0B4lwagiDI/HXF2eLlR8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iJ3yJK+eGkrxmdWs9v3h/bbS8W/SdybNTU+w3Ne3odOJNpFHgswE0PaQI/6rKqC0D
         IVrnTw5+jjoetVZnehVZ4yuqHlk7YkFH70Ed2Jdv27cPLBL7jkQc/ocBKi5lYfMisP
         xRtc2q7xSNRb/cvyIuuQBKvyLk1+8d3JLb8/xkosmHO+rBHXg1wTWBkExrcBslrSSK
         kPNwKHitgHylZUo4PBWUqaq7oU06rTS4aRNn4W9Qni9WluH30i71XaUvO774xdDmin
         qyWr7ASzoz3GeKaZZ/tGn1AMt1OTYoOf6bvoMpCRiV6Pa0YCKu58g4S6MOouXrj2Tp
         nW3zT4Dj2ytxg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227085850.2503725-1-arnd@kernel.org>
References: <20230227085850.2503725-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: zl38060 add gpiolib dependency
Message-Id: <167760723817.68866.9637291073477909539.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 18:00:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 09:58:26 +0100, Arnd Bergmann wrote:
> Without gpiolib, this driver fails to link:
> 
> arm-linux-gnueabi-ld: sound/soc/codecs/zl38060.o: in function `chip_gpio_get':
> zl38060.c:(.text+0x30): undefined reference to `gpiochip_get_data'
> arm-linux-gnueabi-ld: sound/soc/codecs/zl38060.o: in function `zl38_spi_probe':
> zl38060.c:(.text+0xa18): undefined reference to `devm_gpiochip_add_data_with_key'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: zl38060 add gpiolib dependency
      commit: 0de2cc3707b6b6e2ad40bd24ce09a5c1f65d01e1

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

