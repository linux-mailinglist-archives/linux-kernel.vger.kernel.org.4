Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A26AE749
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCGQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCGQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:52:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6D301BF;
        Tue,  7 Mar 2023 08:48:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D5E8B81920;
        Tue,  7 Mar 2023 16:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322FEC433A4;
        Tue,  7 Mar 2023 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207699;
        bh=zHO+u1qrk2DZ4LziGJ9LYpByCrkQlrxSC/s7+kUpHcc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ju9WUoiMo2Q/Z6Z3v8/oMBS3Q9M4Apl3Rpr+qNw8fwPrDnfcg5Yl7qNRw0taQxnOl
         0uwk3DyAyTGvLsOFNsxgHa5Fu1U7cs/bfhCQMuzKfbY9fMPfMUcFg1zHO0mFRniUwd
         jzcuHuBS+3rvMt3h0rQIA/rZp59zfS+xDhuEqkbQ9pJg4QgkNRdJ6TdkmKT2lTrcYU
         gph0mUdrAIn0/Hm24pa8iNKwFZ1Fh4rsQtDJsTV8ed+vM9F38x89hdG+er2KfhM0Rg
         /ERjQonlhffWXMpi1YUiwG3aOhNVmtwQzDyAHgPDHZAPPQsyvUrp4sevUCp/SyQeSg
         s08zL+JXibM5g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230306182913.87231-1-andriy.shevchenko@linux.intel.com>
References: <20230306182913.87231-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Propagate firmware node
Message-Id: <167820769891.97370.14605696476587563702.b4-ty@kernel.org>
Date:   Tue, 07 Mar 2023 16:48:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 20:29:13 +0200, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Propagate firmware node
      commit: c7cc588bf0054ce33a11b98d05859105c046c706

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

