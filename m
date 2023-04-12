Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECE06DF765
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDLNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:39:24 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039A4222;
        Wed, 12 Apr 2023 06:39:23 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1878504c22aso236410fac.8;
        Wed, 12 Apr 2023 06:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306763; x=1683898763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqTBOiXW+OSKCG/B6dEs6T+l192CJMJlj9OxbNQfKPY=;
        b=L1TlGPs6PDO6NX1bYizu84xC5B6Xmw5AE5jjoLBHQr/xu2lrKJ9vwji5DW959ILI+6
         Y0JdZwVaEF8RqOmEJiCMfbysS1kXvWoUVL0nVi0I7hdANChyrCTn5epz8B989HN4iTGq
         EsXipFNBrHKbHrOURVtrBGj6/ZDxYWMYH6K8UgerP2TicxBHsWvAmF6BGJOMIV8Z2xeJ
         obCuS4lv4aBR7VJmSB/yUmUBt1mMQwRuCFQeuauZZhXXTw2tMmPb2RRipYwRifVj3RG2
         V/zfRSurjOfv17HrfYrGOdcaI4CkRc//HDtTHkJ0X8ruBk3PQzLj6uyPiiB+469ajhtl
         WEMA==
X-Gm-Message-State: AAQBX9cI/zHZpPUefl07lvovrbNbU9PU7xTi4TkyWQR5Iu/1lrtu4Bs1
        97NCnbB5FF67A/N4yQNS03srTGraXQ==
X-Google-Smtp-Source: AKy350ackMhPHZrmUsBkYtWkgvuVjprseT2ZSz58PZgTnUQvLVrAPQN80r7cK3FqlRLxKHggFOITwQ==
X-Received: by 2002:a05:6870:f228:b0:17e:9798:6e34 with SMTP id t40-20020a056870f22800b0017e97986e34mr8351022oao.32.1681306762985;
        Wed, 12 Apr 2023 06:39:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r17-20020a05687080d100b001726cfeea97sm6143360oab.29.2023.04.12.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:39:22 -0700 (PDT)
Received: (nullmailer pid 2193869 invoked by uid 1000);
        Wed, 12 Apr 2023 13:39:21 -0000
Date:   Wed, 12 Apr 2023 08:39:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        jun.li@nxp.com, haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Message-ID: <20230412133921.GA2017891-robh@kernel.org>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
 <20230405112118.1256151-2-j.zink@pengutronix.de>
 <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
 <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
 <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
 <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:22:37PM +0200, Johannes Zink wrote:
> Hi Krzystof,
> 
> thank you for your explanations. As I'm still quite new to writing
> bindings, I still have some questions:
> 
> On Fri, 2023-04-07 at 11:03 +0200, Krzysztof Kozlowski wrote:
> > On 05/04/2023 14:14, Johannes Zink wrote:
> > > Hi Krysztof,
> > > 
> > > thanks for your review, please find my questions below.
> > > 
> > > On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
> > > > [snip]
> > > > >        A phandle to the regulator for USB VBUS.
> > > > >  
> > > > > +  fsl,phy-tx-vref-tune:
> > > > > +    description:
> > > > > +      HS DC Voltage level adjustment
> > > > 
> > > > "Level" in what units?
> > > > 
> > > 
> > > The datasheet just shows percent, ranging from -6 to +24%, in 2%
> > > increments. What unit would you suggest?
> > 
> > percent
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> I am still a bit confused how to use this properly. How can I restrict
> the values to multiples of 2 in order to avoid illegal values?
> 
> At the moment the only thing I could come up with is something like
> 
> fsl,phy-tx-vref-tune-percent:                 
>   description: |                              
>     Adjusts the high-speed DC level voltage   
>   $ref: /schemas/types.yaml#/definitions/int32

Note that with standard unit suffixes, you don't need a type.

>   minimum: -6                                 
>   maximum: 24                                 
>   default: 0                                  
> 
> Does something like this work? I am not quite sure if I am on the right
> track here, especially as this requires a signed int, of which I have
> not seen many examples so far.

We'd have to change the type for -percent to signed. That's possible, 
but for vendor specific properties there's not much advantage to use 
standard units instead of just using the register values directly.

Rob
