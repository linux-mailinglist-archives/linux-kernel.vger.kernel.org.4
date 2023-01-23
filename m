Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62937677D17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAWNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjAWNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:52:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD171701;
        Mon, 23 Jan 2023 05:52:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8605652wmc.1;
        Mon, 23 Jan 2023 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RGetk4o2HIZFnZgvS9ZE11Taq81btSmlDkDe1JIV5qU=;
        b=Oef8YuiJbfhTXtw7xJQaqgwMOZjOWyLwPTmbQpX71sJEOmqa+JA6/+iHnesgocyrgS
         u518Jr8D7Y3titcvLvxaL7qY5K/wJbsUvOG4+ojXCV1fJJ2EZus5DMnj3Bte0IKJN/p5
         U+H1+pMStGhB/B8hIWsi0NhIycD1h3h/ZaeIOAPcX9twVeGM+plZHYwx0sq15j3PsRzM
         1qfDTU5gsSUgFk5GJvgnxE+AhJYUSvSNoYiF7IEMf4SkoDjK8IIGvKKLc9zpO+RyGosk
         BRxSs1vQjv055rxsbYkIHTbFo9/UdXJnnk6iy6S5cBW9T2Ct02HtLB2MdCoS7fp+49Yc
         AmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGetk4o2HIZFnZgvS9ZE11Taq81btSmlDkDe1JIV5qU=;
        b=Nh8GdbG5sVsp9SmliSh+ktHcYKz7M//V+l+h3epuJW2/RlvopuRW/7KoDKFE8SuYfd
         MCWuOYVzF/g/TiLXhb+8LuucTsiGpiXdIZNggE5wpHoqF/3IcK0oTO/ccIVQafbMSqR3
         1Vi2VASJR3ml4QErXbszHv+DdNe3+nQF6OdjaxBEH26J0jc6srUA2DhP44ixs/oW2R/T
         NXhb4Ef99Hnh+F44kp5vV2MzkbzMT1rVfSWLbF7iwJloAzze2J13C1syG1sDQVQNoIEK
         rml4fuAKpdoDbERdmpjpLlZ6QcjvTO+lmkXPErutK9DB3kYsp1yWDp58s+K4ZVgAP6hm
         n6Ow==
X-Gm-Message-State: AFqh2koThbYA2fLUCk/elYJXnO61bTJ8ajZDMg14hG7OPFZOrol2h9vk
        V/NP4yy8Rx5g0WMS/BumdB3ZLENBHuM=
X-Google-Smtp-Source: AMrXdXuqmiP/Avp46UPqUJBg1HA9qxeoQlzDyN0tzOpaFrbDNRIw6rt038Yb2NCYQm8jZ3UUZWFamQ==
X-Received: by 2002:a05:600c:c10:b0:3da:f5e6:a320 with SMTP id fm16-20020a05600c0c1000b003daf5e6a320mr29155689wmb.22.1674481957323;
        Mon, 23 Jan 2023 05:52:37 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b002366553eca7sm19984340wro.83.2023.01.23.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:52:36 -0800 (PST)
Message-ID: <63ce9124.df0a0220.50217.cc55@mx.google.com>
X-Google-Original-Message-ID: <Y86RIn3OykTHDi5D@Ansuel-xps.>
Date:   Mon, 23 Jan 2023 14:52:34 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make
 cpr bindings optional
References: <20230122174548.13758-1-ansuelsmth@gmail.com>
 <167448145441.1342371.14502432252817277201.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167448145441.1342371.14502432252817277201.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:49:02AM -0600, Rob Herring wrote:
> 
> On Sun, 22 Jan 2023 18:45:47 +0100, Christian Marangi wrote:
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
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 81 +++++++++++++------
> >  1 file changed, 56 insertions(+), 25 deletions(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230122174548.13758-1-ansuelsmth@gmail.com
> 
> 
> /: opp-table-cluster0:opp-1036800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1056000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1113600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1132800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1190400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1209600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1228800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1286400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1324800000:opp-supported-hw:0:0: 13 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1363200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1401600000:opp-supported-hw:0:0: 13 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1440000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1478400000:opp-supported-hw:0:0: 9 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1516800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1593600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-1593600000:opp-supported-hw:0:0: 9 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-1996800000:opp-supported-hw:0:0: 32 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-2188800000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-307200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-307200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-384000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-422400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-460800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-480000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-537600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-556800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-614400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-652800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-691200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-729600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-768000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-844800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-844800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-902400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0:opp-960000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0:opp-979200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster0: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1228800000', 'opp-1324800000', 'opp-1363200000', 'opp-1401600000', 'opp-1478400000', 'opp-1497600000', 'opp-1593600000', 'opp-307200000', 'opp-422400000', 'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000', 'opp-844800000', 'opp-960000000', 'opp-shared' were unexpected)
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster0: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1056000000', 'opp-1132800000', 'opp-1209600000', 'opp-1286400000', 'opp-1363200000', 'opp-1440000000', 'opp-1516800000', 'opp-1593600000', 'opp-1996800000', 'opp-2188800000', 'opp-307200000', 'opp-384000000', 'opp-460800000', 'opp-537600000', 'opp-614400000', 'opp-691200000', 'opp-768000000', 'opp-844800000', 'opp-902400000', 'opp-979200000', 'opp-shared' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1036800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1056000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1113600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1132800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1190400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1209600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1248000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1286400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1324800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1363200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1401600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1440000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1478400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1516800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1555200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1593600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1632000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1670400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1708800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1747200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1785600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1804800000:opp-supported-hw:0:0: 14 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-1824000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1900800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-1977600000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-2054400000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-2150400000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-2246400000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-2342400000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-307200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-307200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-384000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-403200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-460800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-480000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-537600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-556800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-614400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-652800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-691200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-729600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-748800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-806400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-825600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-883200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-902400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1:opp-940800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1:opp-979200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 
> /: opp-table-cluster1: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1248000000', 'opp-1324800000', 'opp-1401600000', 'opp-1478400000', 'opp-1555200000', 'opp-1632000000', 'opp-1708800000', 'opp-1785600000', 'opp-1804800000', 'opp-1824000000', 'opp-1900800000', 'opp-1920000000', 'opp-1996800000', 'opp-2073600000', 'opp-2150400000', 'opp-307200000', 'opp-403200000', 'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000', 'opp-806400000', 'opp-883200000', 'opp-940800000', 'opp-shared' were unexpected)
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> /: opp-table-cluster1: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1056000000', 'opp-1132800000', 'opp-1209600000', 'opp-1286400000', 'opp-1363200000', 'opp-1440000000', 'opp-1516800000', 'opp-1593600000', 'opp-1670400000', 'opp-1747200000', 'opp-1824000000', 'opp-1900800000', 'opp-1977600000', 'opp-2054400000', 'opp-2150400000', 'opp-2246400000', 'opp-2342400000', 'opp-307200000', 'opp-384000000', 'opp-460800000', 'opp-537600000', 'opp-614400000', 'opp-691200000', 'opp-748800000', 'opp-825600000', 'opp-902400000', 'opp-979200000', 'opp-shared' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
> 	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
> 

Hi, these warning are fixed by patch 2 of this series.

-- 
	Ansuel
