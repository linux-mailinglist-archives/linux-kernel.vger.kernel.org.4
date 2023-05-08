Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4566FB389
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjEHPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjEHPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:16:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3DE6A;
        Mon,  8 May 2023 08:16:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348DeQ2n004664;
        Mon, 8 May 2023 15:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TVrUZMQIloPcNLi/LWi/pvyd8A+HuBGckj8HsCI4kjg=;
 b=Z3N1AAP6i6zzsu/HK3Vw/nPrWRuDH0fLRftg9gFjGFX1ypvSSEOPtzT6iqlkbKvVVZg7
 9lPAEVPcSVubhRtzqwFDI3+A+wPSS+X5uIEPUUKHWGkdhlvZAVAt0F4kxuLD8ICuYa/q
 I4JBha1xf8pFUGOqTtiOQ2kDc4Zm9h4qj6P0/uMET3PjQhVuhnaxiEaV5064xswjlixq
 Ax4zG892bTQOmVo3SFEvmotKHLok6RVJCH4au0B0dJCjSEUVNz9ehW+VZ9T6dP2cCvfF
 2EMMLEcsSuChB2qu8SOVQKpQ9Bnz0S/kcaTriIetZyLZweEGXaC96o6hXFmbLmZRN11m Ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qesg89a32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:16:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348FGfVF028235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 15:16:41 GMT
Received: from [10.216.41.186] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 08:16:38 -0700
Message-ID: <b4464186-217d-4462-3062-eb84a7ad1362@quicinc.com>
Date:   Mon, 8 May 2023 20:46:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] usb: gadget: f_uac2: uevent changes for uac2
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jing Leng <jleng@ambarella.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230508120535.31472-1-quic_akakum@quicinc.com>
 <2023050801-handshake-refusing-0367@gregkh>
From:   AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <2023050801-handshake-refusing-0367@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZscUftcsQBlu5NXXBuW81Tt7eohCj5jR
X-Proofpoint-ORIG-GUID: ZscUftcsQBlu5NXXBuW81Tt7eohCj5jR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=511 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080100
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg for review, will fix the issues in version 2 patchset.

Thanks,

Akash

On 5/8/2023 5:44 PM, Greg Kroah-Hartman wrote:
> On Mon, May 08, 2023 at 05:35:35PM +0530, AKASH KUMAR wrote:
>> Adding uvent from usb audio gadget driver for
> What is a "uvent"?
>
>> uac2 playback/capture events, which userspace reads
>> and later reads sysfs entry to know if playback
>> or capture has stopped or started by host
>> application.
> Please use your full 72 columns please.
>
>> /config/usb_gadget/g1/functions/uac2.0 # cat c_status
>> 1  --> capture started
>> 0  --> capture stopped
>> /config/usb_gadget/g1/functions/uac2.0 # cat p_status
>> 1 --> playback started
>> 0 --> playback stopped
> You need to document these new files in Documentation/ABI/ right?
>
>> Signed-off-by: AKASH KUMAR <quic_akakum@quicinc.com>
> No need to UPPER CASE your name :)
>
>> ---
>>   drivers/usb/gadget/function/f_uac2.c | 57 ++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_uac2.h |  7 ++++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
>> index 0219cd79493a..d0a5fa6b49b8 100644
>> --- a/drivers/usb/gadget/function/f_uac2.c
>> +++ b/drivers/usb/gadget/function/f_uac2.c
>> @@ -1423,6 +1423,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>>   	struct usb_gadget *gadget = cdev->gadget;
>>   	struct device *dev = &gadget->dev;
>>   	int ret = 0;
>> +	struct f_uac2_opts *audio_opts =
>> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>>   
>>   	/* No i/f has more than 2 alt settings */
>>   	if (alt > 1) {
>> @@ -1454,6 +1456,7 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>>   			ret = u_audio_start_capture(&uac2->g_audio);
>>   		else
>>   			u_audio_stop_capture(&uac2->g_audio);
>> +		audio_opts->c_status = alt;
>>   	} else if (intf == uac2->as_in_intf) {
>>   		uac2->as_in_alt = alt;
>>   
>> @@ -1461,10 +1464,14 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>>   			ret = u_audio_start_playback(&uac2->g_audio);
>>   		else
>>   			u_audio_stop_playback(&uac2->g_audio);
>> +		audio_opts->p_status = alt;
>>   	} else {
>>   		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>>   		return -EINVAL;
>>   	}
>> +#ifdef CONFIG_USB_CONFIGFS_UEVENT
>> +	schedule_work(&audio_opts->work);
>> +#endif
> Why the #ifdef?  Please never do that in .c files if at all possible.
>
>>   
>>   	return ret;
>>   }
>> @@ -1493,9 +1500,17 @@ static void
>>   afunc_disable(struct usb_function *fn)
>>   {
>>   	struct f_uac2 *uac2 = func_to_uac2(fn);
>> +	struct f_uac2_opts *audio_opts =
>> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>>   
>>   	uac2->as_in_alt = 0;
>>   	uac2->as_out_alt = 0;
>> +	audio_opts->p_status = 0;//alt;
>> +	audio_opts->c_status = 0; //alt;
>> +
>> +#ifdef CONFIG_USB_CONFIGFS_UEVENT
>> +	schedule_work(&audio_opts->work);
>> +#endif
> Same here and elsewhere in this patch.
>
> thanks,
>
> greg k-h
