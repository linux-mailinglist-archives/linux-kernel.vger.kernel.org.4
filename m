Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB876D0F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjC3T7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjC3T7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A9FF19;
        Thu, 30 Mar 2023 12:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777236211D;
        Thu, 30 Mar 2023 19:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54435C433A0;
        Thu, 30 Mar 2023 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680206377;
        bh=PKl59xrFNUIN+xj66A1w7ioz+iBVnTH7SBApsoJlFVs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=IGBYnkD6/blVHeVCt/RyQ0e/8kyYTnk/zjEu8ftklLhrBtTu+LzCuM53ng07HAGVD
         b9mh9gRKHgSL+SKqqsAJqqH3sLPBImoeIfOjaTuJQJYBDNKSQrDvL9uL9/lQHw5bMr
         B1ZRj0r6c0X4ExtPqhqIavPDsdElNi9kGDZVttro7mjXIqc3Fmm3fg5v2xOnG8UOh9
         jGkC3SFrcFZDrgd47eBBpHFvCs1i8WIKHccQaWor7utUmart55FzPqHues4ljL5IVJ
         c6WCdTwwKDKlrJYW1JoY0eHFiSucJj+fWZVj27OvqYJwLRgiM/gjV6taD2SXTZihBT
         +KZCiQKoPvHsw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330113405.55722-1-krzysztof.kozlowski@linaro.org>
References: <20230330113405.55722-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing
 NPL clock
Message-Id: <168020637506.3358032.8475838193533014341.b4-ty@kernel.org>
Date:   Thu, 30 Mar 2023 20:59:35 +0100
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

On Thu, 30 Mar 2023 13:34:05 +0200, Krzysztof Kozlowski wrote:
> Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
> clock.  Add the clock and customize allowed clocks per each variant.
> The clocks are also required by ADSP in all variants.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
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

