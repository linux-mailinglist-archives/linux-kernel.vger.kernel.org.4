Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86806CEFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjC2Quz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjC2Quw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA35FF2;
        Wed, 29 Mar 2023 09:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCB21B823D8;
        Wed, 29 Mar 2023 16:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C88FC4339C;
        Wed, 29 Mar 2023 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680108647;
        bh=CKOyZDv3JQWgNTEg9VeWLRnaO9byzwy9arbDVJ5dC3w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bhs4Pi2/PPGsfONY6o5af/Sz8FfzQTQ6DdoLP78cTkekzpSYQ7Jp+kb/d5smuOi1w
         OP31cZhs6hUvo4olsJ2a1mwoY6hE72ke+3B326NZWbqb3IZdRDGZ9ihQ0MP8jg/1vW
         6DM3YOzl8B0Omyrtta2sirtNrP7S5Rzs96iyrJNj8gMiWAqKbl8V0JViuXMEshZNps
         qk5msvzc343cjRR1yIt1G7E413aThAqe3T4TD/2/C9zukHMTAUsBP5UrnqwNhb4x+9
         1F58WP58KT9wyMKIh+OTda9p+vApAxbjlTb7wyGMwzfjJB2bByTMDgu33phbU/r0qr
         TA8wwPfuLREZg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Patrick Lai <quic_plai@quicinc.com>
In-Reply-To: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 00/10] ASoC: add audio digital codecs for Qualcomm
 SM8550
Message-Id: <168010864198.3244592.2114017565664183933.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 17:50:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 15:22:44 +0200, Krzysztof Kozlowski wrote:
> This patchset can be merged as is - no dependencies.
> 
> Changes since v2
> ================
> 1. Rebase.
> 2. New patch: ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock.
> 3. Add Rb tags.
> 
> [...]

Applied to

   broonie/sound.git for-6.4

Thanks!

[01/10] ASoC: dt-bindings: qcom,lpass-rx-macro: narrow clocks per variants
        commit: e4cf7805f084772cccf2094b634a16bccf2f444f
[02/10] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
        commit: 0fc109f875721f9cef29bb68095f50d67343b4b7
[03/10] ASoC: codecs: lpass-rx-macro: add support for SM8550
        commit: 492fe974fed0754f7076580e069e1e182e7b3603
[04/10] ASoC: dt-bindings: qcom,lpass-tx-macro: narrow clocks per variants
        commit: bf4afbf950938d42cf0df1ecd915affeb26f4d76
[05/10] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX macro
        commit: 050578c6f18c28e95f9659493a52a67b68b4b667
[06/10] ASoC: codecs: lpass-tx-macro: add support for SM8550
        commit: 5faf6a1c5256559af98c998b7416e4db8fb09b75
[07/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
        (no commit info)
[08/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
        commit: f769fcefa683e150456555e2a280668509d834df
[09/10] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8550 WSA macro
        commit: c1bda22bd2f382f9c3b27fb7a899f8804d92f897
[10/10] ASoC: codecs: lpass-wsa-macro: add support for SM8550
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

