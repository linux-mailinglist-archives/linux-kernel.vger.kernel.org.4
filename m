Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBA6C9A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjC0EbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjC0EbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:31:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66A4C1F;
        Sun, 26 Mar 2023 21:31:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R0Z4MD025881;
        Mon, 27 Mar 2023 04:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TUUCFDqI+u7nB65jzjQQat0ajxrTfcl0QyWyzZcDN3o=;
 b=LVr7WPod8TAvmoSrI0PhM/IRU1zJjixMEYe5FsLWrE6z/n0q/ba1pSt8FTHDE0FxNLl9
 uEsg6u7pOBac+lK0RV0zwLde3TpFRQqoTyAixq52qqEWKGOh0TUXfxsCeuHTXiDdT3LF
 xzgu4s8y5tcSqHEEGGJjDX9hL7Vv+B7m5wlHNvm9xUzAmWHKWyAsZlugGlW6hW4XBkvj
 J/jgzjAPb/UxOyeK36C0M3aMhtboPwZLZJjGs1LFghe30XSFlpRupMMRwlydmuWkuPUA
 gNJH4rhjukfGwtMWbwaVHwK3+5+7ZbffWClNmOuHVwp4/tqwvkOi7spz73Xt8lM0cEKi iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phte8b7ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 04:30:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R4Ur4G001295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 04:30:53 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Mar
 2023 21:30:51 -0700
Message-ID: <cb5d7483-9b6f-51c7-a2b1-9ff83c6e7c8a@quicinc.com>
Date:   Mon, 27 Mar 2023 12:30:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <linux-leds@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
 <20230325170957.GA2904@bug>
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20230325170957.GA2904@bug>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8U2rnc8fuNPNC5_QL7VMlfS2V-7F_Vaj
X-Proofpoint-ORIG-GUID: 8U2rnc8fuNPNC5_QL7VMlfS2V-7F_Vaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=995 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270036
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2023 1:09 AM, Pavel Machek wrote:
> Hi!
>> @@ -61,6 +61,21 @@ config LEDS_MT6360
>>   	  Independent current sources supply for each flash LED support torch
>>   	  and strobe mode.
>>   
>> +config LEDS_QCOM_FLASH
>> +	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
>> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
>> +	depends on LEDS_CLASS && OF
>> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> +	select REGMAP
>> +	help
>> +	  This option enables support for the flash module found in Qualcomm
>> +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
>> +	  channels and each channel is programmable to support up to 1.5 A full
>> +	  scale current. It also supports connecting two channels' output together
>> +	  to supply one LED component to achieve current up to 2 A. In such case,
>> +	  the total LED current will be split symmetrically on each channel and
>> +	  they will be enabled/disabled at the same time.
> 
> "This can be built as a module, module will be called..."

I can update it in a new change considering the initial change has been 
applied.

> 
>> +static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
>> +					enum led_brightness brightness)
>> +{
>> +	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(led_cdev);
>> +	struct qcom_flash_led *led = flcdev_to_qcom_fled(fled_cdev);
>> +	u32 current_ma = brightness * led->max_torch_current_ma / LED_FULL;
>> +	bool enable = !!brightness;
>> +	int rc;
>> +
>> +	rc = set_flash_current(led, current_ma, TORCH_MODE);
>> +	if (rc)
>> +		return rc;
> 
> I'd not mind supporting more than one brightness level -- AFAICT hw can do that.

It does support multiple levels and the 'current_ma' is calculated based 
on different brightness level.

> 
> BR,
> 									Pavel
