Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECC5EA7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiIZOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiIZOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:07:49 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6342028AC;
        Mon, 26 Sep 2022 05:18:54 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q6n3rW004276;
        Mon, 26 Sep 2022 12:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2YNk7rnU4FZ13+o3uecNedyFsARFhIeA+ezdGLGCGk4=;
 b=N/E+FthewNCLizrMRhhzGDsnNtzC5gNVHOgrchi7o+xablsWgHH+JEMTQiXZhSvOMoZF
 kzTVL/7paUPj9gIK5AjIdHwHUp7zTtr0ZmML/F5lH58fLbqaEzl1/JMe+pdtzO3+Q8Wv
 CpBDc0wdI3ZADsJ/CjInzicNOln/2ljjhh0sXV1kE4pHVox8SAaqpK7MvnEV11EBxYCV
 bVSyfx7fdin1+6kiOhGPclP/i9t9BNg6jqBDp10SKp6K4Hi4N4/6ZHgFc4FvJLcX115F
 YpdWo1trqKRP9h5ipHecJh8EJQHY+YYq8KPJ3a2K8UZTqiw7STbaldSlTTyBx3hBs9MH Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsrsjau3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 12:32:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02E3B100034;
        Mon, 26 Sep 2022 12:32:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7CD6D21FEA8;
        Mon, 26 Sep 2022 12:32:03 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.51) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 12:32:03 +0200
Message-ID: <a8d9aee9-a1e3-5d9a-b9f3-4e92f79a99ef@foss.st.com>
Date:   Mon, 26 Sep 2022 12:32:02 +0200
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
 <c21b9c95-ae35-fd7e-9e8e-6926703725b4@foss.st.com>
 <5145d4db-65bf-971d-84cd-73c222311cd3@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <5145d4db-65bf-971d-84cd-73c222311cd3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 11:21, Krzysztof Kozlowski wrote:
> On 23/09/2022 10:29, Alexandre TORGUE wrote:
>> Hi Krzysztof
>>
>> On 9/19/22 13:32, Krzysztof Kozlowski wrote:
>>> On 13/09/2022 09:46, Alexandre Torgue wrote:
>>>> Add "interrupt-controller" and gpio-line-names to gpio subnodes in order to
>>>> fix dtb validation.
>>>
>>> Rebase your patch on recent Linux kernel and use get_maintainers.pl.
>>
>> I did it on 6.0-rc5 but yes I used your kernel.org address instead of
>> linaro ones. Sorry.
>>
>>>
>>>>
>>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>>>> index d35dcc4f0242..92582cccbb1b 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>>>> @@ -65,6 +65,10 @@ patternProperties:
>>>>          '#gpio-cells':
>>>>            const: 2
>>>>    
>>>> +      interrupt-controller: true
>>>> +      '#interrupt-cells':
>>>> +        const: 2
>>>> +
>>>>          reg:
>>>>            maxItems: 1
>>>>          clocks:
>>>> @@ -80,6 +84,8 @@ patternProperties:
>>>>            minimum: 1
>>>>            maximum: 16
>>>>    
>>>> +      gpio-line-names: true
>>>
>>> maxItems?
>>
>> Generic question, Is it mandatory to add maxItems information for all
>> entries ?
> 
> It's not mandatory for all. For some it is recommended, for some it does
> not make sense. Here it's quite easy to add and it will validate the
> entry. Any reason not to add it?

Ok understood. To be honest, no reasons to not add it.

cheers
alex

> 
> Best regards,
> Krzysztof
> 

