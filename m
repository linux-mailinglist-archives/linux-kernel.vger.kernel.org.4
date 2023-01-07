Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D21660B18
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjAGAwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGAwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:52:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A138A;
        Fri,  6 Jan 2023 16:52:13 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3070pNWI021772;
        Sat, 7 Jan 2023 00:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PcCTzQLOna79iKhl3SfZY+DvvqfN7lJVlW4D5wl0maY=;
 b=JeM6/+1ngbSi50nsDLzRU7/lFCShKAeAJ30E2Z41AyUxovn3aavxcTTN6TVOVmKBXy0s
 hP3bAg1/8GAiI11aaV+ozFWmu6uE7ATFyk/NHNj/WmvsufRue0ltIy9MXNP2h3hqg/3/
 LC3xDWIZ5JKDV+DgsQEMWD2qDlJHIoJdK9QeuJS4hz1Vdmp1Lu4f79UYB3fvhpJ2kx/e
 kcf4kW7LufgvupBuOm4a4HbpIs8sS1XX+85RtU4oOLg2pRE3fYNaurZJsMKzRGBkmDR9
 jleMMNRoIhCAn5Byjmpib5e06fveVWo36P/V01XhN4qE6nR71SzAUi5y2q6lo3n8oYuk Jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx9jfjn0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Jan 2023 00:51:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3070pMNF023141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Jan 2023 00:51:22 GMT
Received: from [10.110.74.54] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 6 Jan 2023
 16:51:21 -0800
Message-ID: <ed3d16a2-0320-596f-4091-ceef2d11fca9@quicinc.com>
Date:   Fri, 6 Jan 2023 16:51:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 02/14] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-3-quic_wcheng@quicinc.com>
 <5babccd6-9796-7613-cf82-cc859f338448@linux.intel.com>
 <6e13521a-84bf-f8a6-e8cc-5b90ff4bd675@quicinc.com>
 <65820e0e-be8b-c574-98d0-a2e60ee4be76@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <65820e0e-be8b-c574-98d0-a2e60ee4be76@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2qDcc9MT_mr9ckvvQHeLaPh9VIMfXPaR
X-Proofpoint-ORIG-GUID: 2qDcc9MT_mr9ckvvQHeLaPh9VIMfXPaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070005
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/6/2023 8:09 AM, Pierre-Louis Bossart wrote:
> 
>>>> The QC ADSP is able to support USB playback and capture, so that the
>>>> main application processor can be placed into lower CPU power modes.
>>>> This
>>>> adds the required AFE port configurations and port start command to
>>>> start
>>>> an audio session.
>>>
>>> It would be good to clarify what sort of endpoints can be supported. I
>>> presume the SOF-synchronous case is handled, but how would you deal with
>>> async endpoints with feedback (be it explicit or implicit)?
>>>
>>
>> Sure, both types of feedback endpoints are expected to be supported by
>> the audio DSP, as well as sync eps.  We have the logic there to modify
>> the audio sample size accordingly.
> 
> did you mean modify samples per USB frame (or uframe), so as to change
> the pace at which data is transferred? If yes it'd be the same for Intel.
> 

Yes, sorry for not being clear.  Your understanding is correct.

>>>>      static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>>>> +    {"USB Playback", NULL, "USB_RX"},
>>>
>>> ... but here RX means playback?
>>>
>>> I am not sure I get the convention on directions and what is actually
>>> supported?
>>>
>>
>> The notation is based on the direction of which the audio data is
>> sourced or pushed on to the DSP.  So in playback, the DSP is receiving
>> audio data to send, and capture, it is transmitting audio data received.
>> (although we do not support capture yet)
> 
> ok, it'd be good to add a comment on this convention. Usually RX/TX is
> bus-centric.
> 

Sure, will do.

>>
>>>> +struct afe_param_id_usb_cfg {
>>>> +/* Minor version used for tracking USB audio device configuration.
>>>> + * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
>>>> + */
>>>> +    u32                  cfg_minor_version;
>>>> +/* Sampling rate of the port.
>>>> + * Supported values:
>>>> + * - AFE_PORT_SAMPLE_RATE_8K
>>>> + * - AFE_PORT_SAMPLE_RATE_11025
>>>> + * - AFE_PORT_SAMPLE_RATE_12K
>>>> + * - AFE_PORT_SAMPLE_RATE_16K
>>>> + * - AFE_PORT_SAMPLE_RATE_22050
>>>> + * - AFE_PORT_SAMPLE_RATE_24K
>>>> + * - AFE_PORT_SAMPLE_RATE_32K
>>>> + * - AFE_PORT_SAMPLE_RATE_44P1K
>>>> + * - AFE_PORT_SAMPLE_RATE_48K
>>>> + * - AFE_PORT_SAMPLE_RATE_96K
>>>> + * - AFE_PORT_SAMPLE_RATE_192K
>>>> + */
>>>> +    u32                  sample_rate;
>>>> +/* Bit width of the sample.
>>>> + * Supported values: 16, 24
>>>> + */
>>>> +    u16                  bit_width;
>>>> +/* Number of channels.
>>>> + * Supported values: 1 and 2
>>>
>>> that aligns with my feedback on the cover letter, if you connect a
>>> device that can support from than 2 channels should the DSP even expose
>>> this DSP-optimized path?
>>>
>>
>> My assumption is that I programmed the DAIs w/ PCM formats supported by
>> the DSP, so I think the ASoC core should not allow userspace to choose
>> that path if the hw params don't fit/match.
> 
> Right, but the point I was trying to make is that if the device can do
> more, why create this DSP path at all?
> 

Yeah, I think this brings me back to needing to understand a bit more of 
how the userspace chooses which PCM device to use.  At least for our 
current use cases, userspace would always route through the offload 
path, regardless of if the device can do more.  It will just select a 
lower audio profile if so.

>>
>>> Oh and I forgot, what happens if there are multiple audio devices
>>> connected, can the DSP deal with all of them? If not, how is this
>>> handled?
>>>
>>
>> This is one topic that we were pretty open ended on.  At least on our
>> implementation, only one audio device can be supported at a time.  We
>> choose the latest device that was plugged in or discovered by the USB
>> SND class driver.
> 
> Similar case for Intel. I have to revisit this, I don't recall the details.
> 

Got it.

Thanks
Wesley Cheng
