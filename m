Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38E65912E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiL2TYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2TYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:24:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E03210074;
        Thu, 29 Dec 2022 11:24:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98E1618EA;
        Thu, 29 Dec 2022 19:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42338C433EF;
        Thu, 29 Dec 2022 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672341847;
        bh=QfEfCXuB3KnMw1xvHWaFThHQXYDT3cNkR3iYoi0JilI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SYAi5U2nAYUqRLRbDWTxgSBv1EBNXajIW3Je8zYc8NUwBmCIT9kPyu8Ku7EayImIm
         sPcidnghjju/wb0cWS51lXSRr4a0aWEz4n1sJH4mG9olD18AwOHGKI4IQLoOMuqZln
         07efZuVqvlOl3QTe61JdrZ95O3Wgvy8jIMuX5TTNToLxwHv+7bwYVlPDES6UJZLqPl
         +KDgWwA81V3MI7JzoWFcytkUNnOS7GIzKD04ssT73+ybbpjVo6exlrZbQt9S+FVnoo
         knGv1BrSG7zWeJ2vsbAS1IhZ2UHERBOhHwAWQ12GUG0ICL30tMk/CcgKHxS/w/vDKe
         yA0UWZR7OcI3w==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221224154210.43356-1-krzysztof.kozlowski@linaro.org>
References: <20221224154210.43356-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: cirrus,cs35l41: add interrupts
Message-Id: <167234184391.14869.3164540842887983898.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 19:24:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2022 16:42:09 +0100, Krzysztof Kozlowski wrote:
> Both DTS (SM8250 and SM8350 based Sony Xperia boards) and Linux driver
> mention interrupt, so allow it to fix:
> 
>   sm8350-sony-xperia-sagami-pdx215.dtb: cs35l41@41: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: cirrus,cs35l41: add interrupts
      commit: 642e4f9bdac8d42d5047312e76bab7ceaf4c131e
[2/2] ASoC: dt-bindings: cirrus,cs35l41: cleanup $ref and example
      commit: c1b9c2f02ed796a6cbbfceacb14f7c5f5c7ac94f

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
