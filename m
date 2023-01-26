Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156A67CE06
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjAZO0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjAZO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:26:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D911679;
        Thu, 26 Jan 2023 06:26:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1229219wms.2;
        Thu, 26 Jan 2023 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N/zj2NLkkvJCQd5BlKbuQt5xCuylxPf8hWYFMpsNH/U=;
        b=c8FRZoMJJeocgRwS8FAGK4sX7GEVF9IBTBhSvPWd92cn+m2v7UwZziWihnNMYYjjiu
         Rsq74S5Q1VDl9q800DxtDjI3vbDJz/ojQYWhKp9i8/8Tx3nbpBtMe3U43liHXA7YcAfc
         uBTnz/ko4LD96ixfdEoDzmhE+2uQmwdxODre39fsHmM4wVwteN7gvzpQvvXnKBq5g2nb
         EkH6N96NGQIHqanJV3B7gZclLcWt3M0e3nO+2n8GN+CrwjVgkEAdjHzklT4PJxMaTuoX
         pPzpRDATJloPiVzisKYcXtd+Ea8NtccBQmt2+LO9KvKLMJUpbQk77PubvwjMAhz0encT
         2MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/zj2NLkkvJCQd5BlKbuQt5xCuylxPf8hWYFMpsNH/U=;
        b=1SQRW0qgRFW3UEfZBWS46CcJNCNYXw2AoV9RilZmk220wqDbQXmvrn01mt4vbOUL3E
         VZ1aI33nvUfkyAgFDnDPxMVp6M1CejX32VYWNW5QmFDdUE6U1n70oGtT210U2BYjOEBX
         op3l91kmH4UztjN9oIYZSU+/DVv7u4ktwP5Z8gb0tpNXqbTGDgYOps/nY32Oohnxd0J0
         auylb9mEBLaqTlMrUhfbjfp8X408aVk7ESKgNRD8qdlkvaDGnnNyum1avftD94l+pOBg
         ph9AZPMsPc4XZodjRFfqwJ6cDo8itwC32eFhcEVpvNGGJqeqofCzglCFO6Ctt+wLCMpu
         DtTQ==
X-Gm-Message-State: AFqh2kpw9EhqoXiM/irl9JmVWQ9zchjFm4yThIupeSm+WJTpPdyjqPJD
        7ty3l/snKhOu4KhT0eYBYtU=
X-Google-Smtp-Source: AMrXdXtGExADdDcIuqfZhNrDNq/eJH+XrzYdkLshuY6/JHCgSreV5P5gPtfJiG8Ht8ynnEUDLfKAvg==
X-Received: by 2002:a05:600c:4e93:b0:3db:d3f:a91f with SMTP id f19-20020a05600c4e9300b003db0d3fa91fmr33815447wmq.23.1674743131157;
        Thu, 26 Jan 2023 06:25:31 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db2dede1a2sm5357982wms.26.2023.01.26.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:25:30 -0800 (PST)
Message-ID: <63d28d5a.050a0220.7afab.f613@mx.google.com>
X-Google-Original-Message-ID: <Y9KNWZav9rN/2AuJ@Ansuel-xps.>
Date:   Thu, 26 Jan 2023 15:25:29 +0100
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
Subject: Re: [PATCH v3 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make
 cpr bindings optional
References: <20230123193422.15972-1-ansuelsmth@gmail.com>
 <102e76fd-50bc-9403-b03f-f96a3d3869bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102e76fd-50bc-9403-b03f-f96a3d3869bd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:17:56PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2023 20:34, Christian Marangi wrote:
> > The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> > - pre-cpr that doesn't have power-domains and base everything on nvmem
> >   cells and multiple named microvolt bindings
> > - cpr-based that require power-domain in the cpu nodes and use various
> >   source to decide the correct voltage and freq
> > 
> > When the schema was introduced, it was wrongly set to always require these
> > binding but this is not the case for pre-cpr devices.
> > 
> > Make the power-domain optional and set them required only for qcs404
> > based devices.
> > 
> > While at it also make more clear what the opp-table supports by adding
> > ref to the opp-v2-kryo-cpu and opp-v2-qcom-level schema.
> > 
> > Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > 
> > Changes v2:
> > - Reword commit description
> > - Fix condition order
> > - Add allOf
> > 
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 81 +++++++++++++------
> >  1 file changed, 56 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > index 9c086eac6ca7..6f5e7904181f 100644
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
> > @@ -33,37 +36,65 @@ select:
> >    required:
> >      - compatible
> >  
> > -properties:
> > -  cpus:
> > -    type: object
> > -
> > -    patternProperties:
> > -      '^cpu@[0-9a-f]+$':
> > -        type: object
> > -
> > -        properties:
> > -          power-domains:
> > -            maxItems: 1
> > -
> > -          power-domain-names:
> > -            items:
> > -              - const: cpr
> > -
> > -        required:
> > -          - power-domains
> > -          - power-domain-names
> > -
> >  patternProperties:
> >    '^opp-table(-[a-z0-9]+)?$':
> > -    if:
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              const: operating-points-v2-kryo-cpu
> > +        then:
> > +          $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
> > +
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              const: operating-points-v2-qcom-level
> > +        then:
> > +          $ref: /schemas/opp/opp-v2-qcom-level.yaml#
> 
> This entire part looks independent, please split it into separate patch
> with its own explanation. What I still miss here - why do you remove
> "required-opps" from required properties. It's not clear to me at all.
> 

Hi, the required-opps needs to be part of this patch since they are only
needed for genpd based devices.

I will split the additional if parts in another patch since they are not
related.

-- 
	Ansuel
