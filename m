Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6EE6AC122
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCFNcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCFNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57892ED4C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEE3FB80E40
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9F9C4339C;
        Mon,  6 Mar 2023 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109527;
        bh=vHD+Qw2wXeMkMUjtTnYb4H790o7nOfbwTCjhdr4yWd4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aeBBIhmKunx+ppCbWgZI5muIUNhqTVQ5wbnFA8nAs7/Lqw7KMHj8lQjtsVK5m9G+8
         8zjmV2+u90SQBWkVp+GKRuzkHVuHOVB6SL8TmpsniwJc/HKK4O/p77kkCR9ts6Ybfz
         9q9BZHwoHRYDdRpT3RXNZNm3Gvdmc/6FbI1AcQ1GA0a9pQSieduyFA9ebCVy/6cJFd
         /zFpaxQhGiEgMu2gKA//c/eRKeykKT1WY4HTnNToOa8iV8aQ27fMWstoamZv0w9U+Z
         oSS0HVaIQXRZuvz7boXHJNWGsePH+iTJJDkGu3FJLsjCV0HUlXmphpMC0UW89ciLpG
         BU5rTaU25gaxA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230301113807.24036-1-claudiu.beznea@microchip.com>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/8] ASoC: microchip: some cleanups for AT91 sound
 drivers
Message-Id: <167810952550.75807.18160787538439969782.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 13:37:59 +0200, Claudiu Beznea wrote:
> The following patches do some cleanups for Microchip AT91 sound drivers.
> Along with it I took the chance and updated MAINTAINERS file.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (8):
>   ASoC: mchp-spdiftx: use FIELD_PREP() where possible
>   ASoC: mchp-spdiftx: use regmap_update_bits()
>   ASoC: mchp-spdiftx: update debug message
>   ASoC: mchp-pdmc: use FIELD_PREP() where possible
>   ASoC: mchp-pdmc: return directly ret
>   ASoC: mchp-pdmc: avoid casting to/from void pointer
>   MAINTAINERS: add myself as maintainer for Microchip AT91 sound drivers
>   MAINTAINERS: update Microchip AT91 sound entries with documentation
>     files
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: mchp-spdiftx: use FIELD_PREP() where possible
      commit: 28ce5698456ab53540093836c6fee15119cf1821
[2/8] ASoC: mchp-spdiftx: use regmap_update_bits()
      commit: 0ab4bd5bf277349262065e88eb2feaaabf53584c
[3/8] ASoC: mchp-spdiftx: update debug message
      commit: 2d8dad4dc4d4a12afa3c31e72b60727d4c133b99
[4/8] ASoC: mchp-pdmc: use FIELD_PREP() where possible
      commit: 129742576dd1b972ea1e671595a085e29012f7f3
[5/8] ASoC: mchp-pdmc: return directly ret
      commit: 51124a30308e6db8658575e5d9ec1ea3cb3ba3c3
[6/8] ASoC: mchp-pdmc: avoid casting to/from void pointer
      commit: cb72b29cd5cfac20894a040e411dec70bb75097c
[7/8] MAINTAINERS: add myself as maintainer for Microchip AT91 sound drivers
      commit: 8f943f00d7a844daa9acafd304c2178f30ecc255
[8/8] MAINTAINERS: update Microchip AT91 sound entries with documentation files
      commit: 15dbfc04e6865bae1aa275216baa1a7eb55cd2cf

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

