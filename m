Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422FC5B9774
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIOJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIOJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB359675F;
        Thu, 15 Sep 2022 02:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88CCC62245;
        Thu, 15 Sep 2022 09:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F950C433C1;
        Thu, 15 Sep 2022 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663234280;
        bh=b3yoajN2tS9K2V4FVmNAQPYuhL3f6oCbNn9iOEv9S7o=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=kPQp6MOmi56yTOqy4z9eaTamTfWOQYv2XAwbLjY//ynzz2xIMog5rT3dGytTm76g8
         14UVrIAYYINPsuwezbjiaTjoT2D8Eltkv41YNOzovoP2v+UDeUZ7N2Z4GDNqBMuoKq
         EMatOaYkQhHAt9NeiK4N7GVO+6qTpwl0ZM28xgSYs0ta8oMYPrJ3059R0F/VcBenUO
         VkyXhL8o3IlxA6Od+YCas7G8Pn7xp0QUHdc+NbH7O/PQyzg4w5hXvhVATaWLLEv51Q
         33w7OhpUlwDy9UfRnNghWakMaTJhA97ESC4vI6SsrVpwIPXQw9GQQT6dch6UTJu1uW
         WhBem6d7ZxB2A==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 00/15] ASoC/qcom/arm64: Qualcomm ADSP DTS and binding fixes
Message-Id: <166323427717.2395893.6929759615552147148.b4-ty@kernel.org>
Date:   Thu, 15 Sep 2022 10:31:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:14:13 +0200, Krzysztof Kozlowski wrote:
> Dependencies/merging
> ====================
> 1. The DTS patches are independent.
> 2. The binding patches should come together, because of context changes. Could
>    be one of: Qualcomm SoC, ASoC or DT tree.
> 
> Changes since v3
> ================
> 1. Patch 9-10: re-order, so first apr.yaml is corrected and then we convert to
>    DT schema. This makes patchset fully bisectable in expense of changing the same
>    lines twice.
> 2. Patch 11: New patch.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[09/15] dt-bindings: soc: qcom: apr: correct service children
        commit: b2496de1dfdddfceb87e7a7b791c3a249c860682
[10/15] ASoC: dt-bindings: qcom,q6asm: convert to dtschema
        commit: 7b0ad4629d1fb719ae71a8f2968e8c6268ab1709
[11/15] ASoC: dt-bindings: qcom,q6adm: convert to dtschema
        commit: 301628d805019999f1ae9764aadfcface9c4e309
[12/15] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: cleanup example
        commit: 0630efc3b849f65ef3bad803b84bc0819591dac9
[13/15] ASoC: dt-bindings: qcom,q6dsp-lpass-clocks: cleanup example
        commit: 7af18f4efd85c2e85458e3f504e129a97f6baaf2
[14/15] ASoC: dt-bindings: qcom,q6apm-dai: adjust indentation in example
        commit: 5f170e21fe96fbd1f81ace9ec6e6b695e1098733
[15/15] dt-bindings: soc: qcom: apr: add missing properties
        commit: b2d7616e13c4eb766f5e2f6568c2e746e76b7b53

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
