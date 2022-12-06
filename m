Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7E644A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiLFRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiLFRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:40:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF53C6E9;
        Tue,  6 Dec 2022 09:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36286B81AE2;
        Tue,  6 Dec 2022 17:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E956EC433D7;
        Tue,  6 Dec 2022 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670348346;
        bh=+tdEznI/g0L7siq0SlLmZAepq7d3jTdsbku3dgHfOfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YYo1ndUG1+bV2uRuoYCxh78TVHlUUOMKcPeNRetKFQNjwXSsggo+aWkaw+7M0yud1
         MP0scbJIDw7a9FrEnCc8ex7H3/HLqyB3rd2n7nqha+tCiRd6pyk1GhI/QvcVgGNb6q
         ZY6xkFhiw2L+baF3WJlOACspyLwb6E1O+nZntdK6pTKDQ3jxR0sSEuOwCdejoTHu8E
         l747il4hWHyftjyDkli6B97TuWZ789rgr6qK8rYFVodUrDzmUfvYeB1azXeqj7rn0k
         uxL3BT9zervvZB4JwIwU2k0XXyF17jTXf1rxwhtxboNNcI3zKCy21FFXKGiEeGWn16
         jZkBQVdcJuE/Q==
Received: by mail-vs1-f51.google.com with SMTP id 3so14026976vsq.7;
        Tue, 06 Dec 2022 09:39:06 -0800 (PST)
X-Gm-Message-State: ANoB5pmN1oZ/BLc9Dyp+w5ZMoIoBMZpXHoggscs4AR8VtFD/JDfC5ijD
        wuTStZHlQ+nzFYbSI5Uw8Qj1MEFU76YmKTM3Fg==
X-Google-Smtp-Source: AA0mqf4PpwoI1ggVpjpVZszVRkunYLheMlcwUDFh5/UuwLgs7caqmMUTxdiMDcyl4E9LOSFxuYu4a7YIhDk5ts2lZvk=
X-Received: by 2002:a05:6102:370a:b0:3af:c63c:5536 with SMTP id
 s10-20020a056102370a00b003afc63c5536mr46010667vst.85.1670348345753; Tue, 06
 Dec 2022 09:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20221111162729.3381835-1-robh@kernel.org> <52d2e0c2-a04a-1ae8-cab5-b89a79150fe6@linaro.org>
