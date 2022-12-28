Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71065746A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiL1JEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiL1JEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:04:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A4C74A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:04:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jl4so9245713plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/FTEJ8XCt6QzrbvqyxI8eyBUAXbA8Tx6jTMYIdd6hg=;
        b=mgScZBtHjxG944kgEKqqjyrMOB5bEzMmCzaKYFz9oowAHB40eja7ubIkgrx54v3Y9f
         5VR6VRyR+oCdQhw3PO3cdqfLoG13gT8WKobCs1gKeV4qmcaK5TSl4vMwPtLyzhKkcK04
         cPbY0zjqCnRQVpTVuqwp98ntaNCOqqd2/jBQprD4HKUt6AtmEqUrPVxqRRaniv92vfWU
         yb6yAUABrH4ioOg5x9DnWzGgNCpYZ8g+NBgcGOB9jTmJYtgno4I3hpkH12Ly9cNbb6jq
         ziulXLkupFCBm7C/JyhKy4O3JoS30p65ZS8J+YPtwWCYhXM/xoOJNm8bbJWO6neslOqg
         Ia2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/FTEJ8XCt6QzrbvqyxI8eyBUAXbA8Tx6jTMYIdd6hg=;
        b=JL+1EiPRAxk5PGnqCJj2LNuSIFq4xF/uA+5G8e8X2mLP+MS+9avxslc7YDe8ZIE2a5
         4b6tTQyfI//DhWL2yBjA8xjsaDtwNI3hzRgAblo+7Gus2Z3q0CZnJUAyK1EVSM6O81eM
         eietjNP1345ayp8BOJODgMPHleBN6ocM7oJxHsBGAenHtsPX/ZfpfhVyybfISNBm/Tf3
         0thDbW1BR8PiOwQIdKc80luq0wanIb7Eqleb6CpJS3Tsi0U8pgOhsC3SHaTlZvVQhXdb
         WiAy1qFbqEsoBnYNngQZ4OF6Vbr+0StAnayp4B6iIsqUxA11iWpu778iIvaQZqC49Xbw
         T8ow==
X-Gm-Message-State: AFqh2kq1wW8uPwGt+1ATjH9bBG5RNNhM+bckmnfkg5dGW494/7aW0xtr
        k69fQ/1cPFZjlpPBjFCZDp/V
X-Google-Smtp-Source: AMrXdXvUqXiREoyvpHVXLT3s8wVEI3QvBcRUreLN9CynaeWqp2Hs6Pjf58YpmTmSqmtz6sBUhtJ3mQ==
X-Received: by 2002:a17:90b:2688:b0:225:f8ce:5cd8 with SMTP id pl8-20020a17090b268800b00225f8ce5cd8mr8829683pjb.4.1672218282862;
        Wed, 28 Dec 2022 01:04:42 -0800 (PST)
Received: from thinkpad ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a94c800b00219bf165b5fsm9406890pjw.21.2022.12.28.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 01:04:41 -0800 (PST)
Date:   Wed, 28 Dec 2022 14:34:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Message-ID: <20221228090433.GC30143@thinkpad>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
 <e756516a-a5e2-a6ac-fd7f-71726766fa81@linaro.org>
 <20221223174555.GE4587@thinkpad>
 <9c7cb68c-6516-6087-92ad-e707d8b122ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c7cb68c-6516-6087-92ad-e707d8b122ed@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:15:32PM +0200, Dmitry Baryshkov wrote:
> On 23/12/2022 19:45, Manivannan Sadhasivam wrote:
> > On Fri, Dec 23, 2022 at 07:18:32PM +0200, Dmitry Baryshkov wrote:
> > > On 22/12/2022 15:31, Manivannan Sadhasivam wrote:
> > > > Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> > > > endpoint devices using GIC-ITS MSI controller. Add support for it.
> > > > 
> > > > Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> > > > msi-map-mask of 0xff00, all the 32 devices under these two busses can
> > > > share the same Device ID.
> > > > 
> > > > The GIC-ITS MSI implementation provides an advantage over internal MSI
> > > > implementation using Locality-specific Peripheral Interrupts (LPI) that
> > > > would allow MSIs to be targeted for each CPU core.
> > > > 
> > > > It should be noted that the MSIs for BDF (1:0.0) only works with Device
> > > > ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
> > > >    1 file changed, 14 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > > index 570475040d95..c4dd5838fac6 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > > @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
> > > >    			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> > > >    				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> > > > -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			interrupt-names = "msi";
> > > > -			#interrupt-cells = <1>;
> > > > +			/*
> > > > +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> > > > +			 * Hence, the IDs are swapped.
> > > > +			 */
> > > > +			msi-map = <0x0 &gic_its 0x5981 0x1>,
> > > > +				  <0x100 &gic_its 0x5980 0x1>;
> > > 
> > > This definitely doesn't match what has been used in the downstream.
> > > 
> > 
> > Yes, I do not know why the downstream Device ID doesn't work. I tried finding
> > the answer within Qcom but didn't get any answer so far :/ So I just went with
> > the value that works on multiple boards.
> 
> Ugh :-(
> 
> > 
> > > Also if I understand correctly this change would prevent us from using
> > > multiple MSI interrupts for the connected device, as the last value of the
> > > 0x100 mapping is 0x1, while the vendor kernel uses <0x100 &its 0x5981 0x20>.
> > > 
> > 
> > Not true. The controller can still support multiple MSIs for the endpoint
> > devices but the only difference is, it would use the same Device ID for all.
> 
> I see, please excuse me then. But don't we have to define multiple MSI
> vectors here too?
> 

No, it is not required. GIC-ITS driver will handle the MSI mapping internally
and devicetree only needs to specify the Device ID for each PCIe device.

Thanks,
Mani

> > 
> > The Qcom GIC-ITS implementation could only support 32 Device IDs. By specifying
> > the size of 0x20, a separate Device ID would be used for each devices of bus 1.
> > But if a PCIe switch is connected and the bus count becomes > 1, then the MSI
> > allocation would fail because Device IDs are exhausted.
> > 
> > The downstream implementation just assumes that there will be only bus 1 and I
> > do not want to follow that assumption.
> > 
> > That's why I used "msi-map-mask" property of value "0xff00" here, as that will
> > allow all the devices under the bus 1 to share the same Device ID. For now I
> > only mapped bus 1, but extending that in the future for other busses is simple.
> > 
> > Thanks,
> > Mani
> > 
> > > Do you know by chance, why do we differ from the vendor dtsi?
> > > 
> > > > +			msi-map-mask = <0xff00>;
> > > >    			interrupt-map-mask = <0 0 0 0x7>;
> > > >    			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > > >    					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > > > @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
> > > >    			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
> > > >    				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
> > > > -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			interrupt-names = "msi";
> > > > -			#interrupt-cells = <1>;
> > > > +			/*
> > > > +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
> > > > +			 * Hence, the IDs are swapped.
> > > > +			 */
> > > > +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> > > > +				  <0x100 &gic_its 0x5a00 0x1>;
> > > > +			msi-map-mask = <0xff00>;
> > > >    			interrupt-map-mask = <0 0 0 0x7>;
> > > >    			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > > >    					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > > 
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
