Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDE6F03F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbjD0KJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjD0KJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:09:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3261892;
        Thu, 27 Apr 2023 03:09:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33RA95Eo111786;
        Thu, 27 Apr 2023 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682590145;
        bh=5R2fhojW6V0uw1XdQV9VrPNhcf4y1GUJ9EavXHUjwLA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Elp678UfEnqHGSTZJvdo/AaSRaJMlsVEFkNjaphsiIC0emALhU4qiw876VZgKOMs/
         oRN0AooxHfUXXD6yy0wVO9qVWUgRW1rflLh3cGj5QRSTIImjS289OZvdQgc8MJi9zK
         2sutW7YPi/+1E+vj/FYhTJBoC9bCkxAPkN8rx/1U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33RA954n102611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Apr 2023 05:09:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Apr 2023 05:09:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Apr 2023 05:09:05 -0500
Received: from [10.249.130.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33RA91tS043983;
        Thu, 27 Apr 2023 05:09:01 -0500
Message-ID: <24ea8982-e2ab-d58d-dedd-f51703d0bb92@ti.com>
Date:   Thu, 27 Apr 2023 15:39:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [EXTERNAL] Re: [PATCH 1/5] arm64: dts: ti: k3-j7200: Add general
 purpose timers
To:     Tony Lindgren <tony@atomide.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-2-u-kumar1@ti.com>
 <20230427080049.GH14287@atomide.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230427080049.GH14287@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony

On 4/27/2023 1:30 PM, Tony Lindgren wrote:
> Hi,
>
> * Udit Kumar <u-kumar1@ti.com> [230426 10:38]:
>> There are 20 general purpose timers on j7200 that can be used for things
>> like PWM using pwm-omap-dmtimer driver. There are also additional ten
>> timers in the MCU domain.
> ...
>
> ....
> Oh so also the MCU timers now have interrupts, nice. Can you please check
> if what we have in the comments the other SoCs in the dtsi files for MCU
> timers not having routable interrupts is correct?

checked for AM65 and AM64, looks these SOC follow different IT map wrt J7200

On J7200 reading TRM

https://www.ti.com/lit/pdf/spruiu1

Section 9.4.3.1.2 GIC500 SPI Interrupt Map, table Table 9-109.

MCU_TIMER0_INTR_PEND_0 (848) to MCU_TIMER9_INTR_PEND_0 (857)

looks to be available for A core.

> Also, should the MCU timers be still tagged with status = "reserved"?
Will mark status as  reserved
> See the comments in k3-am62-mcu.dtsi for example for both questions.
>
> Regards,
>
> Tony
