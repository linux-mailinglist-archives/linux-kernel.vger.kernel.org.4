Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69226C5B59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCWAW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWAW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:22:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688FE3B0;
        Wed, 22 Mar 2023 17:22:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so20817615plb.5;
        Wed, 22 Mar 2023 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679530974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYIQCFHldtGBv1bYm6Q51g+I67uL7yWaZuOe7JoG3MY=;
        b=PSXv1ieo6A+Jsnt0qIzPn1+jo3G0t8qnHNzO5aROGJG9lPMC9/VmzspcE87OcKo7Sg
         13bE8dDX3sXI2QwJMdaV5us2/50ZUJOjHTHJRqRfXxU3WEE+svQDHTOffyC2HnaIV1Ht
         EE4UIILHifZH2r7mfhgYcFHTd+EQc7KcE+p0/Pjx6JYVvLVWPMFDr1zjdnUPLKkbqgvk
         SSUGfPlHfsqDcklQqoxMpOytX5Af5VkW9KLpKx0hcErSwj8Nyo3kSCEtgWEuvC5EinsJ
         47ct8s/Zw5k9qQVb+cVVZYQR/LT+bHXFokcvvlbI+St1ie2tytWd41evDa3BMhsRqpwe
         C2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679530974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYIQCFHldtGBv1bYm6Q51g+I67uL7yWaZuOe7JoG3MY=;
        b=1fdO3yL6zh09ltrXocLXwVwerMc5u9/iyrU13s84TmcRbgGxJ/ZFROZXHiZVOaCqF3
         ehlmdxsIIHod2dFfFb+OU9aPTUqRy8Jfxsfe/p7gF1rnRuOc0+W27090fVKdtVJ8DY12
         CKD6/kXAavuNtg8UdoH4ml+63ypNHMW1PIH7twwXHweuBp+UjiyOU7eWx9qlQS8ylus8
         X1399u3RioTgrud3ESK6eMZbca4YoJArtX8twPbNcSBYVVMpR6xRVVrj/Q3cw1LNbCub
         o9K/Iei0Pb7WQctUX/nIQs2n4QaceEukerP83ronPbuJ387pLGlFL6RsSXlQyoB1BWRG
         nvYw==
X-Gm-Message-State: AO0yUKWnTbOg0tZ4EG6FI7Ie9ErTUmx2K27hX0e8Wjzr6/0ytcEmrrcG
        z7HZV9gIaWUAuNljNnq37UU=
X-Google-Smtp-Source: AK7set9Kk2OmrXiC0gmmMn8JXyFhivsdF6RATjFMHZ+SBPAT/IYcOQeYhT+VrAKAIPIy35DyygvfLQ==
X-Received: by 2002:a17:90b:4f8d:b0:23d:35d9:d05b with SMTP id qe13-20020a17090b4f8d00b0023d35d9d05bmr5560574pjb.14.1679530974176;
        Wed, 22 Mar 2023 17:22:54 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090aca8b00b0023d143182b3sm87146pjt.41.2023.03.22.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:22:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 08:22:47 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8250-xiaomi-elish: Add mdss
 and dsi node
Message-ID: <ZBub15QyI5/jX9dX@Gentoo>
References: <20230322171555.2154-1-lujianhua000@gmail.com>
 <20230322171555.2154-2-lujianhua000@gmail.com>
 <fcd5d524-a35f-b91b-be35-bd68643a4bdc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd5d524-a35f-b91b-be35-bd68643a4bdc@linaro.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:16:40PM +0100, Konrad Dybcio wrote:
> 
> 
> On 22.03.2023 18:15, Jianhua Lu wrote:
> > xiaomi-elish uses dual dsi mode panel and dsi phy type is cphy.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Include missing <dt-bindings/phy/phy.h> for phy-type property.
> > 
> >  .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > index a43d4b73ffca..4ff8454d4abe 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > @@ -5,6 +5,7 @@
> >  
> >  #include <dt-bindings/arm/qcom,ids.h>
> >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include <dt-bindings/phy/phy.h>
> 'p' < 'r'
Acked
> 
> 
> >  #include "sm8250.dtsi"
> >  #include "pm8150.dtsi"
> >  #include "pm8150b.dtsi"
> > @@ -469,6 +470,74 @@ &cdsp {
> >  	status = "okay";
> >  };
> >  
> > +&dsi0 {
> > +	vdda-supply = <&vreg_l9a_1p2>;
> > +	qcom,dual-dsi-mode;
> > +	qcom,master-dsi;
> Keep the master property after qcom,sync-dual-dsi so that we
> get a nice reverse-Christmas-tree.
Acked
> 
> > +	qcom,sync-dual-dsi;
> > +	status = "okay";
> > +
> > +	display_panel: panel@0 {
> > +		reg = <0>;
> > +		vddio-supply = <&vreg_l14a_1p88>;
> > +		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
> > +		backlight = <&backlight>;
> > +
> > +		status = "disabled";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> Please add newlines before subnodes.
Acked
> 
> Konrad
> > +				panel_in_0: endpoint {
> > +					remote-endpoint = <&dsi0_out>;
> > +				};
> > +			};
> > +
> > +			port@1{
> > +				reg = <1>;
> > +				panel_in_1: endpoint {
> > +					remote-endpoint = <&dsi1_out>;
> > +				};
> > +			};
> > +
> > +		};
> > +	};
> > +};
> > +
> > +&dsi0_out {
> > +	data-lanes = <0 1 2>;
> > +	remote-endpoint = <&panel_in_0>;
> > +};
> > +
> > +&dsi0_phy {
> > +	vdds-supply = <&vreg_l5a_0p88>;
> > +	phy-type = <PHY_TYPE_CPHY>;
> > +	status = "okay";
> > +};
> > +
> > +&dsi1 {
> > +	vdda-supply = <&vreg_l9a_1p2>;
> > +	qcom,dual-dsi-mode;
> > +	qcom,sync-dual-dsi;
> > +	/* DSI1 is slave, so use DSI0 clocks */
> > +	assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
> > +	status = "okay";
> > +};
> > +
> > +&dsi1_out {
> > +	data-lanes = <0 1 2>;
> > +	remote-endpoint = <&panel_in_1>;
> > +};
> > +
> > +&dsi1_phy {
> > +	vdds-supply = <&vreg_l5a_0p88>;
> > +	phy-type = <PHY_TYPE_CPHY>;
> > +	status = "okay";
> > +};
> > +
> >  &gmu {
> >  	status = "okay";
> >  };
> > @@ -533,6 +602,10 @@ fuel-gauge@55 {
> >  	};
> >  };
> >  
> > +&mdss {
> > +	status = "okay";
> > +};
> > +
> >  &pcie0 {
> >  	status = "okay";
> >  };
