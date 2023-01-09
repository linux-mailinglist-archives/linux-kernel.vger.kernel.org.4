Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41B662BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjAIQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjAIQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65517072;
        Mon,  9 Jan 2023 08:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43644CE10C2;
        Mon,  9 Jan 2023 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E475C433F1;
        Mon,  9 Jan 2023 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282955;
        bh=Zs1I9hWh8DgJCvcIXxrzn5p90o5lzJJFhhZ5y5LaxTE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=p61IZ6WTpB8e8+dn4v8BtFUc7JGNi54Vd0i6Nvicq07pr7S8PtUqGbFAchDC4orhu
         E8mmU3g9MlDmT42YSWtDkT2bgoAt/wOr5pcaVkv9fd9z8LD4eOeFq+YCjxWJ8AQ17s
         X9L7TphpQvMvYmOI9IB/fYn6OfKL1hOefx0Ds2YRqw6mQ5iztpskoLD9O4XS+5vATP
         7a4/2RWTsOGxGXiGBCLRJxZ368/JLx3Lx3+UyRRD+nnL9xttarHeO4CM/3heR70UyK
         Lx1/H/m5hIKlN9Nc5hGCUXDT9YajYDeDJCf29kzkt2F/AITEBIi5NhAPvgP5G2+JAQ
         gKfRUTUlAJerw==
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
In-Reply-To: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: qcom,lpass-cpu: Document required-opps
Message-Id: <167328295277.323147.12695338235961954458.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 16:49:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 17:31:33 +0100, Krzysztof Kozlowski wrote:
> SC7280 LPASS CPU device node comes with required-opps:
> 
>   sc7280-herobrine-crd.dtb: audio@3987000: Unevaluated properties are not allowed ('required-opps' was unexpected)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: qcom,lpass-cpu: Document required-opps
      commit: a1df78540da20b9ce30a5b24b395d2b4a0f4319e
[2/3] ASoC: dt-bindings: qcom,lpass-cpu: Fix DAI children pattern
      commit: 5f9cd0f7c1499174b099a1bda67693df268e711e
[3/3] ASoC: dt-bindings: qcom,lpass-cpu: Correct and constrain clocks, interrupts, reg
      commit: ffb2bbdf79d7e712782fd5f44fc250f3e07b3b92

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
