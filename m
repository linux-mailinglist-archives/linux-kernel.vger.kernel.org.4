Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088AF614B29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKAMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiKAMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:53:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075819031
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E679EB81D1C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419C3C433D6;
        Tue,  1 Nov 2022 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667307225;
        bh=ssrjw0PdeZf+FjcUuVM0bn20nuahEAU+1IE+6PgcWnA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GT21kV1OvpLF3LWoJYL3bGex3+y4Qw91Tl3qYAIcBKFvgujCmYEMPElDIBA1zTNu0
         kPBXRNrDBbY2uCtYliLWsYjsT6ugSaQZAdYYC21muzKkIpNwquVuuPd+nLAb4nLaNt
         aPen64BxLm1WcKc327Exqt96UW5Jqtddy6XJgqKWWdhhiIY4vHzLbhtoYyDRWYVYVy
         yV6RWx+VIcfmnFK2B+TJ/fixc0KfdqgdkNsERUdxSORqVilJM3QIXcXMXZj5vPPGCK
         ZdiBXrYz4AXuOpzvvCJaKP2YWs+u3GH5rZ+u1SJBMHI61hoo6fPbg3MDG9ePnDi4Bd
         iQqm9acgIE/Yg==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com, james.schulman@cirrus.com,
        ckeepax@opensource.cirrus.com,
        Peter Bergin <peter@berginkonsult.se>,
        tanureal@opensource.cirrus.com, david.rhodes@cirrus.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221031203723.168177-1-peter@berginkonsult.se>
References: <20221031203723.168177-1-peter@berginkonsult.se>
Subject: Re: [PATCH v3] ASoC: cs42xx8-i2c.c: add module device table for of
Message-Id: <166730722298.177758.3834028239345965105.b4-ty@kernel.org>
Date:   Tue, 01 Nov 2022 12:53:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 21:37:23 +0100, Peter Bergin wrote:
> When trying to connect the device with the driver through
> device-tree it is not working. The of_device_id is defined in
> cs42xx8.c but is not correctly included in cs42xx8-i2c.c.
> 
> Move of_device_id table to cs42xx8-i2c.c. Get cs42xx8_driver_data
> in cs42xx8_i2c_probe() and pass as argument to cs42xx8_probe(). Move
> error check if no driver data found to cs42xx8_i2c_probe().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42xx8-i2c.c: add module device table for of
      commit: e5afc8677c0d9be4bea5ef5ab01719e190450943

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
