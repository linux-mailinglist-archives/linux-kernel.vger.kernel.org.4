Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC785EF985
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiI2PwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiI2PwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:52:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767B30F41;
        Thu, 29 Sep 2022 08:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5691B824DB;
        Thu, 29 Sep 2022 15:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B4C433D6;
        Thu, 29 Sep 2022 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466730;
        bh=clRcnKf1WONrAa1bzGZb2yasmRWTlVtEWiks0sdwbdc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cxeURFuUb4P1ZC3vqanKViHKD4YaFWxG4pJfTCVXvN+sK+sXfVArHFFyrbnJmUqfn
         FXnp9/sjzjm8cbLJrvkvGGpdkUn5k9uJBqIZJ1OWH+vghbC6AbAvL24uHk+pLio4uk
         2SbarryATFKNkSB6ZnB6hFEjs+eAsOIU2FIQWtE8BFm/nlekqCztGb27GdRIIxpZ+C
         v2hXdK0MT9lERjrvzjIUVgdIEkfFQC1s8A0Cr9vK7QBw10KRyiT1X+0ps5L0/1GxeZ
         lIyIgiqtu19BAENCvsrXRqnU3XlQKX2yowdaWqyu/wsXE0l2TXa0UlZph2MIkYkDbC
         dnqMA6/sA2wMA==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        Jerome Neanne <jneanne@baylibre.com>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        msp@baylibre.com, devicetree@vger.kernel.org
In-Reply-To: <20220929132526.29427-1-jneanne@baylibre.com>
References: <20220929132526.29427-1-jneanne@baylibre.com>
Subject: Re: [PATCH 0/2] Add input_supply support in gpio_regulator_config
Message-Id: <166446672840.175965.2897291078173491886.b4-ty@kernel.org>
Date:   Thu, 29 Sep 2022 16:52:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 15:25:24 +0200, Jerome Neanne wrote:
> This is simillar needs and implementation as fixed-regulator.
> Used to extract regulator parent from the device tree.
> 
> Provide implementation and bindings for vin-supply property.
> 
> Jerome Neanne (2):
>   regulator: gpio: Add input_supply support in gpio_regulator_config
>   dt-bindings: gpio-regulator: add vin-supply property support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: gpio: Add input_supply support in gpio_regulator_config
      commit: adfdfcbdbd32b356323a3db6d3a683270051a7e6
[2/2] dt-bindings: gpio-regulator: add vin-supply property support
      commit: 392cc0a4a0c4b25534f3148b192f18be468f67bd

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
