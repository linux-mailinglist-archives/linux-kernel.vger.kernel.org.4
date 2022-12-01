Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D263E7D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLACcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLACcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:32:06 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF58326C;
        Wed, 30 Nov 2022 18:32:05 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B12Vj4F043071;
        Wed, 30 Nov 2022 20:31:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669861905;
        bh=UVm2cwIB8TlThIuDCvHm+qtDDX5Qgobx7dXacY8aEKI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qW0EQi4EG5UdeXGTqIcK/SJYbmn3rzTWAOQVPKpJjMHIL36irEttJ4TzRaPlOQXC4
         08PNefjHI+aZU5Oa2DHqXBxnuA84EpgM8qi+GjKhufZqRIoT0/dxr9zQOBdTtUW0Ht
         nBl+XP7KmAHKRorOe75YfRXjr8MKu8Mp31APxaI0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B12VjlI010430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Nov 2022 20:31:45 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 30
 Nov 2022 20:31:44 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 30 Nov 2022 20:31:44 -0600
Received: from [10.250.151.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B12VZV1027042;
        Wed, 30 Nov 2022 20:31:36 -0600
Message-ID: <067ea483-6533-1b1e-c522-751e07033ac9@ti.com>
Date:   Thu, 1 Dec 2022 08:01:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH resend] thermal: ti-soc-thermal: Drop comma after SoC
 match table sentinel
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1d6de2a80b919cb11199e56ac06ad21c273ebe57.1669045586.git.geert+renesas@glider.be>
Content-Language: en-US
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <1d6de2a80b919cb11199e56ac06ad21c273ebe57.1669045586.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 9:17 PM, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 53d409c80753c25e..576c2115df85da72 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -877,7 +877,7 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
>    */
>   static const struct soc_device_attribute soc_no_cpu_notifier[] = {
>   	{ .machine = "OMAP4430" },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>   };
>   
>   /***   Device driver call backs   ***/
