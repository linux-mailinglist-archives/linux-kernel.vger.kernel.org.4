Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE010619B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKDP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiKDP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:28:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E9DE9A;
        Fri,  4 Nov 2022 08:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81B57B82EC3;
        Fri,  4 Nov 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A76C433C1;
        Fri,  4 Nov 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667575702;
        bh=LDGCDoHyAerC70HgbuOPtlNQHbiwGebSazZd8iM7vNQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i+ymtIiUa5jIQJkm1gvDG2OjNx/ZxTtJ9bqLheAP02uUTJ2OJxuMlEbg3jtL0yU2K
         jtosVxUw8pnbyQRw3pmqbxTahMKyzFCLxkXE+l9vL1yS9wP2kIa3EmQw6wbq8RwkYe
         BcF8sr0O+rl3A8ImWHUywFmNnOhel1AvC0emiV/wgvhFk8CWALREfK6C+d3eReaH1v
         4JQp7yOyg8wvLbdHqlFhMkENWxXCqPYQKfW50UVQ8Szc6CYxALcnvKyv3nk+lmte1w
         xmfKVLat8V93XEQ02OLkAdyn3AFcuTgmSwqjl89hGqnNCwoV3ohRCv6kT5H8NRnwWt
         YoiukuamcnhCw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <809c82d54b85dd87ef7ee69fc93016085be85cec.1667555967.git.geert+renesas@glider.be>
References: <809c82d54b85dd87ef7ee69fc93016085be85cec.1667555967.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: Merge spi_controller.{slave,target}_abort()
Message-Id: <166757570101.379896.16321881884283599927.b4-ty@kernel.org>
Date:   Fri, 04 Nov 2022 15:28:21 +0000
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

On Fri, 4 Nov 2022 11:01:27 +0100, Geert Uytterhoeven wrote:
> Mixing SPI slave/target handlers and SPI slave/target controllers using
> legacy and modern naming does not work well: there are now two different
> callbacks for aborting a slave/target operation, of which only one is
> populated, while spi_{slave,target}_abort() check and use only one,
> which may be the unpopulated one.
> 
> Fix this by merging the slave/target abort callbacks into a single
> callback using a union, like is already done for the slave/target flags.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Merge spi_controller.{slave,target}_abort()
      commit: 6c6871cdaef96361f6b79a3e45d451a6475df4d6

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
