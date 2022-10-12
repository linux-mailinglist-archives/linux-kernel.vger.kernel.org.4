Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF895FCA84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJLSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJLSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:20:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6EB31341;
        Wed, 12 Oct 2022 11:20:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29CIJB8G109540;
        Wed, 12 Oct 2022 13:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665598751;
        bh=5JtcXvc2y8xgELgZ+i8jCK0pwHl02q0j+wYLyn46Ud0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IFDCH0pz4UCp/F9EExNlGaMBisTGvh42RLgniCbvCK6WlTmXDmWf9MoiwHHO6bZsx
         8mDYqCPpkWz5L9Ydtc+z/OyVjmX1MNpJk46eDXn9XuCpkQMukig3a/+HlQliO1hGf8
         C+NPIJ/IyEaEQnocrhAQcFddovqbPHXKUu+zL1WA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29CIJBqA083381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 13:19:11 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 12
 Oct 2022 13:19:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 12 Oct 2022 13:19:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29CIJB1b124372;
        Wed, 12 Oct 2022 13:19:11 -0500
Date:   Wed, 12 Oct 2022 13:19:11 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/11] dt-bindings: thermal: k3-j72xx: elaborate on
 binding descriptions
Message-ID: <20221012181911.qk7v3yabo726lmtl@bryanbrattlof.com>
References: <20221011231727.8090-1-bb@ti.com>
 <20221011231727.8090-6-bb@ti.com>
 <06249fe9-97eb-1ab8-5e35-00b3c613d3a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <06249fe9-97eb-1ab8-5e35-00b3c613d3a7@linaro.org>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 12, 2022 thus sayeth Krzysztof Kozlowski:
> On 11/10/2022 19:17, Bryan Brattlof wrote:
> > Elaborate on the function of this device node as well as some of the
> > properties that this node uses.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  .../bindings/thermal/ti,j72xx-thermal.yaml    | 27 ++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > index c74f124ebfc00..0b6a6fa07a532 100644
> > --- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > @@ -9,6 +9,24 @@ title: Texas Instruments J72XX VTM (DTS) binding
> >  maintainers:
> >    - Keerthy <j-keerthy@ti.com>
> >  
> > +description: |
> > +  The TI K3 family of SoCs typically have a Voltage & Thermal
> > +  Management (VTM) device to control up to 8 temperature diode
> > +  sensors to measure silicon junction temperatures from different
> > +  hotspots of the chip as well as provide temperature, interrupt
> > +  and alerting information.
> > +
> > +  The VTM device will periodically enable these temperature sensors
> > +  to make a temperature measurement and store the reported data
> > +  allowing the sensors to stay in a reset state when not in use
> > +  to maximize the sensor's life.
> > +
> > +  This VTM driver will then use the following polynomial equation to
> 
> "VTM driver" is some physical/electronic element called driver? Or Linux
> driver? If the latter, drop it and just describe the equation.

Yeah I was trying to talk about the Linux driver. I'll edit it to only 
the equation. 

> 
> > +  calculate the temperature from the value stored in the VTM device.
> > +
> > +  Temp = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
> > +         (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -19,9 +37,16 @@ properties:
> >      items:
> >        - description: VTM cfg1 register space
> >        - description: VTM cfg2 register space
> > -      - description: VTM efuse register space
> > +      - description: |
> > +          A software trimming method must be applied to some Jacinto
> > +          devices to function properly. This eFuse region provides
> > +          the information needed for these SoCs to report
> > +          temperatures accurately.
> >  
> >    power-domains:
> > +    description: |
> > +      Should contain the phandle to a power management (PM) domain
> > +      node and the device-id of this device.
> 
> This is quite generic - why adding it?

This was really a "while I'm here" addition. But there is no need, I can 
drop this

Thanks again Krzysztof
~Bryan
