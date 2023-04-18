Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90A6E6108
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjDRMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjDRMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B758E4C15;
        Tue, 18 Apr 2023 05:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC6A630E9;
        Tue, 18 Apr 2023 12:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5A3C433EF;
        Tue, 18 Apr 2023 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681820322;
        bh=0vmALujuGWkxwAKqOFwxT5rLi8ZVr3GkSFuVQvG7wE8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KTMiaGVjYQdPwDozYPAFfHW/AH8vF1uG1kw1FwtPD9PwuYKTS1r1Fyi3Dw+LXYgcD
         E2CbrOxC4deiXKyMuXOoQ3nqzaIeIdmq3xGjC6N0f8dHvUn5eB1Kv042ok7/KSW8ka
         8zPgFUu4tja2qMXRFPZSIMbgcLdFKTHU801Yp+rGpi8mNmbh6LDaifYFjtlVvjJjtY
         JHGQq3NqPcrekw1ByWkCRvhseXxLU4AmyKBUh36Hx074YZT47gobAIzgkCvqVgmqMa
         RYGeHbdAP29wrB7eZn4Mcggkj8lGqmss3H1l6NKyGnTNJYu6g4m5UxedLHpu9K8jtX
         PKow8KJ2JIdtw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <20230327080626.24200-1-krzysztof.kozlowski@linaro.org>
References: <20230327080626.24200-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH 1/2] regulator: dt-bindings: qcom,rpmh: Correct
 PM8550 family supplies
Message-Id: <168182031987.58640.15713245847312171251.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 13:18:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 10:06:25 +0200, Krzysztof Kozlowski wrote:
> PM8550 is different than PM8550VE/VS, because the latter has much
> smaller amount of supplies (l1-3 and s1-6) and regulators.  The PM8550
> has on the other hand one pin for vdd-l1-l4-l10 supplies.  Correct the
> if:then: clause with their supplies.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: qcom,rpmh: Correct PM8550 family supplies
      commit: 902f8c9830c35cc61a7b3f63003c7246b2bf06ca
[2/2] regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then
      (no commit info)

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

