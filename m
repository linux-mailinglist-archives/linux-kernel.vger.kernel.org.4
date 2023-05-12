Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C436FFFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjELEbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjELEbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3949D5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8965664E17
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68283C433D2;
        Fri, 12 May 2023 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683865893;
        bh=bAmhOvpqUpb/LFt1AmoTPl6RwfAhQvmnAbo9Tzt6M0Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QGQ2jZsG1JdqFHpdu033gEKDfr2mSAwFkxdGQ1bP8XwHUtxFDjBelnmxICLRX9Bdb
         u+zlNhj2yYpl7anVZzzmlSswOlWxv4rk4pHpRawQBY0qZG2Wc04lh3+vN86il7TGAh
         6Cw/TuFQe3dllon5qs52E8VAHYsMc48R2XCKO8wXiZ6A8wcM0q+xLk02dxQw192TG/
         EswXWHJq6HfQp71F28N+Oz+XwroK+VE1sWDNl42gMDRWZMM3MXu7PXmr5WaLjQgXtc
         ndYct8WpQGps0eZmDCDBRVcgjFvAk4N5bJN+0a9JZheEWIZWlPKeWfEXPm/fmSqaZW
         BKvfLiAmm/xJg==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230511091342.26604-1-aidanmacdonald.0x0@gmail.com>
References: <20230511091342.26604-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 0/4] regmap-irq: Cleanups and remove unused
 functionality
Message-Id: <168386589016.356341.17261279641586360743.b4-ty@kernel.org>
Date:   Fri, 12 May 2023 13:31:30 +0900
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

On Thu, 11 May 2023 10:13:38 +0100, Aidan MacDonald wrote:
> v1->v2:
> Rebase patches against for-6.5 branch of broonie/regmap.git.
> 
> - 1/4 and 2/4 remove unused, deprecated functionality
> - 3/4 makes the behavior of .handle_mask_sync() a bit more consistent
>   w.r.t. mask and unmask registers, to aid maintainability.
> - 4/4 removes now-unused "inverted mask/unmask" compatibility code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/4] regmap-irq: Remove type registers
      commit: f05cbadce7e409b38acdf21f0a05d4420afa1b11
[2/4] regmap-irq: Remove support for not_fixed_stride
      commit: 72cc0f523babca3886421721aa662c7d352a6d32
[3/4] regmap-irq: Minor adjustments to .handle_mask_sync()
      commit: a240d23ee9dce2a9fe68d614f19a463d7029fb87
[4/4] regmap-irq: Drop backward compatibility for inverted mask/unmask
      commit: 0a3a56875500aaa5b0bc8f857ed46c8cd46d0775

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

