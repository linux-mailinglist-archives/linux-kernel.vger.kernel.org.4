Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06B62DAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiKQM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiKQM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:27:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF07725DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:27:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so1458101plc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+rPHgMoeBIfRXBLmmqXq8TEde2WOOk6YMN7EVwcUy60=;
        b=jraek21ZocfnSN2KKIGasOmN8gKjHqXSUz8NcmyELSBiCWmxen4F2EqzsD08jEgVcH
         ZtpsK6DVh9mUUeXjmlpJ42VgRm27yJpsZm+zDOYqN9e41mFolyVSokRrXcR2abrA8p9M
         i+F9IKBVgWsdapAaQQocLaj5ArZPZU5xQiEtITwD8F7bhTB5kWDP9mexfzDA1Imu/Yq4
         FpAElabcEz306VyQQylkSKk7oKwjRDDZjlFgZAJvGLioBH+UabAx8w4o9TEJ+gLOhW0j
         4Hyz+zrGHUxTLuo3oBDtciZyvmnVNhZUK1lnCexJqPw/cMiO0JJoGj9uwQ0/8t+Euoqg
         A8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rPHgMoeBIfRXBLmmqXq8TEde2WOOk6YMN7EVwcUy60=;
        b=TmmknVtJzavdMPe01hahkGSl/BEM9ikoHhI9UDLLuMGTSF3cUeUz3mDnztJq0X6pLX
         DhcNqSpBH6/siuUBK93TEBXwbhv7OOc29aHmv9G+HmDfb+YbH38AbKlun6f76ZOjaw84
         hWg1M8UBFnoM3O/yowtvTVjeo8unlE2CMBfTaCwQLOLcwwGGHVb37Nfn3TLVzj26mc8k
         wR4x2daAABMS/Otm3tPwvy9HJIcoBpZ/esXKfDeJTjBxWUOLY0mCatXWiUw/FgIdJ9Yh
         EHITxa+zG+fcIQ2gJzoQKAEdiFjoWqFdglXYoD/FHkXLiL/weEnTkr3d+9yq5KvkDfR2
         /8Tw==
X-Gm-Message-State: ANoB5plH9Uin3yqP67HR4VtC/jGzcdhUPXQmE90kTzN+4Z7nF0Xpm9aM
        RqbV8EqHFk4tHN14ydp6ZC0c
X-Google-Smtp-Source: AA0mqf6rUjKuiCOVlt+yrgJUR5Kc/Kug2qkXh0mr42woayKeSiYzvFqGdvDjKpJ7M1KI3ty5P0PH3w==
X-Received: by 2002:a17:90b:2809:b0:212:e8da:fc3f with SMTP id qb9-20020a17090b280900b00212e8dafc3fmr8269891pjb.189.1668688022120;
        Thu, 17 Nov 2022 04:27:02 -0800 (PST)
Received: from thinkpad ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id i9-20020a635409000000b00476d1385265sm889905pgb.25.2022.11.17.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:27:01 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:56:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>, andersson@kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: iio: qcom: adc7-pm8350: Allow
 specifying SID for channels
Message-ID: <20221117122654.GH93179@thinkpad>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
 <20221103095810.64606-2-manivannan.sadhasivam@linaro.org>
 <b97f6cd7-6d4a-f0d6-7aea-bab16de96621@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b97f6cd7-6d4a-f0d6-7aea-bab16de96621@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:14:00PM +0100, Krzysztof Kozlowski wrote:
> On 03/11/2022 10:57, Manivannan Sadhasivam wrote:
> > As per the new ADC7 architecture used by the Qualcomm PMICs, each PMIC
> > has the static Slave ID (SID) assigned by default. The primary PMIC
> > PMK8350 is responsible for collecting the temperature/voltage data from
> > the slave PMICs and exposing them via it's registers.
> > 
> > For getting the measurements from the slave PMICs, PMK8350 uses the
> > channel ID encoded with the SID of the relevant PMIC. So far, the
> > dt-binding for the slave PMIC PM8350 assumed that there will be only
> > one PM8350 in a system. So it harcoded SID 1 with channel IDs.
> > 
> > But this got changed in platforms such as Lenovo X13s where there are a
> > couple of PM8350 PMICs available. So to address multiple PM8350s, change
> > the binding to accept the SID specified by the user and use it for
> > encoding the channel ID.
> > 
> > It should be noted that, even though the SID is static it is not
> > globally unique. Only the primary PMIC has the unique SID id 0.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> This was never sent to IIO maintainers, so now next is failing.
> 

I missed it since there was only one bindings patch and rest all were dts :/

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 

The problem was that I didn't rebase my patches on top of linux-next/Bjorn's
for-next at that time but used v6.1-rcX. So I did not see the example in
spmi-vadc.

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
