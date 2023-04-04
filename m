Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001016D6722
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjDDPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjDDPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:21:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7B4C16;
        Tue,  4 Apr 2023 08:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B75F634F4;
        Tue,  4 Apr 2023 15:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005DC4339C;
        Tue,  4 Apr 2023 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621661;
        bh=5G84N3XbT0auoxdD1TsB8mJL7Tr2AtnwhLeyQfvCGyE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mdZ00DnEP42M/QLiaDjNAR4LQPlmFUIrhDOwPIY76iX/H5pTWCfMyEL4gVo6q8xRN
         MliVhxpvYBs/BzxpfIovntA/TSh1Aeo8TCSUT0HEWvg5szwBlRf6BVxROP7PiNvVn7
         pyiSUIUkDM0gdq4fWowFgIkUWyCR+b4CLY6sc256ngSyPsBwrEHzIwnOqq9FTpJjpz
         YNGrDQFlhiBRUBk8UEh7jGBC6o/B2q12FxHMHPwl0djF85IxZyfGrquEBc9BJPErN4
         zSeiDA1O6mZXvis7qCwc/13ETtVr1qtqG93wwLEV3tb7IFLrYuYe2xLtKzKGz31DIJ
         4K6/FnFQOc+qQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alain.volmat@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230328061839.82185-1-yang.lee@linux.alibaba.com>
References: <20230328061839.82185-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: stm32: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168062165893.53383.15724461693571159313.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 16:20:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:18:39 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Use devm_platform_get_and_ioremap_resource()
      commit: 75c1b5fc493c21ebe524e9e5bb8501bb351ad94a

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

