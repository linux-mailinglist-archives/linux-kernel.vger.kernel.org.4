Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36BF62FBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiKRRsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiKRRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:48:03 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C55ADD0;
        Fri, 18 Nov 2022 09:48:02 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHlsK3063769;
        Fri, 18 Nov 2022 11:47:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668793674;
        bh=A3nwiVPbNBlR3dhAOxqZ5DKYo/hsCFbpVuyuzPtXeas=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qxEgTIePG4rXEMarwpABpAW4ju+oQynwSWbf6ecxNSkOSMrR15yOj+GUcTKK3Pip3
         atnVjnVpaneUNbrjTL+2KqyJoHw9kb2fu1TyOLiX3tfRYs/dIicj+BhHnvnuTu8Mi8
         L7YP2S02k0jsXdGYIswqMLx1/xVCREwpi3S3U9c0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AIHlsMr038405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 11:47:54 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 18
 Nov 2022 11:47:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 18 Nov 2022 11:47:54 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHlsUr091109;
        Fri, 18 Nov 2022 11:47:54 -0600
Date:   Fri, 18 Nov 2022 11:47:54 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Message-ID: <20221118174754.y37pq77drvla2uxj@tinderbox>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-5-a-nandan@ti.com>
 <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
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

On 11:40-20221118, Andrew Davis wrote:
> On 11/16/22 7:04 AM, Apurva Nandan wrote:

[...]

> > +#include <dt-bindings/net/ti-dp83867.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "k3-j784s4.dtsi"
> > +
> > +/ {
> > +	compatible = "ti,j784s4-evm", "ti,j784s4";
> > +	model = "Texas Instruments J784S4 EVM";
> > +
> > +	chosen {
> > +		stdout-path = "serial2:115200n8";
> > +	};
> > +
> > +	aliases {
> > +		serial2 = &main_uart8;
> 
> This feels hacky. Your chosen node picks serial2 as that is usually
> the one that is wired up on K3 boards. But on this board it is main_uart8.
> So why not have this be serial10, then choose
> 
> stdout-path = "serial10:115200n8";
> 
> Also, I've made comments on previous version of this series, it is
> nice to include folks who have commented before in the CC for future
> versions, that way our filters don't hide these away and we can more
> easily check that our comments have been addressed.

Please stick with the standard of serial2 as the linux console standard.
We ended up with that to ease up capabilities of various distros to
uniformly work across SoC and board variants.

I do agree that phandle is the wrong approach here (baud etc information
missing). "serial2:115200n8" is probably the way to do this right.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
