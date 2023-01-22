Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE26E676D63
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAVOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:05:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8441E9F9;
        Sun, 22 Jan 2023 06:05:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l8so7212582wms.3;
        Sun, 22 Jan 2023 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w+DYwuFS9Dkc93QjhUhcqFaLx7ImoBj+LjvTnSTbnm8=;
        b=DcYu8g70+C7PZXA3VZnn6MsW7kkyGrHhUlHUT+xknVAJQ+nUsllEzfqQT1wAbAh1Ic
         OAul5mZ1m1T9UxlxWCXVmtqTE7L4e6Kx2Xv9/kDBSQ2BzWmnMm3hXANtWxJSYWGDgFLz
         f9fmbfVJ15OV3cwdg+58uUypMjS+6kTuPkcNOZWqCATbBYpVPZ51FbvRVTJrBMjam96P
         dH+GrEaYoot27weeWuXToMMvoC5xYUxBKf+tLs+8QcoOGTwdjGmg2WZAY0kY7VOUU34F
         DGw14uuvDUHv66Ra2T/goSg3FOgF1beQGH0rifmrQlWYwdue1a8uB2nvLz5Il5xvq5Rl
         vjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+DYwuFS9Dkc93QjhUhcqFaLx7ImoBj+LjvTnSTbnm8=;
        b=pYEldFa6EG4BvkuJaRoxejOqdZWbr2RUopAtRpdlouV0l4dUqdEd4IhpmkO3KVnWIo
         vEFlfSoY1mPlP7KFTPLZEQ6tMLT0FjrryByat+VR1sBKTxlKJnb2YGDn6vyq9t/sZ/tC
         jd2WI3JJHXSrvDS+n+aAu4Bfs/4faa3z6Abs+Zz6fwQh+P3VhnNyEJmM6VueiGNeFcYn
         uB5NFL5EFDSFzjuNVJcyRJdi6V2cv1ehulplypLxQYvllmC9y36g8bJIB7S3GPAYIr1C
         UCVo0n1gEIyoAcfuZyx7BgHL+hjAvtZoRwx633b57zB1s2co1KpnUcTg5/j4qEyGP/ui
         l+uA==
X-Gm-Message-State: AFqh2krpdU4kF95RBCzYB4ee+D6ZV0yXCHqsPrTyghcVwkJEXyg7iHuh
        F0iIb22/1KM0cCM2nRy7P5I=
X-Google-Smtp-Source: AMrXdXv+rSm+lsQYdvS3/yF76MtW37onSPVLBg07nzj60X14FGGRCT3TcMxNGfhPGDbb557hHFDsEg==
X-Received: by 2002:a7b:c4d0:0:b0:3d1:f6b3:2ce3 with SMTP id g16-20020a7bc4d0000000b003d1f6b32ce3mr21583864wmk.35.1674396335807;
        Sun, 22 Jan 2023 06:05:35 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm39347527wru.63.2023.01.22.06.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 06:05:35 -0800 (PST)
Message-ID: <63cd42af.df0a0220.aae7d.51f1@mx.google.com>
X-Google-Original-Message-ID: <Y81CrRr8BqFQSEfV@Ansuel-xps.>
Date:   Sun, 22 Jan 2023 15:05:33 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <43ff6113-03ee-a40a-b454-53cadec8728a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ff6113-03ee-a40a-b454-53cadec8728a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 02:57:07PM +0100, Krzysztof Kozlowski wrote:
> On 21/01/2023 01:01, Christian Marangi wrote:
> > The qcom-cpufreq-nvmem driver also supports legacy devices pre-cpr that
> > doesn't have power-domains. When the schema was introduced, it was
> > wrongly set to always require these binding but this is not the case for
> > legacy device that base everything on nvmem cells and multiple microvolt
> 
> What is a "legacy device"? Why do you adjust bindings to legacy device?
> Can't you just fix the DTS on these devices?
>

With legacy I mean device where cpr (core power reduction) wasn't a
thing and qcom used a different way to select the microvolt for the opp.

There is nothing in the related DTS to fix since they are not broken.
The driver doesn't enforce cpr presence and supports both new and old
implementation...

Setting the cpr as a required binding was wrong from the start. It was
probably done when qcs404 was introduced and they had this bright idea
of creating the schema and ignoring the other kind of configuration the
driver supports.

Since now we want to send opp for ipq8064 that use the old
implementation this fixup is required.

Probably I should drop the legacy term and just say that the driver
supports 2 different configuration and the following schema permits only
one?

> > binding providing values based on speedbin, psv and version.
> > 
> > Make the power-domain optional and set them required only for qcs404
> > based devices.
> > 
> > Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 78 +++++++++++++------
> >  1 file changed, 54 insertions(+), 24 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > index 9c086eac6ca7..04aac634d7fc 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > +++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > @@ -17,6 +17,9 @@ description: |
> >    on the CPU OPP in use. The CPUFreq driver sets the CPR power domain level
> >    according to the required OPPs defined in the CPU OPP tables.
> >  
> > +  For old implementation efuses are parsed to select the correct opp table and
> > +  voltage and CPR is not supported/used.
> > +
> >  select:
> >    properties:
> >      compatible:
> > @@ -33,37 +36,64 @@ select:
> >    required:
> >      - compatible
> >  
> > -properties:
> > -  cpus:
> > -    type: object
> > +if:
> 
> Missing allOf. Fix also the placement - this block goes before
> additionalPropertes:false.
> 

Thanks for the review! Will fix in v2.

> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - qcom,qcs404
> >  
> > -    patternProperties:
> > -      '^cpu@[0-9a-f]+$':
> > -        type: object
> > +then:
> > +  properties:
> > +    cpus:
> > +      type: object
> >  
> > -        properties:
> > -          power-domains:
> 
> Best regards,
> Krzysztof
> 

-- 
	Ansuel
