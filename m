Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0867D9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAZXnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjAZXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:43:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81849011;
        Thu, 26 Jan 2023 15:43:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so2297193wmc.1;
        Thu, 26 Jan 2023 15:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EONYoIxZjQ2TsLY9+i04B1myHyhVfZp+OAShfITEebg=;
        b=SLrvUsVpk/8wYUgiDh8+8xfwGmz+PuigYX0XGJ3C5LG+5NbRY/OXV/A6mn564EVVWr
         BQn9m+lYalUK1Q/5CgoF+1gaepal+ISvm8jC/nnFTd2IMRiOPpEABSB3DP6jiVGrfYMq
         m3HUmyaNxZ+pn9PcLCBe5/tuoAvL43QoBcwEWnKGE3x0l910TQ68G9gK1h59BCWoFMOq
         963XbYi1uNEGrX4o590PbXMZm7tNi4mCN5K9t0hC7vy14Ks392Fubx8caokp8rSLhRyy
         XNcxBGlPcViMPb29sbANp1+k1uhz0wty+vTiBFcyrEGEKogiuf+G1E8FiT5OS2ZLy3G3
         wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EONYoIxZjQ2TsLY9+i04B1myHyhVfZp+OAShfITEebg=;
        b=K5WekQr3N9/X0W6KfCY2TXF6zdHgvletcZheKJXpP7DAeH613ZT+bk43KycUuUbUim
         sJm96Ck58eDSlTgZc9nrHKzWTQwiqNTZWJn/W5OZb9Iqtp8JyvUIKLC3QxH/CkGVMpUf
         Fh25IQaaVdPXQ3ujFVTdBgjRBElgnIKhlCxD2kmGM6mry83Rv5YBNUjdw9SryBrcch7G
         0raq58vGv6FMRK6LoPd7WG3IBLdYtZTt6GzvHhjEPuYBn1ksFwwUTgjbDPSELo4L9BDb
         ENYc1Gn+Pzje7GK0QcSGBMM9KzsTJvy00SMV84CmcwI31ePPsWizDv64WN9P8RtEq4DC
         EU9Q==
X-Gm-Message-State: AFqh2kqTO9H0Ta7LV27fdBry/9Ti6SEiPPNI2dLuCOIMx2qObnRx/0i1
        +gvvCVfLGJ/85/WL4UaOwEM=
X-Google-Smtp-Source: AMrXdXtClFX3qNEKpixctJRKjnKhz717i7YBO0EMNuKGjh+4T+5edcCNG6tl549AQ9+f/vxqSfgo8g==
X-Received: by 2002:a05:600c:1609:b0:3db:12a:5e65 with SMTP id m9-20020a05600c160900b003db012a5e65mr36540049wmn.4.1674776599385;
        Thu, 26 Jan 2023 15:43:19 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d99469ece1sm6183454wmb.24.2023.01.26.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:43:18 -0800 (PST)
Message-ID: <63d31016.050a0220.a8e15.261d@mx.google.com>
X-Google-Original-Message-ID: <Y9Lz6X9qKT4HICIV@Ansuel-xps.>
Date:   Thu, 26 Jan 2023 22:43:05 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make
 cpr bindings optional
References: <20230126150026.14590-1-ansuelsmth@gmail.com>
 <167475624070.2087166.4816561741085643801.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167475624070.2087166.4816561741085643801.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:05:46PM -0600, Rob Herring wrote:
> 
> On Thu, 26 Jan 2023 16:00:24 +0100, Christian Marangi wrote:
> > The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> > - pre-cpr that doesn't have power-domains and base everything on nvmem
> >   cells and multiple named microvolt bindings.
> >   Doesn't need required-opp binding in the opp nodes as they are only
> >   used for genpd based devices.
> > - cpr-based that require power-domain in the cpu nodes and use various
> >   source to decide the correct voltage and freq
> >   Require required-opp binding since they need to be linked to the
> >   related opp-level.
> > 
> > When the schema was introduced, it was wrongly set to always require these
> > binding but this is not the case for pre-cpr devices.
> > 
> > Make the power-domain and the required-opp optional and set them required
> > only for qcs404 based devices.
> > 
> > Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v4:
> > - Explain why required-opp needs to be conditional
> > - Split additional ref part
> > Changesv3:
> > - No change
> > Changes v2:
> > - Reword commit description
> > - Fix condition order
> > - Add allOf
> > 
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 62 +++++++++++--------
> >  1 file changed, 37 insertions(+), 25 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml: 'anyOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 	'properties' is a required property
> 	'patternProperties' is a required property
> 	hint: 'additionalProperties' depends on 'properties' or 'patternProperties'
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml: 'anyOf' conditional failed, one must be fixed:
> 	'properties' is a required property
> 	'patternProperties' is a required property
> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230126150026.14590-1-ansuelsmth@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

Hi, Rob, was aware of this error but it was expected from the split of
patches. (since i made each part of the patch conditional the check
complain for no binding defined)

If we really want I can send v5 that should fix this bisect problem by
swapping patch 1 with patch 2 and rebasing.

I already have that ready and fix this bisect error.

-- 
	Ansuel
