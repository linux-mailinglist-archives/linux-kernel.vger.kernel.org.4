Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282EA6CC023
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjC1NGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjC1NGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:06:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD8E1;
        Tue, 28 Mar 2023 06:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B5F7CE1B5B;
        Tue, 28 Mar 2023 13:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F54C433D2;
        Tue, 28 Mar 2023 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680008789;
        bh=x4cblEk4sOAHylEWs5F6A2qdw79QFRP52N4WmGSIy8s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c+eZL4ETzBjnp+yIOByAeNjjF0YLvWNg2ViZc4LPi3i+3n9Jw2OI1bVcGRNbHJYEG
         2xvgU5S66RLQxyxrex/zd71yU9bolvfhngXdtqHzvqy2dzmqgWT+glhjW+idG6RkuD
         I0enkVVElhWUjGtjZo2NUAUStLUtjnsRxvcUp5kBzMLhoqJRQSSLlZnELAQq7/cJvu
         Kh0Z1FMTc8Q+zpv963cofBMV/DS40oIe3o2tgKm0s9X+aaybBETxxoe4LCsALP/LJY
         j6UIbu4B4qOucDw3Nyz4FQd2jENbb3Ou2KY0oT7ZVjDNKh/acyFiAZSqpSP01LkWt4
         e431l5ITCNC6w==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
Subject: Re: (subset) [PATCH 00/14] Control Quad SPI pinctrl better on
 Qualcomm Chromebooks
Message-Id: <168000878531.3186355.13214896425216649908.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 14:06:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 10:30:04 -0700, Douglas Anderson wrote:
> The main goal of this series is to do a better job of controling the
> pins related to the "Quad SPI" IP block on Qualcomm Chromebooks. This
> is essentially 'v2' of my previous attempt in the patch ("arm64: dts:
> qcom: sc7180: Fix trogdor qspi pull direction") [1] but since it's
> spiraled out a bit and there are no patches that are exactly the same
> I've reset to v1.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[05/14] spi: spi-qcom-qspi: Support pinctrl sleep states
        commit: 0098c52745112c4387942a37559ababeaf072f0c

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

