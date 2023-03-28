Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36086CC79A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjC1QMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjC1QM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:12:28 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E580BA;
        Tue, 28 Mar 2023 09:12:27 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SEAsrt016228;
        Tue, 28 Mar 2023 18:12:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5mP6//w6LL/2ItX1lfQc9H2g3uovyhjnSXOXDMDTlZY=;
 b=pOj/u2G8yJCIK6OOY/55cu9eM5k2TXTmzji0xad199sJ70RBSFS6hIRxfRBwuQ9YC34V
 ZxZaXsqrNX9FudPeEcyBwtkpO1g3deylycxp3Cl8RGR9gFkZrg5O4hG0QUqEUzESBDEA
 e9v/o+SVPsoX1lkI61KECO0z/EjQ2ffXMZG5CIh1gpYMtiP9tQFpp6THXL3gD9dYWIJz
 w7W7PFSfFOoFRwLO4BJWpL3lfNgQuijEPX3YZLkEAqCJhe8XFtHOxMdQNlyB+BEkCHwS
 UEldNG5W+AMc9Q1B/GwCYPcGVFZhYl+qrFcBvxWvazgzPgGb/uGC38r6a/coV2vBz7wD 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkwvsah6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 18:12:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41F6F10002A;
        Tue, 28 Mar 2023 18:12:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3749921A21E;
        Tue, 28 Mar 2023 18:12:16 +0200 (CEST)
Received: from [10.48.0.175] (10.48.0.175) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 18:12:15 +0200
Message-ID: <0f0879bf-2634-09e9-4618-d80c7badc0ce@foss.st.com>
Date:   Tue, 28 Mar 2023 18:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ARM: dts: stm32: add FMC support on STM32MP13x SoC family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230328122606.191211-1-christophe.kerello@foss.st.com>
 <fc0738f5-0494-6142-56a4-ae3d0182a903@linaro.org>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <fc0738f5-0494-6142-56a4-ae3d0182a903@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 3/28/23 16:53, Krzysztof Kozlowski wrote:
> On 28/03/2023 14:26, Christophe Kerello wrote:
>> This patch adds the FMC support on STM32MP13x SoC family.
> 
> Do not use "This commit/patch", but imperative mood. See:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp131.dtsi | 34 +++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
>> index 5949473cbbfd..7af3eb15c204 100644
>> --- a/arch/arm/boot/dts/stm32mp131.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
>> @@ -1137,6 +1137,40 @@ mdma: dma-controller@58000000 {
>>   			dma-requests = <48>;
>>   		};
>>   
>> +		fmc: memory-controller@58002000 {
>> +			#address-cells = <2>;
>> +			#size-cells = <1>;
>> +			compatible = "st,stm32mp1-fmc2-ebi";
>> +			reg = <0x58002000 0x1000>;
> 
> 
> compatible is first, reg is second. ranges if present should be third.
> 

Ok, it will be done in V2.

Regards,
Christophe Kerello.

>> +			clocks = <&rcc FMC_K>;
>> +			resets = <&rcc FMC_R>;
>> +			status = "disabled";
>> +
>> +			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
> 
> Best regards,
> Krzysztof
> 
