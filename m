Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFF60414E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJSKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiJSKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:41:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE6E5FCB;
        Wed, 19 Oct 2022 03:19:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J8JVb6008813;
        Wed, 19 Oct 2022 10:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0uBWXpcUu6GK+gkxHOG4A7UL9k/FeUaumNYxBXEQc/g=;
 b=Tbbo8XyJBMAaZvPmonEjVONB8bGajBFUM1UjgncjOgOBhvIhRCVEJapSmG9y13hM12ca
 gV9zb8/3GL1ex7TIuDwEcig6KNvPTqswCmPgyfGQj5T21BOZ5Lk/BIzIxcjigqLeYac0
 TqWNAr6JAJqTVCfpK1IXM8alnab1iRZh5xN2Ifa5MPqveDMDjGmfSvjovnkAg4srgn/Z
 VTYfqqtn22EVSN37puSwjPRmgHxWnVrv5GfAcUNRY11mNgbbKWX/PqEinfii9BgQmns1
 4rR0q56XM9XQzawPQPH2Srenqep6uQ6SXHtfECxORr9vaz5F7nLMyTIPTER/g+P7Hyx7 SA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka5emhhe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 10:17:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29JAHiZH023414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 10:17:44 GMT
Received: from [10.253.8.223] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 03:17:42 -0700
Message-ID: <fbae8ec2-a645-6141-8308-3122c2ca9fab@quicinc.com>
Date:   Wed, 19 Oct 2022 18:17:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/2] Add LED driver for flash module in QCOM PMICs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20221018014024.948731-1-quic_fenglinw@quicinc.com>
 <CNPPXFMBHOPK.2XSBJT5M1TNVP@otso>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CNPPXFMBHOPK.2XSBJT5M1TNVP@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O9ApRDCYgI_KUhvlNefCO8N8dAGLBiY-
X-Proofpoint-GUID: O9ApRDCYgI_KUhvlNefCO8N8dAGLBiY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210190057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/19 15:23, Luca Weiss wrote:
> Hi Fenglin,
> 
> On Tue Oct 18, 2022 at 3:40 AM CEST, Fenglin Wu wrote:
>> Initial driver and binding document changes for supporting flash LED
>> module in Qualcomm Technologies, Inc. PMICs.
>>
> 
> Thanks for these patches, it's really nice to see drivers like this
> being sent upstream!
> 
> I've just tried these patches on pm6150l which also is compatible with
> this driver (and used on sm7225-fairphone-fp4).
> 
> The two different flash LEDs on the device I could adjust as expected
> using sysfs:
> 
> $ echo 255 > /sys/class/leds/yellow:flash-0/brightness
> $ echo 255 > /sys/class/leds/white:flash-0/brightness
> 
> Also lower brightness values resulted in lower brightness on the LED, so
> all is good here!
> 
> But for flash usage, I couldn't figure out how to use it, doing the
> following resulted in no change on the LED.
> 
> $ cat /sys/class/leds/white:flash-0/max_flash_brightness
> 1000000
> $ echo 1000000 > /sys/class/leds/white:flash-0/flash_brightness
> 
> Here's my LED definition:
> 
>    led-0 {
>      function = LED_FUNCTION_FLASH;
>      color = <LED_COLOR_ID_YELLOW>;
>      led-sources = <1>;
>      led-max-microamp = <180000>;
>      flash-max-microamp = <1000000>;
>      flash-max-timeout-us = <1280000>;
>    };
> 
>  From values are from msm-4.19 kernel:
> 
>    qcom,flash_0 {
>      qcom,current-ma = <1000>; // => flash-max-microamp
>      qcom,duration-ms = <1280>; // => flash-max-timeout-us
>      qcom,id = <0>; // => led-sources?
>    };
> 
>    qcom,torch_0 {
>      qcom,current-ma = <180>; // => led-max-microamp
>      qcom,id = <0>; // => led-sources?
>    };
> 
> Could you please let me know how flash is supposed to work or if I
> maybe have messed up some setting here?
> 
> Regards
> Luca

Hi Luca,

Thanks for testing the driver at your end.
The "brightness" node is for enabling/disable/adjusting brightness when 
the LED is working in torch mode, the nodes for enabling/adjusting the 
LED behavior in flash mode are "flash_brightness" "flash_timeout" 
"flash_strobe".
You can strobe the flash by "echo 1 > flash_strobe" directly and the 
default brightness/timeout value will be used, or you can update the 
settings with "echo xxx > flash_brightness; echo xxx > flash_timeout" 
then strobe the LED with "echo 1 > flash_strobe". Please remember you 
always need to "echo 0 > flash_strobe" 1st if you want to enable it again.
Thanks

Fenglin
> 
>> Changes in V3:
>>    1. Updated the driver to use regmap_field for register access.
>>    2. Adressed the review comments in binding document change.
>>
>> Changes in V2:
>>    1. Addressed review comments in binding change, thanks Krzysztof!
>>    2. Updated driver to address the compilation issue reported by
>>       kernel test robot.
>>
>>
>> Fenglin Wu (2):
>>    leds: flash: add driver to support flash LED module in QCOM PMICs
>>    dt-bindings: add bindings for QCOM flash LED
>>
>>   .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 +++
>>   drivers/leds/flash/Kconfig                    |  15 +
>>   drivers/leds/flash/Makefile                   |   1 +
>>   drivers/leds/flash/leds-qcom-flash.c          | 700 ++++++++++++++++++
>>   4 files changed, 832 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>>   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
>>
>> -- 
>> 2.25.1
> 
