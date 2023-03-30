Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70CF6D0F91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjC3T7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjC3T7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EA1040A;
        Thu, 30 Mar 2023 12:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 868BEB829FE;
        Thu, 30 Mar 2023 19:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C957EC433EF;
        Thu, 30 Mar 2023 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680206383;
        bh=Ttdl3uaRbHyE3Z47YHqPbAUk6baq2L8cMS2wkoS2Qzg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u/jkZOw+WpZKhHQyDjzEvDISfnfBiAL/lO6HAy8mkQ9DOxPNQPZ4FDp5r+H+FoTYW
         ar5kDO7B3tvlXbt/nwxfDFvjp0Rim94Rl+npYxh97gn4zL8dF8BfX+nkQ3f7d0ISNl
         dLGb2I3UQwAxCKO/Mk25O4NovmjEVJ6aulM2NRYdqBSjyQ/4dm1ZhtuyValPWMgVIR
         eyRtvqTIHo+f6khD9NVZmeKsKW+quckiBhlLq4iRhuSzwZP/ArxekI3LE9WPAX3aLz
         s4tXk5Ay6v+TVzmUKFiSTpnAqIivLKWoW8zg64F0cA1+eBDn9MVfIkG1NLgMBPUvus
         GPt8NdIGMVX/g==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230306014239.80570-1-jaewon02.kim@samsung.com>
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
 <20230306014239.80570-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: add no_cs description
Message-Id: <168020638158.3358213.6254321466680202636.b4-ty@kernel.org>
Date:   Thu, 30 Mar 2023 20:59:41 +0100
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

On Mon, 06 Mar 2023 10:42:39 +0900, Jaewon Kim wrote:
> This patch adds missing variable no_cs descriptions.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: add no_cs description
      commit: e3d53ded577328f2b26d361f2e62fc70e85ab6a3

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

