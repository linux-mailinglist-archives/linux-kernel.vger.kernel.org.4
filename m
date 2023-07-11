Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A574F9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGKVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGKVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837C170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C5D6160E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD261C433CB;
        Tue, 11 Jul 2023 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689110485;
        bh=3xkkuBXZf9xavOpTtJVeO/yJn1c+bcauJGizthRoAKY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mNKdnOMRvt4fPbSCYrPHdLIVQJQSEtpamgqmoZUnhfGiPkh9pfX+vBzJra9dYviO7
         IiQE6v4lnz0Ez8NPeCi9oI6PHZOBn1mnVm3d8eGrAB1gF47oxlsZyUCGuolBHOFaWU
         iA+sLxyjz4WcZux+dNSYDifkkjUyFd0Z14miWn7InMfwYn8m81lVDR/X8cgC2p3X+H
         D10bx+nMP8V5asohryc7vciU/+Or9GhziksX2VaTkx/wCZ5n0ufIGhuCBMr8l7L0QB
         OFYrRq/ccXS4tJ7/c6KfYshtFTVpVwzInpDmgKFjWThaDzy8oiJcJv9EJsjwfU0hcz
         ygWrs00o5vs7Q==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Syed.SabaKareem@amd.com, Vijendar.Mukunda@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230708025208.54272-1-mario.limonciello@amd.com>
References: <20230708025208.54272-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: Fix extraneous error messages
Message-Id: <168911048356.530041.349357901498684259.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:21:23 +0100
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

On Fri, 07 Jul 2023 21:52:08 -0500, Mario Limonciello wrote:
> On Pink Sardine machines that don't have SdW controllers in use, the property
> `mipi-sdw-manager-list` won't exist.  There is no point in showing an error
> to a user when this situation is encountered.
> 
> Furthermore if the machine doesn't have a DMIC connected to the ACP, there
> may be no platform devices created either.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: Fix extraneous error messages
      commit: cd710900ed2b96b1fbc26d711d562581afc385e2

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

