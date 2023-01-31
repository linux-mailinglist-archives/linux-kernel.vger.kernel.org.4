Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC06821AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjAaB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAaB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:57:57 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844185B8E;
        Mon, 30 Jan 2023 17:57:54 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30V1vcxN122920;
        Mon, 30 Jan 2023 19:57:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675130258;
        bh=nI385oO1ob+RB9n+M3klKZg7ccw2Sb7CN4Tuz0NDZrs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bXSP2fCAh+EfJqWTO3N+57PRFLSoKXw0e4q57O24Xj2tpzBDnxURCt/zDfMnjhgGs
         eY0fDPfwxOdeRpPVY6W7JWCneYuHLMjG0SYZsZ0LdJrlXEuZ4zEk/w3ndh6YSlwZVW
         kCliAlpsaSLLa8zkEIizxJp74bsqp4xpohd5h/yQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30V1vcRx113032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jan 2023 19:57:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 30
 Jan 2023 19:57:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 30 Jan 2023 19:57:38 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30V1vc9Q028990;
        Mon, 30 Jan 2023 19:57:38 -0600
Date:   Mon, 30 Jan 2023 19:57:28 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 2/6] arm64: dts: ti: k3-am62-wakeup: add VTM node
Message-ID: <20230131015728.347i3cttyxtitcwi@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230120003051.9100-1-bb@ti.com>
 <20230120003051.9100-3-bb@ti.com>
 <0172f045-4bd0-ec5e-35a0-efc80da5ace0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <0172f045-4bd0-ec5e-35a0-efc80da5ace0@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh!

On January 28, 2023 thus sayeth Raghavendra, Vignesh:
> Hi Bryan,
> 
> On 1/20/2023 6:00 AM, Bryan Brattlof wrote:
> > @@ -94,10 +95,13 @@ cbass_wakeup: bus@2b000000 {
> >  			compatible = "simple-bus";
> >  			#address-cells = <2>;
> >  			#size-cells = <2>;
> > -			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> > +			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> 
> You would need to update unit address in node name as well:
> 			cbass_wakeup: bus@b00000 {

Ah! I missed that. I'll get this fixed

~Bryan
