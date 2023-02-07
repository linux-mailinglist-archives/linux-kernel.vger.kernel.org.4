Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CCB68DC70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjBGPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjBGPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:06:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E41E1D0;
        Tue,  7 Feb 2023 07:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FD5260CF2;
        Tue,  7 Feb 2023 15:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E79FC433EF;
        Tue,  7 Feb 2023 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782370;
        bh=badlW/3+QDzoUhc29zGHXmZ4z/rz2lxgNwDdywUABmw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nFlTSCI1useyPe3QXNR86BORNCnDOV4NSRAIxfLfZT9KWcH2lT4ZzLqTvowlIW6vm
         YxhWQGZqje4B8nENkBKm6vYUAsE2aA15WuXifJ5EJ7ew73x6NTnDCG4XRIdjhCfmRI
         rkjAiRJFiPU5cHeyl7Te2Yt/phKo1zG5ZIP8CQIK6hLQOFEQe32uqxvuegbNgBMWrE
         zAtC9I+Y4emr9KA8WZ+crRmAFY2/3FWI/WVYKv03nCQ9eAtgeU29EWbXzzypr5K34S
         c2gC7dX2Kk/t4/Tbuufd04g4VIXfqrhPQ7IPPvK6qWuOonspMSz0KjYw3Z7pE3x/6l
         lcnKush00k+Og==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com,
        Mauro Lima <mauro.lima@eclypsium.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230206183143.75274-1-mauro.lima@eclypsium.com>
References: <20230206183143.75274-1-mauro.lima@eclypsium.com>
Subject: Re: [PATCH 0/1] spi: intel: Remove DANGEROUS tag from pci driver
Message-Id: <167578236910.223670.16179762003995286169.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 15:06:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 15:31:42 -0300, Mauro Lima wrote:
> Given that the PCI driver handles controllers that only work with
> hardware sequencing, we can remove the dangerous tag.
> This patch is the second part of Mika's suggestion [1].
> The first part was accepted in [2].
> 
> [1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
> [2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Remove DANGEROUS tag from pci driver
      commit: 7db738b5fea4533fa217dfb05c506c15bd0964d9

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

