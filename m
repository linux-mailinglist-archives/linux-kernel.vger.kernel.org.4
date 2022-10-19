Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE1604C50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiJSPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiJSPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1216084E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6786A61940
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A958CC433D6;
        Wed, 19 Oct 2022 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194612;
        bh=AKdjSjqhfyMLh9EcXa2O+uSYw6EByKpCQewc2c+0jck=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N482c+5c5LbnGDRacYUtcJC3ppY5zO4sARi9SOZhjGpq7Pe5nh2dAntYAd/miee1F
         JKNLcZhM4WBcPg5ebXvyZDrWNIt6MMd2W4rW00ZLpaSg1xCYLY0M2zjMmPNpvmfP9z
         Pcblnt31myzS41Hw6ef/dEOz18Zg+euf9i+CrbuNRtl+FpkykiqI5tcBulz8Jtzp3V
         a5GfPDKE7aKFEnRXnkZJYrTeMNc22GKsvdEG5BuXo4dfSz8yyGCI0qkKjB2rLpYc85
         C1P3P174+ys7toF6VyLNa9lpC7LdVxskzONnvTgk3U5N9QJ49moyRR0Efzd/MFT19l
         1FWNYfIXjqXSg==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lgirdwood@gmail.com
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        spujar@nvidia.com, perex@perex.cz
In-Reply-To: <20221019012302.633830-1-aidanmacdonald.0x0@gmail.com>
References: <20221019012302.633830-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2] ASoC: simple-card: Fix up checks for HW param fixups
Message-Id: <166619461019.884966.4133490951229701907.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 16:50:10 +0100
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

On Wed, 19 Oct 2022 02:23:02 +0100, Aidan MacDonald wrote:
> The "convert-xxx" properties only have an effect for DPCM DAI links.
> A DAI link is only created as DPCM if the device tree requires it;
> part of this involves checking for the use of "convert-xxx" properties.
> 
> When the convert-sample-format property was added, the checks got out
> of sync. A DAI link that specified only convert-sample-format but did
> not pass any of the other DPCM checks would not go into DPCM mode and
> the convert-sample-format property would be silently ignored.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card: Fix up checks for HW param fixups
      commit: 32def55d237e8507d4eb8442628fc2e59a899ea0

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
