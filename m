Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4C69E1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjBUNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBUNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:47:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38C1DB82;
        Tue, 21 Feb 2023 05:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580AE60FE7;
        Tue, 21 Feb 2023 13:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7AEC433D2;
        Tue, 21 Feb 2023 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676987237;
        bh=E1BaK2IwvDddzDnn1BEIWQwSRUe/ogAAmqJRVaYDlf0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SfzK37HcWplIpjhNZHwIGisfJwsdWEOhDtEAmrc926R4jloA9I5vV/r0EbCqNUQi5
         1zN50SS/VyC0i+38H5AGuebmdg1PKRlk17c1xbNmU6NwhtlQFyfzhdPNmh6vm3SdRW
         JX+Q/OVCNWqhOGnopzg6oWh02mDQBp1Fr8oHeg6koI5xkkE3Sry0AuYnXDhuZvMRlw
         MKaSw2sNmVaRqqbgHDfpH5oq53QiRM+aIO5AqnH1uO4kpPi6N6daPHeqqas5Mz5f+3
         Uk0JsDzavYWtdkdlgi1pHsO1dtrH1dxJlnKf6LixslBhOeTg0AxsQWbI1jXxcsflaX
         zvW3uheobCUjw==
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
Subject: Re: (subset) [PATCH 00/17] Device trees for Apple M2 (t8112) based
 devices
Message-Id: <167698723536.32575.6135846680290091834.b4-ty@kernel.org>
Date:   Tue, 21 Feb 2023 13:47:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 16:41:10 +0100, Janne Grunau wrote:
> This series contains dt-bindings updates and device trees for Apple
> silicon devices based on the M2 SoC (t8112).
> 
> Device tree validation depends ont the dart-t8110 bindings queued in
> the iommu tree for 6.3 [1] and support for "local-mac-address" for
> brcm,bcm4329-fmac based devices [2]. The latter fixes validation errors
> for the existing M1 and M1 Pro/Max/Ultra device trees.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[14/17] dt-bindings: sound: apple,mca: Add t8112-mca compatible
        commit: b361d5d2464a88184f6e17a6462719ba79180b1a

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

