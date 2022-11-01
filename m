Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3152161441D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKAFLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:11:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370722BF0;
        Mon, 31 Oct 2022 22:11:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A14xv8P010492;
        Tue, 1 Nov 2022 05:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QZki3yNhJNdqEk75OblUwTCwWovi47EOx4A6q7xKq8s=;
 b=AdieALIAvxOWRma6Dnb54RmkR+YI72XetoIc29y9FUwPXxPbqYqWAy4oHla7wkejPnDV
 Nr+QDZDhksoNtlT0YxKurDtefngt7VTbqisjqCGhkm84r8pRQCtdPoA43uLPM99JuJfA
 RS5K5HepGEAguuQs8wc7BlQJknzXWxCsNJZPlGD4qbGGd793R3eneklOk1WuCXz2ROi+
 CMU/+Lez8x8Nuh0gMJR4iWPql72cMix1MziW6CCYSkG+HECYUo8YE2cG/X19VPlvUEH7
 pEUY7rUrFvbQ37cP46miAGZcmsfxRc/4OUghdG/W2uqKT8Yvt27PCvDWOhq0TcpO5iPk Yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjvseg109-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 05:11:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A15B5Gj011380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Nov 2022 05:11:05 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 22:11:02 -0700
Message-ID: <a189c320-336e-be8e-2b89-dcb2b0664117@quicinc.com>
Date:   Tue, 1 Nov 2022 13:11:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, "Pavel Machek" <pavel@ucw.cz>,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        Dylan Van Assche <me@dylanvanassche.be>
References: <20221025073802.2662564-1-quic_fenglinw@quicinc.com>
 <20221025073802.2662564-2-quic_fenglinw@quicinc.com>
 <CO05SSJUFW72.1PUZJ0FMJH3DF@otso>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CO05SSJUFW72.1PUZJ0FMJH3DF@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I9A98y4Q0AdmRuewTkNRNRJ6UCVcZxf9
X-Proofpoint-GUID: I9A98y4Q0AdmRuewTkNRNRJ6UCVcZxf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_01,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/31 21:56, Luca Weiss wrote:
> Hi Fenglin,
> 
> On Tue Oct 25, 2022 at 9:38 AM CEST, Fenglin Wu wrote:
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
>> ---
>>   drivers/leds/flash/Kconfig           |  15 +
>>   drivers/leds/flash/Makefile          |   1 +
>>   drivers/leds/flash/leds-qcom-flash.c | 700 +++++++++++++++++++++++++++
>>   3 files changed, 716 insertions(+)
>>   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
>>
> 
> <snip>
> 
>> +static const struct of_device_id qcom_flash_led_match_table[] = {
>> +	{ .compatible = "qcom,spmi-flash-led" },
>> +	{ }
>> +};
> 
> Dylan has noticed that auto-loading the module based on dt match doesn't
> work currently. It seems that this line is missing here to enable that:
> 
>    MODULE_DEVICE_TABLE(of, qcom_flash_led_match_table);
> 
> Please add it for v5!
> 
> Regards
> Luca
> 
Will add it for v5, thank you!

>> +
>> +static struct platform_driver qcom_flash_led_driver = {
>> +	.driver = {
>> +		.name = "leds-qcom-flash",
>> +		.of_match_table = qcom_flash_led_match_table,
>> +	},
>> +	.probe = qcom_flash_led_probe,
>> +	.remove = qcom_flash_led_remove,
>> +};
>> +
>> +module_platform_driver(qcom_flash_led_driver);
>> +
>> +MODULE_DESCRIPTION("QCOM Flash LED driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1
> 
