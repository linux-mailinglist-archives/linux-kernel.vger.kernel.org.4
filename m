Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A30643833
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLEWf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLEWf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:35:27 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E51B1F8;
        Mon,  5 Dec 2022 14:35:24 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id s187so8575877oie.10;
        Mon, 05 Dec 2022 14:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W1G20otxMeQHW8Ut4O5w5jmPAPjBh0af0PsBmDHz9Q=;
        b=OHOc/W+1TXK8CRdlT/dPgRw4vXQ+7EkvDgG8oARWCR7Jl65wnpr97OmbrT7BbkENbK
         qSjXMj/Kza/xp/qJ+MK1DgrfOlrlAj16GKAxCPK8ODKCiJ+TEp2kyZwRXi6nbdUs9v5g
         vGK98zzY0ADVyWu30SCFejUs/6g9CAMBRFdFjM+wrcLF5sQO37nS3HPojv1jv2YpSiSj
         dYyzsSsqsHJ4OeKDv+Avx374zpvBQRyR9gjUZWLzCMn+xI55S+y0QstOSuoqFgD7UUJ0
         JfcT94jr63noX3mpdVKzih+oKi5EIQc1Fock3cA05aDzolpERXXfuYAkzrIEw/9HtxzY
         khpA==
X-Gm-Message-State: ANoB5pkIVdXr1NFij2uUyRlcoV0YXcdPCjTCpp07UWqWNlFN7EFRf2Rs
        l1v0JuBQTIBNEg90ziEVTw==
X-Google-Smtp-Source: AA0mqf6VANANHiIfRl2TTTHYXCKn0jXF/j3LWqJQvvcyn54OjkuaJaSgBCITmwxxrJbck6Stvvy/lw==
X-Received: by 2002:a05:6808:193:b0:35b:c0ea:b59b with SMTP id w19-20020a056808019300b0035bc0eab59bmr15619913oic.32.1670279723732;
        Mon, 05 Dec 2022 14:35:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s5-20020a05683004c500b0066d2fc495a4sm8359691otd.48.2022.12.05.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:35:23 -0800 (PST)
Received: (nullmailer pid 2811802 invoked by uid 1000);
        Mon, 05 Dec 2022 22:35:22 -0000
Date:   Mon, 5 Dec 2022 16:35:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <20221205223522.GA2799349-robh@kernel.org>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
 <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
 <20221205130048.GD20192@thinkpad>
 <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:12:48PM +0100, Johan Hovold wrote:
> On Mon, Dec 05, 2022 at 06:30:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
> > > On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> > > > > On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > > > > > > UFS controllers may be cache coherent and must be marked as such in the
> > > > > > > devicetree to avoid data corruption.

Typically, you'd only be doing unnecessary cache flushes without it 
rather than getting data corruption. However, it is possible this 
property triggers other system setup or something that would cause 
problems if not setup right.

> > > > > > > 
> > > > > > > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > > > > > > 
> > > > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> > > > > Yes, it would be a valid, but it will only be added to the DTs of SoCs
> > > > > that actually require it. No need to re-encode the dtsi in the binding.
> > > > > 
> > > > 
> > > > But if you make a property valid in the binding then it implies that anyone
> > > > could add it to DTS which is wrong. You should make this property valid for
> > > > SoCs that actually support it.
> > > 
> > > No, it's not wrong.
> > > 
> > > Note that the binding only requires 'compatible' and 'regs', all other
> > > properties are optional, and you could, for example, add a
> > > 'reset' property to a node for a device which does not have a reset
> > > without the DT validation failing.
> > > 
> > 
> > Then what is the point of devicetree validation using bindings?
> 
> You're still making sure that no properties are added that are not
> documented, number of clocks, names of clocks, etc.

The schema can never be 100%. If it was, then we could practically just 
generate the DT.

IMO, 'dma-coherent' is bit special. I'd say it is valid on any DMA 
capable device node, but there's not any generic way to determine that. 
So it has to be explicit in a device binding.

Rob
