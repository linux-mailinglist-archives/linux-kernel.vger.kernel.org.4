Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE35643FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiLFJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiLFJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:19:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8E20983
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:17:56 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so12852703pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ePWQHlJZ1ifQfk6Te5xFRB+dPeDDvHuJ9FBMyduq99Y=;
        b=bCtcy40TBkMMs+Bx7uvp/8ffgWsN8SmTCqqiq0rSu0lzo3hObF4h5AzqBWU1RUxsqe
         d9MjQKefgoEX5/ePs9f3/OyR8DC51smp0jwcbADoc9qCq4inshfq5p5V7sgXUDG4uLai
         KLXihMWFtwtTsuuVwt23cYGHe47HidgigeuHK5cyOTYqesLPqPXhHvcNC7desZNJ45zS
         PW7yLVv9J/DfOZtUAtCLPuIhRUfjduXXxZfp+MLVw8Yk0bQgjlUR1OBYeVxyrZMW+uoU
         0r/VfW72EUgKAG/Ppl1J9m5QfsSehrdRa/Muf1Fo7fgEn7PBewdOnKcrGMX/MeHJAhGG
         Zvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePWQHlJZ1ifQfk6Te5xFRB+dPeDDvHuJ9FBMyduq99Y=;
        b=zfai/vVdE3bCxvO2y7/kJrQeUok0GPnijJsYSf/yRGfyLzjWZgLbtSmPjY13UHA4+c
         C+8p6RywXp/CRxlt+RSHEAx8+zgNoFNCfvaTn1GufqJIgjIq0GItydyX67N75X+3MfX4
         VgwcnlEV5ZLUiiF3GUkKwT1V9KIvbeMhnDZ35Ah5qiohyiQnKl4YrlkSlDEwFsBbJPmj
         liggXsPNRoexSMGXI3aU9hjdJ67DcWxLlGN46tnNeQB+WD61wi5ALFkL/KyqcePa9Jrw
         EldnzPpp08T8A/wcJ44Q2KzOaZFmySvauhA1KN4qZCZRAOyrIFFdFJaBRX+zjACPJSCm
         Ww3g==
X-Gm-Message-State: ANoB5plDCT4dzGtYDjMI9AAAcdFbT0QgdQyQ+ynv0QA4YeMVAakhyfe+
        mxz4gGivnjK7WoXf1oMX5rAf
X-Google-Smtp-Source: AA0mqf5UTduCpVAOsvqnU2Aq3c7POTsT0fXfbeT+OrZbKq34wo4NaKVMNSIIuYy0HS/p/CxktBtqMA==
X-Received: by 2002:a65:58ca:0:b0:470:2c91:9579 with SMTP id e10-20020a6558ca000000b004702c919579mr58584377pgu.22.1670318276006;
        Tue, 06 Dec 2022 01:17:56 -0800 (PST)
Received: from thinkpad ([59.92.103.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00189371b5971sm12147194plf.220.2022.12.06.01.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:17:54 -0800 (PST)
Date:   Tue, 6 Dec 2022 14:47:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <20221206091737.GC15486@thinkpad>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
 <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
 <20221205130048.GD20192@thinkpad>
 <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
 <20221205133712.GE20192@thinkpad>
 <2699840b-9746-473b-fa17-900258db555d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2699840b-9746-473b-fa17-900258db555d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:14:30AM +0100, Krzysztof Kozlowski wrote:
> On 05/12/2022 14:37, Manivannan Sadhasivam wrote:
> > On Mon, Dec 05, 2022 at 02:12:48PM +0100, Johan Hovold wrote:
> >> On Mon, Dec 05, 2022 at 06:30:48PM +0530, Manivannan Sadhasivam wrote:
> >>> On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
> >>>> On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> >>>>> On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> >>>>>> On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> >>>>>>> On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> >>>>>>>> UFS controllers may be cache coherent and must be marked as such in the
> >>>>>>>> devicetree to avoid data corruption.
> >>>>>>>>
> >>>>>>>> This is specifically needed on recent Qualcomm platforms like SC8280XP.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>
> >>>>>> Yes, it would be a valid, but it will only be added to the DTs of SoCs
> >>>>>> that actually require it. No need to re-encode the dtsi in the binding.
> >>>>>>
> >>>>>
> >>>>> But if you make a property valid in the binding then it implies that anyone
> >>>>> could add it to DTS which is wrong. You should make this property valid for
> >>>>> SoCs that actually support it.
> >>>>
> >>>> No, it's not wrong.
> >>>>
> >>>> Note that the binding only requires 'compatible' and 'regs', all other
> >>>> properties are optional, and you could, for example, add a
> >>>> 'reset' property to a node for a device which does not have a reset
> >>>> without the DT validation failing.
> 
> Optional properties are optional primarily looking at one variant. It
> means that on different boards with the same SoC, things can be routed a
> bit differently and some property can be skipped. E.g. sometimes
> regulators come from PMIC and sometimes are wired to some VBATT, so we
> do not have regulator in DTS for them. Or some interrupt/pin is not
> connected.
> 
> Now between variants of devices - different SoCs: I don't think that
> "optional" should be used in such context, except special cases or lack
> of knowledge about hardware. For given SoC/variant, the property is either:
> 1. valid and possible (can be required or optional),
> 2. not valid, not possible.
> And this we should express in constraints, if doable with reasonable
> complexity.
> 
> Therefore the question is: is dma-coherent not valid for other SoCs?
> 

Yes, it is not valid on older SoCs because they don't support I/O coherency.
So setting this property on those un-supported SoCs may lead to wierd behavior.
This was the concern I had for setting this property valid for all SoCs.

So far we only know that SC8280XP and newer SoCs support I/O coherency.

Thanks,
Mani

> If it is "not needed" for other SoCs, then I would leave it like this.
> Consider also what Rob said, that otherwise we would create DTS from the
> bindings.
> 
> Also, too many allOf:if:then: constraints in the bindings make them
> trickier to read.
> 
> >>>>
> >>>
> >>> Then what is the point of devicetree validation using bindings?
> >>
> >> You're still making sure that no properties are added that are not
> >> documented, number of clocks, names of clocks, etc.
> >>
> >>> There is also a comment from Krzysztof: https://lkml.org/lkml/2022/11/24/390
> >>
> >> Speaking of Krzysztof:
> >>
> >> 	https://lore.kernel.org/lkml/20221204094717.74016-5-krzysztof.kozlowski@linaro.org/
> 
> That's not the best example, because I just do not know where
> dma-coherent is applicable and where it is not, thus I added it as valid
> for all variants. Also, I think that all variants are capable of using
> IOMMU - it isn't restricted per variant. If they are capable of IOMMU,
> then dma-coherent is a possible choice.
> 
> 
> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
