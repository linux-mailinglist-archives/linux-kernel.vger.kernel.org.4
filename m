Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA28E67C19E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjAZA3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjAZA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D664D95;
        Wed, 25 Jan 2023 16:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A7C5616F1;
        Thu, 26 Jan 2023 00:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87372C4339E;
        Thu, 26 Jan 2023 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692941;
        bh=d4HSQHdGnlTFmLj+LdiMNKnyGFgOUaR5G/kz7dGHLhc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ne+nDVS4cq2sqBXf+4BfrBvFkiDT+2mSiafpt8HwbUHceLylv87Nn2BkShpX1Et/N
         YJCyn1UvB0jV65XuzIEpw47qpKuOqjhuNN6cwuZRZSJBeK1tbop+Sl71jaDDCAmd0i
         YoiWODGbhuoaPT88WBJjHUKCS5Zw1u9p1GUo9YT7c1aCN9cYBxxniZ+3lpLHqe8E/+
         sd+ERuluGjzAiR1w1XgAiPyOwh1WhifDmrLAUp0FWzeNfNhyJPx8jBBuBttxPairRS
         S9oTKrt8JQ0SDzRVRE19CWsOQJr0mCK+ppjjoezxVKkr/HTi9OqWgBLj40nZ3eqsXo
         uks+2MH7Eekrw==
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
In-Reply-To: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
References: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,sm8250: use fallback for
 SDM845 sound cards
Message-Id: <167469293821.2696228.18433894144147250698.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:28:58 +0000
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

On Wed, 18 Jan 2023 11:15:41 +0100, Krzysztof Kozlowski wrote:
> All SDM845 sound cards are compatible with each other, so use one
> generic fallback compatible for them.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,sm8250: use fallback for SDM845 sound cards
      commit: b4090b7cda255daafe816a00f2848f4f8e761786
[2/2] ASoC: qcom: sdm845: add remark about unneeded compatibles
      commit: 3a14adc51605452fdf1c009cc3333c7e399821d9

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