In-Reply-To: <52d2e0c2-a04a-1ae8-cab5-b89a79150fe6@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Dec 2022 11:38:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UOJcBKSiVpCsBO+VF8e0BA6JVfGhRtgoED0YbfD=W+g@mail.gmail.com>
Message-ID: <CAL_Jsq+UOJcBKSiVpCsBO+VF8e0BA6JVfGhRtgoED0YbfD=W+g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: thermal-idle: Fix example paths
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 11:15 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/11/2022 17:27, Rob Herring wrote:
> > The reference by path (&{/cpus/cpu@101/thermal-idle}) in the example causes
> > an error with new version of dtc:
> >
> > FATAL ERROR: Can't generate fixup for reference to path &{/cpus/cpu@100/thermal-idle}
> >
> > This is because the examples are built as an overlay and absolute paths
> > are not valid as references must be by label. The path was also not
> > resolvable because, by default, examples are placed under 'example-N'
> > nodes.
> >
> > As the example contains top-level nodes, the root node must be explicit for
> > the example to be extracted as-is. This changes the indentation for the
> > whole example, but the existing indentation is a mess of of random amounts.
> > Clean this up to be 4 spaces everywhere.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > The dtc update is in my tree, so I'd prefer to take this via the DT
> > tree.
> >
> >   .../bindings/thermal/thermal-idle.yaml        | 154 +++++++++---------
> >   1 file changed, 80 insertions(+), 74 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> > index cc938d7ad1f3..72d85eb64247 100644
> > --- a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> > @@ -48,99 +48,105 @@ additionalProperties: false
> >
> >   examples:
> >     - |
> > -    #include <dt-bindings/thermal/thermal.h>
> > +    /{
> > +        #include <dt-bindings/thermal/thermal.h>
> >
> > -    // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
> > -    cpus {
> > +        compatible = "foo";
> > +        model = "foo";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
> > +        cpus {
> >               #address-cells = <2>;
> >               #size-cells = <0>;
> >
> >               /* ... */
> >
> > -                 cpu_b0: cpu@100 {
> > -                         device_type = "cpu";
> > -                         compatible = "arm,cortex-a72";
> > -                         reg = <0x0 0x100>;
> > -                         enable-method = "psci";
> > -                         capacity-dmips-mhz = <1024>;
> > -                         dynamic-power-coefficient = <436>;
> > -                         #cooling-cells = <2>; /* min followed by max */
> > -                         cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> > -                         thermal-idle {
> > -                                 #cooling-cells = <2>;
> > -                                 duration-us = <10000>;
> > -                                 exit-latency-us = <500>;
> > -                         };
> > +            cpu_b0: cpu@100 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a72";
> > +                reg = <0x0 0x100>;
> > +                enable-method = "psci";
> > +                capacity-dmips-mhz = <1024>;
> > +                dynamic-power-coefficient = <436>;
> > +                #cooling-cells = <2>; /* min followed by max */
> > +                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> > +                thermal-idle {
> > +                    #cooling-cells = <2>;
> > +                    duration-us = <10000>;
> > +                    exit-latency-us = <500>;
> > +                };
> > +            };
> > +
> > +            cpu_b1: cpu@101 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a72";
> > +                reg = <0x0 0x101>;
> > +                enable-method = "psci";
> > +                capacity-dmips-mhz = <1024>;
> > +                dynamic-power-coefficient = <436>;
> > +                #cooling-cells = <2>; /* min followed by max */
> > +                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> > +                thermal-idle {
> > +                    #cooling-cells = <2>;
> > +                    duration-us = <10000>;
> > +                    exit-latency-us = <500>;
> >                   };
> > +            };
> >
> > -                cpu_b1: cpu@101 {
> > -                        device_type = "cpu";
> > -                        compatible = "arm,cortex-a72";
> > -                        reg = <0x0 0x101>;
> > -                        enable-method = "psci";
> > -                        capacity-dmips-mhz = <1024>;
> > -                        dynamic-power-coefficient = <436>;
> > -                        #cooling-cells = <2>; /* min followed by max */
> > -                        cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> > -                        thermal-idle {
> > -                                #cooling-cells = <2>;
> > -                                duration-us = <10000>;
> > -                                exit-latency-us = <500>;
> > -                        };
> > -                 };
> > -
> > -          /* ... */
> > +            /* ... */
> >
> > -    };
> > +        };
> >
> > -    /* ... */
> > +        /* ... */
> >
> > -    thermal_zones {
> > -         cpu_thermal: cpu {
> > +        thermal_zones {
> > +            cpu_thermal: cpu {
> >                   polling-delay-passive = <100>;
> >                   polling-delay = <1000>;
> >
> >                   /* ... */
> >
> >                   trips {
> > -                        cpu_alert0: cpu_alert0 {
> > -                                    temperature = <65000>;
> > -                                    hysteresis = <2000>;
> > -                                    type = "passive";
> > -                        };
> > -
> > -                        cpu_alert1: cpu_alert1 {
> > -                                    temperature = <70000>;
> > -                                    hysteresis = <2000>;
> > -                                    type = "passive";
> > -                        };
> > -
> > -                        cpu_alert2: cpu_alert2 {
> > -                                    temperature = <75000>;
> > -                                    hysteresis = <2000>;
> > -                                    type = "passive";
> > -                        };
> > -
> > -                        cpu_crit: cpu_crit {
> > -                                    temperature = <95000>;
> > -                                    hysteresis = <2000>;
> > -                                    type = "critical";
> > -                        };
> > +                    cpu_alert0: cpu_alert0 {
> > +                        temperature = <65000>;
> > +                        hysteresis = <2000>;
> > +                        type = "passive";
> > +                    };
> > +
> > +                    cpu_alert1: cpu_alert1 {
> > +                        temperature = <70000>;
> > +                        hysteresis = <2000>;
> > +                        type = "passive";
> > +                    };
> > +
> > +                    cpu_alert2: cpu_alert2 {
> > +                        temperature = <75000>;
> > +                        hysteresis = <2000>;
> > +                        type = "passive";
> > +                    };
> > +
> > +                    cpu_crit: cpu_crit {
> > +                        temperature = <95000>;
> > +                        hysteresis = <2000>;
> > +                        type = "critical";
> > +                    };
> >                   };
> >
> >                   cooling-maps {
> > -                        map0 {
> > -                             trip = <&cpu_alert1>;
> > -                             cooling-device = <&{/cpus/cpu@100/thermal-idle} 0 15 >,
> > -                                              <&{/cpus/cpu@101/thermal-idle} 0 15>;
> > -                        };
> > -
> > -                        map1 {
> > -                             trip = <&cpu_alert2>;
> > -                             cooling-device =
> > -                                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > -                                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > -                       };
> > +                    map0 {
> > +                        trip = <&cpu_alert1>;
> > +                        cooling-device = <&cpu_b0 0 15 >,
> > +                                         <&cpu_b1 0 15>;
>
> This is pointing to the DVFS cooling device, not the idle cooling
> device. Should it be <&cpu_b0_idle 0 15> and that label defined in
> thermal_idle ?

Ah, yes indeed. I'll fix that up with a label to the correct node.

And note that 'thermal-idle' needs to be added to cpu node schema.
That one currently allows anything extra which I'm working on
addressing.

Rob
