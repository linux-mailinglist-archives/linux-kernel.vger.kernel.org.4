Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEE87506BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjGLLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjGLLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E721980
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D21261796
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E57FC433CC;
        Wed, 12 Jul 2023 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162442;
        bh=tKLfC2rwGbl8YnK4YjwgLzW6T3SVz9CzEGa1Le2ZqKA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NgADLBweT0/pL8STLLYgRap71SqW9W3ABpkb1f5xw6T76IBKC/4jctVi2o7+yzp8G
         zEBXWmB+QvSOe0ZX54kbZV7SfMHRd4sdjWNQrHgBBNSwKVxougyW3N8I6uLVCzgpO+
         +zzoDG4Qkagy71dOKACXasOojrtg0Fa69MDoZFLgjVwROvXa1TxscPExwh1lENdC1t
         ri82wt37Gl7VYX+ikEzWDn5Zzjz7MFubp7Vuj/Qk8iffvl+tApUECx/kEM4nULNHw8
         vyvxzH+9VQo6vCrvN8sPNScnAAIFR5GjGtCXo388Fl8uc07s6SwZrasv1BLRDn/sN1
         9252cpsggdlxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230705214800.193244-1-cristian.ciocaltea@collabora.com>
References: <20230705214800.193244-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v3 0/3] AMD Vangogh support for NAU8821/MAX98388
Message-Id: <168916243923.46574.4640392228923703244.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 00:47:57 +0300, Cristian Ciocaltea wrote:
> This patch series extends the Vangogh machine driver to support a variant
> based on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388
> Speaker Amplifier.
> 
> Changes in v3:
>  * Dropped acp5x_max98388_hw_params() in PATCH 3/3 and rely on dai_link
>    to set format, according to Mark's review
>  * v2: https://lore.kernel.org/all/20230705134341.175889-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: vangogh: Make use of DRV_NAME
      commit: a0cb05cb70b469198ad86c0b13b02cbba3ecd8fd
[2/3] ASoC: amd: vangogh: Use dmi_first_match() for DMI quirk handling
      commit: 3dd26e27ccb4f18b4d25c0a49e1888eca9c6a724
[3/3] ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant
      commit: dba22efd0d177a23c6da2a161e9a1ad29718924c

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

