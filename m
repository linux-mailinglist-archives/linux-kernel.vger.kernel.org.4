Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2A71A2F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjFAPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjFAPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA781F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681E8646AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF6AC433A0;
        Thu,  1 Jun 2023 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634274;
        bh=YU6Gm1YiO17K+MphtoRoKgPhTOkXNovZgUttO4A1VO0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l5/S6IrjoKCHeei+z85Bz1sGf08FxYGZ+09+7u4phDtB9cfiAqGkTw+hD6QU+y7ku
         QsqFn1qXZSPC7fZNxnU+GG861Xt6D/YZGi/vjeLsX36l4JASXP7rgVRzAIpE0gbfDl
         x23dlEX7DyT3EB1bkLlyB8Z0dyffxnqqwWbATWbBBqb2wCydBKE2LfF6Zk6cnVJBul
         UMQqxfxTYiLyBZOsQz0XFKEHnI5+9ARtmdapn2/7ePKdl51j35TUnFNLm3EHv7nvr/
         DIRv5EO7+L8aJlmD5Jer2LIE2ndBNcctjsf1GHNqA/cmtjuT4HtLofNCiRiAOCjYem
         cAMFzFzieJMwA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ryans.lee@analog.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
Cc:     jairaj.arava@intel.com
In-Reply-To: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
References: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: max98363: Removed 32bit support
Message-Id: <168563427297.132600.17300649682311812802.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 16:44:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 06:05:59 -0700, “Ryan wrote:
> MAX98363 does not support 32bit depth audio.
> Removed 32bit from the supported format list.
> Instead, added 16bit and 24bit to the list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98363: Removed 32bit support
      commit: 0e2ee345856454632dcd2f3ee2ba4bb3f8632f74
[2/2] ASoC: max98363: limit the number of channel to 1
      commit: 3a67ad17b47ed111bda692238b6a19420e6934c8

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

