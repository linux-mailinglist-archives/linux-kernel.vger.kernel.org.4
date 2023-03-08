Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB486B0188
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCHIdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCHIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:33:23 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8D769D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:32:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h8so16938584plf.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lhBS/GUQEu7brmFZVBeAPHuw6pR39+tLz9WlYYkonsg=;
        b=FFCYlZLWNk1tYhnWdI1asgnU3M6yS5PPE4rPDJXhrzfBuU+KoHgSa31Yn+jxOeXDLJ
         by/DWkvej+yXc8UIry1KR9G1Qhw2/BaDX2LdEwtBM52l6v75l20CpsKI+WF72o780Tn6
         XJCWxMWYb+14lHarQt6nafFkdN3XAbJiVLLw1QHXG1MNcwn2uYL79b++J8znXOU2w4QR
         4lm6pX/fahlRT3KkYjP66KOzQBeLUIQ4+cQ0hIbdVXmm8EKDwLV5zUYjQOPjyIDF3y3x
         nfzYDr/2WbQnpOUqLlL+nxSX4wbiveL8zDk2WuvVpBIHfN0Nfrgb6SW3XeOmH70Inm5l
         ztAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhBS/GUQEu7brmFZVBeAPHuw6pR39+tLz9WlYYkonsg=;
        b=I6RALX+cLz33TdXBUzIxDSUG3MnH66Is7P055m/0aoBIvTxEvzXtpncdhvUUBkwez0
         DABSp1FyL2mWHJUT4JYG7ZPVSlZR4ipXfB8x1HktVXTdS1hRwhfBQugDdaAy/ISzCJ16
         JhRIlW54SDwjaASTs0zXSidn/ZqXr8FxCzzAFTGZp8+HvSoDx0PaoTRGW6o3xgh07aM3
         DjXz9Ck6U+pD44QoXd7z4eGmiNqu25/6fn9QgQnc8uBnh2RkUjqyz2l4RDMp+Pj2OPlL
         wRCRGVrDDfW+KEcXzmszlZzQKVbf/HuUgKWrDl2D5p/x4Uk0xUcZ/UMwdVBDpdILGVh7
         rtag==
X-Gm-Message-State: AO0yUKUzYhtITHoM0KWTwD9Tdzf4jIs99giV1OkJ+eZf/xDcLW3Iam6p
        3nepPZbL/GxIeRVgkP3bDO90
X-Google-Smtp-Source: AK7set8lRf3e0uXznToqMnifihWGQOGFFAZS+CsEZcNvnhTkQJAw5YaxNvU4HUq/ffTXZpAo2z0AFg==
X-Received: by 2002:a17:902:a512:b0:19d:1474:2ba4 with SMTP id s18-20020a170902a51200b0019d14742ba4mr15263285plq.32.1678264370555;
        Wed, 08 Mar 2023 00:32:50 -0800 (PST)
Received: from thinkpad ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902f78f00b001948ff5cc32sm9414443pln.215.2023.03.08.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:32:50 -0800 (PST)
Date:   Wed, 8 Mar 2023 14:02:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 15/19] dt-bindings: PCI: qcom: Add "mhi" register region
 to supported SoCs
Message-ID: <20230308083244.GE134293@thinkpad>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
 <ZAYZqH2/vB7r9L4L@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAYZqH2/vB7r9L4L@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:49:44PM +0100, Johan Hovold wrote:
> On Mon, Mar 06, 2023 at 09:02:18PM +0530, Manivannan Sadhasivam wrote:
> > "mhi" register region contains the MHI registers that could be used by
> > the PCIe controller drivers to get debug information like PCIe link
> > transition counts on newer SoCs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index fb32c43dd12d..2de6e7154025 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -44,11 +44,11 @@ properties:
> >  
> >    reg:
> >      minItems: 4
> > -    maxItems: 5
> > +    maxItems: 6
> >  
> >    reg-names:
> >      minItems: 4
> > -    maxItems: 5
> > +    maxItems: 6
> >  
> >    interrupts:
> >      minItems: 1
> > @@ -185,10 +185,12 @@ allOf:
> >        properties:
> >          reg:
> >            minItems: 4
> > -          maxItems: 4
> > +          maxItems: 5
> >          reg-names:
> > +          minItems: 4
> >            items:
> >              - const: parf # Qualcomm specific registers
> > +            - const: mhi # MHI registers
> 
> You need to add the new (optional) registers at the end.
> 

Will do it in next revision.

Thanks,
Mani

> >              - const: dbi # DesignWare PCIe registers
> >              - const: elbi # External local bus interface registers
> >              - const: config # PCIe configuration space
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
