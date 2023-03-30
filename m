Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068376D0A34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjC3PmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjC3PmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:42:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D9D53F;
        Thu, 30 Mar 2023 08:41:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UFO6me085602;
        Thu, 30 Mar 2023 10:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680189846;
        bh=ySGkM7XhpG2QJR1IyhjEH+r6F5YDlBy7XmSF2pLNiLY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OfDtqJA0S346CYC/aP76oa+JLNMZ/Z746NEj7xa39na1vwfe5U6VfcTZglAJGjsVZ
         JLLKPCRPmPEKosoyr91ZAhDw/BJ3JnjvaK9NngS4aUcyZX/5TeXQJf1eTfE0gw5QZy
         mjvfI64T6Mq/mtrbnwrEpotddWAWWXX6Q51ymJhY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UFO6EW031585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 10:24:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 10:24:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 10:24:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UFO6OH011690;
        Thu, 30 Mar 2023 10:24:06 -0500
Date:   Thu, 30 Mar 2023 10:24:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support
Message-ID: <20230330152406.fmpri7nnzybf7uqh@jubilance>
References: <20230327083100.12587-1-a-nandan@ti.com>
 <f3be8f20-fe56-489e-440c-53ca66f00508@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3be8f20-fe56-489e-440c-53ca66f00508@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:50-20230330, Bhavya Kapoor wrote:
> 
> On 27/03/23 14:01, Apurva Nandan wrote:
> > Add support for eMMC card connected to main sdhci0 instance.
> > 
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> 
> Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
> 
> > ---
> >   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > index 7480f37e89e8..1622a01a4667 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > @@ -21,6 +21,7 @@ chosen {
> > 
> >   	aliases {
> >   		serial2 = &main_uart8;
> > +		mmc0 = &main_sdhci0;
> >   		mmc1 = &main_sdhci1;
> >   		i2c0 = &main_i2c0;
> >   	};
> > @@ -225,6 +226,14 @@ exp2: gpio@22 {
> >   	};
> >   };
> > 
> > +&main_sdhci0 {
> > +	/* eMMC */
> > +	status = "okay";
> > +	non-removable;
> > +	ti,driver-strength-ohm = <50>;
> > +	disable-wp;
> > +};
> > +
> >   &main_sdhci1 {
> >   	/* SD card */
> >   	status = "okay";
> > --
> > 2.34.1
> Looks correct to me.


Don't you need pinmux?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
