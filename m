Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0B6652D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAKEaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjAKEaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:30:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FB64D9;
        Tue, 10 Jan 2023 20:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0E061A40;
        Wed, 11 Jan 2023 04:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4B3C433EF;
        Wed, 11 Jan 2023 04:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673411403;
        bh=kk8MJmA93YoSMqizAm9++3pfvpXY9zaUqDmjKjU5tBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKL/8S1qUt7cUBC77ZOnhibCfkvXMUR1+S8BbUhR5y1i/7uWQ9wPs6cEXHK/hQG5E
         tTeg8Mf4TdglE7D8te6hz1wHbQsh27/J2geDPSm80CDXNTqKwYt81E8MhudKG6ZKPz
         UPTcjsvLmRtLkmKTZ1sncwzSuyYMr2CrVVH+WHqsLq5MhmFndSyIR6uIDkrhRYXHmj
         SL96o1zHuiMsAPmOHDCdMvJIn0nCc53evldeifK8MoTqfCEg5zHZlC2wsyfnhTTQdv
         w++t23ZmFQQGqkYh7R6S2uECx8+oW6vUMJTr3ocGpRe245/0Qc1LQgfWWne8MhHc5M
         yFX03LitVaosg==
Date:   Tue, 10 Jan 2023 22:30:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Message-ID: <20230111043000.6svnos6u4ynwxjgv@builder.lan>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
 <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
 <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 05:45:49PM +0100, Krzysztof Kozlowski wrote:
> On 14/12/2022 16:29, Marijn Suijten wrote:
> > On 2022-12-14 16:06:05, Krzysztof Kozlowski wrote:
> >> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
> >> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
> >> devices using modified qcom,board-id field.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> >> ---
> >>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index d45e2129fce3..cfb7f5caf606 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -925,15 +925,18 @@ allOf:
> >>                - qcom,apq8026
> >>                - qcom,apq8094
> >>                - qcom,apq8096
> >> +              - qcom,msm8956
> > 
> > I am certain this (and msm8976) were added in [1] but it somehow got
> > lost when that was merged as 05c0c38dc752 ("dt-bindings: arm: qcom:
> > Document msm8956 and msm8976 SoC and devices")?
> > 
> > Should we also add qcom,msm8976 or only when a user for that board is
> > added?
> 
> Bjorn,
> You need to fix your scripts. It's not the first time when applied patch
> is changed and its pieces are gone.
> 

I don't have any script that automagically solves merge conflicts, so if
you prefer to avoid the occasional mistake I can start reject your
patches as soon as they don't apply 100% cleanly.

Regards,
Bjorn

> This is patchwork:
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20221111120156.48040-9-angelogioacchino.delregno@collabora.com/
> 
> This is git:
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=arm64-for-6.2&id=05c0c38dc752eb9244e53d72ce1030f36153daf8
> 
> Two different patches.
> 
> 
> > 
> >>                - qcom,msm8992
> >>                - qcom,msm8994
> >>                - qcom,msm8996
> >>                - qcom,msm8998
> >>                - qcom,sdm630
> >>                - qcom,sdm632
> >> +              - qcom,sdm636
> >>                - qcom,sdm845
> >>                - qcom,sdx55
> >>                - qcom,sdx65
> >> +              - qcom,sm4250
> > 
> > qcom,sm6115 could be added as well unless you rather leave that to the
> > person(s) adding the board compatible later on.
> 
> There is no board, I think, so I did not add compatible.
> 
> Best regards,
> Krzysztof
> 
