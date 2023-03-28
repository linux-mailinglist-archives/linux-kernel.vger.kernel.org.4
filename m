Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F96CB920
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjC1IOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC1IO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:14:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963D46BB;
        Tue, 28 Mar 2023 01:14:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S7V5Q6025442;
        Tue, 28 Mar 2023 08:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VqXphoLRRkC3MK22/ZZDX/i9cnrP5GIKBdWiKIpo58o=;
 b=NacK++ypr+bkLEYWWdMkIRP4pQBP3TZU6/hCk5m2Xvb3DVUYmrqYRHeGa7VsIR20WyBQ
 jdqQPktvGlYZHM6JS4vRfe80JT/RwoimhGXAd5SlA0bHfrlowRL4kz2U5Sl3vgTCgBjv
 m1EsuvtYbETGz0TWyaF7/JNVmb0KaHfnSpmSIfyAshOu+rmZ3RGv14qB8nXot35K0lr1
 RBpmsDMziea4l6Q19P+iJf/WddcEmZ2rWqqAQCZpCjRIAL9fO9mlGCP9VuJqPtxTztEX
 I+3HFfEtcx6oab6o84XtrD+GDPH5bleHVE54pxQYOaUTwOomQUEA48PiFRn9yw+YQEzw bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk5773dnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:14:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S8E1iC017159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:14:01 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 01:13:58 -0700
Message-ID: <b06854ce-45e4-eeee-d5ec-51fb1d8d923f@quicinc.com>
Date:   Tue, 28 Mar 2023 16:13:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <linux-leds@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
 <ZB8xKGgvlb5oC/pt@duo.ucw.cz>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <ZB8xKGgvlb5oC/pt@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YKAFSuBMpH-40JHoM3XkdIYiKhnUeLWZ
X-Proofpoint-ORIG-GUID: YKAFSuBMpH-40JHoM3XkdIYiKhnUeLWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=770 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280068
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2023 1:36 AM, Pavel Machek wrote:
> On Fri 2023-03-03 17:50:22, Fenglin Wu wrote:
>> Add initial driver to support flash LED module found in Qualcomm
>> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
>> and each channel can be controlled indepedently and support full scale
>> current up to 1.5 A. It also supports connecting two channels together
>> to supply one LED component with full scale current up to 2 A. In that
>> case, the current will be split on each channel symmetrically and the
>> channels will be enabled and disabled at the same time.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4 + pm6150l
> 
>> +	flash->led_cdev.brightness_set_blocking = qcom_flash_led_brightness_set;
>> +
>> +	init_data.fwnode = node;
>> +	init_data.devicename = NULL;
>> +	init_data.default_label = NULL;
>> +	init_data.devname_mandatory = false;
>> +
>> +	rc = devm_led_classdev_flash_register_ext(dev, flash, &init_data);
>> +	if (rc < 0) {
>> +		dev_err(dev, "Register flash LED classdev failed, rc=%d\n", rc);
>> +		return rc;
>> +	}
> 
> I'd expect setting max_brightness somewhere around here.
> 
> What does cat /sys/class/leds/*/max_brightness say (and what directory
> name are you using)?

LED_FULL is used as the default max_brightness, the driver will do the 
calculation based on LED_FULL (as below) and set the corresponding 
current when brightness is updated :

u32 current_ma = brightness * led->max_torch_current_ma / LED_FULL;

This is how max_brightness shows on my device:

# cat /sys/class/leds/white:flash-0/max_brightness
255

> 
> BR,								Pavel
