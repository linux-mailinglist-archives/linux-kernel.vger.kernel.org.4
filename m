Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47606498BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 06:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLLFzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 00:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLLFzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 00:55:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69ECE04
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 21:55:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl24so10983932plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrhqU0YeLI505f3HkmmLlBSRikE7SJQhGguGbIbcneY=;
        b=SQ5GHKCNaAwPBZIU08JKNhKj4YVRK/AsGdPoYyXjIimFTZ6XfHHKeT6Ot01D3Ki/88
         FvYWFQsRD2LfohhTpA/FqyefjNjc3gBLt30bnKpcDOJ8UgEXcF7G4ZQH+n+WQrVWVvfG
         ReqsuZlc3IX+x3gCYFHRzLb1WJVjzmdKgW2/C055Sw9R8j7SZEskTuY/ZZePmTQMRytm
         BSk/aK0fgBeJuLFE0G1fI23ZeZhrBmT8F3T1suy2L47gEkuZ/6bx1alqupExTZEr7cED
         hZH4csy9GdKchL5ZfHaKD21/QCgQw/9WIJwF+Vkml79gg/kYp32o0i3RiTiEI/AN7E5g
         AuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrhqU0YeLI505f3HkmmLlBSRikE7SJQhGguGbIbcneY=;
        b=Oxd8St9aMFttjvKt72ZY1H5Q5VMH/gBhBGsLqN5zdoQagthY7IVYmFU08EL5nieso2
         DPvBzE7v6X2QBww5mcUFS62puvf+Z32l/THESWqzDub6Wv+A+UiQYKWKkfp7EJqf6l6y
         i0FwTkyb6Q1qzpoLHRGfNkG/fNNBDevEw/k/PR0dMQLz/eAN9GyZDeGSsuFRu3rbm9gn
         WTE3v5sKXHPmNU9dwc6U0pJL9R1yLTViBjLDeihUrrFGAPKq+3OHEAqdBRE8MzTBFzAF
         BtFcbmUHGABNcC3vXm5H0qABurinWeRYOTM5R+aIynzoXkk5n3dsXqhPmlMgidrPbvLQ
         CzWA==
X-Gm-Message-State: ANoB5pkNUoKqWSvYKRZzMZTQA2dXOM57TTWwb/2y4WuE9NKdMWCKt8hK
        CagImYpkoDifLZwP8bgM3mXS
X-Google-Smtp-Source: AA0mqf7yJuIGPGBSOjf/2toXY87/kNjjjBafuyDhCulX9TELztvYqu+Lr6tUs46bV63pUwkzms/MDA==
X-Received: by 2002:a17:90a:c791:b0:216:ed9:cadc with SMTP id gn17-20020a17090ac79100b002160ed9cadcmr14653355pjb.21.1670824504614;
        Sun, 11 Dec 2022 21:55:04 -0800 (PST)
Received: from thinkpad ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a1f0600b0020647f279fbsm4566248pja.29.2022.12.11.21.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 21:55:03 -0800 (PST)
Date:   Mon, 12 Dec 2022 11:24:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com
Subject: Re: [PATCH 01/12] dt-bindings: arm: msm: Update the maintainers for
 LLCC
Message-ID: <20221212055456.GB20655@thinkpad>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
 <20221207135922.314827-2-manivannan.sadhasivam@linaro.org>
 <5b731ae4-ae5f-af2a-3357-e5e33612a977@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b731ae4-ae5f-af2a-3357-e5e33612a977@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Thu, Dec 08, 2022 at 08:45:48AM +0530, Sai Prakash Ranjan wrote:
> Hi Mani,
> 
> On 12/7/2022 7:29 PM, Manivannan Sadhasivam wrote:
> > Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
> > maintaining with a new identity. So his entry needs to be removed.
> > 
> > Also, Sai Prakash Ranjan's email address should be updated to use
> > quicinc domain.
> > 
> > Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > index 38efcad56dbd..d1df49ffcc1b 100644
> > --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > @@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   title: Last Level Cache Controller
> >   maintainers:
> > -  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > -  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > +  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> 
> Thanks for updating, I believe you can add yourself as well now since
> you maintain LLCC driver.
> 

I only maintain the EDAC driver, so I'll leave llcc to you :)

> Either way,
> 
> Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> 

Thanks,
Mani

> 
> Thanks,
> Sai
> 

-- 
மணிவண்ணன் சதாசிவம்
