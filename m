Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4C688CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBCBol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjBCBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:44:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B558A885F1;
        Thu,  2 Feb 2023 17:44:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3131PMjO010081;
        Fri, 3 Feb 2023 01:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y/EGlQxsE1kUhAZMG5EHnn7oBAg7cZ8XuFCCE6P9M74=;
 b=hioipy7yCXyEN2l+Ymce8pQ/tFSWaKtgY0Mm+zrUTIoiJeEfNKvghUTOl1byH8BtVyIg
 xHCZBzp425J4lKWNgSb/Uv0tDZGf9mQ9idvjK8K33w9RHSTZyMMxaoVSO1UtHzRL3DUE
 61FBsMYpO8uw8jEfKosY1wILEyq6p6tiGaYjJr6WH5/j+ZCutWZXEGJtbVr1sNH/Oqjy
 4mB8odRt3OH2Du+adlgn0aKLtT/IL74bQOrSYMFTXJ6LyRLeyO0VEAmAWgy2J3rhHzOE
 UoqO0Iu0ilEJxKQdrmLwj+OwxQ6FbuBi4z9WI+tkWmGpgf5ykbF8QpwBOC5V5W+LvHDo 3Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns4gabg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 01:44:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3131i5mA027861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 01:44:05 GMT
Received: from [10.110.106.32] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 17:44:04 -0800
Message-ID: <8c6b145c-6d38-2055-7526-7586edbea45d@quicinc.com>
Date:   Thu, 2 Feb 2023 17:44:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 09/22] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
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
 <a494e063-f0a0-2a71-5b7b-cb247efa245c@quicinc.com>
In-Reply-To: <a494e063-f0a0-2a71-5b7b-cb247efa245c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PcVo-wq9bOwB1td7G2pH7qN240NgpFjn
X-Proofpoint-ORIG-GUID: PcVo-wq9bOwB1td7G2pH7qN240NgpFjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=16 lowpriorityscore=0
 suspectscore=0 mlxscore=16 mlxlogscore=71 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=16 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030015
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 2/2/2023 5:23 PM, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 1/31/2023 7:02 PM, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/31/23 20:40, Wesley Cheng wrote:
>>> Hi Pierre,
>>>
>>> On 1/30/2023 3:59 PM, Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>> On 1/30/23 16:54, Wesley Cheng wrote:
>>>>> Hi Pierre,
>>>>>
>>>>> On 1/26/2023 7:38 AM, Pierre-Louis Bossart wrote:
>>>>>>
>>>>>>
>>>>>> On 1/25/23 21:14, Wesley Cheng wrote:
>>>>>>> The QC ADSP is able to support USB playback endpoints, so that the
>>>>>>> main
>>>>>>> application processor can be placed into lower CPU power modes.  
>>>>>>> This
>>>>>>> adds
>>>>>>> the required AFE port configurations and port start command to
>>>>>>> start an
>>>>>>> audio session.
>>>>>>>
>>>>>>> Specifically, the QC ADSP can support all potential endpoints 
>>>>>>> that are
>>>>>>> exposed by the audio data interface.  This includes, feedback
>>>>>>> endpoints
>>>>>>> (both implicit and explicit) as well as the isochronous (data)
>>>>>>> endpoints.
>>>>>>> The size of audio samples sent per USB frame (microframe) will be
>>>>>>> adjusted
>>>>>>> based on information received on the feedback endpoint.
>>>>>>
>>>>>> I think you meant "support all potential endpoint types"
>>>>>>
>>>>>> It's likely that some USB devices have more endpoints than what 
>>>>>> the DSP
>>>>>> can handle, no?
>>>>>>
>>>>>
>>>>> True, as we discussed before, we only handle the endpoints for the 
>>>>> audio
>>>>> interface.  Other endpoints, such as HID, or control is still 
>>>>> handled by
>>>>> the main processor.
>>>>
>>>> The number of isoc/audio endpoints can be larger than 1 per direction,
>>>> it's not uncommon for a USB device to have multiple connectors on the
>>>> front side for instruments, mics, monitor speakers, you name it. Just
>>>> google 'motu' or 'rme usb' and you'll see examples of USB devices that
>>>> are very different from plain vanilla headsets.
>>>>
>>>
>>> Thanks for the reference.
>>>
>>> I tried to do some research on the RME USB audio devices, and they
>>> mentioned that they do have a "class compliant mode," which is for
>>> compatibility w/ Linux hosts.  I didn't see a vendor specific USB SND
>>> driver matching the USB VID/PID either, so I am assuming that it uses
>>> the USB SND driver as is.(and that Linux doesn't currently support their
>>> vendor specific mode)  In that case, the device should conform to the
>>> UAC2.0 spec (same statement seen on UAC3.0), which states in Section
>>> 4.9.1 Standard AS Interface Descriptor Table 4-26:
>>>
>>> "4 bNumEndpoints 1 Number Number of endpoints used by this
>>> interface (excluding endpoint 0). Must be
>>> either 0 (no data endpoint), 1 (data
>>> endpoint) or 2 (data and explicit feedback
>>> endpoint)."
>>>
>>> So each audio streaming interface should only have 1 data and
>>> potentially 1 feedback.  However, this device does expose a large number
>>> of channels (I saw up to 18 channels), which the USB backend won't be
>>> able to support.  I still need to check how ASoC behaves if I pass in a
>>> profile that the backend can't support.

Getting back to passing in a format/profile that the USB BE doesn't 
support.  It looks like ASoC doesn't actually check against the PCM HW 
params received (for components), so the audio playback does still occur 
even though its outside of what we support.

Will need to add changes to specifically check for # of channels, 
format, etc... before we allow the session to proceed.

Thanks
Wesley Cheng
