Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB76DB222
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDGR5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDGR5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091B5B8B;
        Fri,  7 Apr 2023 10:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC7E612B8;
        Fri,  7 Apr 2023 17:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCFC433D2;
        Fri,  7 Apr 2023 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680890250;
        bh=+m7f6bVkDRrtJizfJO9yPDVpd1csXnph50i1ewrtQos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hlu74vfp1I+OxfCdzNZK/2n/sKn4eD0mL1gWOJhirz4Q1uzTswxaU50B1HadtFrwB
         XYcDNpTddCtEDZ/UhBuG1O3s/V6erAw6uKU6Id7Vu3JnXcZbLoU3Yx1swoh5bnCvwQ
         eHWZKcx6an6GjVq9H9Q41AD5bXDwxLcQjQ+NC8TqITtUImxAKV7iVopHiWK1WWTwRn
         lM2dW6jH9yDjXaWvduCt3gMWDCqH6wvwLhRbh8ZVDP76I5pZBJ3VxV2cJoCCAucgo/
         1OIAN5k6qr7AzhZ7rn5okIOUYsy9rj7rnVG5XORUv3phWxUN2hZQ7YPjeoxBVS8v2u
         ak3yzCSGknuHQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rajesh Patil <rajpat@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/14] Control Quad SPI pinctrl better on Qualcomm Chromebooks
Date:   Fri,  7 Apr 2023 11:00:20 -0700
Message-Id: <168089041192.2611193.5973417729822285001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Applied, thanks!

[01/14] arm64: dts: sc7180: Rename qspi data12 as data23
        commit: d84f8f2687bdc67f20262e822b206419bcfd0038
[02/14] arm64: dts: sc7280: Rename qspi data12 as data23
        commit: 14acf21c0d3f7b7298ffcd2e5b5db4a476ec6202
[03/14] arm64: dts: sdm845: Rename qspi data12 as data23
        commit: 37f7349b56decc91c66f8039712e63740b1f25f9
[04/14] arm64: dts: qcom: sc7180: Annotate l13a on trogdor to always-on
        commit: ced32c299e5d6c447ad0b80d7a16b44e0e72e8e0
[09/14] arm64: dts: qcom: sc7180: Remove superfluous "input-enable"s from trogdor
        commit: e8df226339fa032c49f8db4281903930d018a22c
[10/14] arm64: dts: qcom: sc7280: Remove superfluous "input-enable"s from idp-ec-h1
        commit: 6d4794d658a0967a7f257f16d6a7a48afb8c8e05
[11/14] arm64: dts: qcom: sdm845: Remove superfluous "input-enable"s from cheza
        commit: 406fed87083578d07c7cea9483b85b51469594e0
[12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin config
        commit: ab752f03e2feb3323dfd9c1ce161ac759ce09634
[13/14] arm64: dts: qcom: sc7280: Fix qspi pin config
        commit: 5f89df31096d67c244d8f36502f651ce701ddcde
[14/14] arm64: dts: qcom: sdm845: Fix cheza qspi pin config
        commit: 9f5cdeb7031062a36e135ebb88bd99c03f32e5ee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
