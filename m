Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB626DA4B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjDFVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjDFVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D886EAF;
        Thu,  6 Apr 2023 14:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B1064B8F;
        Thu,  6 Apr 2023 21:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A1C4339E;
        Thu,  6 Apr 2023 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816667;
        bh=Uv3tMKE9Fzx6ToyFtH3AoI5OOQ8Bp2qXHLBUseV7EsA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a/AJ1JQZs5/i0TV2CAMV0hjhWEuLS/J4Fcd+Y9FG8iYIGxDhdu2BJ3uZX3eal4wUB
         7LM8bhe3/x2zM/hSSw7Fv+79LLGdZSn1q94KFvCLV0KONHEvMGusbBLl1BzdBUQTXo
         ujgAjsh/OqUFHVSiTrcSfStKNl7H2fwL/dN02Wku0RlMJIQQT/oqVjDJdElAacAUcn
         odr55c/X2cDJuiVEkN5hELHWCUWQlcP1ul/4ulYv+dQHJzlRkrWQdwlUZ9XDXloVKu
         enpvC5/ZxjW1jNSSDc0cX9yPrCJR1Zsix97cgeUvUurBKVga57nD674YRf5UtV1h1P
         t/ZPysQFEQ9iw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20230406192811.460888-1-brgl@bgdev.pl>
References: <20230406192811.460888-1-brgl@bgdev.pl>
Subject: Re: (subset) [PATCH 0/3] arm64: qcom: add PMIC regulators for
 sa8775p
Message-Id: <168081666418.315518.2405515023822683417.b4-ty@kernel.org>
Date:   Thu, 06 Apr 2023 22:31:04 +0100
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

On Thu, 06 Apr 2023 21:28:08 +0200, Bartosz Golaszewski wrote:
> Here are the remaining patches from the big PMIC series that add the DT
> bindings for RPMH regulators for SA8775P platforms, implement relevant
> support in the driver and add the regulator nodes to the sa8775p-ride
> board .dts.
> 
> Since the first submission:
> - the DT bindings now contain the missing supply properties
> - the ldo8 min voltage has been increased
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: qcom,rpmh: add compatible for pmm8654au RPMH
      commit: ba0887a6b94ea7f77df1e464aeca45758b4d92c3
[2/3] regulator: qcom-rpmh: add support for pmm8654au regulators
      commit: 65f1b1dc0cc90236ed9be3970f4a763e853f3aab

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

