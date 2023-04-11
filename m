Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62686DDD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjDKN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjDKN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00825585;
        Tue, 11 Apr 2023 06:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B856E626F4;
        Tue, 11 Apr 2023 13:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D92C433D2;
        Tue, 11 Apr 2023 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681221396;
        bh=fPGYqiIU6kquDKz5yXmqMisxWPOXWHevU445IPmGMMk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qvdPqhB7cLAz9EWo6NwQqxMNKNlEUT8/NtqgYiYnAd8gWN6tdLKsgOcoDNfW39+a7
         LT4YisxrPggrSWnINyn+zAWgZEWfYDZnij937wXOpR40CJ2D+xeNrI/zszbhBC2SQy
         nrNuaq2T3ozOjHMXCJ3QYxogpGwY/MsO19zstq5GaEu/7CKGNxCKNl1fWvYBc4Qe3h
         CtxNsDd3W3CIWcbS9Hoz0a4sCH1sKKyvXIkFO0WLrN1lOsWc4b2PydmAT3bt++kR1s
         4xFoGwyG68vMeeeF4PGdXjlUQanVoRqYAOPEw7w1Bz84LaHQlYqKyIHRg42lzdjyMA
         QgkWHCiw/Wfmg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
In-Reply-To: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
References: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v3 0/2] add support for Amlogic A1 SPI Flash Controller
Message-Id: <168122139290.49976.14155303919070360064.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 14:56:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 21:32:15 +0300, Martin Kurbanov wrote:
> This patchset introduces DT bindings and driver for the Amlogic A1 SPI
> flash controller (A113L SoC).
> 
> The existing spi-meson-spifc driver is incompatible with the A1 SPIFC
> at all.
> 
> The implementation has been tested on the Amlogic A113L SoC based device
> connected with ESMT F50L1G41LB spinand flash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: add Amlogic A1 SPI controller
      commit: d040fe8f9fa94cf17cb3558bd061cb580a4d63c8
[2/2] spi: add support for Amlogic A1 SPI Flash Controller
      commit: 909fac05b92653f860ecaa1e59b23fc25d27166e

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

