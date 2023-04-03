Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3848E6D468D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjDCOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjDCOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:10:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324992CADF;
        Mon,  3 Apr 2023 07:10:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 333E9lR1128847;
        Mon, 3 Apr 2023 09:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680530987;
        bh=YkBhzOteRAMchrVfAipOT9qe161ClYPmJBLvxSqm6Qc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NU+J/DP5J2HVvMxYRV/qskr/i2I8+kOwPlrsW3vvpmG6kto6U7XJWNPEll7Y4MZ6p
         rsUZItIx08HdVB1PXS7gjl4zexO8iBJaOXYUbUIQNXoUL7ZsXVLifjRa14Fx0VXcM3
         7sZAFMgXch7m0HTM0a26+dzmCrEdFoYlNIEnMYzI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 333E9lQI050188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 09:09:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 3
 Apr 2023 09:09:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 3 Apr 2023 09:09:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 333E9lfH017904;
        Mon, 3 Apr 2023 09:09:47 -0500
Date:   Mon, 3 Apr 2023 09:09:47 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
CC:     "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 2/6] arm64: dts: ti: k3-am62-wakeup: add VTM node
Message-ID: <20230403140947.kj7t5lq2puketgkt@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230120003051.9100-1-bb@ti.com>
 <20230120003051.9100-3-bb@ti.com>
 <0172f045-4bd0-ec5e-35a0-efc80da5ace0@ti.com>
 <20230131015728.347i3cttyxtitcwi@bryanbrattlof.com>
 <CAH9NwWeDSFrF61UC=NENTvQpUU_erGtKrhUzBVQWvA3KjbH_Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAH9NwWeDSFrF61UC=NENTvQpUU_erGtKrhUzBVQWvA3KjbH_Fg@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian!

On April  3, 2023 thus sayeth Christian Gmeiner:
> > Hi Vignesh!
> >
> > On January 28, 2023 thus sayeth Raghavendra, Vignesh:
> > > Hi Bryan,
> > >
> > > On 1/20/2023 6:00 AM, Bryan Brattlof wrote:
> > > > @@ -94,10 +95,13 @@ cbass_wakeup: bus@2b000000 {
> > > >                     compatible = "simple-bus";
> > > >                     #address-cells = <2>;
> > > >                     #size-cells = <2>;
> > > > -                   ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> > > > +                   ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> > >
> > > You would need to update unit address in node name as well:
> > >                       cbass_wakeup: bus@b00000 {
> >
> > Ah! I missed that. I'll get this fixed
> 
> Any update on this? Would be great if these changes could make it into
> the next merge window.
> 

You got me :) I let this fall off my radar... I'll send out v3 by today 
or tomorrow to restart the review process.

Thank you for reviewing and for the reminder Christian
~Bryan
