Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E26174D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKCDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCDTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:19:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989213F5C;
        Wed,  2 Nov 2022 20:19:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A322HZp018040;
        Thu, 3 Nov 2022 03:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F1LkSXnUermJdD2RjBgt3PIA4s5jkgEuknfgFWZ7kq8=;
 b=VshYmpj3hWyjkxm4XBmRBj4ZnqeUMsmobOLFoRH+oQdSfOpXAc5v8wqAjtPC/ZCS4el9
 myk5fONgB7syjOIH00ErLhiyLWM8H0R0mWM5cKLzOj539UV65YmhVFlLOTZ3Hs47LHZP
 gtZTX4Bp84EZR1wqcO2+fVyEPQlO8orXuRnP9Y12qW48HeF7cQSLLlvFEYCH+pK+iB10
 /YyOv/f010PTpViS96EkvwujGawFH34pUFrdZtZa974JtsUCvDvvLUFrGt4fMkQ1BobK
 LwjeOzTuVVnnj4nKrXATlrYogM0049JmQSFhZC/o71QemB2KNG3qJ1zSuIiEDetSaTWL WQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km2270g3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:19:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A33JFRj002688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 03:19:15 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 20:19:11 -0700
Message-ID: <d1d11c50-9b5a-6fda-3d68-0b43920a013a@quicinc.com>
Date:   Thu, 3 Nov 2022 11:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, "Pavel Machek" <pavel@ucw.cz>,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20221025073802.2662564-1-quic_fenglinw@quicinc.com>
 <20221025073802.2662564-2-quic_fenglinw@quicinc.com>
 <0212be2972991ef2803c7f92c01217443def3dfd.camel@dylanvanassche.be>
 <578b6d6c-7a66-949c-c18f-3a962f9d37ff@quicinc.com>
 <adec3d56a1dbfbb97ce3d7a9dd172d593aff67c3.camel@dylanvanassche.be>
 <b92e9e09-f56c-1f0b-c718-d6e60f6253a7@quicinc.com>
 <b5a1c376200858f67f870766c4250ce810ed19db.camel@dylanvanassche.be>
 <54442085-5e72-dd12-2eed-3cda261fcbe0@quicinc.com>
 <db20b5ac25803020d7579c6bc8d5cd06572c3b12.camel@dylanvanassche.be>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <db20b5ac25803020d7579c6bc8d5cd06572c3b12.camel@dylanvanassche.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zQmrzug6o49NaTaCn0hNbtvcO5ZLqw2v
