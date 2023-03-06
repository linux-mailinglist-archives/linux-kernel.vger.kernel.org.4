Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BA6AC04A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCFNFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCFNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:05:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0B83D4;
        Mon,  6 Mar 2023 05:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE791B80E13;
        Mon,  6 Mar 2023 13:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD48BC4339B;
        Mon,  6 Mar 2023 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107912;
        bh=o/reu7XhlEU4l+WGdxo2zPNSFB63mVxpMFab8epHRZY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HdDmL6p3TDqGagRGMgH9Z7kISaiAfzZNwzfKjjQpJIa80Yk72fNaSwiwPT2fUS/y7
         aZQOC3/pJRdKyKaLy2yl0ToHMCUOEdDy6sFyuUmH9CmC+zpBDBPyPRsd/mp9304S9M
         YcdYq9ymQLK7ADVH44cCGgHdy9s2HCdks/HkuZC7JkjxIIWbUqit4FVktpkb9tu21H
         AKhtSTqxMcrE4WZ21v2rmveR0ifGI9OnRccjtxUSAklBZtlEaUEdM/pPjdhsFu6k2U
         btfCP1oXQssfM5u0BK0PI8yza3R6+RIQWnAhDnqjiANe2unqS/UbTyi3hAJn0QO4IO
         Tp5FZ5S0s5F/g==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <c112aad16eb47808e1ec10abd87b3d273c969a68.1677704283.git.christophe.jaillet@wanadoo.fr>
References: <c112aad16eb47808e1ec10abd87b3d273c969a68.1677704283.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: Reorder fields in 'struct spi_message'
Message-Id: <167810791156.67440.14345936497327774965.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:05:11 +0000
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

On Wed, 01 Mar 2023 21:58:52 +0100, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size from 112 to 96 bytes.
> 
> This should have no real impact on memory allocation because 'struct
> spi_message' is mostly used on stack, but it can save a few cycles
> when the structure is initialized with spi_message_init() and co.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Reorder fields in 'struct spi_message'
      commit: ae2ade4ba58167f165fbf3db19380f9b72c56db8

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

