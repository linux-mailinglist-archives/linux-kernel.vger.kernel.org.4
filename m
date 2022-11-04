Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56358619AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKDO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKDO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E32ED53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 965C6B82E8C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AABC433D7;
        Fri,  4 Nov 2022 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573769;
        bh=MnImCmWDPv3dphWbt7ZOdBidCmswfX5FKBN4bBqb3hM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rlv2JQx7uSqpV6bvQLw6X4fzO8gJTleJFba+KjQML3UvJei1aXOtfKOtJPaPv8TWy
         rmUmCUhjmWo/cpyy3uUxPqS0sgXcOtMNvcmAZVoZNCu4DivKzxjMzf5tfEPpk3blfd
         VVbMGfU9Qrq7kPeyLzxbyTW9mmYZ1jyS1TksVvpfjgn5d2C3ao6/JIwufzaKpxVioL
         6etkz0PkNTRYJyB4yysAhSDFcLTqcYj3xfaTQNZKs93KdXmOHbGn/PnQ0o9ds9Jkmq
         uzAWPoEmg8ARqnDcamjHjzzRakhrTZhjzSv3/nGL1v/Ell44uvp1yrLQoy/NVCe1hg
         ptkF7UYOJbXDg==
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20221104100637.13376-1-vitalyr@opensource.cirrus.com>
References: <20221104100637.13376-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] spi: amd: Fix SPI_SPD7 value
Message-Id: <166757376782.346504.17328725307428801040.b4-ty@kernel.org>
Date:   Fri, 04 Nov 2022 14:56:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 10:06:37 +0000, Vitaly Rodionov wrote:
> According to data sheet SPI_SPD7 should be set to 7.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Fix SPI_SPD7 value
      commit: bff6bef701db784bb159a659e99c785b4594fc96

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