X-Proofpoint-GUID: zQmrzug6o49NaTaCn0hNbtvcO5ZLqw2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>>>>>> led_classdev_flash
>>>>>>>>>>
>>>>>>>>> *fled_cdev, u32 brightness)
>>>>>>>>> +{
>>>>>>>>> +       struct qcom_flash_led *led =
>>>>>>>>> container_of(fled_cdev,
>>>>>>>>> struct
>>>>>>>>>> qcom_flash_led, flash);
>>>>>>>>> +
>>>>>>>>> +       led->flash_current_ma = min_t(u32, led-
>>>>>>>>>> max_flash_current_ma, > brightness / 1000);
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>
>>>>>>> This doesn't seem to work in torch mode for me on PMI8998.
>>>>>>> If
>>>>>>> the
>>>>>>> brightness is 0, the torch is OFF as expected, but when the
>>>>>>> torch
>>>>>>> is
>>>>>>> ON, you cannot control the brightness. The brightness is
>>>>>>> the
>>>>>>> same
>>>>>>> for
>>>>>>> [1, 255]. If the hardware cannot change the brightness in
>>>>>>> torch
>>>>>>> mode,
>>>>>>> it would be nice to report a max_brightness value of 1
>>>>>>> instead
>>>>>>> of
>>>>>>> 255
>>>>>>> for userspace. This could be a limitation of the PMI8998,
>>>>>>> not
>>>>>>> sure.
>>>>>>> Do you have any insights here? This driver is already 99%
>>>>>>> working
>>>>>>> for
>>>>>>> SDM845+PMI8998.
>>>>>>>
>>>>>>> Flash mode works great, timeout & brightness can be
>>>>>>> configured
>>>>>>> just
>>>>>>> fine.
>>>>>>>
>>>>>>
>>>>>> Here, function qcom_flash_brightness_set() is used for
>>>>>> setting
>>>>>> brightness in flash mode and it was supposed to be working
>>>>>> with
>>>>>> following commands combination:
>>>>>>            echo xxx > flash_brightness
>>>>>>            echo 1 > flash_strobe  (you will need to toggle
>>>>>> flash_strobe
>>>>>> when you
>>>>>> enabling it again)
>>>>>>
>>>>>> Can you check if you can see the brightness change in flash
>>>>>> mode
>>>>>> when
>>>>>> you updating the flash_brightness value with these commands?
>>>>>>
>>>>>> You can echo any value between [0, max_flash_brightness] into
>>>>>> the
>>>>>> flash_brightness, there is a "max_flash_brightness" sysfs
>>>>>> node
>>>>>> and
>>>>>> the
>>>>>> value comes from DT property "flash-max-microamp", ex. my
>>>>>> dtsi
>>>>>> node
>>>>>> has
>>>>>> "flash-max-microamp = <2000000>;" defined so I am having
>>>>>> following
>>>>>> value
>>>>>> for max_flash_brightness:
>>>>>>
>>>>>> kalama:/sys/class/leds/white:flash-0 # cat
>>>>>> max_flash_brightness
>>>>>> 2000000
>>>>>>
>>>>>> And by default flash mode uses 12500uA resolution so you
>>>>>> won't
>>>>>> see
>>>>>> brightness change when you update it with values between [1,
>>>>>> 12500].
>>>>>
>>>>> Yes, this works perfectly fine on PMI8998. I can adjust the
>>>>> flash
>>>>> brightness and flash timeout perfectly.
>>>>>
>>>>>>
>>>>>> If you want to update the brightness for torch node, you can
>>>>>> directly
>>>>>> update the "brightness" node with values between [0, 255],
>>>>>> and
>>>>>> it's
>>>>>> mapping to the torch current between [0, led-max-microamp].
>>>>>> "led-max-microamp" is also has value coming from the DT
>>>>>> property.
>>>>>>
>>>>>> This worked at my side on both pm8150C and pm8550.I think it
>>>>>> should
>>>>>> work
>>>>>> on PMI8998 as well because the flash module in it is very
>>>>>> similar
>>>>>> to
>>>>>> the
>>>>>> one in PM8150c. Let me know if you still see such issues at
>>>>>> your
>>>>>> side.
>>>>>> Thanks
>>>>>
>>>>> Only here I have an issue with PMI8998: the "brightness" nodes
>>>>> should
>>>>> change the brightness of the torch, but it doesn't make a
>>>>> difference
>>>>> here. When I do:
>>>>>
>>>>> - echo 0 > brightness --> LED turns OFF
>>>>> - echo 255 > brightness --> LED turns ON
>>>>> - echo 100 > brightness --> LED is still ON, but brightness is
>>>>> the
>>>>> same
>>>>> as with 255.
>>>>>
>>>>> Could it be that PMI8998 is slightly different here than with
>>>>> PM8150c
>>>>> for example? Maybe it doesn't support brightness for torch?
>>>>>
>>>>> Here's my DTS:
>>>>>
>>>>> *PMI8998*
>>>>>
>>>>> pmi8998_flash: led-controller@d300 {
>>>>>           compatible = "qcom,pm6150l-flash-led", "qcom,spmi-
>>>>> flash-
>>>>> led";
>>>>>           reg = <0xd300>;
>>>>>           status = "disabled";
>>>>> };
>>>>>
>>>>> *SDM845 SHIFT axolotl*
>>>>>
>>>>> &pmi8998_flash {
>>>>>           status = "okay";
>>>>>
>>>>>           led-0 {
>>>>>                   function = LED_FUNCTION_FLASH;
>>>>>                   color = <LED_COLOR_ID_WHITE>;
>>>>>                   led-sources = <1>;
>>>>>                   led-max-microamp = <180000>;
>>>>>                   flash-max-microamp = <1000000>;
>>>>>                   flash-max-timeout-us = <1280000>;
>>>>>           };
>>>>>
>>>>>           led-1 {
>>>>>                   function = LED_FUNCTION_FLASH;
>>>>>                   color = <LED_COLOR_ID_YELLOW>;
>>>>>                   led-sources = <2>;
>>>>>                   led-max-microamp = <180000>;
>>>>>                   flash-max-microamp = <1000000>;
>>>>>                   flash-max-timeout-us = <1280000>;
>>>>>           };
>>>>> };
>>>>>
>>>> Thank you for getting back all the details. The devicetree node
>>>> looks
>>>> good to me.
>>>>
>>>> I checked again and confirmed that the flash modules in PMI8998
>>>> and
>>>> PM8150C have the same register definition for ITARGETx (0xD343 +
>>>> x)
>>>> and
>>>> IRESOLUTION (0xD347), these are the only 2 settings would impact
>>>> LED
>>>> brightness, and in torch mode, IRESOLUTION is fixed to 5mA and
>>>> only
>>>> ITARGET is updated accordingly.
>>>>
>>>> I updated my workspace to use the same current for torch mode as
>>>> your
>>>> settings in devicetree and tried again on my PM8150C device,I
>>>> could
>>>> notice the brightness change when echoing different values to the
>>>> brightness sysfs node, however, when I updating values between
>>>> 255
>>>> and
>>>> 200, it wasn't a very noticeable brightness change with naked
>>>> eys,
>>>> but I
>>>> could see the ITRAGETx register changed accordingly when reading
>>>> its
>>>> value back from the regmap debugfs node.
>>>>
>>>> Can you try the same and see if the register got updated
>>>> accordingly
>>>> when you updating brightness values? If yes, I would wonder if
>>>> the
>>>> LED
>>>> component on your device has upper current limit in torch mode
>>>> close
>>>> to
>>>> (100 / 255 ) * 180mA so you that you can't observe the brightness
>>>> change
>>>> when updating between 100 to 255. Another easier thing to try,
>>>> can
>>>> you
>>>> echo a lower brightness value, such as 10, to see if you can
>>>> notice
>>>> the
>>>> brightness change?
>>>>
>>>
>>> Aha! It does seem to work partially!
>>>
>>> I tried it with brightness 0 --> 255 --> 1. This order keeps the
>>> highest brightness at all times, matching 255. The other way
>>> around: 0
>>> --> 1 --> 255 keeps the lowest brightness, matching 1.
>>> Changing the brightness only works if the LED was turned OFF first:
>>>
>>> 0 --> 255 --> 0 --> 1
>>> 0 --> 1 --> 0 --> 255
>>>
>>> both work fine, verified it with the following shell commands
>>> (assumed
>>> that the LED was turned OFF to start):
>>>
>>> echo 1 > brightness && sleep 3 && echo 0 > brightness && echo 255 >
>>> brightness
>>> echo 255 > brightness && sleep 3 &&  echo 0 > brightness && echo 1
>>>>
>>> brightness
>>>
>>> Maybe a register needs to be reset when the brightness changes?
>>>
>>
>> Hi Dylan,
>>
>> Would you mind to help me testing this small change on PMI8998? It
>> simply toggles the CHANNEL_EN bit when updating LED brightness. If it
>> works, I will add it specifically for PMI8998 in patch v5.
>>
>> @@ -241,8 +243,21 @@ static int set_flash_strobe(struct
>> qcom_flash_led
>> *led, enum led_strobe s
>> trobe,
>>                   chan_mask |= BIT(chan_id - 1);
>>           }
>>
>> -       /* enable/disable flash channels */
>>           mask = chan_mask;
>> +       /*
>> +        * For flash module inside PMI8998, if strobe(true) is called
>> when
>> +        * the LED is already enabled, disable the channel 1st and
>> then
>> +        * enable it again.  This could happen when updating LED
>> brightness
>> +        * after LED is turned on.
>> +        */
>> +       if (led->enabled && (led->enabled == state)) {
>> +               rc =
>> regmap_field_update_bits(chip->r_fields[REG_CHAN_EN], mask, 0);
>> +               if (rc < 0)
>> +                       return rc;
>> +       }
>> +
>> +       /* enable/disable flash channels */
>>           val = state ? mask : 0;
>>           rc = regmap_field_update_bits(chip->r_fields[REG_CHAN_EN],
>> mask, val);
>>           if (rc < 0)
>>
>> Thanks
>> Fenglin Wu
> 
> With this change I can indeed change the brightness.
> However, it works now 50% of the time:
> 
> - echo 255 > brightness --> LED turns ON, max brightness: 255
> - echo 1 > brightness --> LED turns OFF
> - echo 1 > brightness --> LED turns ON, min brightness: 1
> 
> This behavior didn't occur before I applied this change.
> I had a look at the change but I cannot really pinpoint why this is
> happening...
> 
> Kind regards,
> Dylan Van Assche
> 
Thanks Dylan. It seems much more complex than what I thought to support 
the flash module in PMI8998 with the same driver. Then I will not 
include PMI8998 support in patch v5 and I will consider to push a 
following patch after this driver got accepted, I will try if I can find 
a PMI8998 device and fully test the driver before I push that.
Thanks

Fenglin Wu
