Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB66FBF5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjEIGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjEIGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2BAD28;
        Mon,  8 May 2023 23:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2168F62D2D;
        Tue,  9 May 2023 06:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A212DC4339B;
        Tue,  9 May 2023 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614344;
        bh=YgR5gthn/7Amv3cH003JLPMWgQs5SKsPVqLbkaAxcDo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Z9/UC3n6pY4XVT4CTaIkUIIzFuxrmzj/nq7QD3yO0hxehH7B+ErA0vZBrpOCZAo7v
         ZhLROItSmj10A8edWjK6dgFKoeAtfChWz1q592KCGo+vSb79/66s/Gz0Q6NiIKEAhC
         nmWaNeGgpJ7ZUGuB7KHrItGvfc+HVD8VlQ6LUpq8Fe1IbSvGMrG+sBfN5X4Qiy7ABc
         HH4YSMrKqbFVf6rtZ6QlNsij7jeodbipG9ExULX/96jZXuuHxsNXpOWOUl8DPyv8IQ
         jxtg7H5YI3b73J79QQ66PppAXXu3qB3Fhwmxya7wF7bGCaVfNwQJydA/5VU5CMitx6
         ojubw7W1wwiAg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507174543.264987-1-krzysztof.kozlowski@linaro.org>
References: <20230507174543.264987-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: google,sc7180-trogdor: allow up to
 four codec DAIs
Message-Id: <168361433934.303059.8293357053687076617.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:38:59 +0900
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

On Sun, 07 May 2023 19:45:43 +0200, Krzysztof Kozlowski wrote:
> SC7180 Trogdor sound cards come with multiple audio amplifiers, so allow
> up to four of them to fix dtbs_check warnings like:
> 
>   sc7180-trogdor-homestar-r3.dtb: sound: dai-link@1:codec:sound-dai: [[275], [276], [277], [278]] is too long
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: google,sc7180-trogdor: allow up to four codec DAIs
      commit: 853a954bf506c42c91b2d2b0d57be891a659ee5a

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

