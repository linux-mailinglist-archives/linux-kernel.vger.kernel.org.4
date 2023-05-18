Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48454708B97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjERW3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjERW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240DE64;
        Thu, 18 May 2023 15:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FC365185;
        Thu, 18 May 2023 22:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD33C43442;
        Thu, 18 May 2023 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684448958;
        bh=/T7AEYxSdRmFaQS6UOragCbvf7lT1o8mzvCzRzQ1ruw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CPpHxPtTX7IcURQiGOLxPL7pj4AnsxElOrT5pW0WSjQ7z8TS/6sxJdNA4zfLgzgik
         LpnFFZW3GjPKJ2Lsy8V8Y0PojLjxiot4ZPzqyZyEynaDFRONAFmoc3tFtTfkFsgslv
         flAJtiTXBV0kQSx32L4VKiC62lGYBLRzhlKlY5N7uvCSLwvo/+9SH/kCAoXZ+PMXcS
         sqPgNSFE1lc0uypRI8U8dKULCD1BEQ7sACM7aCFDhFz4Bkff8UsbHFoXw90MantOQw
         IhmBG5hN76t+BfxWgl6+MmnJSuo/Q60M15zrmc8HqEq/GzU/TaRjY8b5Pb3gl/CGpQ
         +Z4BD7QxuOEEA==
From:   Mark Brown <broonie@kernel.org>
To:     f.fangjian@huawei.com, Yeqi Fu <asuk4.q@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230518052515.368978-1-asuk4.q@gmail.com>
References: <20230518052515.368978-1-asuk4.q@gmail.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Fix error checking
Message-Id: <168444895641.494730.18173477830143130577.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 07:29:16 +0900
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

On Thu, 18 May 2023 13:25:15 +0800, Yeqi Fu wrote:
> The function debugfs_create_dir returns ERR_PTR if an error occurs,
> and the appropriate way to verify for errors is to use the inline
> function IS_ERR. The patch will substitute the null-comparison with
> IS_ERR.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Fix error checking
      commit: 120e1aa2f2e60b55f9d20c2fe1c6144739e00dc4

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

