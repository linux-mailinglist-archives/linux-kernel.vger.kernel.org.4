Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC368E4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBHAPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHAPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:15:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDE30B1B;
        Tue,  7 Feb 2023 16:15:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso285539wms.4;
        Tue, 07 Feb 2023 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V+RaIQchGCjUg8WOksp5jBJckUUbTckJoGWe5pG0GSY=;
        b=Waz6OqmEiKR5LaLEL73seaMZYDb3R+RIHxMX1QVtxmKviO3+QhuE892RvE37lHcV7k
         d9nMa8MNVCqwZsku3FsPqi1DUMC5fKMylmfO93WDPLL80RUErx4CsdrEopCyFGVvPrSQ
         mfEm18Nq60gVXCGwJykxUMe1Lq74MstkD6omCgh2r8U7qxHPspHvjYouTD76v5Dk7WxO
         NDF4oiOxxfwZV4byhtxutwN3Fw3S9/C0ST/Fmx1qzBlWJV6zLlZKNSHQrnKkiP3qE5DK
         ElODprlEOzwW9IiJG3MAGJIaJ/7tIWxszGvRxqMsru6kv2aEn7yYfc8NCzIUJUQBf4Lm
         eNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+RaIQchGCjUg8WOksp5jBJckUUbTckJoGWe5pG0GSY=;
        b=ZKwbQS0k5yyjJQ1MEKGC29MDbQMzlgtHnU1i2wAeO03ni469eWB/X7CR16gT5uGveU
         vK0fp2d4wgodmt+aOxFcekpVrF9Uciw5UaNLKGXdMg0wfk1fyzk7ts5MhqZx0gyLB6Qs
         13XrcyTo0h2q/dvEGgPRkFxX6PbDJ2h4wams9gL8yFF1MO8rvQ8oItAyiZjq3HOtND/X
         3iQOL1CLav6OauA4ns54XgAPlALVp9Ld5bkjBXBqdvktToNskyDStY35CGOFu/pZefpU
         qR1XTtGkL6y2DhWNCqNXIlYLmbz/LsVHnHfIz+iwefDdgTTDrUnzg9evMtWqO/GJfZku
         K8tQ==
X-Gm-Message-State: AO0yUKVD7wAfeIwp2vyZNoIEw2OA77QoFE+L6Xz6aAO7ChhtpOxNlLWj
        QxrtqTc2bm9YIj13vnp/K8I=
X-Google-Smtp-Source: AK7set+DvXgzYGfzr9DxS7yBBi4l5d+iWP8nM85ZN7MeY3yjIT7d8SO4oFjZnehOLLA51e6OgGRVkg==
X-Received: by 2002:a05:600c:4d21:b0:3dc:3398:cf87 with SMTP id u33-20020a05600c4d2100b003dc3398cf87mr4660731wmp.11.1675815298358;
        Tue, 07 Feb 2023 16:14:58 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm274023wmi.18.2023.02.07.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 16:14:58 -0800 (PST)
Message-ID: <63e2e982.7b0a0220.ff24d.1315@mx.google.com>
X-Google-Original-Message-ID: <Y+LpgLTT/buvJLJy@Ansuel-xps.>
Date:   Wed, 8 Feb 2023 01:14:56 +0100
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
Subject: Re: [PATCH v5 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify
 supported opp tables
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
 <44d94a1d-47d6-f93e-4a20-d9d83375398d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d94a1d-47d6-f93e-4a20-d9d83375398d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:19:42AM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 16:18, Christian Marangi wrote:
> > Add additional info on what opp tables the defined devices in this schema
> > supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
> > and reference them.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v5:
> > - Swap patch 1 and patch 2 to fix dt_check_warning on single
> >   patch bisecting 
> > Changes v4:
> > - Add patch split from patch 1
> > 
> >  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 35 ++++++++++++++-----
> 
> This patch causes new warnings:
> 
> arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb: /: opp-table-cluster0:
> Unevaluated properties are not allowed ('compatible', 'nvmem-cells',
> 'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1228800000',
> 'opp-1324800000', 'opp-1363200000', 'opp-1401600000', 'opp-1478400000',
> 'opp-1497600000', 'opp-1593600000', 'opp-307200000', 'opp-422400000',
> 'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000',
> 'opp-844800000', 'opp-960000000', 'opp-shared' were unexpected)
> 

Hi, this is fixed by the third patch and caused by

opp-supported-hw:0:0: 16 is greater than the maximum of 7

that is fixed by documenting the new bits.

-- 
	Ansuel
