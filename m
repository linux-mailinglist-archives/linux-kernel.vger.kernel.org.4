Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55409676D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjAVOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:15:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C31B576;
        Sun, 22 Jan 2023 06:15:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so3089823wmq.1;
        Sun, 22 Jan 2023 06:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4BnGN2hh4y8sFQgJdSP7H1cARsQS/2gc8pQ9GQD8K6E=;
        b=gJ6vLFx6mxrdVrzWql4OZTvxuQfx7PJ3eloJz7UOwUrEkKv1uQP0u8KN/Z2EzwG+9o
         EuUYHs9xLCEIqrBK+J+FhjkcAmrC2kKCiFYqHlpv0HCImIbqwv0ELsRt0qgvUsdCFHhi
         mEV3HACYV0DA+W+ODIpWInzILvc2uis/AS53UeQknqi/mO8fXK8E7pi6ysPwjEEaFbQC
         9B14RUc4wEKtOJgZ9Y8NdxXYaLYWSgP1vYfq3AccUW0DO8PWj8IlzM2keEITTQiWwl5d
         vuve/3BMW5kfHZ8IneKCTKWRjONAm9XYFFVoknL5Zimby3fJCuZ6eJefktvruvcDrCg1
         WeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BnGN2hh4y8sFQgJdSP7H1cARsQS/2gc8pQ9GQD8K6E=;
        b=p3ltv56QFHsGUA50MGkzBrM3oEXpAsjFfui/nW0+l5EgihXsg3shS030LDHZjlNe18
         iyK+Ch3jDFb7rpoIDsyVXFoCSA2EIfE55Dgmkfidm1xDmeEUEKg18Cofwr7OU8H0uSo5
         NFfKU0VWjDwGkwIhVYydfLpn2U/9OKNGUx0I3dblhCEyRuIg5hpx7mNjCfSQ6AwXJuBi
         qv8Vr750uDYsDDHxnS5EmuHk8x7H6ThZ725zD9tHtDRhkcPgFqV2XOIWCF4GuMm9MsXi
         OR+BtfSh7NVEhqiqUf39CpfkB+MD/kHD+RhDPKkX/4rV/PIKUXxUhB8r6EXVc2x6OFd1
         qxFg==
X-Gm-Message-State: AFqh2kqAh3TcMzbtJM2HcPi+7LSdWH/5A6N6JVUfh9/5WkAvPh9VnRhd
        9LrpcBRH816Gmrf+E7/wxNA=
X-Google-Smtp-Source: AMrXdXvIlKNPcRhY/Qr5IwsbKpS4xQf2VVp3DDO5N7nsI0+zsXrjS/1UBKWh/UlNonJyG/y+WYfC4Q==
X-Received: by 2002:a05:600c:3549:b0:3da:acb1:2f09 with SMTP id i9-20020a05600c354900b003daacb12f09mr17393839wmq.19.1674396902354;
        Sun, 22 Jan 2023 06:15:02 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id fm17-20020a05600c0c1100b003db06224953sm9539577wmb.41.2023.01.22.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 06:15:02 -0800 (PST)
Message-ID: <63cd44e6.050a0220.ed90.635a@mx.google.com>
X-Google-Original-Message-ID: <Y81E5KVPsx16/35y@Ansuel-xps.>
Date:   Sun, 22 Jan 2023 15:15:00 +0100
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
Subject: Re: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt
 nvmem based
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-2-ansuelsmth@gmail.com>
 <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 03:00:22PM +0100, Krzysztof Kozlowski wrote:
> On 21/01/2023 01:01, Christian Marangi wrote:
> > The operating-points-v2-kryo-cpu driver supports defining multiple
> > opp-microvolt based on the blown efuses in the soc. It consist of 3
> > values that are parsed: speedbin, psv and version. They are all
> > appended to the opp-microvolt name and selected by the nvmem driver and
> > loaded dynamically at runtime.
> > 
> > Example:
> > 
> > opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> > opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> > opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> > opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> > 
> > Add support for this and reject these special binding if we don't have a
> > nvmem-cell to read data from.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > index b4947b326773..cea932339faf 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > @@ -61,6 +61,17 @@ patternProperties:
> >  
> >        required-opps: true
> >  
> > +    patternProperties:
> > +      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':
> 
> This does not end with correct unit suffix. Should be
> opp-speed-.....-microvolt
>

I think I didn't understand this?

From opp-v2-base and from what we are using downstream, the named
opp-micrvolt works correctly.

(speed[0-9]-pvs[0-9]-v[0-9] is the entire name of the named
opp-microvolt- binding)

This is the reference I always used for the pattern. [1]
Here the pattern used by the driver. [2]

[1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/opp/opp-v2-base.yaml#L209
[2] https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/qcom-cpufreq-nvmem.c#L238

> > +        description: |
> > +          Assign a microvolt value to the opp hz based on the efuses value from
> > +          speedbin, pvs and vers
> 
> Where is the DTS change?

You mean an additional example that use this additional binding? This
may be difficult to add since the current example in this schema is a
root one and I can't put multiple root example.

Is it acceptable to add a dummy opp table with some comments explaining
the dummy node is not supported in the current compatible? (apq8096)

> 
> Best regards,
> Krzysztof
> 

-- 
	Ansuel
