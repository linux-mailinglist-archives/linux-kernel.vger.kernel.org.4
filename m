Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B196645E98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLGQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLGQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:21:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607663B94;
        Wed,  7 Dec 2022 08:21:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 769FEB81EC3;
        Wed,  7 Dec 2022 16:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE31C433D6;
        Wed,  7 Dec 2022 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430071;
        bh=A652jjUzRU9IUq0/Tbi1nZ8daE3vz6KyEgWd61MjQeQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Bm0EtuV0rh1ztc6gO/xr4XkWN8I5E1KEGQoqSq2wfjeFPdv5bdJbxg3y6bfHo2Aca
         raJMjqx8MCyss6uze5ol3HHDYsoIuSMRX1pY49p5pB7I7HSaaR5XE9zzp4L91gi7KN
         Vh309j654o1ygWs7xoZT95P9XPZMCl/SsPvVdVgm4cEquoFcoRUo4qdQ9Jlwu+Dj5A
         Nd89Suld7z4YGFhOM8fPrx3hsKEkTy7wvU9lhbhlsDYWzEMpV3gnWnA3QgMMgDZ9gm
         +uA+vAqODlQp52CKSh224xMV3zvt3C6dxavTBL8LBy5RErEleYXZupFWmbuwnfKELD
         cHufOE5WtixjA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Han Xu <han.xu@nxp.com>
In-Reply-To: <20221206225410.604482-1-han.xu@nxp.com>
References: <20221206225410.604482-1-han.xu@nxp.com>
Subject: Re: [PATCH 1/2] spi: spi-fsl-lpspi: support multiple cs for lpspi
Message-Id: <167043006949.286366.8466486306454456470.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 16:21:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 16:54:09 -0600, Han Xu wrote:
> support to get chip select number from DT file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-fsl-lpspi: support multiple cs for lpspi
      commit: 5f947746f0089529c85654704643f158b420ff92
[2/2] dt-bindings: spi: spi-fsl-lpspi: add num-cs for lpspi
      commit: bc9ab1b7a6c687370b5d4edf34064bf04af8d369

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
