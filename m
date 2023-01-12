Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8566836F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjALUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbjALUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:03:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252713E2A;
        Thu, 12 Jan 2023 12:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0FBDB81E62;
        Thu, 12 Jan 2023 20:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28061C433D2;
        Thu, 12 Jan 2023 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553688;
        bh=DjplknG/Og42vIVzT/q7FbntQdQMbrnKJqFFsTyhjNM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EUafdQGi6kPVntwFcsX8dQ++eMfDpAt4hRufXGYp4rn3498p9O5an8Dtzb32f8VZO
         /0dwxqLx9EiZWyrofGYjXdGydKTREAjzdQvusJ0Ow7D4V0fv83WO6VIMOVK93JIW2S
         WKNFKVIBv7VwC+kTD5h1WgF5etFBp2YPn8S3ZXmT1Seav9nsmaQ1vhNBslaNNmcYRn
         zsCLB4TmasZgZxWFa1UpanGfaUnDdJStrP+pk1HardQUH3NiBxgoCCXTezH0ic2ZBw
         6otuSPV9m9aONvZu3dzL7IfHqeZgMZCL4VALktP1HibdXNi78cOSWjN0jogQQsvptF
         31XhLFJQie5QQ==
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, stern@rowland.harvard.edu,
        alexandre.belloni@bootlin.com, brgl@bgdev.pl,
        damien.lemoal@opensource.wdc.com, dmitry.torokhov@gmail.com,
        linux@dominikbrodowski.net, balbi@kernel.org,
        gregkh@linuxfoundation.org, deller@gmx.de, perex@perex.cz,
        jingoohan1@gmail.com, lee@kernel.org, kernel@wantstofly.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        marek.vasut@gmail.com, mkpetch@internode.on.net,
        miquel.raynal@bootlin.com, lost.distance@yahoo.com,
        philipp.zabel@gmail.com, linux@armlinux.org.uk, sre@kernel.org,
        slapin@ossfans.org, s.shtylyov@omp.ru, sudipm.mukherjee@gmail.com,
        tiwai@suse.com, ulf.hansson@linaro.org, vigneshr@ti.com,
        viresh.kumar@linaro.org, wsa+renesas@sang-engineering.com,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH v2 00/27] ARM: pxa: remove all unused boards&drivers
Message-Id: <167355367885.2500964.3629822486060649314.b4-ty@kernel.org>
Date:   Thu, 12 Jan 2023 20:01:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 14:45:55 +0100, Arnd Bergmann wrote:
> Most of the legacy PXA board files were marked as unused in linux-5.19 and
> can get removed in linux-6.3. There is support for pxa250/pxa270/pxa300
> using devicetree already, which supports a number of boards, but progress
> on converting the remaining ones has stalled over the past few years.
> 
> The two boards that are left in the tree for now are the three 'sharpsl'
> variants (spitz/akita/borzoi) and the 'gumstix' family of machines.
> Both of these are supported by qemu, which can be helpful for completing
> the DT conversion.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[14/27] ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable
        commit: 5eab9265759e2fb042aa452931c3d06ab7ab8dae
[15/27] ASoC: pxa: remove unused board support
        (no commit info)

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
