Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E851D70F576
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEXLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEXLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8E198
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAB261B00
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40764C433D2;
        Wed, 24 May 2023 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684928368;
        bh=cTtguEbhPkzWJnBDLLz4tHh5TJJkXD4MErwbggUTmHE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m+vr9NneiLnneunVEspp37Y6HRxkDLqx2sfuvHDaasr6DOMOpKmTzw3OOFbuIjgpQ
         YajFHCi8QPH4h1rZF6rewLkmL8KLYmbKZmMfsACaNKTrkOKkPFGyB9IAV6gKr1xZ7d
         ugMNAmDsDMnIX54KHPYB4/KsVdkIkal1ZBONP9VLAJpH41zWBOaPzgHfK7G7tdNobY
         NuOR/lL0ainHsSVTRxFFSx3PUU2EMmI31L4K+DvaPLOjKaBTc9coRiNJZFFxpmTqMn
         /k9cW7UZfmhPnBYvJCGVN39QOonTWTbCRR3/x26QydGp5sh8TG6LBwdd32VULdeQ93
         uxVxcGtlv5yuA==
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230523-regcache-maple-load-defaults-v1-1-0c04336f005d@kernel.org>
References: <20230523-regcache-maple-load-defaults-v1-1-0c04336f005d@kernel.org>
Subject: Re: [PATCH] regmap: Load register defaults in blocks rather than
 register by register
Message-Id: <168492836798.52206.9285339967466812417.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:39:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 22:22:27 +0100, Mark Brown wrote:
> Currently we use the normal single register write function to load the
> default values into the cache, resulting in a large number of reallocations
> when there are blocks of registers as we extend the memory region we are
> using to store the values. Instead scan through the list of defaults for
> blocks of adjacent registers and do a single allocation and insert for each
> such block. No functional change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Load register defaults in blocks rather than register by register
      commit: 3a48d2127f4dbd767d43bf8280b67d585e701f75

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

