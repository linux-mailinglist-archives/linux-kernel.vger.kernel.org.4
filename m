Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE15FCA58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJLSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJLSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:16:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D717A94;
        Wed, 12 Oct 2022 11:15:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29CIFVNH129232;
        Wed, 12 Oct 2022 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665598531;
        bh=ep5GtCavMkvjrrA9IxGQyL1LS5VWk/moXIEdjG8E7Ik=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bbusyDaSb9DVGIqFHRhfCETC28HimkaSBd4KBZExXLgiXD6s8ytA7ee1k3brb7/fk
         GfQbK3KCdTUPEqULdOEi+m3BYkalOYKyJ04QldI2h99SyQAgrQJwI8QiFklqa7+TZP
         /yLfz3WHNoVEG4SdoZsXV0sNCr+cccheMQlC08/o=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29CIFV1f067217
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 13:15:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 12
 Oct 2022 13:15:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 12 Oct 2022 13:15:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29CIFVhR075788;
        Wed, 12 Oct 2022 13:15:31 -0500
Date:   Wed, 12 Oct 2022 13:15:31 -0500
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
Subject: Re: [PATCH 06/11] dt-bindings: thermal: k3-j72xx: conditionally
 require efuse reg range
Message-ID: <20221012181531.cdvbfhbdxb3tscm4@bryanbrattlof.com>
References: <20221011231727.8090-1-bb@ti.com>
 <20221011231727.8090-7-bb@ti.com>
 <2eaae603-9726-290e-7c9d-67b89256140c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2eaae603-9726-290e-7c9d-67b89256140c@linaro.org>
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
> > Only some of TI's J721E SoCs will need a eFuse register range mapped to
> > determine if they're affected by TI's i2128 erratum. All other SoC will
> > not need this eFuse range to be mapped to function properly
> > 
> > Update the bindings for the k3_j72xx_bandgap thermal driver so other
> > devices will only need to define two register ranges
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  .../bindings/thermal/ti,j72xx-thermal.yaml    | 34 +++++++++++++------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > index 0b6a6fa07a532..387628ab35959 100644
> > --- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > @@ -33,16 +33,6 @@ properties:
> >        - ti,j721e-vtm
> >        - ti,j7200-vtm
> >  
> > -  reg:
> 
> No, keep entire part here.
> with minItems:2
>

Ah ok! I was unsure what this should look like. Your way is better :)

Thanks Krzysztof
~Bryan

