Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E826D5E8098
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIWRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIWRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E5111DFED;
        Fri, 23 Sep 2022 10:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC794B82304;
        Fri, 23 Sep 2022 17:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E8C433D6;
        Fri, 23 Sep 2022 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663953703;
        bh=Pz9vo+ffvibzd8kfte/fXYOJF8UbJYLQ5sZ1ccDor6g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gth9Y+fQf0onv0y7QYSRmp6Uqip8bA4UfUnvovB/TutA99ey2V3KMwTBGAHG/LUgY
         i7gOCBJSPPPYktFEjXBZJfZuXPavZWNPtVw6pwJSMhe8vpY1FeCgJrl3HHmNfSvwVD
         j1m/+nbU1Byz0mIDrV7BnNtlgvoBQ4fymAdJigP3o0MtFDoFYjQDQP8GFk4fFrtKXf
         4ubMUq/VV+5ted6mdWKm9YzFwPhRP1w+7YUlQAKqMq4Ze/nY2FII+nTIDeiqQ3cdX1
         Zs7UDlNFdaRQwrIUEG+5+7cvj40Kno/GK+qEIyEu0C0ToNWZQwHrWwgXF/X07Fb1iQ
         3QtIBtwDUJfXA==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <Yy07WbMAG4bPgYNd@google.com>
References: <Yy07WbMAG4bPgYNd@google.com>
Subject: Re: [PATCH] spi: spi-mpc52xx: switch to using gpiod API
Message-Id: <166395370224.637404.13213672182113687221.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 18:21:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 21:51:37 -0700, Dmitry Torokhov wrote:
> This switches the driver to use gpiod API instead of legacy gpio API,
> which will brings us close to removing of_get_gpio() and other
> OF-specific old APIs.
> 
> No functional change intended beyond some differences in error messages.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mpc52xx: switch to using gpiod API
      commit: 2f3a896b0a416bbda633c98212f6490cfcfff310

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
