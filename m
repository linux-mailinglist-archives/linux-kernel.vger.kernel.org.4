Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A064C6CC844
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjC1QlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjC1QlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:41:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0A3C1D;
        Tue, 28 Mar 2023 09:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80651B81DBB;
        Tue, 28 Mar 2023 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D2C4339B;
        Tue, 28 Mar 2023 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680021675;
        bh=puCNRpwmEqJetbrROPl1Vggv5627DYtpnEIhZnhgltU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=f8g1IPFus2nyhjwbRIIMFTOz+6qNnpSGGL2tYJOnKy8VQn9vCMe27AlwPqZPVRs+v
         tJk0Xn1UVFqiiMlNDq24yvVFfeKa9CJL4p8aXWehSRCyWGAc/2Hpjt2b8JqDQXWH0Q
         kv2BE1KIbe1Ay7Sepna3QVj20bwfoAP0bwMayGREvVzE0lUs9gi1KMsdbHbiHNED9X
         xu43/VinAzcXE+y1/xclLIKQGI2DouaM2FiMeHP/wj8fxjx4eAWhiAL0yBNVx9wOt4
         EIXyIG0g8OjglQDrOeIRlrYWoH53ZYmuNJNhTA7sxNkCYq734gonl4xma03uKIrjgu
         dDhJ3kxW1p44A==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313075551.17290-1-krzysztof.kozlowski@linaro.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075551.17290-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/9] ASoC: add audio digital codecs for Qualcomm
 SM8550
Message-Id: <168002167217.51443.3734911880079647013.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 17:41:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 08:55:51 +0100, Krzysztof Kozlowski wrote:
> Dependencies
> ============
> For va-macro bindings:
> https://lore.kernel.org/r/20221118071849.25506-2-srinivas.kandagatla@linaro.org
> 
> NOT a dependency
> ================
> The patchset can be applied independently of my previous fix:
> https://lore.kernel.org/linux-arm-msm/20230310100937.32485-1-krzysztof.kozlowski@linaro.org/T/#u
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: dt-bindings: qcom,lpass-rx-macro: narrow clocks per variants
      commit: e4cf7805f084772cccf2094b634a16bccf2f444f
[2/9] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
      commit: 0fc109f875721f9cef29bb68095f50d67343b4b7
[3/9] ASoC: codecs: lpass-rx-macro: add support for SM8550
      commit: 492fe974fed0754f7076580e069e1e182e7b3603
[4/9] ASoC: dt-bindings: qcom,lpass-tx-macro: narrow clocks per variants
      commit: bf4afbf950938d42cf0df1ecd915affeb26f4d76
[5/9] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX macro
      commit: 050578c6f18c28e95f9659493a52a67b68b4b667
[6/9] ASoC: codecs: lpass-tx-macro: add support for SM8550
      commit: 5faf6a1c5256559af98c998b7416e4db8fb09b75
[7/9] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
      (no commit info)
[8/9] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8550 WSA macro
      commit: c1bda22bd2f382f9c3b27fb7a899f8804d92f897
[9/9] ASoC: codecs: lpass-wsa-macro: add support for SM8550
      commit: 6b004b836ced4d9ce655b5f1c810833c1a880369

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

