Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A180774FA94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGKWEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGKWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926B170E;
        Tue, 11 Jul 2023 15:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597A261632;
        Tue, 11 Jul 2023 22:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D65C433C9;
        Tue, 11 Jul 2023 22:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113044;
        bh=sgG4GZ2s6ORnJwOxVKfOxW49a30kTh+UGbUpknPHOBQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oa6PeJxwcztQH9DanqQVH5fAhuRixAg62OTeT4DKUnXdNUerUHGGSWIGiGd0wlq9M
         6LwdMofWimHXsbFwxMHxtf/VQDy40eaUx41eFrWPJ3xT5Z6wbK6X686whBO3jietaO
         yyzLIuG7E0mVHyGOi6V4FdTrMj12xcwPaMJtYtr0pIuzZxp9t6dx12sHcICn2TBglR
         oyLfA2mhHzHFBL/WKZlN58By9ES2HfXSfMAzV9enohJIfrk8mRQp2PxBfWSi+qqIEX
         89A9X0U00PGwNBFe7bvwSVu51f5a10FweTauVReEYr2bpOUJ9m3BLKLgGK5IwxPe3B
         HLLblQ30yl5mg==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
In-Reply-To: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
References: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v1 0/2] spi: amlogic-spifc-a1: fixes and improvements
 for amlogic-spifc-a1
Message-Id: <168911304326.642798.13272097605762748928.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023 12:45:16 +0300, Martin Kurbanov wrote:
> This series adds support for max_speed_hz and implement adjust_op_size()
> callback.
> 
> Martin Kurbanov (2):
>   spi: amlogic-spifc-a1: implement adjust_op_size()
>   spi: amlogic-spifc-a1: add support for max_speed_hz
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
      commit: 9bee51722cdc1b32193d4ddf6ea6952d666d8f13
[2/2] spi: amlogic-spifc-a1: add support for max_speed_hz
      commit: 54b8422cc64d6236024ec7d72bc63ca3ca90b87f

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

