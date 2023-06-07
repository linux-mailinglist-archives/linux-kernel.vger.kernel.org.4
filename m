Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EE87269F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFGTjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFGTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:39:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA71FF7;
        Wed,  7 Jun 2023 12:38:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d55ac17bso714679066b.3;
        Wed, 07 Jun 2023 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686166736; x=1688758736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9mPghHb0zo1ioIAUBDYOj0SyzS0wuoa2sSWyDcE21Y=;
        b=TMoCvkTXY/gjiABpDtpmoPrgs8TFK7QZ05E5+WWu6EBV7Gy0jTCyX33VxR8NHkQLKe
         qlFitCGePxzK+aPNmEXd57dXg3IGTaoC7pUCtG3ERgqfwh8c99Lr32evc5+k9zi+1oZf
         UEkjKGMFt5HcwLuAptRvkxZl1vgcH1zAeWMUiv8jGhDf2JvFPF8/MAlvNXOzRdlD6y7/
         3SymvUlAjtm0dNSGbIOK+GKCEBLXAzwG94kFYYEsI9ZJ0isKV+dEB05ehfVCUcLVLC5B
         XD1hgH8/RVkMQJRYVWJgBcjX9jzs6LT4PGOUfYnayYC06x3fRDBM/FrUqsQUf6HJSa5a
         rGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166736; x=1688758736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9mPghHb0zo1ioIAUBDYOj0SyzS0wuoa2sSWyDcE21Y=;
        b=PcFD2Cp/3YaaFNl9lgjbbr6v0l8pDeR37pOUe52dK+Qpv9LPMxOzAOu9NUqwMusL6F
         Y4cYx8ud9jTD7h45G7e+qkpj5FDD0p4UJi9Uwa+ZYKh3d5JaAYZ6PXuKWt8f0jmrWwrO
         1ng1PW9G/1Sph6a/AAl65EZDnmuPD60LVfNfK4+8kHxp+u8u7QsXmJTqyJaZjW2hMHAi
         MDoEAaO8jgfihh2atjtXdqQahi3+LJ/k5epsEaA8z4cMoTRsKpQP0cg3qjrxhXhFlR2r
         SFNQC6GgUnCBKdZ94H1mvyYqK4KYxUxHgRQBaFivayIL+05f9tmwfJLJugZX3fg+fDhW
         UsKg==
X-Gm-Message-State: AC+VfDxgKwPD1UiwBNa+wsUK4S3/AbLyDmYBjDT+XDjPuS90UKMHBCyC
        JiNHmry1/rdMdUQkiOmpeQE=
X-Google-Smtp-Source: ACHHUZ4Y/8td78SY0svLXTall9qR9vpoyxxDO0P4VmvMlnMotCJwzc3XyvZ9UvHWTvlWNUXQocANjg==
X-Received: by 2002:a17:907:7da3:b0:977:d676:d3ca with SMTP id oz35-20020a1709077da300b00977d676d3camr7458256ejc.33.1686166735589;
        Wed, 07 Jun 2023 12:38:55 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090682c800b0097889c33582sm688895ejy.215.2023.06.07.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:38:55 -0700 (PDT)
Date:   Wed, 7 Jun 2023 21:38:52 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIDczFHCWCWyDSBo@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <17971357-523c-f907-13a9-8f7abce90c24@linaro.org>
 <ZICgPUDv+GjK4C5t@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <4673281c-0281-6fc5-97c3-b4ec821c81d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4673281c-0281-6fc5-97c3-b4ec821c81d5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:11:54PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 17:20, Tommaso Merciai wrote:
> > Hi Krzysztof,
> > 
> > On Wed, Jun 07, 2023 at 04:18:48PM +0200, Krzysztof Kozlowski wrote:
> >> On 07/06/2023 15:19, Tommaso Merciai wrote:
> >>> Add documentation of device tree in YAML schema for the ALVIUM
> >>> Camera from Allied Vision Inc.
> >>>
> >>> References:
> >>>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> >>>
> >>> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> >>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> ---
> >>> Changes since v1:
> >>>  - Fixed build error as suggested by RHerring bot
> >>>
> >>> Changes since v2:
> >>>  - Fixed License as suggested by KKozlowski/CDooley
> >>>  - Removed rotation property as suggested by CDooley/LPinchart
> >>>  - Fixed example node name as suggested by CDooley
> >>>  - Fixed title as suggested by LPinchart
> >>>  - Fixed compatible name as suggested by LPinchart
> >>>  - Removed clock as suggested by LPinchart
> >>>  - Removed gpios not as suggested by LPinchart
> >>>  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> >>>  - Fixed vendor prefix, unit append as suggested by KKozlowski
> >>>  - Fixed data-lanes
> >>>  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> >>>  - Dropped status into example  as suggested by KKozlowski
> >>>  - Added vcc-ext-in supply as suggested by LPinchart
> >>>  - Dropped pinctrl into example as suggested by LPinchart
> >>>
> >>> Changes since v3:
> >>>  - Fixed vcc-ext-in-supply description as suggested by LPinchart
> >>>  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
> >>>  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
> >>>  - Collected Reviewed-by tag from LPinchart
> >>
> >> You still did not test it before sending. Four versions of which none
> >> were tested :(
> > 
> > You are right.. my bad. :'(
> > 
> > After fixing id, as suggested by Laurent/bot into:
> > 
> > $id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
> > 
> > I'm running the following test:
> > 
> > make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> > 
> > With the following result:
> > 
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > /home/tom/work/mainline/linux/Documentation/devicetree/bindings/media/i2c/.alliedvision,alvium-csi2.example.dts.pre.yaml: ignoring, error parsing file
> >   DTEX    Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dts
> >   DTC_CHK Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dtb
> > 
> > Is that correct?
> 
> No, it doesn't look correct. You have error parsing your file. Check
> your yaml file and its example DTSI.
> 
> Be sure you have also yamlling installed.

Thanks for the feedback!

Regards,
Tommaso

> 
> Best regards,
> Krzysztof
> 
