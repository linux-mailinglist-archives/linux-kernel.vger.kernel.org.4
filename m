Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DE750CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGLPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjGLPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90842C2;
        Wed, 12 Jul 2023 08:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4446182A;
        Wed, 12 Jul 2023 15:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB0FC433C7;
        Wed, 12 Jul 2023 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176067;
        bh=3WtcJ+Dyxnn4Rl4C6So+cfqEj18Krh+fww26OVBEmxY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UCHQC/d/H578EPmAgE5SLIt/rsdpJiV5igXspdavCEz3e2t8fYhSIRNd3ZDwaZZ0P
         wCE4TENZCQkW/es9iYcX6O4F4ip40bpYzb/PxMwwxz4Dgz4a7VWBFI6fSCeukUdBHz
         NV/cWCnU5Kyh2/Yqjr3QpxFwGjVAD5PrKe/e+g6wwEEEOq3c7aWuxMRArblzBU4zAw
         +1waMus+XMWINJAm1wXlfIHLwf4mC9EnE9Vyex4ncX+sFko2hjNym0WDh978ykGLvS
         0TcyyakYxBVVLyoEoKRCXpUEe41KmvS9+7c3dLDXE6v9i4qz+MnGI9S1YVZP6lG4Hb
         +EAGUK9jTig9g==
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230708195309.72767-1-jonas.gorski@gmail.com>
References: <20230708195309.72767-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: add myself for spi-bcm63xx
Message-Id: <168917606588.94105.10119340050189882242.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 16:34:25 +0100
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

On Sat, 08 Jul 2023 21:53:08 +0200, Jonas Gorski wrote:
> I noticed the driver is unclaimed. Since I was the last one doing
> substantial work on it, add me as the maintainer.
> 
> As it is only found in legacy products, mark it as "Odd Fixes"
> instead of "Maintained".
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] MAINTAINERS: add myself for spi-bcm63xx
      commit: 2bbc72ffc4de803f6265119963aa7aac6559960f
[2/2] mailmap: add entry for Jonas Gorski
      commit: 54ccc8758ef4d29de9e8fdb711c852abbdd4103a

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

