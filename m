Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF872847F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFHQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjFHQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:01:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453130C6;
        Thu,  8 Jun 2023 09:01:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 358G0up0003457;
        Thu, 8 Jun 2023 11:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686240056;
        bh=+044SB8JfSnWUwpBcTcNTtHlcD21RFEeVggm7URky6I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=h6F3VYVpzCHuJGJXoig9h0xAF0hFY0eQE2iDczds3Jg/zWaPA0XFW6+uFuCu70HUU
         4asgU2N6RcdUqzbTeZIw5TdCAA8JrTlKRk5mmiqDnJhhM8YfxE5MZRwb+l/G12U+Fv
         xTcpscwcCh79qtWd5okIrpa99306jP1dQ8hpOy6k=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 358G0uDm091311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jun 2023 11:00:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Jun 2023 11:00:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Jun 2023 11:00:56 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 358G0qck023969;
        Thu, 8 Jun 2023 11:00:52 -0500
Message-ID: <fd3e3174-a2cd-9cd1-d04a-cd82a07977b7@ti.com>
Date:   Thu, 8 Jun 2023 21:30:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200-common-proc-board: Add
 uart pin mux in wkup_pmx0
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
References: <20230604045525.1889083-1-u-kumar1@ti.com>
 <20230604045525.1889083-6-u-kumar1@ti.com>
 <20230606120959.r4pnxuigknl7qkjr@outpour>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230606120959.r4pnxuigknl7qkjr@outpour>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nishanth

On 6/6/2023 5:39 PM, Nishanth Menon wrote:
> On 10:25-20230604, Udit Kumar wrote:
>> Add uart pin mux of wkup domain into common board file.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   .../dts/ti/k3-j7200-common-proc-board.dts     | 22 ++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index e12d93f56c51..809d1c910015 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -79,6 +79,24 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
>>   	};
>>   };
>>   
>> [..]
> Could you add the pins to wkup_uart0 node as well?
>
>> +		pinctrl-single,pins = <
>> +			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
>> +			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
>> +		>;
>> +	};
>> +};
> We are also missing pinmux for main_uart1 and main_uart2


I will address missing pin mux in next version

> [..]
