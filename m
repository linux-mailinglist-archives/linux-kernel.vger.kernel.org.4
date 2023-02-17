Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A469B53F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBQWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:06:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04D5DE31;
        Fri, 17 Feb 2023 14:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2400B82DD1;
        Fri, 17 Feb 2023 22:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB33C433EF;
        Fri, 17 Feb 2023 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676671568;
        bh=IjMYXqZfSaF0uyHmjW79JznzTpnlZIbAQMOTrHR9bm0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rRxsE3x6aNrX4qK9JzhvD8tFwxpsmNWeJjd8nIHRFmaAgk3D/ofYu3BbPcNqrvsJk
         V4sHHGMUtPZ8r4DiDcyiK2kmlvpP0kj/37AmyMFyTTwIGQBNLxhiQgQ/rEsJCr2YCO
         YpxzgLQXaYrp8I75HteqDNBTvn1UG0qQZUgp/lluXab4vmbRC7Hx8DTKi6kriIYZz0
         d26HBBjhoXgpSX0M/Rvz/iC3effFvZ9nblZRhjukxf+s4AOz+mI8j7YXp63oCiSRM4
         fWh8OtbdcFqnbl6HH04BCzEEI81KmhxYGddemrz6LAU8q4lDgNWnphU2uW6wgJIXOC
         S4CpvirCzWtKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217155802.848178-1-krzysztof.kozlowski@linaro.org>
References: <20230217155802.848178-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: qcom,spi-qcom-qspi: document OPP and
 power-domains
Message-Id: <167667156624.105826.15926331460082215742.b4-ty@kernel.org>
Date:   Fri, 17 Feb 2023 22:06:06 +0000
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

On Fri, 17 Feb 2023 16:58:02 +0100, Krzysztof Kozlowski wrote:
> QSPI on Qualcomm SDM845, SC7180 and SC7280 SoCs uses OPP table (both in
> DTS and Linux driver) and is suuplied by CX power domain.  Document
> missing properties to fix:
> 
>   sc7280-idp2.dtb: spi@88dc000: Unevaluated properties are not allowed ('operating-points-v2', 'power-domains' were unexpected)
> 
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: qcom,spi-qcom-qspi: document OPP and power-domains
      commit: 7234d746a8339066313518bfa024fa03f363a55e

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

