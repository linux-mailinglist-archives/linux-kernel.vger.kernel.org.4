Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B196AC124
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCFNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCFNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9B2F78E;
        Mon,  6 Mar 2023 05:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 189C660E96;
        Mon,  6 Mar 2023 13:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47FC4339E;
        Mon,  6 Mar 2023 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109530;
        bh=0HED5BF+CSMfApE3r3XXE+GO27EAtl453R3CEWKwYEo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=WpCcykSic850aKKJpl1UOMtcvw1Ngz7H69pUzq9SIT8S0psJvfClgxeo723/409Oy
         wZig95iyo6RbUYI/NuaPzG/GF5AGtviFov8Bx0zbK+Ams7hjL9maBQ6ZBYJmvE1Sc6
         TvbJPllsuqGA6lZ/VkkXUED/An3L54JRyORkapRm2oMViCfw58XtDEHnxjLOzp/6Dm
         lDL8va/AYSFIMcLCP2VuHgu2hHgizBxbXKbelA0Sa6zKYh/aRslNBJHWsBEQ0YVxjw
         PhyFGJgRyGKupOnTUET02RUrdWxOlDk+Rdbg/TnfEJXFZ2t+QTtatYdEKxHxslcos5
         HeORDDFfobWfw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,wcd934x: Reference
 dai-common
Message-Id: <167810952776.75807.5349861629003654396.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:07 +0000
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

On Mon, 20 Feb 2023 10:56:42 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to get sound-dai-cells description and
> allow name-prefix.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,wcd934x: Reference dai-common
      commit: 0106ba2476e1cce06da738a2076a98428a7da2a2
[2/2] ASoC: dt-bindings: qcom,wcd9335: Convert to dtschema
      commit: 631b8a8bb448e90764b8d4b6c0f8cdcc97b1e3e4

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

