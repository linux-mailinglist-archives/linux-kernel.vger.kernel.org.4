Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800D6D44DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjDCMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjDCMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00DDC;
        Mon,  3 Apr 2023 05:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6756F61A78;
        Mon,  3 Apr 2023 12:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A59C433D2;
        Mon,  3 Apr 2023 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680526267;
        bh=AJEjoPDvOiW9O7K74lmqI5HZy8RzM1Zgtt3tX3ncQVU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=idZVmq4o2EB52wKthrVNjlBfK6yyo6TDGbGtIp/0DZUo8D/XZqfEYeFONbXR7VQcu
         VWDcTUChhGJIfAQgze424L7gve3jiz6eINVeL2APdtQoqC3DZ8a8/leoXFd6Z9lTH9
         6CSOVnq4/zrdewmZ8cuBwS0orRjspEArZmm6tIxxrnwlIeNmX16toMfeNvXB7sp2I7
         ntvbVfxhFSc/SNOTSRUVcI7NiNLheJVIybVj7D7EImiBm5Y1fKzzA8iFcu5fa9L/5k
         u4rVVpPYiLz6j7lRrzcqSg6VnVB5/HOaB1DaTC34MEDL17KMy4S1iR90wk1ArWiyLR
         WL2TwHszaikqQ==
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
Subject: Re: (subset) [PATCH v3 00/10] ASoC: add audio digital codecs for
 Qualcomm SM8550
Message-Id: <168052626277.36561.10428671254225734348.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 13:51:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[07/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
        commit: cfad817095e111b640c7d538b9f182d2535ee065

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

