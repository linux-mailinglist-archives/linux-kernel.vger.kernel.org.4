Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A66D6726
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjDDPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjDDPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2F4680;
        Tue,  4 Apr 2023 08:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F723634F4;
        Tue,  4 Apr 2023 15:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4742EC4339B;
        Tue,  4 Apr 2023 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621668;
        bh=8m23xWXw2v6aPr62DgfVWXPOFPt6TQkXIqgxZD0dGl8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EOtZ/Pvga+vndUcRqQiCWjdrbBg7rdx2fJ8wCaUZ6FnvH8V5zk7f6NrrUnLqTWA6d
         d0/MXWBECqonggDyrkcDyrzdxkCgsxhq67oWRH5N4r332w4KeKMxbFbbHM0ssAJZWT
         g52B4i4T1fbFa4EBXjCbSvvJVFps5TCHmN5G+MlJtM+d+m5AV4PGe9rktGJKmI2mmA
         H+NDpZQnS0TQNJb6IPb9w7p1+pcVSpGcL8YudDxor6jGWo8/0thqXLfup8qEp7NyQv
         AINn3ZPg8s877v7VBdBh5+RDQpIbJ794hgyhZM7cvHtbyQg64LVjbV/UwL+yJH8wxZ
         h+sUiuPRgi/LQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <20230318222132.3373-1-kgroeneveld@lenbrook.com>
References: <20230318222132.3373-1-kgroeneveld@lenbrook.com>
Subject: Re: [PATCH] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
Message-Id: <168062166496.53383.6928239606358306120.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 16:21:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 18:21:32 -0400, Kevin Groeneveld wrote:
> When using gpio based chip select the cs value can go outside the range
> 0 – 3. The various MX51_ECSPI_* macros did not take this into consideration
> resulting in possible corruption of the configuration.
> 
> For example for any cs value over 3 the SCLKPHA bits would not be set and
> other values in the register possibly corrupted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
      commit: 87c614175bbf28d3fd076dc2d166bac759e41427

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

