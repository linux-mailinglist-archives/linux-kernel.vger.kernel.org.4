Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83E6A5E80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB1SBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjB1SBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:01:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E232E54
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:00:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBFFB80E9A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BD8C433D2;
        Tue, 28 Feb 2023 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607230;
        bh=g/zRMqEHWvrUdMovSA/zwPxEgtx1YbVsjFwL8peZugg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HZobxikkQG2ou9HWf9cwO80G/+gCBkcX18aLab76EEwpTtYw+lxF8IHqxBAC6+GXJ
         BlkOzb9P9w01cIPARw6UG+mydWBCXarm5pTkQ/RmNVbBI10GrzvoGeExZLBRKCSgeF
         I8s7vbJ7tshwQ8R5n9o9pz/Dbtic7IqxKrxQB+tV7jjiB4Idr3n6T8fDtTwoueM4Jj
         lM9v8Ed7TbLgf5FNexWIfvjADWwcPYMGqwCU4vpk7fc5QyS+VP2xqGw6Gy7od/kMY/
         Klpv/cAv4vLHt+IuQnw04T/aUYaxaMCCeIxFV4sFZvVOsWNjst+9TL9BqyEQMVNs7K
         TK4UF3I2GouTA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: mt8192: Fixes from initial glance at
 kselftest run
Message-Id: <167760722797.68866.15387830398391668204.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 18:00:27 +0000
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

On Fri, 24 Feb 2023 14:03:54 +0000, Mark Brown wrote:
> This is a collection of fixes I came up after glancing through an
> initial test run with the Spherion Chromebook on KernelCI.  There are
> more issues flagged, this is just what I fixed thus far - the volume
> controls on the MT6359 have issues for example, and a lot of controls
> aren't marked as Switches like they should be.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mt8192: Remove spammy log messages
      commit: 5df1a5d28449f2b98ff84f69dea74b06f9b8e362
[2/4] ASoC: mt8192: Fix event generation for controls
      commit: b373076f609993d333dbbc3283b65320c7a41834
[3/4] ASoC: mt8192: Report an error if when an invalid sidetone gain is written
      commit: 05437a91173b8780692ac35313f98cac68be7c42
[4/4] ASoC: mt8192: Fix range for sidetone positive gain
      commit: ce40d93b062c0bdcd29218c12ab1dba544382dd8

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

