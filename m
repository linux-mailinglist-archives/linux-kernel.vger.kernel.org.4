Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8267476B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjASXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjASXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:48:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84B9FDEC;
        Thu, 19 Jan 2023 15:48:39 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JMuKrf021035;
        Thu, 19 Jan 2023 23:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fUPQsesXUV1J4QHz/pEYuFtqcqIAkXbkp9riGktQX3Q=;
 b=DyXmGt7fFr5ZauyIKHPVCjsf0IoVCptIDT5cFaoI6YtbEfn3p7N4/5yRONvOLWYmRkfa
 brnGb0rJ6fR1LmXWQdSuMhQtgkR2b2Z3qnbdf4iaa/e4kP8I4ZJgMavCts3+BVgICvr5
 FafDMbQYjqyIXxdGu7Ugpj6y0DHUrmb3SonLLY490FOKfjWGyddBF/onG+gHySHDeYy8
 frstYZcrntC713zTh0yhF7wdwHdkGwSmM1Zurzat4vOpTKsnBVE9tqGcR8Nt25K/ZbPg
 CLCJN03sxyIY6CyTpWP0XV+OAcPv6Do9d4qfw5pIsbwrOD4u27U1FiDNjvnd7LQK+laX kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n75w3hb7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 23:48:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JNmXZO007918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 23:48:33 GMT
Received: from [10.110.55.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 15:48:32 -0800
Message-ID: <07f1c818-ef05-2886-0b79-8061c2b13af5@quicinc.com>
Date:   Thu, 19 Jan 2023 15:48:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <Thinh.Nguyen@synopsys.com>, <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <Y8k/Y4O/99pnKI2h@kroah.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <Y8k/Y4O/99pnKI2h@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 74B6knsy_kzMAAseWR3Ym9Eicc6Rc-T-
X-Proofpoint-GUID: 74B6knsy_kzMAAseWR3Ym9Eicc6Rc-T-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=536
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190200
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 5:02 AM, Greg KH wrote:
> On Tue, Jan 17, 2023 at 01:55:03PM -0800, Elson Roy Serrao wrote:
>> Add a flag to indicate whether the gadget is capable
>> of sending remote wakeup to the host.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 3 +++
>>   include/linux/usb/gadget.h     | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index 403563c..b83963a 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -965,6 +965,9 @@ static int set_config(struct usb_composite_dev *cdev,
>>   	else
>>   		usb_gadget_clear_selfpowered(gadget);
>>   
>> +	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
>> +		gadget->rw_capable = 1;
>> +
>>   	usb_gadget_vbus_draw(gadget, power);
>>   	if (result >= 0 && cdev->delayed_status)
>>   		result = USB_GADGET_DELAYED_STATUS;
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index dc3092c..15785f8 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -385,6 +385,7 @@ struct usb_gadget_ops {
>>    *	indicates that it supports LPM as per the LPM ECN & errata.
>>    * @irq: the interrupt number for device controller.
>>    * @id_number: a unique ID number for ensuring that gadget names are distinct
>> + * @rw_capable: True if the gadget is capable of sending remote wakeup.
>>    *
>>    * Gadgets have a mostly-portable "gadget driver" implementing device
>>    * functions, handling all usb configurations and interfaces.  Gadget
>> @@ -446,6 +447,7 @@ struct usb_gadget {
>>   	unsigned			lpm_capable:1;
>>   	int				irq;
>>   	int				id_number;
>> +	unsigned			rw_capable:1;
> 
> Why not put this by the other bitfields in this structure?
> 
> thanks,
> 
> greg k-h

Done. I will make that change

Thanks,
Elson
