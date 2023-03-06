Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25CC6ACF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCFUay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:30:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058728234;
        Mon,  6 Mar 2023 12:30:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2013761178;
        Mon,  6 Mar 2023 20:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054BEC433D2;
        Mon,  6 Mar 2023 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678134650;
        bh=EzyQ3MFE9bDskGkMob8SF3iTbMV/JwpCm6+1rwkuY/Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hFabFcGKQag/u2uJWte4wLKT+RA++HuQxedYciItv3wzkFIN51mmuAmdZ7j0WvMUQ
         3U2vUBH/aC6kQeSEYIcAuTLv0oxH5tTAgqJ0xDqWIzt7cNsHY0ECnU6iAvykze43ax
         UT3DysiOrJwT1NitdGO6YiIsEgZzzvAWnMD2j1L9PKL4G0AEe/vHu3VmwXUP7Tgree
         nIeiLIcOxGVp85Ddfmpfq4Aatio4mfAxtuzEma9sJ2e4iq/ilU50dMdjf8jaWLiInq
         QiPytgUKSq25LNusOsm1r388EsNaJoNbChXv1QK5z/iuUjBlUTMyL/Njoncwr9rz0r
         BZYh9khbpVXmQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lucas Tanure <lucas.tanure@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230223084324.9076-1-lucas.tanure@collabora.com>
References: <20230223084324.9076-1-lucas.tanure@collabora.com>
Subject: Re: [PATCH v7 0/4] Add CS35L41 shared boost feature
Message-Id: <167813464774.226962.10169178357307484106.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 20:30:47 +0000
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

On Thu, 23 Feb 2023 08:43:20 +0000, Lucas Tanure wrote:
> Valve's Steam Deck uses CS35L41 in shared boost mode, where both speakers
> share the boost circuit.
> Add this support in the shared lib, but for now, shared boost is not
> supported in HDA systems as would require BIOS changes.
> 
> Based on David Rhodes shared boost patches.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs35l41: Only disable internal boost
      commit: 4658de99d43cd740e019e7fd124b4128f8f4027f
[2/4] ASoC: cs35l41: Refactor error release code
      commit: be9457f12e84437259707415364cc5fc96041ed6
[3/4] ALSA: cs35l41: Add shared boost feature
      commit: f5030564938be112183ba3df0cdd6dea3f694c2e
[4/4] ASoC: dt-bindings: cirrus,cs35l41: Document CS35l41 shared boost
      commit: 340307d7effd99303fe933cde3b7288f8f3c6677

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

