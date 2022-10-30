Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12816128A4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ3HRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJ3HRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:17:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0732AF2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:17:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p3so8277072pld.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/6WjG/dX440R2RO6wLGBQFAWw0l4A8fGFfY6dPSRdk=;
        b=Mg+zuw4new1q3qD5JLv0sng+Xzr0B9aaKuJVVMyROQg15GkfkdVUFar0pKR7lM5noA
         XAxmOWH4JeJapdFWDD+cn4+TUDOXGSOOkHCs6jPi7bMaRrJ4Kbo3Mz1LIhzWkyILtaQQ
         GVL1b86UAiWqtlsXiZ9eddGmLgoEvUr7HJlHZEuvAztKYH8s0POz2FN5CWKGTSTvMnSv
         D4qsukxWiQj6gQ/gsfpd35xHFlS4xCOwXwG7FNefbipZ7dtuXzA5OtM+rKbzKfQDLwuh
         GgYjelVud9QIK7BuDHA6y04/Afg9ggpM9TIOsLaILSiF/Za2DaJ9DC3FagIIoFSJ1PeZ
         P4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/6WjG/dX440R2RO6wLGBQFAWw0l4A8fGFfY6dPSRdk=;
        b=qjdhL1MVLNYzaW9fY/Exld9s8BTQJvQEed5V2Amjt1+zDZHUaXziEjFRrm7Xvr/9tb
         GdjvWsuV3fu89pnxqO7Cx8jRhp3J0egxL38YHBBxIPkXQQlRwL57gB+b4IKohanWjXFQ
         dIozi1ce+E3JdDlRbgqd2BGI8EHbR2Z22RimdoggsiVrZ6+jQ6VpT+z3vGv3t9MsvB1e
         yHni7yugqAqetFqXojSEs8S+VJ1HokONguBjPWyZ/lj/EZMwLynCeAVsXhkECgtBYkdK
         /5Ez9gViOXR4QllhY32to6Bm749CVljubOIySI7ZXHbZHZnCzNS6VXMcp5P7zcX9U5TA
         XvfA==
X-Gm-Message-State: ACrzQf3txhWqTIEqWofosEYVLhYgs3E/rIindC3TL1Ip8BF5kPWeCNDB
        9sSv/Yo4Pn6HH+DO3Axg02lf
X-Google-Smtp-Source: AMsMyM7wsfvc+EMO+FSSOGbqYotGNKN6ObjIJAVh/JYMc2kixEPR3MrUzel3AnaAx1M4DMOxBfAU9g==
X-Received: by 2002:a17:90a:86c6:b0:213:36b6:1b4c with SMTP id y6-20020a17090a86c600b0021336b61b4cmr8494492pjv.7.1667114228178;
        Sun, 30 Oct 2022 00:17:08 -0700 (PDT)
Received: from thinkpad ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b0017a0668befasm2249377plx.124.2022.10.30.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 00:17:06 -0700 (PDT)
Date:   Sun, 30 Oct 2022 12:46:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2}
 VADC channels
Message-ID: <20221030071659.GE5362@thinkpad>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-10-manivannan.sadhasivam@linaro.org>
 <5e66c095-898e-067e-1874-a3d2e5babf17@linaro.org>
 <20221029044831.GC5362@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221029044831.GC5362@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 10:18:37AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 27, 2022 at 10:09:21AM -0400, Krzysztof Kozlowski wrote:
> > On 27/10/2022 02:30, Manivannan Sadhasivam wrote:
> > > Add VADC channels of PM8280_{1/2} PMICs for measuring the on-chip die
> > > temperature and external thermistors connected to the AMUX pins.
> > > 
> > > The measurements are collected by the primary PMIC PMK8280 from the
> > > slave PMICs PM8280_{1/2} and exposed them over the PMK8280's VADC
> > 
> > secondary PMICs
> > 
> > Drop "them"
> > 
> > 
> > > channels.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 61 +++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > index 9ac5d5c22832..d300d217fdc6 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > @@ -7,6 +7,7 @@
> > >  /dts-v1/;
> > >  
> > >  #include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> > >  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> > >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > >  
> > > @@ -189,6 +190,66 @@ pmk8280-xo-therm@44 {
> > >  		qcom,ratiometric;
> > >  		qcom,hw-settle-time = <200>;
> > >  	};
> > > +
> > > +	pm8280-1-die-temp@103 {
> > 
> > pmic-die-temp? What pm8280 stands here?
> > 
> 
> As agreed, will use "pmic-die-temp"
> 
> > 
> > > +		reg = <PM8350_ADC7_DIE_TEMP(1)>;
> > > +		label = "pm8280_1_die_temp";
> > > +		qcom,pre-scaling = <1 1>;
> > > +	};
> > > +
> > > +	sys-therm1@144 {
> > 
> > I would say sys-therm@... why do we need the "1" suffix in node name?
> > 
> 
> Suffix represents the index of the thermistor as per the schematics but I guess
> it can be dropped.
> 

I was wrong. Suffix is necessary since IIO core registers the channel based on
the node name, so it has to be unique.

Thanks,
Mani

> Thanks,
> Mani
> 
> > > +		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
> > > +		qcom,ratiometric;
> > > +		qcom,hw-settle-time = <200>;
> > > +	};
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
