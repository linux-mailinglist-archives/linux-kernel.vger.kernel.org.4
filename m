Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF56C8494
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCXSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCXSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:14:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE4193EC;
        Fri, 24 Mar 2023 11:14:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32OIEafR026550;
        Fri, 24 Mar 2023 13:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679681676;
        bh=YK4F4tSGAcURqTAwwf797Br7wFrzaKlT5abaM+BnqeU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=C7sCQdEgjNzchT8Sklrb/p0JBDCLjBUU00UBzYEOuX/aHnNs/Dw0WG/Tc6eFAWW04
         V37+ytWzWTKYgt8/aqzEn4OcIXobES7MTl6UXWQqWHVJNeHUAQepigIbodpBkpaHE9
         cLkL4zREpw0OVqthl8jNGvWIpLKiKiSQx/EOGIf0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32OIEai4010305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 13:14:36 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 13:14:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 13:14:35 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32OIEah9120867;
        Fri, 24 Mar 2023 13:14:36 -0500
Date:   Fri, 24 Mar 2023 13:14:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider
 property to usbss1
Message-ID: <20230324181435.i2n2q6cvh6x4kabw@repeal>
References: <20230324133150.43224-1-rogerq@kernel.org>
 <20230324133150.43224-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230324133150.43224-2-rogerq@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:31-20230324, Roger Quadros wrote:
> From: Dhruva Gole <d-gole@ti.com>
> 
> The property "ti,vbus-divider" is needed for both usbss0 and usbss1 as
> both USB0 and USB1 have the same external voltage divider circuit.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 67dc26fc23e4..be027fad5f61 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -482,6 +482,7 @@ &usbss0 {
>  
>  &usbss1 {
>  	status = "okay";
> +	ti,vbus-divider;
>  };
>  

1. Does'nt this need a fixes tag?
2. lakml is missing in CC

>  &usb0 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
