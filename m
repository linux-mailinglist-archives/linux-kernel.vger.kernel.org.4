Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CDA64D008
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbiLNTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiLNTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:21:34 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A3DE94;
        Wed, 14 Dec 2022 11:21:33 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0FF8C20393;
        Wed, 14 Dec 2022 20:21:32 +0100 (CET)
Date:   Wed, 14 Dec 2022 20:21:30 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Message-ID: <20221214192130.pv2yf2x5kz7mlggo@SoMainline.org>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
 <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
 <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-14 17:45:49, Krzysztof Kozlowski wrote:
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

That is quite unfortunate, and it had me puzzled for a second...

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

Correct, it's still in progress before being uptreamed.  Given that
Konrad already has patches to add the names here when he does, it makes
sense to leave this.

- Marijn
