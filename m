Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913972ECB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbjFMUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbjFMUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7D1FF9;
        Tue, 13 Jun 2023 13:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0674763A81;
        Tue, 13 Jun 2023 20:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A76C433F0;
        Tue, 13 Jun 2023 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687169;
        bh=lSpE3z3DCEtozgP5ySEwTV4ARJWw0/T04lDYVrx7VwI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dl9UTg/7GF6ccg5VZ4V97JI5DjbgNZPesP1X7V2GzCpekZNWgwJ+7FzpXmOMvuiEM
         0jIQDiHUIEygA2uyBxU+NtMF/Ven4fHICQynXAh5B9m0dQY2LA6HqVNTd9nqSpyBC9
         d9rfzODkNdD+VGkeO3awOFcIoBv1Elba/tzmPuAXffmctMYpASU8czCYFi/gRgJhTa
         2rxFMwpv1qTSe6x7kmiM73EiCKNbDi875Abo/2oCQoMFrvLeTH6yPnjdygqSpDTBGM
         7z013dyD8IHhx0njuwEdm2c/n9un5K3zE7LBYV7sSZW1JHnwxp4uUpBuK2O1G38arr
         WRHmowpyO+8Pw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Abe Kohandel <abe.kohandel@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230613162103.569812-1-abe.kohandel@intel.com>
References: <20230613162103.569812-1-abe.kohandel@intel.com>
Subject: Re: [PATCH] spi: dw: Replace incorrect spi_get_chipselect with set
Message-Id: <168668716790.174856.4659003414906953886.b4-ty@kernel.org>
Date:   Tue, 13 Jun 2023 21:12:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 09:21:03 -0700, Abe Kohandel wrote:
> Commit 445164e8c136 ("spi: dw: Replace spi->chip_select references with
> function calls") replaced direct access to spi.chip_select with
> spi_*_chipselect calls but incorrectly replaced a set instance with a
> get instance, replace the incorrect instance.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Replace incorrect spi_get_chipselect with set
      commit: eee43699217504ba69cadefc85c6992df555e33f

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

