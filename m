Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB14616AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKBRhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKBRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B072E686;
        Wed,  2 Nov 2022 10:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A6461A7E;
        Wed,  2 Nov 2022 17:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F99C433D6;
        Wed,  2 Nov 2022 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410669;
        bh=qBcuLcIPjdURuvuk20JLNusPnboz7EfavDEfGEAzt1Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=irEtKYzo3mT3UCtb4KYleQhSUD7Xi9uU0H7UsGUVhWuhOXXDM1cTHFVoqylD/I9bT
         09SenWfscm1yu1IOyUZN4gJHihHgcdcdWkPPKTB+fkaO7kfQe1ccRcVidPXwAQ8G7F
         srjRIC3QeOoObSntKkgRFH7s4Iy3mAGdQztWs8FZNQc+jhi3pzdSQ7ajSlxz9kUYYo
         WEpvelhLAOeOX4Jq6/2ZwxLHPMJV7OHCE8AZ7qpLegl8wq21jt8B68KrPK1FtewF9j
         ZtsZRZTq/ER5cyu1jw1k8rj+DjTyoakhEuLZLcm/wRAUFgbfufYgoXGvuVy+dAB8yC
         HMZQRc5fZYchg==
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        linux-spi@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102152904.143423-1-colin.i.king@gmail.com>
References: <20221102152904.143423-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] spi: nxp-fspi: make const array ls1028a_soc_attr static
Message-Id: <166741066762.302937.13190941938549227127.b4-ty@kernel.org>
Date:   Wed, 02 Nov 2022 17:37:47 +0000
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

On Wed, 2 Nov 2022 15:29:04 +0000, Colin Ian King wrote:
> Don't populate the const array ls1028a_soc_attr on the stack, instead
> make it static. Also makes the object code smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: make const array ls1028a_soc_attr static
      commit: 6c6c49f2c0993ab3ea4bb71a12c800afd0c59e30

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
