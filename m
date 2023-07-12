Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42F7504CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGLKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjGLKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69AF1BEB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3399861707
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2ABC433C9;
        Wed, 12 Jul 2023 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689158167;
        bh=KD4gVagUA2lMJptzSAAW8RaeD9mlcDyPpcf22RpSAiE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=m8ZkgbmJdaS7/82gGWz49rwC1pbZJisuC/V8LAvUKcSjQLhgkjfyaKOCsJKdo5vFg
         Tsaa6/X3eWD3vrQIf6QL5j/qKqbSJlahvolZjY57PhwHRb5nnW3K6JPolmREsMwMRa
         k5RCkGK/OnOKYMDYYa+yuz8pp5Uts46zn3uzoS8oVPFY+PHwjS3FezNjpwFILTWVem
         zny/9cjl7H4Jvl4c8miCjMD/93wqpdQzmUBEGGX7Al5/8RE2z9EwHvLGIEI74HMqvN
         GDm8utLFF9R1hAuyftlEg7w69IZfGDSNVTad4EzhtBPtzfBrg7DT1lhJdmKK3zcGED
         KrFf0fZSdL9gw==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@linaro.org, linux-kernel@vger.kernel.org,
        Ryan.Wanner@microchip.com
In-Reply-To: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
References: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a maintainer for Microchip
 SPI
Message-Id: <168915816580.10699.2252199875288526043.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 11:36:05 +0100
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

On Fri, 30 Jun 2023 09:17:00 -0700, Ryan.Wanner@microchip.com wrote:
> Tudor is not with Microchip anymore. I have worked lately
> with Microchip SPI drivers replacing Tudor with myself as this
> maintainer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Add myself as a maintainer for Microchip SPI
      commit: c09168c9392ac9250d87d71fc5ca3156f7456ea4

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

