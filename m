Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4D6B005E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHIAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCHIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:00:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AB10244
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:00:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kb15so15812520pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678262430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJctsTMSbAff9LHQoujSIdcWG8rrHRROdtWNIfdasOE=;
        b=aLPQ2SJOdWerlloRXkwFX7S53tuyV7yfLO3MjQ9Xln+wVjY1KRdEqBFTNAeQJNsJk1
         3aHj+8eZCX/7npblwQUjL1bCnnzF+N3DfN2pkia1gW3vsHvXErpin5RNr5+c1amyBaT5
         Bz8JqtkWEviAkkFuT/00PQtBVxKLnmWKJqEgSZvnPBrs7Aq01yXjhWFTC+qTl8MDyn5c
         nfeL9pdNJVT6lWWezZ5q8Oh7TtUwLpdFbovbs8exWvsZTYBu2LqpjmtXP+m4DRFILYY6
         +rUnuZUhusL5gGTuOI4gKxBniAeuPyuKu39MDGMcQ/wNz1YLstzT1I/1fxgC56pjziWK
         bEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJctsTMSbAff9LHQoujSIdcWG8rrHRROdtWNIfdasOE=;
        b=yql2OwmMjQoz34vVwbnn0FMy6cn5HM7i9G1sM3RFa8q8HPrRbYtfey/nrajL9C8qGs
         HR1av1a38gg6fsRE7TILa/hydNE6uaYhGS1cEAI4reMLaXbwYt63+VxTTzCDVOUMRqOd
         omVl4/7aGYzfgbY50BVH2XAeFb5vZCDRXgRb8iTd+EXffcYimGFyX3/x6SQ7amQwvLfv
         /xmpwjMHjDuT+gXiBS8JuQ1C94xWPgVhS6oNjB4xtgtuNi8DfH2wSkDJ1TjMRKNOLkTm
         xGFsizdx8l4g3qr4JUn3/JxNwNTydlSwJh3SASJ5FEO1P9Z4w9EPcJ3UBwV+bgSIHLzF
         TxGA==
X-Gm-Message-State: AO0yUKWhy2HbJa29ldFVyASxVqef/AS+F95s8NCVwyNaE70I0XLVOEx0
        zKKNsAvtgQ2VQbuA3D2icT7a
X-Google-Smtp-Source: AK7set/5vFSwxsJD6OsCxklmEx/lSyPeqrb8QmZwXd7ypBS7coinZdPBKKUTNU/Y6ak8ht/ZDJvRmQ==
X-Received: by 2002:a17:902:ec84:b0:19c:c87b:4740 with SMTP id x4-20020a170902ec8400b0019cc87b4740mr20459711plg.34.1678262429975;
        Wed, 08 Mar 2023 00:00:29 -0800 (PST)
Received: from thinkpad ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b00196807b5189sm9339879plb.292.2023.03.08.00.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:00:29 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:30:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <Robin.Murphy@arm.com>, andersson@kernel.org,
        lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: PCI: qcom: Add iommu properties
Message-ID: <20230308080022.GA134293@thinkpad>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-3-manivannan.sadhasivam@linaro.org>
 <20230227195535.GA749409-robh@kernel.org>
 <20230228082021.GB4839@thinkpad>
 <CAL_JsqJXb1junhU+56ZcqHzAq8g0VN8BzQ2A1C9rB80pZDWJ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJXb1junhU+56ZcqHzAq8g0VN8BzQ2A1C9rB80pZDWJ-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 08:58:51AM -0600, Rob Herring wrote:
> +Robin
> 
> On Tue, Feb 28, 2023 at 2:20 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Feb 27, 2023 at 01:55:35PM -0600, Rob Herring wrote:
> > > On Fri, Feb 24, 2023 at 04:28:55PM +0530, Manivannan Sadhasivam wrote:
> > > > Most of the PCIe controllers require iommu support to function properly.
> > > > So let's add them to the binding.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > index a3639920fcbb..f48d0792aa57 100644
> > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > @@ -64,6 +64,11 @@ properties:
> > > >
> > > >    dma-coherent: true
> > > >
> > > > +  iommus:
> > > > +    maxItems: 1
> > > > +
> > > > +  iommu-map: true
> > > > +
> > >
> > > I think both properties together doesn't make sense unless the PCI host
> > > itself does DMA in addition to PCI bus devices doing DMA.
> > >
> >
> > How? With "iommus", we specify the SMR mask along with the starting SID and with
> > iommu-map, the individual SID<->BDF mapping is specified. This has nothing to
> > do with host DMA capabilities.
> 
> I spoke with Robin offline and he agrees that having both is broken at
> least in RC mode. He pointed out the issue is similar to this one on
> Tegra[1].
> 

Looked into that thread and concluded that "iommus" property should go away.
Submitted a patch [1] to remove that property from PCIe nodes of all Qualcomm
SoCs.

Thanks for pointing out! Will update this bindings patch in next revision.

- Mani

[1] https://lore.kernel.org/linux-arm-msm/20230308075648.134119-1-manivannan.sadhasivam@linaro.org/

> Rob
> 
> [1] https://lore.kernel.org/all/AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM/

-- 
மணிவண்ணன் சதாசிவம்
