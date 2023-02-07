Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26DA68D507
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBGLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:03:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1F10249
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:03:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n13so10737993wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ93a5Pn7pV9qf9vPyQI+os80WkoEdvC0T6foUnk8Mg=;
        b=INmIU2NouIzVm1jjPfdrm53AB5JjOg8/iz3jZE+fI1b7pLAYBvKC7TMLsXvXEmMnZQ
         tvcX16TPZzl8SlvyqiF5TxNKUMYyM5yxTebfEAX2rlWAA+HUitsAujtgmlJ4a0OcbvKp
         8E5zmSXqfdwXT0d4KY3ZDO9k4vXuXxN9PyBOyRPm+3wnJPCfpXAh5V/4V8UB4b9tOHuU
         K7pSJDwrBk41FSY187xils4uDkG/6SBfJQGcBUbIf4WTIakcMUO5FDDxVvwxRqszTNr5
         oK/eoxuZQpvWPGGUUZgVSbTt9YU2fw93GINQrZoiQBQZRluPERuKlrOsol0IIiu+xtLd
         k0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ93a5Pn7pV9qf9vPyQI+os80WkoEdvC0T6foUnk8Mg=;
        b=p6wblh2TnXpTXeoTl1vo4CRZGFuVu/l4SWPWFpoSA9CvSSBz/tQ21TbWqhNls+Igzi
         eBfkkgquWbmniY0BsPZkFeXECQsWVP+a7MlQHFbaenojj+BreU/0Mnhse0zmxc172DrB
         KzlOED4i70UQQY+BWIsk4Xe23WlZ/hxyUHDm3DOqagSYARErz2eBkvpL5VLJliN1cINc
         fzz9hlhWoJiHC3OuGUu0KrTpU4VVsaO92g/mXkKaiE4zNkzaQJNdNSnLIZ+OdzUNKeGD
         SNf9Atq9d4U2zt5JttMqtVpi8BYqDzs0QHexTId2rEU5MXQOyv3w1Q/kVzWDgMAyZlN2
         DUXA==
X-Gm-Message-State: AO0yUKWt9t+IA9UM/p5Cjd1+u2KPNPUOQaix3qdDmtim/U+85fjVN/Wi
        x/JodCyRYZCM6WKPDW0aMYy2EQ==
X-Google-Smtp-Source: AK7set+9m5mhPHjw7qowGtSxwYkGbks55ol9xKSpV7ArSxwhymRP73uRItp25IcvPAhrZonE5E9JbA==
X-Received: by 2002:a05:600c:4da2:b0:3dc:51f6:8f58 with SMTP id v34-20020a05600c4da200b003dc51f68f58mr2766884wmp.6.1675767808312;
        Tue, 07 Feb 2023 03:03:28 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003dffe312925sm6761960wmc.15.2023.02.07.03.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:03:27 -0800 (PST)
Date:   Tue, 7 Feb 2023 13:03:26 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Message-ID: <Y+Iv/s7V5PYkRI8D@linaro.org>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-8-abel.vesa@linaro.org>
 <Y9zoD/eVG8zjMYNx@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zoD/eVG8zjMYNx@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-03 11:55:11, Johan Hovold wrote:
> On Thu, Feb 02, 2023 at 03:25:10PM +0200, Abel Vesa wrote:
> > Add USB host controller and PHY nodes.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > Changes since v3:
> >  * none
> > 
> > Changes since v2:
> >  * none
> > 
> > NOTE: This patch has been already merged. It is here only to provide
> > context for the rest of the patchset. There is a change with respect to
> > the clocks, but that will be sent as a separate/individual fix patch.
> 
> I believe it was because of the 'phy' and 'common' resets, which have
> been switched below.

No, the resets haven't been switched, at least not compared to the
already merged version.

> 
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi | 92 +++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > index a85d2ae7d155..0262193e2ffe 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > @@ -14,6 +14,7 @@
> >  #include <dt-bindings/mailbox/qcom-ipcc.h>
> >  #include <dt-bindings/power/qcom-rpmpd.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/phy/phy-qcom-qmp.h>
> >  #include <dt-bindings/thermal/thermal.h>
> >  
> >  / {
> > @@ -746,7 +747,7 @@ gcc: clock-controller@100000 {
> >  				 <&ufs_mem_phy 0>,
> >  				 <&ufs_mem_phy 1>,
> >  				 <&ufs_mem_phy 2>,
> > -				 <0>;
> > +				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> >  		};
> >  
> >  		ipcc: mailbox@408000 {
> > @@ -2060,6 +2061,95 @@ opp-202000000 {
> >  			};
> >  		};
> >  
> > +		usb_1_hsphy: phy@88e3000 {
> > +			compatible = "qcom,sm8550-snps-eusb2-phy";
> > +			reg = <0x0 0x088e3000 0x0 0x154>;
> > +			#phy-cells = <0>;
> > +
> > +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> > +			clock-names = "ref";
> > +
> > +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		usb_dp_qmpphy: phy@88e8000 {
> > +			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
> > +			reg = <0x0 0x088e8000 0x0 0x3000>;
> > +
> > +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> > +
> > +			power-domains = <&gcc USB3_PHY_GDSC>;
> > +
> > +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> > +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> > +			reset-names = "phy", "common";
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <1>;
> > +
> > +			status = "disabled";
> > +		};
> 
> Johan
