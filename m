Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABD6E694F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjDRQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjDRQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65679CC29;
        Tue, 18 Apr 2023 09:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC83D6366C;
        Tue, 18 Apr 2023 16:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2E2C43444;
        Tue, 18 Apr 2023 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834904;
        bh=C+YXp1YzghPs/PzpGff4esPU4fpZ46k0RtwOSnDI8y8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ew/I6nMkKZizb3tYOL5cs7Xtm6Dz2apRcY961rAzuHRN/3AOio86IIE2JOeH2NgXd
         f4tOgdkGvNrXuRibKyYrsUl6gUuefwT8dwltYcV56VMfU2ZmE4ZV3iD4hrZBIheW4q
         7Jwt5zOa5b1W4FYqA09hfWBpcHL4ke1WWmz663R4Q+gvsogK/41ZoZHk/pnGTCbRAN
         FCpuzeEy2KLWXNaGK+5336JPKQfUMNi8jbTEdoV9+zVU4U4gE2bAA0K+KzSDUij90O
         8o8eGd7KQHWbBxE93ge17BbkEE7FU9+etRtX+GfjTLTyXG76HrL771DWwzHEasc9o1
         JehuD24BRoZsw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, gcnu.goud@gmail.com
In-Reply-To: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
References: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
Subject: Re: [PATCH v2 0/2] spi: spi-cadence: Add Slave mode support
Message-Id: <168183490294.88110.10975692656587526542.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 19:17:03 +0530, Srinivas Goud wrote:
> Replace spi_master structure with spi_controller structure.
> 
> Currently SPI Cadence controller works in Master mode only.
> Update driver to support Slave mode and also Full duplex transfer
> support in Slave mode
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cadence: Switch to spi_controller structure
      commit: f6997e9bd879ed1f1c61e65b6fcab0de9a873ab0
[2/2] spi: spi-cadence: Add support for Slave mode
      commit: b1b90514eaa3454223d6f576a108cc0a58924a65

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

