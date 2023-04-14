Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2F6E2A03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDNSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:24:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1302210A;
        Fri, 14 Apr 2023 11:24:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EIO1ek015629;
        Fri, 14 Apr 2023 13:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681496641;
        bh=Z5CJHczslczZQ9OeiqWZznyRouEiOAg61taaEPD1DZQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SHjP1a68XYFLwDm99vZAGe1QNvAp/R247cl7QaeRP0SAfNLezA8SXbuZ8Uf1gJseP
         JQAj7nvgEeZLyIfVmN07ochqWFa7x+6mWqJUExhFzeKowuKoHIzbJRxVxwEGiWxZuI
         vnHQF5MoY2m6OP/qh1mklueiK2IZVpAeJk2kt8Tk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EIO1lt003095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 13:24:01 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 13:24:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 13:24:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EIO1EY035581;
        Fri, 14 Apr 2023 13:24:01 -0500
Date:   Fri, 14 Apr 2023 13:24:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Enable
 I2C
Message-ID: <20230414182401.2yfpwjug3naiwesi@quicksand>
References: <20230414181434.2046049-1-u-kumar1@ti.com>
 <20230414181434.2046049-3-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414181434.2046049-3-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:44-20230414, Udit Kumar wrote:
> All I2C nodes were disabled in SOC dts file and in board
> dts needed nodes were enabled.
redundant.

> This patch enables wkup_i2c0 node in board dts file.
> 
> Fixes: a9ed915cd55c ("arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level")


This should'nt be fixing the commit - the commit is correct in the sense
that if the board does'nt describe a node with pinmux, the i2c is'nt
functional in the first place.

> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 63633e4f6c59..e66bbfe65ff2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -254,6 +254,10 @@ exp3: gpio@20 {
>  	};
>  };
>  
> +&wkup_i2c0 {
> +	status = "okay";

How about the pinmux? speed? what peripheral is on the wakeup i2c?

	Do we have an eeprom or something here?

> +};
> +
>  &main_sdhci0 {
>  	/* eMMC */
>  	non-removable;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
