Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D106572AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL1Eh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiL1EhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B6EDFBD;
        Tue, 27 Dec 2022 20:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CDD361303;
        Wed, 28 Dec 2022 04:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5F2C43396;
        Wed, 28 Dec 2022 04:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202223;
        bh=qxNLARjYk0U+JT2mXmsl5CA/8nSxnGgfRvek3e7BNO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7IKy5U8zHHn18qzH3Td6FwRNN4ZUayoy3DNZtaihsRhulfzqOkRloTdr2YWHcLKz
         be8HkXtGVkb6Shrw0YfN3jNLw71JYcXcjJ7YGLqu5vm3xqbY1aUhmpBjwP/+jaALXU
         /bU35n0TBBiKcbVoUSo+1ArrfAEtkohbZsHt9Q+6Q4zta4my2QfBzy4v+bIIKccxot
         l/rhD60lsEu5xTiCnujAwrdMtq4Cx7tjl/n3db9O3DQzHS0znyTR/uKaVlf90Of05P
         CYhStZuxNDUFmFSLatYWnN8XFae2Xln0JC0M7JYPvKDBWlIW4Gwl6vJrnAUcdzWRW1
         z6tBsdhbSknwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        me@iskren.info, robh+dt@kernel.org, devicetree@vger.kernel.org,
        patches@linaro.org
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: sm6115: Fix UFS node
Date:   Tue, 27 Dec 2022 22:36:38 -0600
Message-Id: <167220221224.833009.7704596716289147327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221208201401.530555-1-konrad.dybcio@linaro.org>
References: <20221208201401.530555-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 21:13:57 +0100, Konrad Dybcio wrote:
> In its current form, UFS did not even probe successfully - it failed
> when trying to set XO (ref_clk) to 300 MHz instead of doing so to
> the ICE clk. Moreover, the missing reg-names prevented ICE from
> working or being discovered at all. Fix both of these issues.
> 
> As a sidenote, the log reveals that this SoC uses UFS ICE v3.1.0.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sm6115: Fix UFS node
      commit: 01b6041454e8bc4f5feb76e6bcdc83a48cea21f2
[2/5] arm64: dts: qcom: sm6115: Provide xo clk to rpmcc
      commit: ad9514be8ddb9d3a8c262aa415c2f1c1f4cc97f9
[3/5] arm64: dts: qcom: sm6115: Provide real SMD RPM XO to SDC1/2
      commit: 0f1619aa22cd78a47522008e9b83524eae6bb922
[4/5] dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab P11
      commit: 92ad27fb925943d62deaaa659931ce85ddec99c8
[5/5] arm64: dts: qcom: Add Lenovo Tab P11 (J606F/XiaoXin Pad) dts
      commit: 67e75cfea375b5eca42a8d41b927fa195e723fe6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
