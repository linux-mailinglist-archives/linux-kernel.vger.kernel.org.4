Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7B68E4C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBHAKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:09:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F123C50;
        Tue,  7 Feb 2023 16:09:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d14so15177975wrr.9;
        Tue, 07 Feb 2023 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fPJJB9qOsh5b2nvBTWu4/nqwjKDoLHCIFCF8FelrcKc=;
        b=lXnTPrYrZgP4XV/KUqDn8qszQLaPl/EwWxP6SYKBd/IH3Pu9QPo4UWJ8tXTLIHPLoJ
         0v4zDxS7CLXodZRKWlGuwYu1uWAPk3emZgYndswnX3DJTPD5hS+Nj7Rf8dbJHtwFvU7w
         wwDaS30YJVwbo3H0iH6V0oe5L5VJenaIvuoGXzmcaDNz0K9leg7NETvwM2QMvwZI9Ozz
         OuBUL+JBgjXyynfkt3+ljaptycRxbIRIpD+67ai9pGLpKp4j1gq7hKjZoFpyM4Obk7kd
         Gkvj+nWLMajrytnkh/kBkEVXG2gEeX5sil4cBTlXBcVBe24T6kxDHz/bkpZvXfXjVv/0
         aVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPJJB9qOsh5b2nvBTWu4/nqwjKDoLHCIFCF8FelrcKc=;
        b=nbJus/BT1XXEcml0kKj4b+0upZQUV5Zb/zBmHrUBkY+zkxXiGmITIqT+PXYO07M521
         Tez51AEGR4TqdHWxLANNDzoVo/lUueolssV1vmWcEsrJqobxTA9ftzYNt0/Vjqw0YroF
         mFzHZQDbc1v6DHXHfQmmMsgfGcLAyLzW+sTjQg71H+zQuGjaNzCDQfT4hRSpl53EbnyJ
         U0FnFd5kIicO7wVQuY7YavMlvxeZtnDR6Pjb+nb/bn69duzZ7nuPqc9VqZkWyieu61Op
         82PNsajQkyr9s+3YySEsBA4LY1T9KDLk+hqW0fh3Ptea0njAd8TK6oM733RAydqLsdoY
         Hfbg==
X-Gm-Message-State: AO0yUKWGqc2oTpGQfqDaM3LGnaaKcDP4qmKbWauKaBKheOJkZNXSSSjF
        tem1gGdMEyFKWdSvjpPmjGg=
X-Google-Smtp-Source: AK7set//8J5hzdxAAnhwCEAirPqk23len4DWSMS8W3c77+YJcIXd8X0Abozon2zuH07chhGiKqj1Ig==
X-Received: by 2002:adf:ea89:0:b0:2bf:b54f:61f0 with SMTP id s9-20020adfea89000000b002bfb54f61f0mr4688900wrm.57.1675814996776;
        Tue, 07 Feb 2023 16:09:56 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id q12-20020adfdfcc000000b002c3ec35f360sm4977327wrn.56.2023.02.07.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 16:09:56 -0800 (PST)
Message-ID: <63e2e854.df0a0220.52915.56aa@mx.google.com>
X-Google-Original-Message-ID: <Y+LoU66HmDdcYfzQ@Ansuel-xps.>
Date:   Wed, 8 Feb 2023 01:09:55 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make
 cpr bindings optional
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
 <20230131151819.16612-2-ansuelsmth@gmail.com>
 <1670489b-e4f0-7328-3dbb-d849d1d6bd7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670489b-e4f0-7328-3dbb-d849d1d6bd7e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:20:39AM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 16:18, Christian Marangi wrote:
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
> 
> Fixes go as first patches in the series.
> 

Hi,
this is problematic. This documentation is a bit special.

v4 had this patch as first but this cause error with make
dt_binding_check as the schema will be effectively empty (as it will
have only if condition)

This is why I pushed v5 that swap this with the second patch and first
add non conditional stuff to the schema and only with the second patch
makes them conditional.

Any hint to handle this corner case? I'm having some diffiulties due to
how special this is but we really need this fix since it's blocking the
introduction of opp table for ipq806x and ipq807x (as the schema is
currently flawed)

-- 
	Ansuel
