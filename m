Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A963B0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiK1SDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiK1SDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:03:23 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349494A9ED;
        Mon, 28 Nov 2022 09:49:42 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 40FDCD05C0;
        Mon, 28 Nov 2022 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669657751; bh=IqhpQLGGkiGqyy4JQ4pVzD5MqL2+L88to0Jgl2XJDko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pEA4Ov+5jgMkGW4lwDrMwTvJUnQH/AjHERSRnos3jRf1KWoEmOLq1GApFcU9NVHqx
         oNQnNUg1fgqUuZpx3b0jl3NX10bRLa/R0MIcvEMO3/9XWerQnfnUIcGDFOkp/bayLM
         lOXE9Y7ULU3PNpOFp0qMUMfusUAoTcFJmdKLImiU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: msm8974: castor: Define pm8841 regulators
Date:   Mon, 28 Nov 2022 18:49:10 +0100
Message-ID: <4785971.31r3eYUQgx@g550jk>
In-Reply-To: <c6f52e13-3692-5739-eabd-550936f34bed@linaro.org>
References: <20221121212226.321514-1-luca@z3ntu.xyz> <c6f52e13-3692-5739-eabd-550936f34bed@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 21. November 2022 23:32:22 CET Konrad Dybcio wrote:
> On 21.11.2022 22:22, Luca Weiss wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Define the pm8841 regulators under SMD/RPM, to allow the modem
> > remoteproc to set the voltage during boot of the remote processor.
> > 
> > Entries are just copied from the Honami dts.
> 
> I hope it was supposed to be "identical to" and not "copied and hoped it
> would be ok" :/

Blame Bjorn from many years ago :P

But I just double checked and in some Sony msm8974 kernel sources I have on my 
computer (https://github.com/rcstar6696/android_kernel_sony_msm8974 branch 
cm-14.1) all Sony devices have the same values these pm8841 regulators, none 
have it overriden from what I could find. So should be fine.

Regards
Luca

> 
> Maybe I'm a bit picky, but I suppose this is said in a misleading way..
> 
> Konrad
> 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes in v2:
> > * new patch in this series
> > 
> >  ...-msm8974pro-sony-xperia-shinano-castor.dts | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git
> > a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> > b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts index
> > 3f45f5c5d37b..2c33f84a6e4e 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> > +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> > @@ -319,6 +319,30 @@ led@7 {
> > 
> >  };
> >  
> >  &rpm_requests {
> > 
> > +	pm8841-regulators {
> > +		compatible = "qcom,rpm-pm8841-regulators";
> > +
> > +		pm8841_s1: s1 {
> > +			regulator-min-microvolt = <675000>;
> > +			regulator-max-microvolt = <1050000>;
> > +		};
> > +
> > +		pm8841_s2: s2 {
> > +			regulator-min-microvolt = <500000>;
> > +			regulator-max-microvolt = <1050000>;
> > +		};
> > +
> > +		pm8841_s3: s3 {
> > +			regulator-min-microvolt = <500000>;
> > +			regulator-max-microvolt = <1050000>;
> > +		};
> > +
> > +		pm8841_s4: s4 {
> > +			regulator-min-microvolt = <500000>;
> > +			regulator-max-microvolt = <1050000>;
> > +		};
> > +	};
> > +
> > 
> >  	pm8941-regulators {
> >  	
> >  		compatible = "qcom,rpm-pm8941-regulators";




