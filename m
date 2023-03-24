Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019C6C8636
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXTwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXTwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9A59D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA5CBB82582
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3882C433EF;
        Fri, 24 Mar 2023 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679687565;
        bh=OOIq79glHbDyn3NOGSr+CYyWZMQwvP3Vqubh/mt7bWA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bpwwZWDo5Te3rYYDGM6yY5WiM5KVzh8JP2o/KoxzdW1f7JPXQJDiHcknRDdRwvRt7
         eoRBX4gOii5uIT0Mngy6apTc7EPNIYGQ/QP15ficQKxwpnObKKRla/hJ2QdOENVMm9
         ndW9RndLXF3ByP/hpgYNyQ3NB1wRdN6SQNYlX53Kc7iv407V3hso/sDkpo52hpl+0l
         cykk6skmt6pUtSqwFYq7ZoHEEND3G55tC7Bu5ESO4gkw2k1DgJNBSkW6SKvfBkj3Y7
         SajgV03MkRfFttTPMMzlt5s4Duq89avhP/sxXr/jh7DScKIPyG+juLDh8s31OQImh5
         JKo2BDCwFUpdw==
From:   Mark Brown <broonie@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230324145535.3951689-1-harshit.m.mogalapalli@oracle.com>
References: <20230324145535.3951689-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] ASoC: cs35l56: Remove redundant return statement
 in cs35l56_spi_probe()
Message-Id: <167968756243.2700247.10054205791284149281.b4-ty@kernel.org>
Date:   Fri, 24 Mar 2023 19:52:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 07:55:35 -0700, Harshit Mogalapalli wrote:
> We have unreachable 'return ret' statement in cs35l56_spi_probe(),
> delete it as its dead code..
> 
> This is found by static analysis with smatch.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove redundant return statement in cs35l56_spi_probe()
      commit: 283771e8eefcbe4a0a84c6a00a0b7a210bbc5846

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

