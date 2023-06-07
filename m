Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A15726413
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbjFGPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjFGPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:20:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0716FC;
        Wed,  7 Jun 2023 08:20:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-976a0a1a92bso932340266b.1;
        Wed, 07 Jun 2023 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686151233; x=1688743233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNJDIjs7Ttsy90T0MogpvFCvyK09YUh2d0LVsS1aFR4=;
        b=jvNbKeOohtzqxi3YAtZ3RViRK0eiOkIjU48fk6JPlGSAnwI0oSa2G2GpXt0p5fOdus
         Z56XRPdi8XBufhlolqizYsbWxzPsVYUF8nkeAv9VCapNX3isKJ62K3ORW1tKT+GEqipw
         U4NkEhNxHpnjfikq2bfbJaOt3+zAIh100sFRRf1dGuyYnPtWzz7w2yrmGGUKKlbzOux6
         z7HPKGSn1c/8hJmrC5bKJ3QJPGZeeA31TvMSQfAZLthZb78/7G0scq4+GpqtgprhTaSo
         kAj3KyD6LH2qpUa5C5lXm6qag62R3ioCtiIvX5y4pDUsUlLqfvhAebZ4btG+WxnAZGAz
         yJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151233; x=1688743233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNJDIjs7Ttsy90T0MogpvFCvyK09YUh2d0LVsS1aFR4=;
        b=gMf33uQU+l/JYU+4aLRuYlmFIXJZdrNqWJoxYa1K6yXjZO4LSc02wxkozsS9v8+Jcm
         +jDmU3ZOlh1xj/fLx04lPGCJ+cfzM+itS7TM4eXUJuPbQ0176r7xV6A+FAOR8hEmMtXM
         0KK9UX2Gs2/RqZ1L8dtFxD3c1jx1j+54oD77Hi0fzlTchkZnhqsnSnKvSIsWCyG8goMQ
         sqFCbmYkB9n8nBJLJxlTD969BVwYpEMCQUXOYALz3oyyMbnCB8ECLvv7tujfEb4BYJzr
         GBEmcnacOOG9liHdRmdqREXrZDr3WkOVGMmQcTCTEB+FlZsD5qFTJR1TJ4sLSPhIUxPw
         YDHw==
X-Gm-Message-State: AC+VfDzItf80WogYBgXPCURShczyDuTlAiTxqa2gnn4ltEu6sc8ZeGTs
        CZdho5OWUaZ2T68au/ApBKM=
X-Google-Smtp-Source: ACHHUZ7qLvIh+FyK7dUofUEvP/IpPwPimm3tWDeTEal81mKPuhi2e5fDWSijXXGjO8ieLBSs7kJlyw==
X-Received: by 2002:a17:907:6e0e:b0:973:71c3:8b21 with SMTP id sd14-20020a1709076e0e00b0097371c38b21mr6301469ejc.72.1686151232974;
        Wed, 07 Jun 2023 08:20:32 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id k5-20020aa7c045000000b00514b854c399sm6410932edo.84.2023.06.07.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:20:32 -0700 (PDT)
Date:   Wed, 7 Jun 2023 17:20:29 +0200
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
Message-ID: <ZICgPUDv+GjK4C5t@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <17971357-523c-f907-13a9-8f7abce90c24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17971357-523c-f907-13a9-8f7abce90c24@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jun 07, 2023 at 04:18:48PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 15:19, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the ALVIUM
> > Camera from Allied Vision Inc.
> > 
> > References:
> >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v1:
> >  - Fixed build error as suggested by RHerring bot
> > 
> > Changes since v2:
> >  - Fixed License as suggested by KKozlowski/CDooley
> >  - Removed rotation property as suggested by CDooley/LPinchart
> >  - Fixed example node name as suggested by CDooley
> >  - Fixed title as suggested by LPinchart
> >  - Fixed compatible name as suggested by LPinchart
> >  - Removed clock as suggested by LPinchart
> >  - Removed gpios not as suggested by LPinchart
> >  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> >  - Fixed vendor prefix, unit append as suggested by KKozlowski
> >  - Fixed data-lanes
> >  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> >  - Dropped status into example  as suggested by KKozlowski
> >  - Added vcc-ext-in supply as suggested by LPinchart
> >  - Dropped pinctrl into example as suggested by LPinchart
> > 
> > Changes since v3:
> >  - Fixed vcc-ext-in-supply description as suggested by LPinchart
> >  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
> >  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
> >  - Collected Reviewed-by tag from LPinchart
> 
> You still did not test it before sending. Four versions of which none
> were tested :(

You are right.. my bad. :'(

After fixing id, as suggested by Laurent/bot into:

$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#

I'm running the following test:

make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml

With the following result:

  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/tom/work/mainline/linux/Documentation/devicetree/bindings/media/i2c/.alliedvision,alvium-csi2.example.dts.pre.yaml: ignoring, error parsing file
  DTEX    Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dts
  DTC_CHK Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dtb

Is that correct?
Let me know. Thanks in advance :)

Regards,
Tommaso

> 
> Best regards,
> Krzysztof
> 
