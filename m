Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D3714FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE2TjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2TjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:39:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DADC;
        Mon, 29 May 2023 12:39:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TJRIrx008646;
        Mon, 29 May 2023 19:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3ySqhIXMUvVVIRKgUA1QpiSdF3Ns24L3jZl/xjHlh9A=;
 b=hrgAVC7rD7DOB8DRVAPaOP6peKArhfmhTPCyNxMsLF6tQDKzguDdoNMki+8T+SpMzc/l
 AY20P6JlvLQPAkUSy9PWFUpz/76bRASgONcst5bvl51/7kAho0M0bdAdsPuz+WuYsDmp
 BnjtBIOZPnnxjjd+8eiAqwyZ0WlDwM5s/CGvRacBcPnuSrDRhtuBxptYVh4PzEenQ8xE
 DUEkDB9PIZsWXEtk0DW8Ni7KqZfo9/9rRCiLjwxziAChb2YbinoV/nd2sYQQtYDYvNZk
 4WsxIu8AnvMARy/i9fq02wG8eUtTc1pB2YAIh+8t5Kx+1vutg07g2cf0SP0K0ly6qKk3 kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvsr212bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 19:39:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TJd3JM016363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 19:39:03 GMT
Received: from [10.216.59.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 12:39:01 -0700
Message-ID: <b14dd204-180d-8035-3eaf-8a53692ef546@quicinc.com>
Date:   Tue, 30 May 2023 01:08:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
 <2023052513-gestate-tartar-bf15@gregkh>
 <5f144d80-0439-d014-c845-1cfb1adb840a@quicinc.com>
 <2023052801-immersion-venus-ad0f@gregkh>
 <a86f3bd4-8c87-de67-bdb6-fbe88dc23a56@quicinc.com>
 <2023052943-headfirst-satchel-6d90@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023052943-headfirst-satchel-6d90@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0qig47KF6g0RsS6fdzMHDwGDRQKQR8f7
X-Proofpoint-GUID: 0qig47KF6g0RsS6fdzMHDwGDRQKQR8f7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=788 priorityscore=1501 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290164
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30-05-23 12:31 am, Greg Kroah-Hartman wrote:
> On Tue, May 30, 2023 at 12:00:15AM +0530, Prashanth K wrote:
>>
>>
>> On 28-05-23 05:03 pm, Greg Kroah-Hartman wrote:
>>>>>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
>>>>>> index e20874c..30bdb81 100644
>>>>>> --- a/drivers/usb/common/usb-conn-gpio.c
>>>>>> +++ b/drivers/usb/common/usb-conn-gpio.c
>>>>>> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>>>>>>     	platform_set_drvdata(pdev, info);
>>>>>>     	device_set_wakeup_capable(&pdev->dev, true);
>>>>>> +	/* Set last role to unknown before performing the initial detection */
>>>>>> +	info->last_role = USB_ROLE_UNKNOWN;
>>>>>
>>>>> Shouldn't last_role have already been set to 0?  If so, why not just
>>>>> have this enum value be 0?
>>>> Last role would be 0 during first detection, that's the problem here.
>>>> During initial detection, if the the new role is detected as USB_ROLE_NONE
>>>> (0), then we wouldn't call the set_role(). But it should send the current
>>>> role to gadget after the inital detection.
>>>
>>> So you are hoping that the old enum type is still assigned to 0?  That's
>>> brave, please make it explicit otherwise it's very hard to follow or
>>> ensure that this really will happen.  And most of all, document it so
>>> that that value remains 0 in the future, otherwise a list of enum types
>>> without explicit values are seen as if the values do not matter.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> So I think it would be better to add USB_ROLE_UNKNOWN towards the end of
>> enum usb_role, so that we can avoid explicit declaration. Is that fine?
>>
>>   enum usb_role {
>>   	USB_ROLE_NONE,
>>   	USB_ROLE_HOST,
>>   	USB_ROLE_DEVICE,
>> +	USB_ROLE_UNKNOWN,
> 
> Either is fine, be explicit, or not, just don't mix the two please.
> 
> thanks,
> 
> greg k-h

Thanks for the suggestion, will update it in next patch.

Regards,
Prashanth K
