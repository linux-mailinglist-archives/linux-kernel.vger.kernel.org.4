Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA165596C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLXIuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:50:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A613F8D;
        Sat, 24 Dec 2022 00:50:12 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BO8nNdB006584;
        Sat, 24 Dec 2022 08:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g4UmJxyjmtqTRAhg4qgVoU4p0UZgUFzlINjE0kA+iaM=;
 b=ItWc/iJ3n8eJwsuElg8YuHK5ICTPwNnjYOoBFMwdQDlUv0OHRNAG5s8Uuzl3E98TSwON
 Dxb0jdybZrpiIbosTSLGw/25JzEnHqo0o6K7IPJ4nAk9zek2kv+X7xVoB7Z8KiGpYPrd
 HuyypHVS2IG9/VJbs/oeztl4AbtAW46s9qY4t3KEo1pgfOMiJCvm31amZhLuLuVrEmdG
 s2czy9VDrkyGI9C9DHs082F8VMuXH/oemLUaoRIIgxnOU9KwgSII/reAHVcWqiydqSAa
 b0Fm/m/CULxTgk0EBnsQ7JObfe3RzZjHAd8nOzeks+gt+HRj1j9fz06QotFt8oh4WNJv uA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnsna097b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Dec 2022 08:49:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BO8nMMJ014633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Dec 2022 08:49:22 GMT
Received: from [10.110.37.149] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 24 Dec
 2022 00:49:20 -0800
Message-ID: <b1254942-0900-0ab2-5356-4832104c0670@quicinc.com>
Date:   Sat, 24 Dec 2022 00:49:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 00/14] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <Y6agEsfXKMMXPpmz@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y6agEsfXKMMXPpmz@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VxxEBC_10yV46A71lGzz8qkr5eFx1CbG
X-Proofpoint-ORIG-GUID: VxxEBC_10yV46A71lGzz8qkr5eFx1CbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-24_02,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212240074
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/23/2022 10:45 PM, Greg KH wrote:
> On Fri, Dec 23, 2022 at 03:31:46PM -0800, Wesley Cheng wrote:
>> Several Qualcomm based chipsets can support USB audio offloading to a
>> dedicated audio DSP, which can take over issuing transfers to the USB
>> host controller.  The intention is to reduce the load on the main
>> processors in the SoC, and allow them to be placed into lower power modes.
>> There are several parts to this design:
>>    1. Adding ASoC binding layer
>>    2. Create a USB backend for Q6DSP
>>    3. Introduce XHCI interrupter support
>>    4. Create vendor ops for the USB SND driver
>>
>> Adding ASoC binding layer:
>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>> The port is always present on the device, but cable/pin status can be
>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>> communicate with USB SND.
>>
>> Create a USB backend for Q6DSP:
>> q6usb: Basic backend driver that will be responsible for maintaining the
>> resources needed to initiate a playback stream using the Q6DSP.  Will
>> be the entity that checks to make sure the connected USB audio device
>> supports the requested PCM format.  If it does not, the PCM open call will
>> fail, and userpsace ALSA can take action accordingly.
>>
>> Introduce XHCI interrupter support:
>> XHCI HCD supports multiple interrupters, which allows for events to be routed
>> to different event rings.  This is determined by "Interrupter Target" field
>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>
>> Events in the offloading case will be routed to an event ring that is assigned
>> to the audio DSP.
>>
>> Create vendor ops for the USB SND driver:
>> qc_audio_offload: This particular driver has several components associated
>> with it:
>> - QMI stream request handler
>> - XHCI interrupter and resource management
>> - audio DSP memory management
>>
>> When the audio DSP wants to enable a playback stream, the request is first
>> received by the ASoC platform sound card.  Depending on the selected route,
>> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
>> will send an AFE port start command (with enabling the USB playback path), and
>> the audio DSP will handle the request accordingly.
>>
>> Part of the AFE USB port start handling will have an exchange of control
>> messages using the QMI protocol.  The qc_audio_offload driver will populate the
>> buffer information:
>> - Event ring base address
>> - EP transfer ring base address
>>
>> and pass it along to the audio DSP.  All endpoint management will now be handed
>> over to the DSP, and the main processor is not involved in transfers.
>>
>> Overall, implementing this feature will still expose separate sound card and PCM
>> devices for both the platorm card and USB audio device:
>>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>   1 [Audio          ]: USB-Audio - USB Audio
>>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
>>
>> This is to ensure that userspace ALSA entities can decide which route to take
>> when executing the audio playback.  In the above, if card#1 is selected, then
>> USB audio data will take the legacy path over the USB PCM drivers, etc...
>>
>> This feature was validated using:
>> - tinymix: set/enable the multimedia path to route to USB backend
>> - tinyplay: issue playback on platform card
> 
> This looks to duplicate a bunch of the same things that a number of
> different google developers have posted recently.  Please work with them
> to come up with a unified set of patches that you all can agree with,
> AND get them to sign off on the changes before resubmitting them.
> 
> This uncoordinated drip of patches from different people doing the same
> thing is almost impossible to review from our side, as I'm sure you can
> imagine.

I saw some of the Google patchsets submitted awhile back, but didn't 
really get a chance to look at them in detail.  Let me reach out to 
Albert Wang to see if we can come to a solution that works for both 
implementations.

 From the looks of it (at least from the XHCI HCD changes), it seems 
that a different set of resources is required for the Google 
implementation to work.  I'll need to ask for a bit more details before 
I can comment further...

> 
> That being said, thank you finally for at least submitting all of the
> needed changes together as one patch set.  That's a first, and something
> we had been asking for for years.
> 
> Have a good holiday break,

Thanks for the quick in-depth review, and the feedback.  Gives me some 
more things to think about improving over the break :).  Happy holidays!

Thanks
Wesley Cheng
