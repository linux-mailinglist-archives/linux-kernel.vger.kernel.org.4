Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B769105B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBISgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBISg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:36:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3668AEB;
        Thu,  9 Feb 2023 10:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5A1B82297;
        Thu,  9 Feb 2023 18:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7170AC433A0;
        Thu,  9 Feb 2023 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967783;
        bh=P3p3nQT18iB5KgEcNBU65v36D9Khuq9im6IUZT0tPnk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g4QVe/AL+TAnwYSc4YCElFAX9/qtKqwrG4JP7XSpkKtpZ0I9LT4qG9bL4aXXLJbq8
         eRBDxsuxoY0f62lDt1ch+Ibo8jEZFHvJa+D5y+eQ9FSQfvOLGdWtZtuIjokErjp6wJ
         wz/nGbHugKD1YcE54LEqlcY9wOB3yVUlxkoFYiPu2AtJMguc427UKhClTkjOubsyFt
         r047BhG1c2gcN5lbraZNdxyrX86DIsxDWn+dJnYMMX2meZshLszMTqZnR3mvE4CLEj
         VjzAzJrK9B1rmuM7vMkmG8glUBul1tB+PfeL+zd3KKG8iDdiQ6NL08WUYOJbtdISu6
         TWkSqu/I3JZvg==
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
Cc:     Rob Herring <robh@kernel.org>
In-Reply-To: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
References: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH 1/3] ASoC: dt-bindings: qcom,wsa881x: Allow
 sound-name-prefix
Message-Id: <167596778018.879652.6223173953232819619.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 18:36:20 +0000
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

On Mon, 06 Feb 2023 19:08:03 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to fix:
> 
>   sdm845-db845c.dtb: speaker@0,1: 'sound-name-prefix' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: qcom,wsa881x: Allow sound-name-prefix
      commit: edcda9a605bbfdd78d8d79043e01544d8b742828
[2/3] ASoC: dt-bindings: qcom,wcd934x: Describe slim-ifc-dev
      commit: 636caca3583923b75fa538bc43ce57801fb8a1a2
[3/3] ASoC: dt-bindings: qcom,wcd934x: Allow usage as IFD device
      commit: 7ee35b6b099ce6b51c6ac249d19b5b405f8e825d

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

