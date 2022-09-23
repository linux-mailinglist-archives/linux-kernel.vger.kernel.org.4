Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B85E75D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIWIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiIWIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:30:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBDE1DF0A;
        Fri, 23 Sep 2022 01:30:09 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N8NuVn008297;
        Fri, 23 Sep 2022 10:29:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0DVET0yqg0ORfnzJuoG/jUYeOp0S+RFad2f1MOPoD2o=;
 b=ftf55e/g/O8czrKa6QDoCm9piO9tMutoL5xtsunXRbhxp/QSZBH2imhyDoVejK9jFnx3
 rlcVjQMRmCiDWvyB03wcstLM1rUmPvxA+FTiB3mIU+0Y1hS0iDAC32Z7FxCYogPVSJAQ
 7MX629zBlHxo2Vp3fW29KLCUVmwwqZofNo6AFbynCuwz2M/ax9Eb1OOGaAxaQLMwnt8a
 HpmQcFxONfsmwAX+fPQaQB2D4t2j1Q/D8xKsffDqnrNTZftVNd6zl6ybez1L9BqGgnHv
 BXihx+pKwiafyve7NEOVh0/MIjvZJLGl0oxFrGYM9SKNEvTseNuFQv8UHnFB44511WTD JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jn6g5wc4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 10:29:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2CC3410002A;
        Fri, 23 Sep 2022 10:29:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 972402171C6;
        Fri, 23 Sep 2022 10:29:47 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.119) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 10:29:46 +0200
Message-ID: <c21b9c95-ae35-fd7e-9e8e-6926703725b4@foss.st.com>
Date:   Fri, 23 Sep 2022 10:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: pinctrl: stm32: add missing entries for gpio
 subnodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
References: <20220913074639.31932-1-alexandre.torgue@foss.st.com>
 <9b711a9e-9e63-b69e-fabf-e05c11f145a6@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <9b711a9e-9e63-b69e-fabf-e05c11f145a6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 9/19/22 13:32, Krzysztof Kozlowski wrote:
> On 13/09/2022 09:46, Alexandre Torgue wrote:
>> Add "interrupt-controller" and gpio-line-names to gpio subnodes in order to
>> fix dtb validation.
> 
> Rebase your patch on recent Linux kernel and use get_maintainers.pl.

I did it on 6.0-rc5 but yes I used your kernel.org address instead of 
linaro ones. Sorry.

> 
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>> index d35dcc4f0242..92582cccbb1b 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>> @@ -65,6 +65,10 @@ patternProperties:
>>         '#gpio-cells':
>>           const: 2
>>   
>> +      interrupt-controller: true
>> +      '#interrupt-cells':
>> +        const: 2
>> +
>>         reg:
>>           maxItems: 1
>>         clocks:
>> @@ -80,6 +84,8 @@ patternProperties:
>>           minimum: 1
>>           maximum: 16
>>   
>> +      gpio-line-names: true
> 
> maxItems?

Generic question, Is it mandatory to add maxItems information for all 
entries ?

For sure I'll send a v2 with it.

Alex

> 
> 
> Best regards,
> Krzysztof

