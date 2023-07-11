Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE374FA95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGKWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5FD1705;
        Tue, 11 Jul 2023 15:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D1D6162C;
        Tue, 11 Jul 2023 22:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE2AC433C7;
        Tue, 11 Jul 2023 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113050;
        bh=HYgJlSRzlY/c6CJzQ2MT1NOTLLiTjwa8Xi9ku0nnMRQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nvOOyXEWX21QB4FR6f1/NxCxHjXJciOzhHZpbErTSP8x0mran2olGaOoGYDt47Dwm
         1dPdebP7ytuvvGvZJjyBVFCp9ZrqPD44T5/2mbGOgF63ZoN43u2Qj5xC196f8Hib3f
         U55bE2UFM0/Wx4Inj0XKLItOJy1FvGUlvhTTU2u8iNTtQMubpgcwURSdEAYPr/HhIy
         UZjAmNicxHjI5q72WUOOsZEBsj8r0gOfYDb2lf3IRuQ3Fo2NN40gDNj8MwGcj61ndx
         X31wjh+0LhuzPRXvOntOF6Q6gl8a8sw3nMWbYq0JrYUGwPhivWagX5r1Lb4GjWxQdM
         GxN9oh5oZIYXw==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
In-Reply-To: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v2 0/2] spi: amlogic-spifc-a1: fixes and improvements
 for amlogic-spifc-a1
Message-Id: <168911304916.642798.15717840786600920513.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 14:03:29 +0300, Martin Kurbanov wrote:
> This series adds support for max_speed_hz and implement adjust_op_size()
> callback.
> 
> Changes v2 since v1 at [1]:
>   - Make cosmetic changes as Andy suggested at [1]
> 
> Links:
>   [1] https://lore.kernel.org/all/20230703094518.53755-1-mmkurbanov@sberdevices.ru/
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

