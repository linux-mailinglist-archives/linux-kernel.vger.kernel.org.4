Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482876240A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKJLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJLDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:03:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40F25C1;
        Thu, 10 Nov 2022 03:03:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BEAB8216B;
        Thu, 10 Nov 2022 11:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D72C433C1;
        Thu, 10 Nov 2022 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668078225;
        bh=Bg9efXol0ccwRMunJy8Gh3qhd8CXZJ2k6fchLXeoSUk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fflnf8+VIYGNGWrN9IRVzFZ0T9a7nk2zcdtDgFIEvg/vdWgYNNvzdR0vBb9AO9P0f
         +vF1a6XnIOXl0M4c6Q3eOvpyvbvUEJSoHJCUJsJf0AII6iEMn3YP5prbGw+Nnm99mp
         Og8bfb+13sFvNb0BQXi/OaUK8pbzcAooMD3m/bokFZq6JHwz/VwRX1rEF79bDpAwa2
         B/X3k+JCoWTZIc+Y1raNfxBwigc2pyjuBIwgXrml8LXBapZnPldbPwp3dn7ScOlCT/
         /KOmo/4TaIVWODvRHe7J7JrYlY06sKXTe+yPdsSyymxHv+heku6PqWEgrBRXWjm0iF
         oqyB6IBJEaduw==
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, patches@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221109110846.45789-1-konrad.dybcio@linaro.org>
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
Message-Id: <166807822235.115312.17138185226634439165.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 11:03:42 +0000
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

On Wed, 9 Nov 2022 12:08:45 +0100, Konrad Dybcio wrote:
> PMR735a also appears to be bundled with some SMD RPM SoCs.
> Document it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
      commit: 9263c69696c8c75ef97ebf57cb4f308c4c2420ea
[2/2] regulator: qcom_smd: Add PMR735a regulators
      commit: 0cda8c43aa2477b7a9f9bed0adff2f34d3afc143

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
