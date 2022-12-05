Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506206428E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiLENBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLENA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:00:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE311B9FF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:00:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6107422pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxnV3Qp0Y7lPeJMlAC3B0qrclK4fA9O7m2KwNM9QZuo=;
        b=JSWTno9Ovpi4N2n7SJLNvOb921h7NEAgoxBTP99nODbDxre5VKCW/RolX8wEH1ew1N
         d3gwaS208r0SX3gBiOGTwfNxXY1ExcIz/wKYK0y0XIhx9QwhVnl9qU02TaEdu0FWJWw3
         yn6KeodIQiqYlsDj+/oHDkTEnFfOpoFGTGYwPjrpkN108il9qnbshVF7CxcgOVn/30aB
         0haTYo7TNYWsiwxQJtmKLnVlBkY3h0ZA1pIVVQiL9NNt7dpOlROTVU6+soQyDvNq/X/W
         FZTK5W7dOCCiINcjP7JoYPaywAs2sCkuYnkzKpxn4FlTl59W26EKlfLE6tNPtuLAQvw4
         xIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxnV3Qp0Y7lPeJMlAC3B0qrclK4fA9O7m2KwNM9QZuo=;
        b=hRtSmsUaJBtuin4UUpIF19unuAN7DT7xabUAcoULOjqnPVp6kL8NncwKJwdTfP1eIP
         ENb6QRqf+IJ6pPmWjieXhTTKT/02IZd+vF+5gUZPa4VaEHVdXXmruBeKHXej81caQv3r
         F5iktp2Y5ZhF2SzaT5JXGPrzHAyTTT7RuFlkq69misp9M0fr2TTcwPVtptPdgM6s1/pa
         TyCgzteyc7ksKerFmEsrRydZEr7JfRmn3N9kilp175mgVd1n1Dfnn3NREw33Kb4naQuh
         iN5iArZb2ZitVukDu3S9vnUlnVd2tM9IuIMoKu0pl3lxECDjVyVO+gtcowJ8e9Dzuhfd
         A7VA==
X-Gm-Message-State: ANoB5pn9vF3s0OrQrDUplvXCLhcCM8GcI3qAfKvXyPTR3Wdo+q6u0DEL
        UJIKxmZIrz2aRePwMMsRjCRa
X-Google-Smtp-Source: AA0mqf4QKmXyJpi9rKCFIjNDVyx44KTwNxyz7CRQu216au3lnsFPqelqBDhkXgelGv8HfIOBkVWeMg==
X-Received: by 2002:a17:90a:4889:b0:20d:d531:97cc with SMTP id b9-20020a17090a488900b0020dd53197ccmr90688319pjh.164.1670245256899;
        Mon, 05 Dec 2022 05:00:56 -0800 (PST)
Received: from thinkpad ([59.92.98.136])
        by smtp.gmail.com with ESMTPSA id s25-20020aa78bd9000000b00576d4c45a22sm2785404pfd.147.2022.12.05.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:00:55 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:30:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
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
Message-ID: <20221205130048.GD20192@thinkpad>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
 <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
> On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> > > On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > > > > UFS controllers may be cache coherent and must be marked as such in the
> > > > > devicetree to avoid data corruption.
> > > > > 
> > > > > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > > > > 
> > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > > index f2d6298d926c..1f1d286749c0 100644
> > > > > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > > @@ -44,6 +44,8 @@ properties:
> > > > >      minItems: 8
> > > > >      maxItems: 11
> > > > >  
> > > > > +  dma-coherent: true
> > > > > +
> > > > 
> > > > This property is not applicable to all SoCs. So setting true here will make it
> > > > valid for all.
> > > 
> > > Yes, it would be a valid, but it will only be added to the DTs of SoCs
> > > that actually require it. No need to re-encode the dtsi in the binding.
> > > 
> > 
> > But if you make a property valid in the binding then it implies that anyone
> > could add it to DTS which is wrong. You should make this property valid for
> > SoCs that actually support it.
> 
> No, it's not wrong.
> 
> Note that the binding only requires 'compatible' and 'regs', all other
> properties are optional, and you could, for example, add a
> 'reset' property to a node for a device which does not have a reset
> without the DT validation failing.
> 

Then what is the point of devicetree validation using bindings?

There is also a comment from Krzysztof: https://lkml.org/lkml/2022/11/24/390

Thanks,
Mani

> It's the devicetree which is supposed to describe hardware, you don't
> have to encode it also in the binding.
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
