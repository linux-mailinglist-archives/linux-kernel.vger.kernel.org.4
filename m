Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C146CAB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjC0RMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC0RMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FFD7;
        Mon, 27 Mar 2023 10:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3844161357;
        Mon, 27 Mar 2023 17:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216F5C433D2;
        Mon, 27 Mar 2023 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679937130;
        bh=6nimPFLYwuxjc5KVvZb6Tod5BF0/dagQYwkARQEU2EQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GPJvpXZAN1M4PNxP18MWbapVrDwotat21wA/RgEqhQvjaXGeo1Wr41JfxoP0FzYEb
         0jVG7V0nT8rbrKs2eOPHB5roOSaXEEcTAfVu8Ke/jm4m1pqxwexgOU/X2W4rx2JVe9
         8EsxOFiQqGLAkZZAQbaw9Eq74T2iGF5cKPUBXclYdrMROFsks/xcVHRsDn+WfuR1qh
         EDOT/eCTGK8zOV5oGhBtmj3h/u0R+7CFAQ30DJpx+zC3/YwUTXc9VMDugxpQKegflI
         KR/6+p2v/KSxkE54yszrud1OXvVhanxlQuDdqoQP0PXOilZk8swA3Xs33vMdFaj9lT
         bWh//bIFHVMWQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
References: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] spi: sprd-adi: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <167993712821.3172134.10114914596481224802.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 18:12:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 14:05:15 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/2] spi: sprd-adi: Use devm_platform_get_and_ioremap_resource()
      commit: 8499d4b5970f5fd135ee8860075768562a5efe70
[2/2] spi: sprd: Use devm_platform_get_and_ioremap_resource()
      commit: 5936e77c202add2cc20c21cd4486ace1a362bd43

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

