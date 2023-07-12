Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32167506BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjGLLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjGLLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51E2136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A2CC6177D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFB6C433B7;
        Wed, 12 Jul 2023 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162456;
        bh=myz2k7Mv+fL8tABco6Rx+eeXiNPJi8yVNn8qTy6Zh78=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P32vuQQGv5VgIc2utmR2j95Dz2Uc5BQpFRUirwi1MP64j79AQ+f/wcMb5Cf/MdPpP
         M4i6cWdF5AEuwYv+E0LOgU21OeqWQy3aVyHEP0gQ/uCIfyqpz/vbStnlF6kwnivQwp
         zvNdYO8qqhcNzMxwywc3dvQX0vVEsKsdkNflaL6jqXayyF3W5rkYdHTIWSFRbZC8nj
         dnbC2i57gIKTQh7bVUGFTongBYH014otYEBy/x2qSa1niZUhhUGg8z3kxjOLl5hmiv
         o6sgKlV9+uFqoKt+/g+BHT37NXwfdx04cw3L62hp0YX+6A1+PkQN2+qE94xREDir9S
         b4VeNWd3OURnA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
References: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] regmap: Drop never (properly) worked 64-bit
 support
Message-Id: <168916245462.46943.10881541017318568849.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 21:36:10 +0300, Andy Shevchenko wrote:
> regmap API internally operates on unsigned int values for the register
> offsets and data. The commit back in 2015 that introduces 64-bit
> excerpts in the code made a false impression that it works. Not really.
> 
> Consider two things:
>  1/ register offset
>  2/ data
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: Revert "add 64-bit mode support" and Co.
      commit: 1425bdd7ef88631d0623ce3d0b8c89d8a65815d2
[2/3] regmap: cache: Revert "Add 64-bit mode support"
      commit: 039fd2e4134b7b880ba83f40a136df440047594a
[3/3] regmap: mmio: Remove unused 64-bit support code
      commit: 875403a7b524e9523e49dd32662adbc3e48cc12a

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

