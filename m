Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFA6BEE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCQQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCQQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994E5D8B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49848CE20DE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD02C433EF;
        Fri, 17 Mar 2023 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071240;
        bh=zzj5xFoA7fcW2ai1OCzgVDIOUVE95vKPZjxuGeoZ1w4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G1dMEdK26p1myMFu7+Mqy4HjKMe55IVEq9DN9WFO+7qT12rCyLskpS674dUOULU/F
         kWhLaiB/by9Yed/p8dyCtB4tT6IPymd23UekXr1J4OacDsuZqkg7admWKBEnxz2uWE
         TAGMcXNzelhGOvofLlNMNbY28ixqo7fVXaO2d+Tl3wgeTtkIoc1ltzre9/th+fsma1
         82xQBjCX5cWh9ssZ5zIli01Cgolxf6R/vzvtRLh5o9G1Z36iwZ+jzARqt3DMcMt89K
         3sg9uMLPiIjkwVatg0AaYqXZoCGvnUYO/5MKOKSLW8UU/nLipigjp/p1vcSX4lXE3m
         KdSRI0oW9y29g==
From:   Mark Brown <broonie@kernel.org>
To:     Ge-org Brohammer <gbrohammer@outlook.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <PAVP195MB22610BD3A98379E740C93C08DABF9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
References: <PAVP195MB22610BD3A98379E740C93C08DABF9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP
 Laptop 16-e1xxx (8A22)
Message-Id: <167907123961.46507.2293327345396862339.b4-ty@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 21:26:00 +0000, Ge-org Brohammer wrote:
> This model requires an additional detection quirk to
> enable the internal microphone.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)
      commit: 205efd4619b860404ebb5882e5a119eb3b3b3716

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

