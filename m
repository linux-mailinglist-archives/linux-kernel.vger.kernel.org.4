Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3F604E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJSRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiJSRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:24:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2F18DD79;
        Wed, 19 Oct 2022 10:24:05 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFwhdS021524;
        Wed, 19 Oct 2022 19:23:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=z4NuzLYnlhuUAveYIXaA0i15wFwqK0u8Xd/CIKAqiIg=;
 b=NFKujf5ixQszUEjatken2l9ciMY1ctnAjSp39seTO4kzacyeyBb5qNecgBiM/58D0R47
 9WIbKrgJVojkLDymJtHpglLYhbJzOczg38pBY2OBAvmf5rAvFk0HO2IeAOCUAnDhbcwq
 puWuwJuj+cDvwI9PA21fc7tAOL9Xbmg5DyhVFCPO/dUrzXsh54LBn+p0ZwGwT8Vs5f07
 YMDarjzE61A8Gx2afrSFzWAGLlhgIv3TSuZ59rSTaoxT6gkrl2J/4p7pylDW/Tr0Iidu
 zsTfNnJ0fzNybSLgec1ko/T+fTlZR9EWKJBFa4npcUJGaLF1ZGCZtr+Bp0APxRan2ino aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7j9n4n32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 19:23:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67874100034;
        Wed, 19 Oct 2022 19:23:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61E4623D3F0;
        Wed, 19 Oct 2022 19:23:38 +0200 (CEST)
Received: from [10.48.0.213] (10.48.0.213) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 19:23:35 +0200
Message-ID: <4d113cfd-4c22-780e-2a13-48ca0e2b28ab@foss.st.com>
Date:   Wed, 19 Oct 2022 19:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: nvmem: add new stm32mp13 compatible for
 stm32-romem
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
 <7ada410d-8d13-b29a-869c-3f5d032528bf@linaro.org>
Content-Language: en-US
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <7ada410d-8d13-b29a-869c-3f5d032528bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.213]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_10,2022-10-19_04,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/22 03:56, Krzysztof Kozlowski wrote:
> On 14/10/2022 11:23, Patrick Delaunay wrote:
>> Add a new compatible for stm32mp13 support.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
>> index 448a2678dc62..16f4cad2fa55 100644
>> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
>> @@ -22,6 +22,7 @@ properties:
>>     compatible:
>>       enum:
>>         - st,stm32f4-otp
>> +      - st,stm32mp13-bsec
>>         - st,stm32mp15-bsec
> According to usage in DTS (separate patch for some reason), the devices
> are compatible, so please describe them like that.


I push the separate patch "ARM: dts: stm32mp13: fix compatible for BSEC"

It is a advice of my colleagues: send an update of device tree

only when the binding modification is acked.


Sorry for disturbance, I can sent a V2 with the 2 patches.


The STM32MP15 and STM32MP13 don't use the same version of the BSEC device,

and the driver need to handle it.


In these 2 patches:

- [PATCH] dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem

- [PATCH] ARM: dts: stm32mp13: fix compatible for BSEC


I fix a error for BSEC node in the initial patch to support STM32MP13x,

the DTS "stm32mp131.dtsi" should not used/accepted with the a BSEC node 
using

the compatible "st,stm32mp15-bsec" in commit 1da8779c0029 ("ARM: dts: 
stm32: add STM32MP13 SoCs support")


It is a preliminary step to add support of STM32MP13x in STM32 ROMEM driver.


I don't indicate these patches as "Fixes:" to avoid a dts check issue

if only the DTS patch was backported.


Today it not blocking for STM32MP13x users because this SoC is not yet 
available for customers

and it is only used internally on the ST Microelectronics board 
STM32MP135F-DK.


Nobody (except STMicroelectronics) use this SoC  STM32MP13x with the 
current DTS / Linux version.


Moreover, by default, the STM32 ROMEM driver in not activated in any 
defconfig,

I prepare a other patch to activated it by default in arm_multiv7_defconfig.

but I am waiting this DTS correction to avoid to probe the stm32 romen 
driver with STM32MP15

configuration on STM32MP13x SoC.


I think is a good time to update this DTS error before the SoC availability,

agreed with SoC Maintainer, Alexandre Torgue, even if this patch breaks 
surrent users

of STM32MP13x DTS (but it is only internals user STMicroelectronics 
until now).


but perhaps you prefer a other solution ?


add Fixes in the DTS patch ?

+ Fixes: 1da8779c0029 ("ARM: dts: stm32: add STM32MP13 SoCs support")

or


         bsec: efuse@5c005000 {
             compatible = "st,stm32mp13-bsec", "st,stm32mp15-bsec";


sorry, I misses to share this context.


>
> Best regards,
> Krzysztof


Regards

Patrick

