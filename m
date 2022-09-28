Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A905EE316
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiI1R1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiI1R1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:27:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27CF1D74
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 696A3B8216E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7EFC433D7;
        Wed, 28 Sep 2022 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386021;
        bh=dkjJX3GmTUUEkX53QWs8rV3NWH4VfCMRbH6qGJMwdts=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A9sOr9ddn0zmiTF4Gq7/WqosRJlG6j/PR+b7EyX39g572sg+QfEpvDtSAyMjt6Rgw
         w+l7U7p3snIl0oxw8jw4HJyYWPos/rUJBqLBoiFa6moWg/PDPB+n1DDCa5D8UQkrUs
         oZxfDtDrFRiS5gV6Ayb+G8SkebthxyECwvxOrmZjDNQN8P1RPR8PJr4Gw2Gaf3Mq4/
         C1b3aHJF05hCXOPZbUgdTngmO8PrD/9VSRZBnxxUZ9eTBvwoeDwpVjXx37Mgv9UC3H
         pWD1O2rD00jyi3EkE6Mgue5lZIpPlTF/pSFILWoDA5PpjHyWUQtXwzkp/rUtECBoYr
         vvlJ3/96QANXw==
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>, matthias.bgg@gmail.com,
        tiwai@suse.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220927151141.11846-1-trevor.wu@mediatek.com>
References: <20220927151141.11846-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: update audio tuner settings
Message-Id: <166438601946.235698.6774354071024623483.b4-ty@kernel.org>
Date:   Wed, 28 Sep 2022 18:26:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 23:11:41 +0800, Trevor Wu wrote:
> Audio tuner is used to handle clock drift between 26M and APLL domain.
> 
> It's expected when abs(chg_cnt) equals to upper bound, tuner updates pcw
> setting automatically, and then abs(chg_cnt) decreases.
> In the stress test, we found abs(chg_cnt) possibly equals to 2 at the
> unexpected timing. This results in wrong pcw updating.
> Finally, abs(chg_cnt) will always be larger than upper bound,
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: update audio tuner settings
      commit: 7ba6546b547c75b0196029c7e0aaaab2eb6694a4

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
