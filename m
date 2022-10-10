Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E35F9FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJJOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJJOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:12:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618DBE11;
        Mon, 10 Oct 2022 07:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 379F3B80E4F;
        Mon, 10 Oct 2022 14:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D18C433C1;
        Mon, 10 Oct 2022 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665411168;
        bh=j7Wfnake3CJ3homudSZKv7HyVaELWmzOCCH9FfeINig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jhlZB+rpP0P2vdZqSbtV86fLC5gKgh6jeqFWgV6mxdBfzh9VvS3SepdYYQl9nqgIt
         SVYSBI/km42cAt2WMzGEp1aExOLcacMJZRY2aR6NXHwCgXtpCcQOawvF01Wk28PdM1
         7ido+ZWuj4RUoH5QqaYjUzLzUfMq9/lQ3227vtiXyv5+a7hxIQNAQmgcJCCEmBlyeM
         WVr+zlo64af9vingfC2oNBUzA0wpnj02y5c/D8okCBmAljpiscwWPWmdxzeV09YQqr
         v8ijD7RDMaK4EIx7LKIM9zJOfAg7b9EpgbsrWnw6HAqo6qvA+bvXSldzYG/nksAb8e
         ZfNZ0JmeWnjLw==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f41e09d710879726eacb98daedf16d0847303b9b.1665034444.git.christophe.leroy@csgroup.eu>
References: <f41e09d710879726eacb98daedf16d0847303b9b.1665034444.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: mpc52xx: Replace NO_IRQ by 0
Message-Id: <166541116698.121778.4088773863978498893.b4-ty@kernel.org>
Date:   Mon, 10 Oct 2022 15:12:46 +0100
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

On Thu, 6 Oct 2022 07:35:12 +0200, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx: Replace NO_IRQ by 0
      commit: b25fe93ff705cdd8e98ad8d0435c621ea5462c82

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
