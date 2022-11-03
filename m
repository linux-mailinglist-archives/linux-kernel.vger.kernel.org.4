Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96B617C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKCMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKCMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:12:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D113FDDF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:12:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v28so1387957pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rieV2SdG8Mne1lxC+rYgGfokYn80pf6/u2BwWRn0Sa8=;
        b=c0tT0ytkIGnqZS9md6cRj/skv0p3s9o9YUJ12rIVp0tf5XWrqoZpQ5jyc2bASunn08
         avIYT7RBqtT9KBIrhIYDT8tiJuJwPppPNvui1v3S3QQXNz6k3Vd1rObtd6IgQ6AEumgH
         I6P+N/0tDH6AVwNnv3ICutpmT4ETirJ404d5S3vEdysntZgqLcR5Io8DX3NIM/BVhRQA
         ekjvNUflGxsTbQLgqH3dkh8BF9lOPk+dgSk5bdmTugtnNmfcbBsksse1sZTW9aEsaoGA
         QKMUmTdvBmruOuLf4sCwi4ndNH9krFSE147UDQcYr/dJKYEbYfPlc2rgh9btp4sK/eib
         gIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rieV2SdG8Mne1lxC+rYgGfokYn80pf6/u2BwWRn0Sa8=;
        b=HHQ2UlQK6YnfqlPdoRJ/8IG4ASRxmtzO4wVICW55Uho0VoxFo/yNa3nia7AjSHHTLC
         GshJzeAEMcFruYDwa5SGrPGkGY9o+yWVuHHM5utM6zVumcTxMuc7xnXGNmHgPyybrcBM
         7RRdIIXCaSTklletEfGoi+xaGmPlLd3KY+/aHJbZMeHqSOzOQW1tep9fs+RRLcT2TC8/
         2deHbV4lL0gNYgLh2tbksQLH1vhErbfLX66sglrAVMNSmHKU9IpjQKLB5ARCk5k++pXz
         3/QEvm3CeFQKzHewSa8mHYyAdDgDkGHPC167KNMqV/RJropyV5I6VJCpeaFb7PKd6N93
         tc/A==
X-Gm-Message-State: ACrzQf0dNBmziANjFVBdaFvNjxymxDTOSHKbPCxbuG8cy+MitWx4xHW3
        1smlm5CPQCGXKgomb5lQx5s0
X-Google-Smtp-Source: AMsMyM5MvSMm8DZRRoUBG8baRgK1tsDVj6xLuyNJi/jpppTIwzgYHsAlA4LC9r7rDPe2PErVWX/yCQ==
X-Received: by 2002:a05:6a00:cd4:b0:56c:b47:a743 with SMTP id b20-20020a056a000cd400b0056c0b47a743mr29723853pfv.25.1667477555333;
        Thu, 03 Nov 2022 05:12:35 -0700 (PDT)
Received: from thinkpad ([59.92.102.81])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0021358bd24b9sm3240468pje.21.2022.11.03.05.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:12:34 -0700 (PDT)
Date:   Thu, 3 Nov 2022 17:42:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal
 zone support
Message-ID: <20221103121228.GB8434@thinkpad>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-13-manivannan.sadhasivam@linaro.org>
 <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
 <20221103055014.GA8434@thinkpad>
 <e46c817b-1a3b-d20c-22e7-a67b7684f17b@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e46c817b-1a3b-d20c-22e7-a67b7684f17b@somainline.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:02:30AM +0100, Konrad Dybcio wrote:
> 
> On 03/11/2022 06:50, Manivannan Sadhasivam wrote:
> > On Sat, Oct 29, 2022 at 04:29:05PM +0200, Konrad Dybcio wrote:
> > > 
> > > On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> > > > Add thermal zone support by making use of the thermistor SYS_THERM6.
> > > > Based on experiments, this thermistor seems to reflect the actual
> > > > surface temperature of the laptop.
> > > > 
> > > > For the cooling device, all BIG CPU cores are throttle down to keep the
> > > s/throttle/throttled
> > > 
> > > Is it okay to let the 4xA78C run at full throttle in thermal emergencies though?
> > I don't get it. Can you elaborate?
> 
> 8280xp has 4xA78C and 4xX1C. You only added the latter ones to the cooling
> map.
> 

Right, that's because the first 4 cores doesn't contribute to thermal much and
thottling them doesn't yield any thermal gain.

Thanks,
Mani

> 
> > 
> > > > temperature at a sane level.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
> > > >   1 file changed, 46 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > index ca77c19c6d0d..96e2fa72f782 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > > @@ -29,6 +29,52 @@ backlight {
> > > >   		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> > > >   	};
> > > > +	thermal-zones {
> > > > +		skin-temp-thermal {
> > > > +			polling-delay-passive = <250>;
> > > > +			polling-delay = <0>;
> > > > +			thermal-sensors = <&pmk8280_adc_tm 5>;
> > > > +
> > > > +			trips {
> > > > +				skin_temp_alert0: trip-point0 {
> > > > +					temperature = <55000>;
> > > > +					hysteresis = <1000>;
> > > > +					type = "passive";
> > > > +				};
> > > > +
> > > > +				skin_temp_alert1: trip-point1 {
> > > > +					temperature = <58000>;
> > > > +					hysteresis = <1000>;
> > > > +					type = "passive";
> > > > +				};
> > > > +
> > > > +				skin-temp-crit {
> > > > +					temperature = <73000>;
> > > Ouch, I didn't know we were serving burnt fingers at the cafeteria today :D
> > > 
> > > Or maybe this just looks scary.. The laptop looks plastic, so maybe it won't cause instant
> > > burns?
> > > 
> > 73c is what the reasonable number I came up with after some experiments. At
> > this point the temperature won't burn your finger but crossing this surely
> > would (that's what happening without this series).
> 
> Ok, then I suppose it's fine. Thanks!
> 
> 
> Konrad
> 
> > 
> > Thanks,
> > Mani
> > 
> > > Konrad
> > > > +					hysteresis = <1000>;
> > > > +					type = "critical";
> > > > +				};
> > > > +			};
> > > > +
> > > > +			cooling-maps {
> > > > +				map0 {
> > > > +					trip = <&skin_temp_alert0>;
> > > > +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > > +				};
> > > > +
> > > > +				map1 {
> > > > +					trip = <&skin_temp_alert1>;
> > > > +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > > +				};
> > > > +			};
> > > > +		};
> > > > +	};
> > > > +
> > > >   	vreg_edp_bl: regulator-edp-bl {
> > > >   		compatible = "regulator-fixed";

-- 
மணிவண்ணன் சதாசிவம்
