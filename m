Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59ED6BDBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCPWft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCPWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:35:47 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329D58C10;
        Thu, 16 Mar 2023 15:35:46 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id o12so1503505iow.6;
        Thu, 16 Mar 2023 15:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsDQM6oA7Sc4GrwdW4rvd7swFz7mkc413XGqYjlViXE=;
        b=VJegj11omvMfG1HOy22SdWAjVHXM32uEILBjYWdgS5+KpR40o2K6INph25wiE70uFA
         /nnOt54OypgaL+NuDS5xDDKRdQLeIGgz40hG3ux0rAAFQKjwg1gCkfHRDVzVyegAQN3c
         yY5T+SbLg3opbED/mqrLwaN5fu3SnUmybld4sqNIwR/7+pQ6gW7fmKhABMTjKi1VE/Ay
         VasOFQhS0DrX6hfpYL7rdvb5719MyUpmNwOLGMdSaqSe7hpXYo8PtjXwpJ1s0Q0c6AZL
         1bH4nH0b8YSrRHsGkYsu46erVzPayjc+hH25snLVn0rle/4FjEds9rVnhkSjbobAdrIb
         lzxQ==
X-Gm-Message-State: AO0yUKXOj0/DarVDv4ioI6n8Ncmx3GH5TZKoLHD1jjduF+O2U3MKqXUc
        SVJxFmHBWMMojgjRRfh9MQ==
X-Google-Smtp-Source: AK7set8scroUEs+g+P+YuNnzijoW4C2z9w+t4go2VOkci7XB0pxR0PPx9n8TncXiQ6U5y2eS8rnQbw==
X-Received: by 2002:a6b:a13:0:b0:753:2862:a2c0 with SMTP id z19-20020a6b0a13000000b007532862a2c0mr263784ioi.21.1679006145636;
        Thu, 16 Mar 2023 15:35:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d4-20020a6b6804000000b0073f8a470bacsm117385ioc.16.2023.03.16.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:35:45 -0700 (PDT)
Received: (nullmailer pid 4013127 invoked by uid 1000);
        Thu, 16 Mar 2023 22:35:43 -0000
Date:   Thu, 16 Mar 2023 17:35:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, bchihi@baylibre.com,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to
 LVTS thermal controllers for mt8195
Message-ID: <20230316223543.GA4008428-robh@kernel.org>
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-2-bchihi@baylibre.com>
 <CAGXv+5FUrWEF4SZ6DKjoF8Oai--JGFffzQ3_DyzQrUrThVEQ7Q@mail.gmail.com>
 <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:39:13AM +0100, Daniel Lezcano wrote:
> On 09/03/2023 05:40, Chen-Yu Tsai wrote:
> > On Wed, Mar 8, 2023 at 12:46 AM <bchihi@baylibre.com> wrote:
> > > 
> > > From: Balsam CHIHI <bchihi@baylibre.com>
> > > 
> > > Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.
> > > 
> > > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > > ---
> > >   include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> > > index c09398920468..8fa5a46675c4 100644
> > > --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> > > +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> > > @@ -16,4 +16,14 @@
> > >   #define MT8195_MCU_LITTLE_CPU2  6
> > >   #define MT8195_MCU_LITTLE_CPU3  7
> > > 
> > > +#define MT8195_AP_VPU0  8
> > 
> > Can't this start from 0? This is a different hardware block. The index
> > namespace is separate. Same question for MT8192.
> 
> The ID is used to differentiate the thermal zone identifier in the device
> tree from the driver.
> 
> +		vpu0-thermal {
> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
> +
> +			trips {
> +				vpu0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> 
> If MT8195_AP_VPU0 is 0, then the code won't be able to differentiate
> MT8195_AP_VPU0 and MT8195_MCU_BIG_CPU0
> 
> The LVTS driver will call devm_thermal_of_zone_register() with the sensor
> id. If MT8195_MCU_BIG_CPU0 and MT8195_AP_VPU0 have the same id, then at the
> moment of registering the MT8195_AP_VPU0, the underlying OF thermal
> framework code will use MT8195_MCU_BIG_CPU0 description instead because it
> will be the first to be find in the DT.
> 
> If MT8195_AP_VPU0 is described in DT before, then the same will happen when
> registering MT8195_MCU_BIG_CPU0, MT8195_AP_VPU0 will be registered instead.
> 
> IOW all ids must be different.

That's broken for how producer/consumer phandle+args bindings work.

Rob
