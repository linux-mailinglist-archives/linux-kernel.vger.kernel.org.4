Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1355EAC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiIZQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIZQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:16:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9847956AB;
        Mon, 26 Sep 2022 08:05:54 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B9370C78D3;
        Mon, 26 Sep 2022 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664204723; bh=C+tqJ4n0S2ecHmWkQN6j74ywMYCFWy0zDJJ0uK+9sWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lW/hBz8qeRaX5zYRiWHV+puDQ5cZ75Qdqsw9V8u6C1jYkzvbxgIIFPFTHz+WvoVKL
         6c9HdTUO+bR5cVDAyFVjlW3djw3UJOeUh7Bo5zdJGrXrwdLWLEZRv2pm40QcxSsgHo
         Uqs7+fkhXPvFjLsosty3KgwGLhKIg8YC+PmL0OdU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: qcom: pm8941: fix iadc node
Date:   Mon, 26 Sep 2022 17:05:22 +0200
Message-ID: <1828122.tdWV9SEqCh@g550jk>
In-Reply-To: <74ef3de8-5be0-70ec-e34b-717ba93d3d77@linaro.org>
References: <20220925161821.78030-1-luca@z3ntu.xyz> <20220925161821.78030-2-luca@z3ntu.xyz> <74ef3de8-5be0-70ec-e34b-717ba93d3d77@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Montag, 26. September 2022 10:54:23 CEST Krzysztof Kozlowski wrote:
> On 25/09/2022 18:18, Luca Weiss wrote:
> > The iadc node name is supposed to be just 'adc' and the compatible is
> > only supposed to be qcom,spmi-iadc according to the bindings.
> > 
> > Adjust the node to match that.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > b/arch/arm/boot/dts/qcom-pm8941.dtsi index 3c15eecf2f21..33517cccee01
> > 100644
> > --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> > @@ -131,8 +131,8 @@ adc-chan@48 {
> > 
> >  			};
> >  		
> >  		};
> > 
> > -		pm8941_iadc: iadc@3600 {
> > -			compatible = "qcom,pm8941-iadc", 
"qcom,spmi-iadc";
> > +		pm8941_iadc: adc@3600 {
> > +			compatible = "qcom,spmi-iadc";
> 
> I am not sure this is correct. Usually specific compatibles are encouraged.

I'm happy to change it the other way also.

But the sibling of this compatible, qcom,spmi-vadc also only has that single 
compatible so it'd align it with that.

Let me know what you think.

Regards
Luca

> 
> Best regards,
> Krzysztof




