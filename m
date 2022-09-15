Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714F5B9779
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIOJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIOJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:31:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355397502;
        Thu, 15 Sep 2022 02:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17890CE1AC0;
        Thu, 15 Sep 2022 09:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB5C433D7;
        Thu, 15 Sep 2022 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663234293;
        bh=+H67WghLWWeD/FzwU6ijZ9dc+DOFpnXlZHulNlDyqh0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sQNuhjeNl2CTzNfZv05/FS/3/7tCMlwLsu1ox7CrnSi8oMHe0lWAkJki2OCr3ZYqs
         Bj/lSUMp4hmQw9Ss8ziYVsB70Tf9LF1lO6/Vqb+IwvisVKk89ZlD0yiiXiprzQ98dj
         qAuj1rcJEtcAGaiOtarawUZzPBJhSqyHf7xzR86FT+zujbBvxHy0gqy7ajIM09eL09
         5Z41DQtkGcGhUODCdj7bMMR0l9UEVnpcd5nELOUsYRzTloEY6KXhj9xOpuKV/N9mog
         mkvFbgAUYVvJ9JNvr6P2dJqFZ8OTF6USPaGobTbr/7zMMrfBNslQ6qgXDji3FmH0Qj
         TVaRtflOjao/w==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <753266abafe81722d86c3ddb8bac8ef1cb00fe8c.1660829841.git.christophe.leroy@csgroup.eu>
References: <753266abafe81722d86c3ddb8bac8ef1cb00fe8c.1660829841.git.christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH v1] spi: fsl_spi: Convert to transfer_one
Message-Id: <166323429229.2397913.17024770218235834185.b4-ty@kernel.org>
Date:   Thu, 15 Sep 2022 10:31:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 15:38:37 +0200, Christophe Leroy wrote:
> Let the core handle all the chipselect bakery and replace
> transfer_one_message() by transfer_one() and prepare_message().
> 
> At the time being, there is fsl_spi_cs_control() to handle
> chipselects. That function handles both GPIO and non-GPIO
> chipselects. The GPIO chipselects will now be handled by
> the core directly, so only handle non-GPIO chipselects and
> hook it to ->set_cs
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: fsl_spi: Convert to transfer_one
      commit: 64ca1a034f00bf6366701df0af9194a6425d5406

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
