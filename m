Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63396D0DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjC3S1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjC3S1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:27:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123DEC78;
        Thu, 30 Mar 2023 11:27:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UIRZvH051124;
        Thu, 30 Mar 2023 13:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680200855;
        bh=iwVvxxRviT6unOdLjY9LnCnWTXA8oTUOvdHCBztIn4Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=o8RFiSyoupCLX3l+sReRbvjwU+3QYgCbUgmIU/JM29f1oJhfKsbUfBE622Hp8BqoL
         nue6EOUT6JoOBGQDYh0G93KHQfUqlICdsSL/KHxqpJ63RElfbI3e8o0IIjAXNfo2GK
         nLYPcsPA8bt2xykk3ld5e1YlE9mN9sFGhjBXyuZA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UIRZPD007347
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 13:27:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 13:27:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 13:27:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UIRZPC023276;
        Thu, 30 Mar 2023 13:27:35 -0500
Date:   Thu, 30 Mar 2023 13:27:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support
Message-ID: <20230330182735.2lkuplsqcjku5enh@unnoticed>
References: <20230327083100.12587-1-a-nandan@ti.com>
 <f3be8f20-fe56-489e-440c-53ca66f00508@ti.com>
 <20230330152406.fmpri7nnzybf7uqh@jubilance>
 <8f4e8265-da64-1e53-e1ed-b925e0326cad@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f4e8265-da64-1e53-e1ed-b925e0326cad@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:14-20230330, Bhavya Kapoor wrote:
> 
> On 30/03/23 20:54, Nishanth Menon wrote:
> > On 11:50-20230330, Bhavya Kapoor wrote:
> >> On 27/03/23 14:01, Apurva Nandan wrote:
> >>> Add support for eMMC card connected to main sdhci0 instance.
> >>>
> >>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >> Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
> >>
> >>> ---
> >>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 9 +++++++++
> >>>   1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> >>> index 7480f37e89e8..1622a01a4667 100644
> >>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> >>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> >>> @@ -21,6 +21,7 @@ chosen {
> >>>
> >>>   	aliases {
> >>>   		serial2 = &main_uart8;
> >>> +		mmc0 = &main_sdhci0;
> >>>   		mmc1 = &main_sdhci1;
> >>>   		i2c0 = &main_i2c0;
> >>>   	};
> >>> @@ -225,6 +226,14 @@ exp2: gpio@22 {
> >>>   	};
> >>>   };
> >>>
> >>> +&main_sdhci0 {
> >>> +	/* eMMC */
> >>> +	status = "okay";
> >>> +	non-removable;
> >>> +	ti,driver-strength-ohm = <50>;
> >>> +	disable-wp;
> >>> +};
> >>> +
> >>>   &main_sdhci1 {
> >>>   	/* SD card */
> >>>   	status = "okay";
> >>> --
> >>> 2.34.1
> >> Looks correct to me.
> >
> > Don't you need pinmux?
> >
> Hi Nishanth, pinmux is not needed since there is no mux options for emmc pins (mmc0) in datasheet.
> 
>  -> Kindly refer to datasheet for same : https://www.ti.com/lit/ds/symlink/tda4vh-q1.pdf?ts=1680197698102&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTDA4VH-Q1%253FkeyMatch%253DTDA4VH%2BDATASHEET

Aah, yes - thanks for clarifying.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
