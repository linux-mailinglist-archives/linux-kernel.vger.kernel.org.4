Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74FB685D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBAClY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBAClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:41:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD84A208;
        Tue, 31 Jan 2023 18:41:22 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31107oSa026391;
        Wed, 1 Feb 2023 02:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E688QmTDigvdKOL9g2naWC/n4Oz7W10bC/WvsCml3Cs=;
 b=A/aweUUJsGmrCO0mOQIo2Iz3/taK5p2+jw7ZfS6uy94LQSVRr3W1JaPxUZ4un1iM2Afv
 BYHbowU8Q7AAz4hKAh+k/s48sta3JZz0q9aBqInigL8em2U36CNHF86sQIlBy6xv8Evk
 zCd0FdnVwalaGueMPl2axSCHt903HnVYtOc/4iQMrOvdF/d87uAAz8vjwtOCKZGPwOt3
 4cGAd7NV58suvDnArLh5MYs7THA4jajXjOF23KM9GuOSAOSO1VEr2BkZrU1vykv82DKC
 1Ss+GrNkozKfXFxsJbO9jAGbOfzL9qhrgwHUyeClmOAUqqUO0uL1muFWWcLDQsBLJRS+ kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3new3uard4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 02:40:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3112epXH005752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 02:40:51 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 18:40:50 -0800
Message-ID: <fa35124c-682f-8045-6733-c71f9ce8df9e@quicinc.com>
Date:   Tue, 31 Jan 2023 18:40:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 09/22] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-10-quic_wcheng@quicinc.com>
 <dea77277-6971-fe27-1ae0-ed551e84b6e4@linux.intel.com>
 <5dec443d-9894-2d06-1798-c56b8f2e1e5e@quicinc.com>
 <ebf8ebed-ef79-bf18-4635-360f916877a6@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ebf8ebed-ef79-bf18-4635-360f916877a6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TlyEZa_fV1uJtAmcq2M3HTTSTJaH_upD
X-Proofpoint-ORIG-GUID: TlyEZa_fV1uJtAmcq2M3HTTSTJaH_upD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=819
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010020
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/30/2023 3:59 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/30/23 16:54, Wesley Cheng wrote:
>> Hi Pierre,
>>
>> On 1/26/2023 7:38 AM, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/25/23 21:14, Wesley Cheng wrote:
>>>> The QC ADSP is able to support USB playback endpoints, so that the main
>>>> application processor can be placed into lower CPU power modes.  This
>>>> adds
>>>> the required AFE port configurations and port start command to start an
>>>> audio session.
>>>>
>>>> Specifically, the QC ADSP can support all potential endpoints that are
>>>> exposed by the audio data interface.  This includes, feedback endpoints
>>>> (both implicit and explicit) as well as the isochronous (data)
>>>> endpoints.
>>>> The size of audio samples sent per USB frame (microframe) will be
>>>> adjusted
>>>> based on information received on the feedback endpoint.
>>>
>>> I think you meant "support all potential endpoint types"
>>>
>>> It's likely that some USB devices have more endpoints than what the DSP
>>> can handle, no?
>>>
>>
>> True, as we discussed before, we only handle the endpoints for the audio
>> interface.  Other endpoints, such as HID, or control is still handled by
>> the main processor.
> 
> The number of isoc/audio endpoints can be larger than 1 per direction,
> it's not uncommon for a USB device to have multiple connectors on the
> front side for instruments, mics, monitor speakers, you name it. Just
> google 'motu' or 'rme usb' and you'll see examples of USB devices that
> are very different from plain vanilla headsets.
> 

Thanks for the reference.

I tried to do some research on the RME USB audio devices, and they 
mentioned that they do have a "class compliant mode," which is for 
compatibility w/ Linux hosts.  I didn't see a vendor specific USB SND 
driver matching the USB VID/PID either, so I am assuming that it uses 
the USB SND driver as is.(and that Linux doesn't currently support their 
vendor specific mode)  In that case, the device should conform to the 
UAC2.0 spec (same statement seen on UAC3.0), which states in Section 
4.9.1 Standard AS Interface Descriptor Table 4-26:

"4 bNumEndpoints 1 Number Number of endpoints used by this
interface (excluding endpoint 0). Must be
either 0 (no data endpoint), 1 (data
endpoint) or 2 (data and explicit feedback
endpoint)."

So each audio streaming interface should only have 1 data and 
potentially 1 feedback.  However, this device does expose a large number 
of channels (I saw up to 18 channels), which the USB backend won't be 
able to support.  I still need to check how ASoC behaves if I pass in a 
profile that the backend can't support.

Maybe in the non-class compliant/vendor based class driver, they have 
the support for multiple EPs per data interface?  I don't have one of 
these devices on hand, so I can't confirm that.

>>> And that brings me back to the question: what is a port and the
>>> relationship between port/backend/endpoints?
>>>
>>> Sorry for being picky on terminology, but if I learned something in days
>>> in standardization it's that there shouldn't be any ambiguity on
>>> concepts, otherwise everyone is lost at some point.
>>>
>>
>> No worries, I can understand where you're coming from :).  After
>> re-reading some of the notations used, I can see where people may be
>> confused.
>>
>>>
>>>>    static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>>>> +    [USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
>>>>        [HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
>>>>        [SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
>>>>                    SLIMBUS_0_RX, 1, 1},
>>>
>>> And if I look here a port seems to be a very specific AFE concept
>>> related to interface type? Do we even need to refer to a port in the USB
>>> parts?
>>>
>>
>> Well, this is a design specific to how the Q6 AFE is implemented.  There
>> is a concept for an AFE port to be opened.  However, as mentioned
>> earlier, the "port" term used in soc-usb should be more for how many USB
>> devices can be supported.
>>
>> If there was a case the audio DSP would support more than one USB
>> device, I believe another AFE port would need to be added.
> 
> 
> would the suggested infrastructure work though, even if the DSP could
> deal with multiple endpoints on different devices ? You have static
> mutexes and ops, can that scale to more than one USB device?

The mutex is only for registering the card, and ensuring atomic access 
to the list.  I don't see how that would block support for having 
multiple devices being registered to soc-usb.  ops are stored per 
backend device.

Greg did want me to re-look at the soc-usb device management, so I will 
have to rework some of these things.  It would be nice to see if we can 
get it to work like how the headphone jack works, ie interaction between 
soc-jack and core/jack.c.

Thanks
Wesley Cheng
