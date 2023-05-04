Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB9B6F709E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEDROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEDROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:14:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1504491;
        Thu,  4 May 2023 10:13:44 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344GOodc004106;
        Thu, 4 May 2023 19:13:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ihg12T+69B+3QoBkRHL955kHcMtgqd6NplSZmSmTng0=;
 b=xOTudm6fa9ewAcy2R/FOby93Uc/fzNtqjriXqM5uNuVInv+UaVEHxP0hZQ3vfe1AsMMN
 zeTz81wXONSYfDetpdbVlOz5K8+WOTyzEaqMtdPQ48pM1wYto8eS/Y/hVn9uwTJwxLf7
 QluN2Gz5hSspBcl3pYsuXoUs/8o3oGS1MXpL2NwEzPemkBJnjgUJ4Vi2PlU5PC5ePdib
 uzY6PusJ08QxaXi49vSWM1Ul7PYfcLMZARcF3JysW+fQKW0oQxUxRN20Ny3sm7qoIqZ+
 b5wwmYm3MMsOyx3e5WwR1mp8VAcDJQhn9/PpSuKKPdUYzmQUYFKw7Kdizf6OFo1gA2lK 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qbu4j7au3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 19:13:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76E5110002A;
        Thu,  4 May 2023 19:13:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C5F3227F18;
        Thu,  4 May 2023 19:13:35 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 19:13:34 +0200
Message-ID: <b03257a8-2236-c709-043d-ffa4e6b062a8@foss.st.com>
Date:   Thu, 4 May 2023 19:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/7] dt-bindings: spi: stm32: add stm32h7
 st,spi-slave-underrun property
Content-Language: en-US
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
 <20230428121524.2125832-7-valentin.caron@foss.st.com>
 <20230428215641.GA332435-robh@kernel.org>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20230428215641.GA332435-robh@kernel.org>
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


On 4/28/23 23:56, Rob Herring wrote:
> On Fri, Apr 28, 2023 at 02:15:23PM +0200, Valentin Caron wrote:
>> This property is used to enable and configure stm32h7 SPI controller to
>> handle underrun that could appear in slave mode.
>>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   .../devicetree/bindings/spi/st,stm32-spi.yaml     |  8 ++++++++
>>   MAINTAINERS                                       |  1 +
>>   include/dt-bindings/spi/spi-stm32.h               | 15 +++++++++++++++
>>   3 files changed, 24 insertions(+)
>>   create mode 100644 include/dt-bindings/spi/spi-stm32.h
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> index 1d26fa2658c5..e946ea71a247 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> @@ -28,6 +28,7 @@ allOf:
>>         properties:
>>           st,spi-midi-ns: false
>>           spi-slave: false
>> +        st,spi-slave-underrun: false
>>   
>>   properties:
>>     "#address-cells": true
>> @@ -70,6 +71,13 @@ properties:
>>         In case of spi-slave defined, if <0>, indicate that SS should be
>>         detected via the dedicated HW pin
>>   
>> +  st,spi-slave-underrun:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      First parameter enables and selects slave underrun reaction.
>> +      Refer to "dt-bindings/spi/spi-stm32.h" for the supported values.
>> +      Second parameter is the pattern in case of SPI_SEND_PATTERN mode.
> So, max 2 cells? Then:
>
> minItems: 1
> maxItems: 2
>
> Though I don't really think this belongs in DT. The driver implementing
> the SPI slave function defines all the rest of the protocol the slave
> implements. Why not this little bit? Perhaps there is no way for a SPI
> slave driver to tell the SPI controller which controller specific mode
> to use, so you abuse DT to configure the SPI controller. Also, with a
> controller specific response, then the slave driver is coupled to that
> SPI controller which isn't great either.
>
> Rob
I basically made this DT property to configure the controler and doesn't
give attention to the fact that this parameter can came from framework.

I will not rework this functionality, but simply let it down as we has
no demands on it.

Thanks for all your remarks,
Valentin
