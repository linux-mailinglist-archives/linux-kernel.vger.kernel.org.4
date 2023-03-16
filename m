Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D76BD236
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCPOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCPOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D4F945;
        Thu, 16 Mar 2023 07:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B4C61FF1;
        Thu, 16 Mar 2023 14:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F28C4339C;
        Thu, 16 Mar 2023 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678976287;
        bh=Ci9ItVkj5gf1I+OfearvK0vmfMCatFwAi/+AzU1GIrs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uquHCU9vxLG7cVct5aKtyyF4TQz0jeQpavetxw3BxTL6nq5AWvFn/wexwv190xFKt
         LVwi7vPXbb3dl95UF0V+QrLhu1nqDwqafyTbOEB1NaPHMFuwaUyY/1gbsI0t9Ol0ot
         u8wz9ZjJFvzmu6VpX4gWcasTpnrN6ofWhnjU+LaAXzaJDd1Fsm3Zc08OyS3VWx7WKD
         pBZsWcw0onQWVdZCytoAN2Lgj6ZvfMFFlHK+TIuH/YDXFPiGXrx31x/LMOxXbYFKo9
         uG+XxJ9kdANmbcIWSUW7kMAGwP41bNzXiOMqZw/M3X1hTQu5l/xVEn0PENvI8u2gD+
         vB3HFlPM2u/QQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vijaya Anand <sunrockers8@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20230315231055.3067-1-sunrockers8@gmail.com>
References: <20230315231055.3067-1-sunrockers8@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT
 schema
Message-Id: <167897628543.92626.6326219364017588458.b4-ty@kernel.org>
Date:   Thu, 16 Mar 2023 14:18:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 04:40:55 +0530, Vijaya Anand wrote:
> Convert the binding document for adi,adau17x1 from txt to yaml
> so one could validate dt-entries correctly and any future additions
> can go into yaml format. Add address and size cells to example to
> prevent errors regarding reg format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
      commit: 87771c94025890246a6dfec9773eb62bd41c4c5a

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

