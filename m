Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2987372672A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjFGRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjFGRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D01FC2;
        Wed,  7 Jun 2023 10:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF12641FD;
        Wed,  7 Jun 2023 17:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56FC4339B;
        Wed,  7 Jun 2023 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158636;
        bh=ysTQmFwcrMaqtH0/fQKIWDIqrZAmWkJtUOp6eA2jO3Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BLtQ/YEq3DLQPvlWQQg1WppzW6CisxWFAfz371VCOAdPHz3KywMwhmub+66ev5bq2
         tEczhXs1h3aelxFBqBXDf2ciJ7dUVXRIP2Kq3gkqeMAAlNCDYpE1zfJsY6yTC5RTdh
         QnkA9h2QxWVSfxYwDcqFlc5lOs3yzpcQ32tI4WeWC1RErxFzjMgsVODKksIGROKkmD
         GGu58Ub8OALiABj49Msr96yA71FmRdIjgpf6rLWfjO4a/T89pQiYXqZ3Iq4ouLrHeN
         tILlBeoXLjYwCjVbpE1h1OAE/c3bWhXMlF1pD+Pw0g5WxfjyBqr9G/mRApvlTmWdTT
         on0nFwWwAM0vg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20230605115607.921308-1-abel.vesa@linaro.org>
References: <20230605115607.921308-1-abel.vesa@linaro.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix regulators for PM8550
Message-Id: <168615863501.61774.16381253106507638065.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 18:23:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 14:56:07 +0300, Abel Vesa wrote:
> The PM8550 uses only NLDOs 515 and the LDO 6 through 8 are low voltage
> type, so fix accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Fix regulators for PM8550
      commit: b00de0000a69579f4d730077fe3ea8ca31404255

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

