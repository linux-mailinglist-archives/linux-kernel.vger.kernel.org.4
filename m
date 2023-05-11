Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58676FEB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjEKFoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjEKFnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3558A55B6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A4164AD1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777D1C433D2;
        Thu, 11 May 2023 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683783825;
        bh=qWrQqDMjF7ovhGaRXAFXUk0Z6gYgLzrlgbl7nuc26dM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tKOAM/HUbOgABfVdPtI5c0R6D2rG35CZhL7hoEu+x79Y3MT4yu0man5Y0HKv5jyDu
         YHL6/0L1BSPpjVIpAS5+OskCgaET9OfySDw2mmNwjcF7laCG2f52JODo9hu9svZ32V
         zlDBgD+fSFFQ198yOL8mc9J+fOnEZDKFkxaFVYLePaqxFMZ0QxZsWWFocMpI7FcatV
         SyyqM3zFw3FoPtag/wkyspvX+ZiQMM6kA7aCChj94j42qnQEpqQw7hzu0XPlNYgCiV
         eV+zzhEMmrE7me8Z51qNaEnRRgznc9Y0X9AZ4F0RoZchmQVszdbcnN5r8NpeguidII
         3f6agm8U1AblA==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v1 0/6] regmap-irq: Cleanups and remove unused
 functionality
Message-Id: <168378379961.328087.747032449434710098.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 14:43:19 +0900
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

On Tue, 09 May 2023 12:00:54 +0100, Aidan MacDonald wrote:
> This is a straightforward patch series, mostly just removing a bunch
> of old features that were only used by a handful of drivers.
> 
> - 1/6 is a documentation fix
> - 2/6, 3/6, and 4/6 remove unused, deprecated functionality
> - 5/6 makes the behavior of .handle_mask_sync() a bit more consistent
>   w.r.t. mask and unmask registers, to aid maintainability.
> - 6/6 removes now-unused "inverted mask/unmask" compatibility code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/6] regmap-irq: Fix typo in documentation for .get_irq_reg()
      commit: 212bc1ce618dd7c734920a68988fe4b473f09f40
[2/6] regmap-irq: Remove virtual registers
      commit: f33a751d5a7fe03b11d95e6a33e1fdd3b4f8ec18
[3/6] regmap-irq: Remove type registers
      (no commit info)
[4/6] regmap-irq: Remove support for not_fixed_stride
      (no commit info)
[5/6] regmap-irq: Minor adjustments to .handle_mask_sync()
      (no commit info)
[6/6] regmap-irq: Drop backward compatibility for inverted mask/unmask
      (no commit info)

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

