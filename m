Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A795B9776
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIOJbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIOJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:31:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662A97512;
        Thu, 15 Sep 2022 02:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1533B81F06;
        Thu, 15 Sep 2022 09:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7CEC433D6;
        Thu, 15 Sep 2022 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663234291;
        bh=lBKPmLbjzFxuJu62Vh8rf5713uoi9Z/o9W5MVo7ErJk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OBVnYl4sASrxWbDpDP4Z23YBu3TFec6cKPFZdUMgJUOnz1iFXP5dVawW4N1zTzTTe
         KpjKJE0ibvVI0EZISBmwVsAeN7SehWWqCbiP1odPMEzqCOaaRUKdv/krLXCTqPGN+X
         O9SXC17thuZma+znDsfzB6Ll536kIGRa0r1laYA9a0HHu0bGDVLxqD2pKhr34rWALx
         /QANPTR1iYBdPCvehZUp9m9ZjQUwUL3ZGHfd02HXa/Bvz0D1bsmcWJ8etpVLwBr0F6
         /O6uWRDJoiRhaGBdQfOOG2H9byRD2RlYGCtGlx1SDJmdZyWlBpxlLORmv9XqYC75a/
         xwlAcJUFT3M6A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220914153333.37701-1-andriy.shevchenko@linux.intel.com>
References: <20220914153333.37701-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: mpc52xx: Replace of_gpio_count() by gpiod_count()
Message-Id: <166323429089.2397913.15544119703242117517.b4-ty@kernel.org>
Date:   Thu, 15 Sep 2022 10:31:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 18:33:33 +0300, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx: Replace of_gpio_count() by gpiod_count()
      commit: a0c4b120431172490793fb21d43c908b35fd3e50

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
