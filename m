Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA4725D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjFGL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjFGL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:27:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C010DE;
        Wed,  7 Jun 2023 04:27:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-976a0a1a92bso885463766b.1;
        Wed, 07 Jun 2023 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686137240; x=1688729240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZj9zEPNMu6PNT680HAS4M1mr61aJ9tD4PBTYeqywYs=;
        b=RQlok25fj/9vJrPYbbct9bexovSu3Uf3Q+g2uMbk3emn9X6o3H00jzcyLGpxscGEIN
         4ZFNKn2kiWKwvY++sqS6vgbRVfSGiJvPOo/DWxXyxGvUWt4nrjHUuJVq5i75r7mPbJc9
         EljJx82O2k77zi/nO/1SVJ7OSKA1SLVOEYnzezu+SicfDlv0rM5zRmzBSaIlJej3D5ei
         mVozfbF1QlAWMmJIWOdKc5EJGMT/Qx7JpBcGn0HaVGqTuz0X5SDy6TbitEfFLj+CrzLp
         vIY2MwuxtNIMrOJPVDoIB9ITCGTy4tHWz8YjCsSmQRN2EWcg2+vmm3hJICN2VeN1Glrb
         F8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137240; x=1688729240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZj9zEPNMu6PNT680HAS4M1mr61aJ9tD4PBTYeqywYs=;
        b=TI2ceIzmVMFGDZ+O1Vp+jCfMcXyD7RlqMtcS+esmJYz1QShKOZoVQ4Vqydbt4vI7Ks
         Gpn82jeeOZk8fS7R56T80CXYRhDfZMRQOW9KNBQ+IpbN7UkWYjGQ/2z5oueHil7D9M/K
         D6r9QEJ6Wyr2xdH3HQOrlTWrUczTsu2Wvgvh27jR0viHPD5hCRRloA8oxxTa2gGBgcX2
         bp4HuiffhXk9TM0SG1108nVPa9ssM2l8YmWzj+5nRVp1StYsAPsjF4RjcnbCHqKFENPf
         cSGDEst0vILBxJTEmB1IhHacd/HtwwUYYZ4yfMCMCRifZYLR02zloQNU4AcfshxDxj1i
         JfhQ==
X-Gm-Message-State: AC+VfDxSIKpZQMxQYyRFHmjHalgMBTHZdB0OOWfILMuunaFvSK1q9rHv
        q8ZP0AogQvmbhHCLQxTpsZs=
X-Google-Smtp-Source: ACHHUZ4qNanpQ2K8kT4AddIsaGIj7F+UCXUl8nxvF7xcI0lE+eswM2cdOkE7Frhj31mu39SJ9K7thg==
X-Received: by 2002:a17:907:2d10:b0:973:fe5d:ef71 with SMTP id gs16-20020a1709072d1000b00973fe5def71mr5991058ejc.14.1686137239579;
        Wed, 07 Jun 2023 04:27:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id u3-20020a1709063b8300b00977e7f7d599sm3195495ejf.71.2023.06.07.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:27:19 -0700 (PDT)
Date:   Wed, 7 Jun 2023 13:27:16 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Conor Dooley <conor@kernel.org>, jacopo.mondi@ideasonboard.com,
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
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIBplDv/NFb0jGoq@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
 <20230606-jaundice-womankind-7e583789fb7a@spud>
 <ZIAuaF/5Aib1DoQ+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230607072134.GK14101@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607072134.GK14101@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Laurent,

On Wed, Jun 07, 2023 at 10:21:34AM +0300, Laurent Pinchart wrote:
> On Wed, Jun 07, 2023 at 09:14:48AM +0200, Tommaso Merciai wrote:
> > On Tue, Jun 06, 2023 at 07:07:42PM +0100, Conor Dooley wrote:
> > > On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> > > > On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
> > > 
> > > > > +  alliedvision,lp2hs-delay-us:
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      Low power to high speed delay time in microseconds.
> > > > 
> > > > You can drop "in microseconds", that's implied by the suffix.
> > > > 
> > > > > +      The purpose of this property is force a DPhy reset for the period
> > > > > +      described by the microseconds on the property, before it starts
> > > > > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > > > > +      forces a dphy-reset on all lanes for that period. That means all
> > > > > +      lanes go up into low power state. This may help a csi2 rx ip to
> > > > > +      reset if that IP can't deal with a continous clock.
> > > > 
> > > > I'd like to propose what I think is a clearer version:
> > > > 
> > > >     description: |
> > > >       Low power to high speed delay time.
> > > > 
> > > >       If the value is larger than 0, the camera forces a reset of all
> > > >       D-PHY lanes for the duration specified by this property. All lanes
> > > >       will transition to the low-power state and back to the high-speed
> > > >       state after the delay. Otherwise the lanes will transition to and
> > > >       remain in the high-speed state immediately after power on.
> > > > 
> > > >       This is meant to help CSI-2 receivers synchronizing their D-PHY
> > > >       RX.
> > > 
> > > Question about the property.
> > > Why not make it have a minimum value of 1 and drop the special-case
> > > behaviour for zero?
> > 
> > Personally I prefer to stay with zero case.
> > This reflect better the real camera register behaviour.
> 
> Speaking of which, could you document the maximum value in the bindings
> ?

150ms is the max value I'll document this in v4.

Regards,
Tommaso

> 
> > (also is optional)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
