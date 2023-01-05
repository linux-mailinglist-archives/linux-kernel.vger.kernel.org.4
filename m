Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61765E37E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAEDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjAEDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:30:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBB2F793;
        Wed,  4 Jan 2023 19:30:22 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3053PKXV012892;
        Thu, 5 Jan 2023 03:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rYZZ7K2evFRILFiOW3T3WVNM4lxUmUKMsxscKwrHJ6I=;
 b=Udx87EQhHLo0CDo8fSBroF+7fDENtAemn9Kdbmikp5mKhYccZHnQUG1h5W6Js1QnUGW3
 Ql7YMsZRuBPlAV19qun2l2IFDFZySyXXtkz/2UgUX/wbM4MKl0x6MNb5VRyn5YiwaIsR
 kZveF2jhYGDNm5Ou6oQwvNZTzeRNdxzyGraK4widgpnEPop46R92EBhykXWyOg5yofF2
 fzvfcumxG/IK3rIROKe8CwsHy5tLy4hAm99VAd4bwTSFJCD5EPiktyW4dNgYAGV3GoHA
 gU52ETxO+jOxb1/IkQHTPf4Tm9F/vDdoN9A1d3adiPmqJ1ltHj7D2bW4oRroft71nZ0X Lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvfbamd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 03:30:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3053U9dh007600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 03:30:09 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 19:30:06 -0800
Message-ID: <ab314039-2c69-8afa-cfb2-e5876ac6afe2@quicinc.com>
Date:   Thu, 5 Jan 2023 11:30:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: configure
 flash LED
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, Pavel Machek <pavel@ucw.cz>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
 <Y5S+6j1yJ62RJU/v@duo.ucw.cz> <COZW5FAXA36Z.175ARPIESQSLL@otso>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <COZW5FAXA36Z.175ARPIESQSLL@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QG9Tjmjud-8tTfVegRavIMMjdsTZoQmm
X-Proofpoint-GUID: QG9Tjmjud-8tTfVegRavIMMjdsTZoQmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 mlxlogscore=456 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050027
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/12 21:59, Luca Weiss wrote:
> On Sat Dec 10, 2022 at 6:16 PM CET, Pavel Machek wrote:
>> Hi!
>>
>>> Configure the pm6150l flash node for the dual flash LEDs found on FP4.
>>
>>> +&pm6150l_flash {
>>> +	status = "okay";
>>> +
>>> +	led-0 {
>>> +		function = LED_FUNCTION_FLASH;
>>> +		color = <LED_COLOR_ID_YELLOW>;
>>> +		led-sources = <1>;
>>> +		led-max-microamp = <180000>;
>>> +		flash-max-microamp = <1000000>;
>>> +		flash-max-timeout-us = <1280000>;
>>> +	};
> 
> Hi Pavel,
> 
>>
>> I'm pretty sure the flash is not yellow.
> 
> The marketing term is Dual LED flash or Dual-tone flash, one LED is a
> blue-ish white and one is a yellow-ish white, but from what I can tell,
> in the original code it's always referred to as white and yellow so I
> also followed that here.
> 
> Also the LEDs are right next to each other so in practise for torch just
> both go on, and for camera flash I cannot really tell you but I guess
> it's doing something there with the camera tuning.
> 
> See also this picture:
> https://shop.fairphone.com/media/catalog/product/cache/b752d78484639b19641a8560800d919d/p/_/p_5b_main_camera_back.jpg
> 
Hi Pavel,

Luca is right. It is normally called dual CCT (Correlated Color 
Temperature) flash LED. It has 2 LEDs, one is with higher CCT (~6000K) 
so it looks like a white LED, another is with lower CCT (~2000K) and it 
looks like a yellow LED. I am not an expert of this but my understanding 
is the camera tuning process normally adjusts the brightness of the two 
LEDs and enables them to get different CCT for different snapshots.
I was thinking to use the "white" and "yellow" to name the flash LEDs 
which should be much better that just using indexes, it implicitly tell 
that the "white" one is having higher CCT and the "yellow" one is having 
lower CCT.

Fenglin
>>
>> Plus, how is the node in /sys/class/leds called? Can you make an entry
>> in Documentation/leds/well-known-leds.txt and ensure the name stays
>> consistent across devices?
> 
> / # ls -al /sys/class/leds/white:flash/
> total 0
> drwxr-xr-x    3 0        0                0 Jan  1 00:00 .
> drwxr-xr-x    4 0        0                0 Jan  1 00:00 ..
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 brightness
> lrwxrwxrwx    1 0        0                0 Jan  1 00:00 device -> ../../../c440000.spmi:pmic@5:led-controller@d300
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 flash_fault
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_strobe
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_timeout
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_flash_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_flash_timeout
> drwxr-xr-x    2 0        0                0 Jan  1 00:00 power
> lrwxrwxrwx    1 0        0                0 Jan  1 00:00 subsystem -> ../../../../../../../../../class/leds
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 uevent
> / # ls -al /sys/class/leds/yellow:flash/
> total 0
> drwxr-xr-x    3 0        0                0 Jan  1 00:00 .
> drwxr-xr-x    4 0        0                0 Jan  1 00:00 ..
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 brightness
> lrwxrwxrwx    1 0        0                0 Jan  1 00:00 device -> ../../../c440000.spmi:pmic@5:led-controller@d300
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 flash_fault
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_strobe
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 flash_timeout
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_flash_brightness
> -r--r--r--    1 0        0             4096 Jan  1 00:00 max_flash_timeout
> drwxr-xr-x    2 0        0                0 Jan  1 00:00 power
> lrwxrwxrwx    1 0        0                0 Jan  1 00:00 subsystem -> ../../../../../../../../../class/leds
> -rw-r--r--    1 0        0             4096 Jan  1 00:00 uevent
> 
> There's also already flash LED on PinePhone and some MSM8916 devices,
> but I think they also have white:flash based on the dt.
> 
>>
>> Best regards,
>> 								Pavel
>> -- 
>> People of Russia, stop Putin before his war on Ukraine escalates.
> 
