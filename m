Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A727504CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjGLKg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGLKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402B26B2;
        Wed, 12 Jul 2023 03:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 204EB6173C;
        Wed, 12 Jul 2023 10:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B79C433C9;
        Wed, 12 Jul 2023 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689158165;
        bh=VkCxafuAToBre3vc8lS0wUYnWmKlgNyNV/gnYYNU8FA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RQtV1i7V1Jfra+HJhh69lb+C1wY9v1UUqydX1n+QemCDXU2CLF1qSgpxcocJ8BumU
         4gLXEJr1xWQvhP+5cs7tr7hvMWdEzagpwYhnJ86bBtabDBlsc1eY6KzT8WOT9RtiHk
         7ZlmskXOtCx7avYhx5CG1h6fShWlsMvIZ0UR24BWhTPeVINnlADGxiOmYNIfHramtN
         VnXYzWPCrehVHzfpWnoEs0Vq2y82i4fXYDBySpUkH6iCFHkHN+rbhrfwFHZxUlZe7Y
         4Y2UXOtcVaFJ7xPU3fS0OOwOEgOBaMeLIaqCs8jVLyvSu9tJjm4kqF0obGC9rkiKNb
         SBSbp0waTcT+g==
From:   Mark Brown <broonie@kernel.org>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230629071453.62024-1-jonas.gorski@gmail.com>
References: <20230629071453.62024-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: fix max prepend length
Message-Id: <168915816358.10699.3038300967858113647.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 11:36:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 09:14:52 +0200, Jonas Gorski wrote:
> The command word is defined as following:
> 
>     /* Command */
>     #define SPI_CMD_COMMAND_SHIFT           0
>     #define SPI_CMD_DEVICE_ID_SHIFT         4
>     #define SPI_CMD_PREPEND_BYTE_CNT_SHIFT  8
>     #define SPI_CMD_ONE_BYTE_SHIFT          11
>     #define SPI_CMD_ONE_WIRE_SHIFT          12
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: fix max prepend length
      commit: 5158814cbb37bbb38344b3ecddc24ba2ed0365f2

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

