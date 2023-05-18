Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4747086EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjERRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjERRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33210D7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097AC6513C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62614C433EF;
        Thu, 18 May 2023 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431073;
        bh=2JMyH0DeCkX9IHcvnWkxfFx/LIba4c9iS84FNWhAdIY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jTHSIqezh77O4L/i7t/PkFgsFrWgZs8Pzfh59y2BMGeEQuN82yj6HCk+meg4jI99k
         FaCPt1E63le+gibZqYuOx9dFm2DrSvxEUk4GsiHkllscg5zFmjS5NMoy8pxAML0EQc
         1rBplmQ0elaX8t68wSvPBCgM/ooeZaixRXKS7VLhY8rE30WyFcCbr5qx6Ph3OfBf+c
         AYIwAKoOjSiD8IAoqTFjNS+AdK1FgUYavpKnBZdAv0rE3ys8NoTxjnYF0VP2xekkPN
         DCD9TEnetQOZOcEOVcPZHYM4lFmJaRdvNKgkqukUHp4D1X5pugGRvoro/tsvu4tg+0
         NzponnZ8z6Jng==
From:   Mark Brown <broonie@kernel.org>
To:     Jim Wylder <jwylder@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230517152444.3690870-2-jwylder@google.com>
References: <ZGQqzlU7XPF+rS8c@finisterre.sirena.org.uk>
 <20230517152444.3690870-1-jwylder@google.com>
 <20230517152444.3690870-2-jwylder@google.com>
Subject: Re: [PATCH] regmap: Account for register length when chunking
Message-Id: <168443107216.480556.12280205564293032202.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:31:12 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 10:20:11 -0500, Jim Wylder wrote:
> Currently, when regmap_raw_write() splits the data, it uses the
> max_raw_write value defined for the bus.  For any bus that includes
> the target register address in the max_raw_write value, the chunked
> transmission will always exceed the maximum transmission length.
> To avoid this problem, subtract the length of the register and the
> padding from the maximum transmission.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Account for register length when chunking
      commit: 3981514180c987a79ea98f0ae06a7cbf58a9ac0f

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

