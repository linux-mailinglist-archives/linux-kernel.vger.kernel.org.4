Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E27665700
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjAKJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjAKJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:10:50 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178313F3C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:07:36 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CCC473EE6C;
        Wed, 11 Jan 2023 10:07:33 +0100 (CET)
Date:   Wed, 11 Jan 2023 10:07:32 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Message-ID: <20230111090732.4rdkp74cuwytolay@SoMainline.org>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
 <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
 <65ccd0c9-8bd9-fc3c-ef33-78b905adf294@linaro.org>
 <20230111043000.6svnos6u4ynwxjgv@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111043000.6svnos6u4ynwxjgv@builder.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 22:30:00, Bjorn Andersson wrote:
> On Wed, Dec 14, 2022 at 05:45:49PM +0100, Krzysztof Kozlowski wrote:
> > On 14/12/2022 16:29, Marijn Suijten wrote:
> > > On 2022-12-14 16:06:05, Krzysztof Kozlowski wrote:
> > >> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
> > >> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
> > >> devices using modified qcom,board-id field.
> > >>
> > >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > 
> > > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > 
> > >> ---
> > >>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
> > >>  1 file changed, 5 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > >> index d45e2129fce3..cfb7f5caf606 100644
> > >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > >> @@ -925,15 +925,18 @@ allOf:
> > >>                - qcom,apq8026
> > >>                - qcom,apq8094
> > >>                - qcom,apq8096
> > >> +              - qcom,msm8956
> > > 
> > > I am certain this (and msm8976) were added in [1] but it somehow got
> > > lost when that was merged as 05c0c38dc752 ("dt-bindings: arm: qcom:
> > > Document msm8956 and msm8976 SoC and devices")?
> > > 
> > > Should we also add qcom,msm8976 or only when a user for that board is
> > > added?
> > 
> > Bjorn,
> > You need to fix your scripts. It's not the first time when applied patch
> > is changed and its pieces are gone.
> > 
> 
> I don't have any script that automagically solves merge conflicts, so if
> you prefer to avoid the occasional mistake I can start reject your
> patches as soon as they don't apply 100% cleanly.

Is this manual conflict resolution by you?  Git would/should only make
it disappear if it thinks that (part of) the patch has already been
applied, though I don't think those lines were added with the exact same
indentation elsewhere in the file.

There's also a mode that makes git reject the patch if the context (and
line numbers?) doesn't match up exactly, but that may cause more harm
than good.

- Marijn
