Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B360D4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiJYTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiJYTmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:42:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586748C448;
        Tue, 25 Oct 2022 12:42:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJg2MZ119572;
        Tue, 25 Oct 2022 14:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666726922;
        bh=H/as/1Tn9o1i2U2DwmPl0CGI3P3tgiJdJ3deInJ3bw0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Er6+biu5OoiqIuFs74X+1JBEm08eYptQuWK8UBFebRFe6bIZ1L4SDUNL13nlRFtGa
         vBIsiDuCbkfVT3dhdCSLmg6TjWgJE2KAaJJvfRbI7t2uVOSnC/tm7H5jgux8+TuYc0
         auGAs2disOnVah1ZKlLcyrqSJ1bF1hg4OxpHgAo8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJg2PJ079385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:42:02 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:42:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:42:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJg1kL027737;
        Tue, 25 Oct 2022 14:42:01 -0500
Date:   Tue, 25 Oct 2022 14:42:01 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/11] thermal: k3_j72xx_bandgap: map fuse_base only
 for erratum workaround
Message-ID: <20221025194201.3iup4ionv3zhnfd5@bryanbrattlof.com>
References: <20221025191515.9151-1-bb@ti.com>
 <20221025191515.9151-5-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221025191515.9151-5-bb@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 25, 2022 thus sayeth Bryan Brattlof:
> Some of TI's J721E SoCs require a software trimming procedure for the
> temperature monitors to function properly. To determine if a particular
> J721E is not affected by this erratum, both bits in the WKUP_SPARE_FUSE0
> region must be set. Other SoCs, not affected by this erratum, will not
> need this region.
> 
> Map the 'fuse_base' region only when the erratum fix is needed.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/thermal/k3_j72xx_bandgap.c | 37 ++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 

...

>  
> -	if (workaround_needed)
> -		devm_iounmap(dev, fuse_base);
> -

Ugh... This is wrong. 

Of course I will catch it right after I send this out

Sorry for the noise everyone
~Bryan
