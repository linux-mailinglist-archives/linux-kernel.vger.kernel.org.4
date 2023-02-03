Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8AB688C77
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBCBYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBCBYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:24:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED884B64;
        Thu,  2 Feb 2023 17:24:33 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3131JYgp025024;
        Fri, 3 Feb 2023 01:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OsB6/Mh/Ws2MNKlRmvc0v3bTZKseg4POlIFzfO/1NAk=;
 b=Qh9sG0gAHDo2lKmx/xs1rvmbPJ+i8zhcHscS8oXrqyF7wZR3fUoOMSxqVRPO98jgyeHs
 ugrtxb0EyRHTvi2mz0uoOu0gpSR3s+ytGurdKLC6rrrB6LuMI4ucqVYWMWN0mfe9vm89
 UcwmIdBCVOaQdwxhZwgscLpGZjQREXk/DdbZkDSDXAToRQRwItrM0jdj5EkKq9mjs0B7
 QDfUd/8fn9ANOvcuQaVBFhSrmATWPTEQemAlobqDomSQvDqPlbknunt1m9K5SrYrqPEV
 AXnTI48RQcp6xEwXaSB+U2cF0MN/d4j2m8uyOXRkTF9J8nAoOoKecLNHh+BLqfUEPAK3 aQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfnyhmcbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 01:23:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3131NlCa016718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 01:23:47 GMT
Received: from [10.110.106.32] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 17:23:46 -0800
Message-ID: <a494e063-f0a0-2a71-5b7b-cb247efa245c@quicinc.com>
Date:   Thu, 2 Feb 2023 17:23:46 -0800
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
 <fa35124c-682f-8045-6733-c71f9ce8df9e@quicinc.com>
 <de03c6b1-b6d6-0045-ea60-6ae800913e95@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <de03c6b1-b6d6-0045-ea60-6ae800913e95@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KCqg9973o3enm9jrQAYKp0I7rG7EY1SL
X-Proofpoint-ORIG-GUID: KCqg9973o3enm9jrQAYKp0I7rG7EY1SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=502
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030011
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/31/2023 7:02 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/31/23 20:40, Wesley Cheng wrote:
>> Hi Pierre,
>>
>> On 1/30/2023 3:59 PM, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/30/23 16:54, Wesley Cheng wrote:
>>>> Hi Pierre,
>>>>
>>>> On 1/26/2023 7:38 AM, Pierre-Louis Bossart wrote:
>>>>>
>>>>>
>>>>> On 1/25/23 21:14, Wesley Cheng wrote:
>>>>>> The QC ADSP is able to support USB playback endpoints, so that the
>>>>>> main
>>>>>> application processor can be placed into lower CPU power modes.  This
>>>>>> adds
>>>>>> the required AFE port configurations and port start command to
>>>>>> start an
>>>>>> audio session.
>>>>>>
>>>>>> Specifically, the QC ADSP can support all potential endpoints that are
>>>>>> exposed by the audio data interface.  This includes, feedback
>>>>>> endpoints
>>>>>> (both implicit and explicit) as well as the isochronous (data)
>>>>>> endpoints.
>>>>>> The size of audio samples sent per USB frame (microframe) will be
>>>>>> adjusted
>>>>>> based on information received on the feedback endpoint.
>>>>>
>>>>> I think you meant "support all potential endpoint types"
>>>>>
>>>>> It's likely that some USB devices have more endpoints than what the DSP
>>>>> can handle, no?
>>>>>
>>>>
>>>> True, as we discussed before, we only handle the endpoints for the audio
>>>> interface.  Other endpoints, such as HID, or control is still handled by
>>>> the main processor.
>>>
>>> The number of isoc/audio endpoints can be larger than 1 per direction,
>>> it's not uncommon for a USB device to have multiple connectors on the
>>> front side for instruments, mics, monitor speakers, you name it. Just
>>> google 'motu' or 'rme usb' and you'll see examples of USB devices that
>>> are very different from plain vanilla headsets.
>>>
>>
>> Thanks for the reference.
>>
>> I tried to do some research on the RME USB audio devices, and they
>> mentioned that they do have a "class compliant mode," which is for
>> compatibility w/ Linux hosts.  I didn't see a vendor specific USB SND
>> driver matching the USB VID/PID either, so I am assuming that it uses
>> the USB SND driver as is.(and that Linux doesn't currently support their
>> vendor specific mode)  In that case, the device should conform to the
>> UAC2.0 spec (same statement seen on UAC3.0), which states in Section
>> 4.9.1 Standard AS Interface Descriptor Table 4-26:
>>
>> "4 bNumEndpoints 1 Number Number of endpoints used by this
>> interface (excluding endpoint 0). Must be
>> either 0 (no data endpoint), 1 (data
>> endpoint) or 2 (data and explicit feedback
>> endpoint)."
>>
>> So each audio streaming interface should only have 1 data and
>> potentially 1 feedback.  However, this device does expose a large number
>> of channels (I saw up to 18 channels), which the USB backend won't be
>> able to support.  I still need to check how ASoC behaves if I pass in a
>> profile that the backend can't support.
>>
>> Maybe in the non-class compliant/vendor based class driver, they have
>> the support for multiple EPs per data interface?  I don't have one of
>> these devices on hand, so I can't confirm that.
> 
> Look at Figure 3-1 in the UAC2 spec, it shows it's perfectly legal to
> have multiple Audio Streaming interfaces - but one Audio Control
> interface only.
> 
> The fact that there is a restriction to 1 or 2 endpoints per Audio
> Streaming interface does not really matter if in the end there are
> multiple endpoints and concurrent isoc transfers happening to/from the
> same USB device.

So the reason I wanted to mention the max number of EPs within the audio 
streaming descriptor is because the USB SND driver currently creates 
streams based off of the number of AS desc:

static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
{
...
	for (i = 0; i < assoc->bInterfaceCount; i++) {
		int intf = assoc->bFirstInterface + i;
		if (intf != ctrlif)
			snd_usb_create_stream(chip, ctrlif, intf);
	}

"assoc" is the audio control interface desc.  In the end, when userspace 
initiates a playback session, it operates on the streams created (which 
contains at max 1 isoc and 1 feedback ep)

In short, the audio DSP doesn't need to consider handling more than 1 
isoc ep (and potentially 1 feedback).  I believe that each audio stream 
creates a separate PCM device, so userspace is still free to attempt to 
activate another audio stream.  I believe # of PCM devices created 
matches the # of streams, so when userspace does activate another 
session, it would be on an entirely different substream, and can be 
handled through the USB SND (non-offload) path.  If attempted to open 
the substream used by the offload path, then we would reject is based on 
the new change.

Thanks
Wesley Cheng
