Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E687054A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEPRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEPRCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:02:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B083EC;
        Tue, 16 May 2023 10:02:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GE7fMQ015581;
        Tue, 16 May 2023 19:01:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=EEGjMvBwmChywxvRvi7rS3GCQucVoQGQ96IwahsoA5Q=;
 b=rnPxbOSHwO2TIpEiV36gayBM2qIkRyZ7Lm9yeNMl3nyf/YO56dDvdN9nmRH+ARYZncXJ
 chxQzRNF0+GwPltv3+zJoSpa+eeyIG6fj8/NhsZa55VQ7TPzIyMluubHpfpLF95aAfAX
 LQTodchwDIsyreKvVi1zCT2q4xwkJyRqhzePsV3IfjllNyx1apre7nNKbmycAfL3zJ5P
 5DN1vr9wnx2mDHvC8MKYgZ7jq3AZnwEYAthHXyJdz+MlqrsW+Z+O2RkUA6DhCqzjmqrW
 YinV9MP8sDAMg6dQpUpdp/rzQByw4K4FRgQ7yEbpxqSV5O2ysl+04aeeR/ZHw1YvFM8N uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qm7tfagke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 19:01:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 336B410002A;
        Tue, 16 May 2023 19:01:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A10423BDF3;
        Tue, 16 May 2023 19:01:57 +0200 (CEST)
Received: from [10.201.21.213] (10.201.21.213) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 16 May
 2023 19:01:53 +0200
Message-ID: <33acd8d5-20bf-e39d-85c8-4379f5e7e6ad@foss.st.com>
Date:   Tue, 16 May 2023 19:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/4] ARM: dts: stm32: fix m4_rproc references to use
 SCMI
Content-Language: en-US
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
 <20230512093926.661509-5-arnaud.pouliquen@foss.st.com>
 <20c010da-7245-7acf-db2f-991ee2975ea2@foss.st.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20c010da-7245-7acf-db2f-991ee2975ea2@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 5/16/23 17:35, Alexandre TORGUE wrote:
> Hi Arnaud
> 
> On 5/12/23 11:39, Arnaud Pouliquen wrote:
>> Fixes stm32mp15*-scmi DTS files introduced in [1]:
>> This patch fixes the node which uses the MCU reset and adds the
>> missing HOLD_BOOT which is also handled by the SCMI reset service.
>>
>> This change cannot be applied as a fix on commit [1], the management
>> of the hold boot impacts also the stm32_rproc driver.
>>
>> [1] 'commit 5b7e58313a77 ("ARM: dts: stm32: Add SCMI version of STM32 boards
>> (DK1/DK2/ED1/EV1)")'
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
> 
> I just ran YAML validation on your DT patches and it fails. I added your DT
> patches + dt-binding one (just for the test). I got the following issue:
> 
> /arch/arm/boot/dts/stm32mp157c-ed1-scmi.dtb: m4@10000000: st,syscfg-holdboot:
> False schema does not allow [[7, 268, 1]]
>     From schema:
> /local/home/frq08678/STLINUX/kernel/my-kernel/stm32/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> 
> Do I miss another dt-binding update not present in this series ?

I reproduced the issue.

I need to add "/delete-property/ st,syscfg-holdboot;" in stm32mp157*-scmi.dts
files.

As Mathieu already integrates the patch 1/4 and 2/4, I will send a V4 containing
only the patches 3 and 4.

Thanks,
Arnaud

> 
> alex
> 
>>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 6 ++++--
>>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 6 ++++--
>>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 6 ++++--
>>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 6 ++++--
>>   4 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> index e539cc80bef8..134788e64265 100644
>> --- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> @@ -55,8 +55,10 @@ &mdma1 {
>>       resets = <&scmi_reset RST_SCMI_MDMA>;
>>   };
>>   -&mlahb {
>> -    resets = <&scmi_reset RST_SCMI_MCU>;
>> +&m4_rproc {
>> +    resets = <&scmi_reset RST_SCMI_MCU>,
>> +         <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
>> +    reset-names =  "mcu_rst", "hold_boot";
>>   };
>>     &rcc {
>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> index 97e4f94b0a24..c42e658debfb 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> @@ -61,8 +61,10 @@ &mdma1 {
>>       resets = <&scmi_reset RST_SCMI_MDMA>;
>>   };
>>   -&mlahb {
>> -    resets = <&scmi_reset RST_SCMI_MCU>;
>> +&m4_rproc {
>> +    resets = <&scmi_reset RST_SCMI_MCU>,
>> +         <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
>> +    reset-names =  "mcu_rst", "hold_boot";
>>   };
>>     &rcc {
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> index 9cf0a44d2f47..7a56ff2d4185 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> @@ -60,8 +60,10 @@ &mdma1 {
>>       resets = <&scmi_reset RST_SCMI_MDMA>;
>>   };
>>   -&mlahb {
>> -    resets = <&scmi_reset RST_SCMI_MCU>;
>> +&m4_rproc {
>> +    resets = <&scmi_reset RST_SCMI_MCU>,
>> +         <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
>> +    reset-names =  "mcu_rst", "hold_boot";
>>   };
>>     &rcc {
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> index 3b9dd6f4ccc9..119874dd91e4 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> @@ -66,8 +66,10 @@ &mdma1 {
>>       resets = <&scmi_reset RST_SCMI_MDMA>;
>>   };
>>   -&mlahb {
>> -    resets = <&scmi_reset RST_SCMI_MCU>;
>> +&m4_rproc {
>> +    resets = <&scmi_reset RST_SCMI_MCU>,
>> +         <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
>> +    reset-names =  "mcu_rst", "hold_boot";
>>   };
>>     &rcc {
> 
