Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6862628D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiKKUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiKKUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8A11816;
        Fri, 11 Nov 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73CC5B8260F;
        Fri, 11 Nov 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB719C433D6;
        Fri, 11 Nov 2022 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668197383;
        bh=PzS0md/R98teTQLOBivBEycYuxdpDjm/Kz1yZeYFP0w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=K7mRA65GuShqGApRUfNyO8lLj7vIUm1koqrsswCYzunKzBv4G/Xd9JscPC7nBekHg
         HGVCYXuxkPilExhHSueartS805yFmWZo/bZkw7N0cHWHCzh0JCJDrWbahiiH2ht26o
         SqcDC2PouciYEyI4wypEuihkci4f/Z4J82SVQbSGEePLHtDpxyXFg8OKcNgYNo5Bnx
         16OUSZhkdjcmpvIPU5vDYxGHysV6ppYMZfO8W4MnqC6ZkyG+pYO5ho4B8z7rs/oDYQ
         uKQd0NtYR0G+cli5T07r9y+nzr766Rsqwb4Y0OGav+i2nEWhGNmpQBPqaq9j1piNbE
         bTIATgHzkfuvQ==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20221110133512.478831-1-krzysztof.kozlowski@linaro.org>
References: <20221110133512.478831-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: qcom,wsa883x: Use correct SD_N polarity
Message-Id: <166819737928.635730.17163192130637526976.b4-ty@kernel.org>
Date:   Fri, 11 Nov 2022 20:09:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 14:35:11 +0100, Krzysztof Kozlowski wrote:
> Use correct polarity in example and powerdown-gpios description.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,wsa883x: Use correct SD_N polarity
      commit: 817e981736d27731adb9d7ca11eb8069d1ee569d
[2/2] ASoC: codecs: wsa883x: Use proper shutdown GPIO polarity
      commit: ec5dba73f7ba10797904cf18092d2e6975a22147

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
