Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB46F7082
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54B46A3;
        Thu,  4 May 2023 10:10:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344GYtMP016288;
        Thu, 4 May 2023 19:10:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rkbvLyVT3Mb/rSSlFLY4A805v2Hk2Yhfbj8z298Ej7M=;
 b=BSdj86tRf6c/laZrSlGXBL3fYo19jKVP2cAxj8qbQ63UZu2NCz8DnuhxngaNn9CWlCh6
 anfKkr3HY3kWzAmzD8//aLI0sCLRt/SaQX7cKWho/TPXSApiZeFsNs72EI/G+yJwr9ZF
 lgOBn15eIgjKs08ydxGOQ/mqOOGaxhS39iwmf1pwhqQ+FyI7MLW/a4MBuGIpNXfU6bRx
 UxJEYuuxjYs8vmzW/OuPs1fXrsupmM6xU3mwRDGqZbZrzN12/TeMXTVGjOpy6pPjf7S8
 mvYWjRED/zdlnouyq3Rue0t1epNrM6fry8VxGHcaaxIAc2y2EKzwr6UMj/Md1zG8xUGJ 2Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qc6uwcjhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 19:10:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7AE910002A;
        Thu,  4 May 2023 19:10:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C77DC227F0C;
        Thu,  4 May 2023 19:10:01 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 19:10:00 +0200
Message-ID: <9100bb4f-d12b-79f6-659c-0005294886fa@foss.st.com>
Date:   Thu, 4 May 2023 19:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] dt-bindings: spi: stm32: add address-cells and
 size-cells into yaml
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-2-valentin.caron@foss.st.com>
 <20230428214157.GA322525-robh@kernel.org>
Content-Language: en-US
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20230428214157.GA322525-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/28/23 23:41, Rob Herring wrote:
> On Fri, Apr 28, 2023 at 02:15:18PM +0200, Valentin Caron wrote:
>> Theses properties need to be described to satisfy dtbs_check.
> No, they are defined in spi-controller.yaml, so they should not be
> needed here.

Yes, you're right, I cannot remember why I need to add theses properties.

Thank you,
Valentin

>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> index 9ca1a843c820..c599eb359d56 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> @@ -29,6 +29,9 @@ allOf:
>>           st,spi-midi-ns: false
>>   
>>   properties:
>> +  "#address-cells": true
>> +  "#size-cells": true
>> +
>>     compatible:
>>       enum:
>>         - st,stm32f4-spi
>> -- 
>> 2.25.1
>>
