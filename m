Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632F5EBFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiI0Kej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiI0Keb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:34:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902BEE2365;
        Tue, 27 Sep 2022 03:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CF9FB81AE1;
        Tue, 27 Sep 2022 10:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124C9C433D6;
        Tue, 27 Sep 2022 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274865;
        bh=B2GDKcwdgITexSrV6c7//f4qj6nximN7W8IEtr7vxYY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qLiNA4NBmNGXiOqsXlliQQqxRMpo8l4h/R2zFVjJwYg1XJMoZT8hrd8a3mfcOANIO
         lJZ7yx1fqVM7GWZAKYzvk5i21yWGaCfxHYZ976l6hgeeksQkrd9CnMim7ykocovyRn
         tMLrjDjTWEJG6SotMqknI3bXR1DJBEBktdLeTS1ExEHTKLars8t1ztyrH8qPw1omDu
         dI2hqhXxSL2K29OSJj4YkOJJ7r4psME++yc85pAlRAMT/K3/j8hAhdHj4XwmcBnVGn
         LOEr1+CQ1q+DJFPydn+KUp+tm25Vq1zx9+sfBpDI2rVRfnwVTV7u/sZeSL2ipnTYFQ
         Gr4NMzCZZNUGA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, robh+dt@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
References: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/12] ASoC: codecs: qcom add support for SM8450 and SC8280XP
Message-Id: <166427486278.60697.18427258412799379354.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 11:34:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 18:01:00 +0100, Srinivas Kandagatla wrote:
> This patchset adds support for SM8450 and SC8280XP SoC and also some of
> the fixes requried to get stable audio on X13s.
> 
> Tested SmartSpeakers and Headset on SM8450 MTP and
> Lenovo Thinkpad X13s.
> 
> Changes since v1:
> - moved va-macro from using of_device_is_compatible to compatible data
> - added some fixes for qcom codecs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: codecs: wsa-macro: handle swr_reset correctly
        commit: fdc972d4a754b32cdf05294669ae0d6036242826
[02/12] ASoC: codecs: rx-macro: handle swr_reset correctly
        commit: 1a4e73915a7553d7ffb4f365b8a671bb2fa1f7ef
[03/12] ASoC: codecs: tx-macro: handle swr_reset correctly
        commit: d83a7201412d32e2ac76f20439470976b2edf699
[04/12] ASoC: codecs: tx-macro: fix active_decimator array
        commit: 1c6a7f5250ce81f11a248f9bf88fdbca8b6b0b5d
[05/12] ASoC: codecs: tx-macro: fix kcontrol put
        commit: c1057a08af438e0cf5450c1d977a3011198ed2f8
[06/12] ASoC: codecs: wsa883x: add clock stop support
        commit: 3e29fb7479760d6d03380125d500b60081ccb5e9
[07/12] ASoC: qcom: dt-bindings: add sm8450 and sc8280xp compatibles
        commit: 473d218b56559934ef4720a6fc086c8ad0da9d38
[08/12] ASoC: codecs: wsa-macro: add support for sm8450 and sc8280xp
        commit: 8d2be441ebc1078eaa9f2b7aa7c6d3880973851e
[09/12] ASoC: codecs: tx-macro: add support for sm8450 and sc8280xp
        commit: 7ca36514752fa5bdf0d237436dc0042aefbf42ad
[10/12] ASoC: codecs: rx-macro: add support for sm8450 and sc8280xp
        commit: c0bcaa72fabab1f2900aecc8643f33212c0072cc
[11/12] ASoC: codecs: va-macro: clear the frame sync counter before enabling
        commit: c55b7381d7932eb303dbd97691f89c1a9c452956
[12/12] ASoC: codecs: va-macro: add support for sm8450 and sc8280xp
        commit: 0f47dd211938d5646f4041407089390bf89b96e8

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
