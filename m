Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AC68F769
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBHSsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBHSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:48:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2476B45BEA;
        Wed,  8 Feb 2023 10:48:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so2221363wms.1;
        Wed, 08 Feb 2023 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SKtB3R9rHCWK7NstTDvxS8MuIhQzUey/gryNgu1EbKk=;
        b=qm99wdV9MMY+hMMkh1700/WG4A7YhrnQjrU9ac/bXUUxYWkS3gU3jcuCgaaqwb4m89
         xzyqEHicVk9x1LuBKsZH2WTMh/A48YJb4Yl1WNAvYLPGqa3iDIG8pkr3+aQPd1Hr1CC8
         V16Q+O7McXcztziQ5sGKdJJtOvRgGdW86LkvXz/WgFdWs7yJMrNBCVI1sXHEMJCMp2e+
         jofg39oBRSDufDqItdTLPSyub2/TZ+7dl1Er5ZXTurN9hgMNJFpQi/8XrX7Sk55472p2
         i/l1P0jTFPJydP5d2xtmB8YXXDOG0gQOUo9UYRQlEekFZcMWVOdIbRuC7lUsFfHf1Ohw
         T+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKtB3R9rHCWK7NstTDvxS8MuIhQzUey/gryNgu1EbKk=;
        b=C/5BopgHdFeff++c6rq7kQSDH41lVaImQveC62h8n0417SR9pWpm8/2LQ+6X6k3ZQO
         9WrMenfuyh0s5P0Nl2zG3zSS77d2q242PKGaToQ2JAI31Pe8ZNMg6QxZWYRQpgm7qOwK
         2biNcKKVKfJAgEYX2S6kfM7khl2X6qjX0qYCeAeNhc71e8cARblQzQGXfb3DSa3pmINP
         mRZlI+7mbnAWULUeTF8CKB9xyhkEg+BxRbUIjeX/S95ghs6PKe/ZvKOWcj4e9Y+SvBbZ
         FAv0z1+J8hp3evvVlVCJ0GaFr8RPnLqTWd5QS4ZOoMwD2AGSLtC3wPAygiJ4JDd5l4u8
         +Khg==
X-Gm-Message-State: AO0yUKUmWFjcOxozroD2QEHlseaWTd1wvcxZWBCFtJCEvYtKbjTygofF
        ozLPuHLzev+IaJ96WXzA3rQ=
X-Google-Smtp-Source: AK7set9l5HbE0jWzNtbkUrn5GI6kWXwqEcYAA5H1idTmhBauT2/gi0Al6K61b0+Ale8gTKIiwjOjKw==
X-Received: by 2002:a05:600c:329d:b0:3dd:97d6:8f2e with SMTP id t29-20020a05600c329d00b003dd97d68f2emr7359214wmp.17.1675882124335;
        Wed, 08 Feb 2023 10:48:44 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003e00c9888besm2728957wmj.30.2023.02.08.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:48:43 -0800 (PST)
Message-ID: <63e3ee8b.7b0a0220.ebd26.c1b8@mx.google.com>
X-Google-Original-Message-ID: <Y+PuizqDQ9iN8DEL@Ansuel-xps.>
Date:   Wed, 8 Feb 2023 19:48:43 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make
 cpr bindings optional
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
 <20230208153913.24436-2-ansuelsmth@gmail.com>
 <167588124523.2281121.12225542985317117778.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167588124523.2281121.12225542985317117778.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:46:59PM -0600, Rob Herring wrote:
> 
> On Wed, 08 Feb 2023 16:39:12 +0100, Christian Marangi wrote:
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
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v6:
> > - Drop Fixes tag (can't be backported due to prereq changes required)
> > Changes v5:
> > - Swap patch 1 and patch 2 to fix dt_check_warning on single
> > Changes v4:
> > - Explain why required-opp needs to be conditional
> > - Split additional ref part
> > Changes v3:
> > - No change
> > Changes v2:
> > - Reword commit description
> > - Fix condition order
> > - Add allOf
> > 
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 74 +++++++++++--------
> >  1 file changed, 44 insertions(+), 30 deletions(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230208153913.24436-2-ansuelsmth@gmail.com
>

Just to not cause confusion since I know these are automated.

All fixed in patch 3.

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

-- 
	Ansuel
