Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798EC5B854B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiINJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiINJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB050065;
        Wed, 14 Sep 2022 02:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A5661ADA;
        Wed, 14 Sep 2022 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D843BC433D6;
        Wed, 14 Sep 2022 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663148423;
        bh=ui4a4307ErOPtFPrDWbQDs8itl5K/H0TZiMAW9g5cJI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=RthdDpg8Xyhwd8u568+xgwUj4PRMmUv1XKg3xc8PdASGHU+uUxe14wwHqaWJpS6ta
         K7XeTMClkmYEYrgKm2bV545GrJBBt9O3mojUMp2vLChm6V/vF58NJS5CCHYpUxkosF
         NBZj59B7f86GS2gZFB2hmkTHafjnAXwlaauUdvhYc/c0WCDJFLhlGS6qDrgU1YMtvv
         88enqTA5Na95PY9YuWoFLh8PfiC9cFccKr2H3fYpPJPZWCNTv4KJ3T9xMEps6+BuKZ
         czA+Zljc43KaXqoHoErBR8b0oIhLHkrKlxospBPSTKuF7/2xLlmatFyJix+HMJKUA/
         7o+S6SZUIs+Zw==
From:   Mark Brown <broonie@kernel.org>
To:     Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220910090856.49271-1-krzysztof.kozlowski@linaro.org>
References: <20220910090856.49271-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,q6afe: remove binding
Message-Id: <166314842061.314266.11703491169387696036.b4-ty@kernel.org>
Date:   Wed, 14 Sep 2022 10:40:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:08:56 +0200, Krzysztof Kozlowski wrote:
> qcom,q6afe is already documented in soc/qcom/qcom,apr.yaml.  The
> version-based compatibles ("qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>")
> are not used (neither in upstream nor in downstream DTS).
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,q6afe: remove binding
      commit: 1c2d23fc6134fa72b040a36ae953e1a6614844f4

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
