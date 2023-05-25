Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E071074A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbjEYI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjEYI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:27:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284C195;
        Thu, 25 May 2023 01:27:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P7DUj9029815;
        Thu, 25 May 2023 08:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CDAp/8lxKKBMi2F1RWZSUoljFotx/Q6IClC6pFPFajk=;
 b=P2Fu8i15RKl0z+9g2mqfB20TnszMjK+YlL1YjPsp7ucqhFq7rgVKbg8ACLWvb34qVfq4
 3RPOQCF10F+WK7XA9FLCyxpCrWiHeV+XlKxgzmyr55QnKPdYX6eITXyn9soX3vWU0SEn
 ++g0wvCCvFIM7jwRTJpHRGdIOZbPk06/Lj8lc+ujwPM6Hi8BxwB57j0ExmhMozlhdR4e
 jI52+nNB48yhy9h340dbaBIIWql/qQyqOlGTXROj+2R/R2V1A5PezjbDPPGzHxrEPPy0
 LZD2CSfLQUfTJ9TJniKkV1aMvC0mTwQOpWfJaYZnZ4jorGzulwsN4In0XGXze5TqM9Ag GQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt02a8h2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:26:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P8Qsev011489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:26:54 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 01:26:52 -0700
Message-ID: <a93575a0-e941-6fe2-635f-ac3c4d7acfef@quicinc.com>
Date:   Thu, 25 May 2023 13:56:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <1684936207-23529-1-git-send-email-quic_prashk@quicinc.com>
 <87bee7defd2578dba9502c14b53b7e5a91b5a5a8.camel@mediatek.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <87bee7defd2578dba9502c14b53b7e5a91b5a5a8.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1KWrzmH1Lgbau4h01aMCjVIolSh2J9pa
X-Proofpoint-ORIG-GUID: 1KWrzmH1Lgbau4h01aMCjVIolSh2J9pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_04,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250069
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-05-23 12:27 pm, Chunfeng Yun (云春峰) wrote:
> On Wed, 2023-05-24 at 19:20 +0530, Prashanth K wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialized to zero.
>>
>> To avoid this, added a new constant in enum usb_role, last_role
>> is set to USB_ROLE_UNKNOWN before performing initial detection.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection
>> detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>> v2: Added USB_ROLE_UNKNWON to enum usb_role
>>
>>   drivers/usb/common/usb-conn-gpio.c | 3 +++
>>   include/linux/usb/role.h           | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/common/usb-conn-gpio.c
>> b/drivers/usb/common/usb-conn-gpio.c
>> index e20874c..30bdb81 100644
>> --- a/drivers/usb/common/usb-conn-gpio.c
>> +++ b/drivers/usb/common/usb-conn-gpio.c
>> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device
>> *pdev)
>>          platform_set_drvdata(pdev, info);
>>          device_set_wakeup_capable(&pdev->dev, true);
>>
>> +       /* Set last role to unknown before performing the initial
>> detection */
>> +       info->last_role = USB_ROLE_UNKNOWN;
> 
> Do you only use vbus-pin?

This driver has support for both Vbus and ID GPIOs.
> 
> This driver assumes that the gadget driver's default role is none.

No, after probe it calls set role based on the state of Vbus and ID pin.
If Vbus is low, then it should issue none role to the gadget. But 
currently it doesnt call set_role if initial role is none.

Regards

