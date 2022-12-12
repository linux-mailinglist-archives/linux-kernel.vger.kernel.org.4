Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5C649A04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiLLIbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiLLIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:31:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3299CE2A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:31:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14909059pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWyqcbEobVY6MJH71CuFBWxe9XmeeKvZO6SIVIyqpig=;
        b=nKIeqNHGRJB6T98ir5rkARvWH/vB1natI0w21/uQ2CUCTH6Pzva6OJJLipesiEydXl
         HeOuvTrNeIom3knzVR6TjSh/GF2fpvtx14dySdlJA+WibjR0RKeYC/U4ODnpCUMhlAaP
         JqQ/1Cb5ksE2rE88wMdvWzupLHegqBZm/DObm2dljRg5RD9se8FRyOgX1HyQj9ROhoRP
         9WAnToJ/oXGZ4M7And9YvRufqqICUyB0CeOPOSHN7E2301aa3PLKTCppt+2+N8hXSXVr
         r8YgzG5GwhSKwvKq3SM/ncuvQXZ/GfP/x5cGIv+oQZDQRNZHK7T0eQNnQrAaJMdp2XE8
         pD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWyqcbEobVY6MJH71CuFBWxe9XmeeKvZO6SIVIyqpig=;
        b=GiFv4E4szEeeFfeZCqidXWcrNlGl3z9/FJjU3dAe63prqfPcQ6TpfmyhY/lXv+BZo6
         FBTuhz3FptRIBcqywjDPObcPV8vlgxPKo+2mS1G0drw653RF3oWlmekyML622XMMpwsO
         5x3efqXyKrw0JywonKlcGpenfiBbtP672F4lEuJvc2N5acgorfXB075EOiOiuYqGrAuS
         112nyKrGgQkEm0jWPwKSIsVrUrO5gfn3P/mvcsQKSXrH9xDCOKdO0Kfre8DeKUt+lXtl
         NfwXthsVNoWeST+0ARgWDS7yWq17U6x85tCZAuPQ7aVfpfenIglSmUalg9r67eDoBRvb
         BQ5g==
X-Gm-Message-State: ANoB5pmK+xLJphqQ1JbDXS4qby6xrO/fbEw1PxPh4YFkOMC5dBwvkS/n
        A0US8JhMnU932Bgf7CC/hSry
X-Google-Smtp-Source: AA0mqf5YVHazpTO71ZrnKrYEDHTRfJPDKITohRgEWwQpgS65K5BiYVb/ehEEU4wTA2QcZ5twGgAn1A==
X-Received: by 2002:a17:902:bb8a:b0:189:abdd:400a with SMTP id m10-20020a170902bb8a00b00189abdd400amr16646760pls.15.1670833872372;
        Mon, 12 Dec 2022 00:31:12 -0800 (PST)
Received: from thinkpad ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b00188fc6766d6sm5697322plg.219.2022.12.12.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 00:31:11 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:01:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com
Subject: Re: [PATCH 00/12] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221212083104.GC20655@thinkpad>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
 <COWBMT72Y57W.2W8G3XDNT3T34@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <COWBMT72Y57W.2W8G3XDNT3T34@otso>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Thu, Dec 08, 2022 at 10:16:27AM +0100, Luca Weiss wrote:
> Hi Manivannan,
> 
> On Wed Dec 7, 2022 at 2:59 PM CET, Manivannan Sadhasivam wrote:
> > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> > This offset only works for some SoCs like SDM845 for which driver support
> > was initially added.
> >     
> > But the later SoCs use different register stride that vary between the
> > banks with holes in-between. So it is not possible to use a single register
> > stride for accessing the CSRs of each bank. By doing so could result in a
> > crash with the current drivers. So far this crash is not reported since
> > EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> > driver extensively by triggering the EDAC IRQ (that's where each bank
> > CSRs are accessed).
> >     
> > For fixing this issue, let's obtain the base address of each LLCC bank from
> > devicetree and get rid of the fixed stride.
> >
> > This series affects multiple platforms but I have only tested this on
> > SM8250 and SM8450. Testing on other platforms is welcomed.
> 
> If you can tell me *how* I can test it, I'd be happy to test the series
> on sm6350, like how to trigger the EDAC IRQ.
> 

I suppose there is no manual way to trigger EDAC IRQ on Qcom platforms.
For testing the series, I manually called the EDAC IRQ handler to verify
that it doesn't crash reading the registers.

> So far without any extra patches I don't even see the driver probing,
> with this in kconfig
> 
>   +CONFIG_EDAC=y
>   +CONFIG_EDAC_QCOM=y
> 
> I do have /sys/bus/platform/drivers/qcom_llcc_edac at runtime but
> nothing in there (except bind, uevent and unbind), and also nothing
> interesting in dmesg with "llcc", with edac there's just this message:
> 
>   [    0.064800] EDAC MC: Ver: 3.0.0
> 
> From what I'm seeing now the edac driver is only registered if the
> interrupt is specified but it doesn't seem like sm6350 (=lagoon) has
> this irq? Downstream dts is just this:
> 

Right. The upstream EDAC driver only works in IRQ mode. So you need the
interrupts property in LLCC devicetree node for probing.

> 	cache-controller@9200000 {
> 		compatible = "lagoon-llcc-v1";
> 		reg = <0x9200000 0x50000> , <0x9600000 0x50000>;
> 		reg-names = "llcc_base", "llcc_broadcast_base";
> 		cap-based-alloc-and-pwr-collapse;
> 	};
> 
> From looking at the downstream code, perhaps it's using the polling mode
> there?
> 
> 	/* Request for ecc irq */
> 	ecc_irq = llcc_driv_data->ecc_irq;
> 	if (ecc_irq < 0) {
> 		dev_info(dev, "No ECC IRQ; defaulting to polling mode\n");
> 

In the next version, I will add polling support so that you can test the
series on your platform without any hacks.

Thanks,
Mani

> Let me know what you think.
> 
> Regards
> Luca
> 
> >
> > Thanks,
> > Mani
> >
> > Manivannan Sadhasivam (12):
> >   dt-bindings: arm: msm: Update the maintainers for LLCC
> >   dt-bindings: arm: msm: Fix register regions used for LLCC banks
> >   arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
> >   qcom: llcc/edac: Fix the base address used for accessing LLCC banks
> >
> >  .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
> >  drivers/edac/qcom_edac.c                      |  14 +-
> >  drivers/soc/qcom/llcc-qcom.c                  |  64 +++++----
> >  include/linux/soc/qcom/llcc-qcom.h            |   4 +-
> >  13 files changed, 197 insertions(+), 67 deletions(-)
> >
> > -- 
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
