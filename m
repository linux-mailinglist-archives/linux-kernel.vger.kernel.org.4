Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E45639111
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKYV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1B537EB;
        Fri, 25 Nov 2022 13:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E59260F25;
        Fri, 25 Nov 2022 21:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC92C433D6;
        Fri, 25 Nov 2022 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411713;
        bh=LhYwtLkaq7/ZZHyMuHHZqpobqBOf2PGXymDDA6l9SKk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y6dLQUKQ7Vcq1rE0glaSY8vAxkCBNW9KBdOBYkOwrjYpy8ak0XTePx+W5CsgKkJJa
         rjZoooaFqu5Za1NRcYxp2hxK9ggeJJHxWl8odGkX+iDQsoriUAG++BLOKNvQdkeN4V
         iBG0uVIFwd8cuLwfPVt0t662RNSsy+9/qxSeE3cvdE2aIxfwls7pUuRpQrsZR5kDj8
         vRGYSNieGr2p36PWPSNwGX6QuQy5BZOiZ/9evHU+bPpGtvMSPVeKrTgaAlDXwhZm6g
         POzcbm7T6u/HVdE1CCZuLg80195XNv7U8a+8Ntn0o2+4kKS3W+0JPvJBqWQsiIL9TZ
         NTSr0j+f5m1Tg==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: msm8996: fix sound card reset line polarity
Message-Id: <166941171130.2089698.17807923413045649291.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:28:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 00:46:47 -0700, Dmitry Torokhov wrote:
> When resetting the block, the reset line is being driven low and then
> high, which means that the line in DTS should be annotated as "active
> low". It will become important when wcd9335 driver will be converted
> to gpiod API that respects declared line polarities.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/6] ASoC: dt-bindings: wcd9335: fix reset line polarity in example
      commit: 34cb111f8a7b98b5fec809dd194003bca20ef1b2

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
