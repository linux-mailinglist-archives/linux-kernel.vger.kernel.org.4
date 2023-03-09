Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1016B2F55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCIVKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCIVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:10:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F711C31B;
        Thu,  9 Mar 2023 13:10:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IXgOP018291;
        Thu, 9 Mar 2023 21:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8el4BNsj1CspilqeKLLsVHYfa8Yw1SbtZUvlg7ilTVs=;
 b=R3hTZPGfy8WYMPksfZV27q+LnKBIRnmKIDJoBuUAzzFAGmYy1Udr4VuU2fk2RXmytBzu
 XYmsXgiB1QOM5zM8WM3qddB3ImeRV7kJeiMnU/P6dfx82JNyKGcC8mR158bAxKKHYyFH
 sHbffgFuzuhtG3uTemdKJSf8in1s3pphh/5IMkuAOs2SDxh5d43E0S+921SDm4WdlzeI
 Sslt7uVh9m94LWnjwpk/wA5Imjn2HTMCOLiMoZD57iCmZAsbBEHs41Srrt4SGnFEyyAh
 XebIcIdjNnzi7D65oroQnHr8mOGAQaQFZXfRzLAaow3MKQU/o15l9We+SPhu0u6uRsE8 Og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7mgrgf6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 21:10:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329LA6nA019125
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 21:10:06 GMT
Received: from [10.110.90.116] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 13:10:01 -0800
Message-ID: <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
Date:   Thu, 9 Mar 2023 13:10:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 00/28] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <4f8a66c0-398f-5655-3aa7-a59bc9ba56cc@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <4f8a66c0-398f-5655-3aa7-a59bc9ba56cc@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1PbZ9S7KhArdbbBF6PRZi3aursefaom7
X-Proofpoint-GUID: 1PbZ9S7KhArdbbBF6PRZi3aursefaom7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090172
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 3/9/2023 9:13 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 3/8/23 17:57, Wesley Cheng wrote:
>> Changes in v3:
>> - Changed prefix from RFC to PATCH
>> - Rebased entire series to usb-next
>> - Updated copyright years
> 
> You may want to move the per-version changes after the description of
> this patchset.
> 

Thanks for reading through this :).

Sure, will do that going forward.

>> XHCI:
>> - Rebased changes on top of XHCI changes merged into usb-next, and only added
>> changes that were still under discussion.
>> - Added change to read in the "num-hc-interrupters" device property.
>>
>> ASoC:
>> - qusb6 USB backend
>>    - Incorporated suggestions to fetch iommu information with existing APIs
>>    - Added two new sound kcontrols to fetch offload status and offload device
>>      selection.
>>      - offload status - will return the card and pcm device in use
>>          tinymix -D 0 get 1 --> 1, 0 (offload in progress on card#1 pcm#0)
>>
>>      - device selection - set the card and pcm device to enable offload on. Ex.:
>>          tinymix -D 0 set 1 2 0  --> sets offload on card#2 pcm#0
>>                                      (this should be the USB card)
>>
>> USB SND:
>> - Fixed up some locking related concerns for registering platform ops.
>>     - Moved callbacks under the register_mutex, so that
>> - Modified APIs to properly pass more information about the USB SND device, so
>> that the Q6USB backend can build a device list/map, in order to monitor offload
>> status and device selection.
>>
>> Changes in v2:
>>
>> XHCI:
>> - Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
>> in his tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
>>
>> Adjustments made to Mathias' changes:
>>    - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
>>      Moved dependent structures to this file as well. (so clients can parse out
>>      information from "struct xhci_interrupter")
>>    - Added some basic locking when requesting interrupters.
>>    - Fixed up some sanity checks.
>>    - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
>>      issue where SMMU fault occurs if DMA addr returned is 64b - TODO)
>>
>> - Clean up pending events in the XHCI secondary interrupter.  While testing USB
>> bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
>> timeout.
>> - Added offloading APIs to xHCI to fetch transfer and event ring information.
>>
>> ASoC:
>> - Modified soc-usb to allow for multiple USB port additions.  For this to work,
>> the USB offload driver has to have a reference to the USB backend by adding
>> a "usb-soc-be" DT entry to the device saved into XHCI sysdev.
>> - Created separate dt-bindings for defining USB_RX port.
>> - Increased APR timeout to accommodate the situation where the AFE port start
>> command could be delayed due to having to issue a USB bus resume while
>> handling the QMI stream start command.
>>
>> USB SND:
>> - Added a platform ops during usb_audio_suspend().  This allows for the USB
>> offload driver to halt the audio stream when system enters PM suspend.  This
>> ensures the audio DSP is not issuing transfers on the USB bus.
>> - Do not override platform ops if they are already populated.
>> - Introduce a shared status variable between the USB offload and USB SND layers,
>> to ensure that only one path is active at a time.  If the USB bus is occupied,
>> then userspace is notified that the path is busy.
> 
> 
> ---> start of the cover letter:
> 
>> Several Qualcomm based chipsets can support USB audio offloading to a
>> dedicated audio DSP, which can take over issuing transfers to the USB
>> host controller.  The intention is to reduce the load on the main
>> processors in the SoC, and allow them to be placed into lower power modes.
>> There are several parts to this design:
>>    1. Adding ASoC binding layer
>>    2. Create a USB backend for Q6DSP
> 
> clarify what 'backend' means. I would guess you are referring to the
> ASoC DPCM concept of Back-End, which typically exposes an audio
> interface controlled by a DSP?
> 
> If yes, the description should be
> 
> "Create a Q6DSP ASoC DPCM BackEnd for USB audio playback/record".
> 

You're correct.  "backend" was referring to a Q6DSP ASoC DPCM backend.

>>    3. Introduce XHCI interrupter support
>>    4. Create vendor ops for the USB SND driver
> 
> Add an introduction as to why this would be needed? which 'vendor' are
> we talking about, is this on the SOC side or the USB device side?
> 

This would be referring to the SoC side.  For example, QCOM can 
potentially have a different implementation of offloading USB SND to the 
audio DSP versus another OEM.  This is to allow those other entities to 
be able to define their own offload methodology.

For the most part, the common operations across all offloading 
implementations have so far is being able to handle USB SND 
connect/disconnect events.

>> Adding ASoC binding layer:
>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>> The port is always present on the device, but cable/pin status can be
>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>> communicate with USB SND.
> 
> port == backend?
> 
> Using different words for the same concept is a sure way to lose the
> reviewers, and not describing different concepts isn't much better.
> 

Yes, port is corresponding to the

>> Create a USB backend for Q6DSP:
>> q6usb: Basic backend driver that will be responsible for maintaining the
> 
> What does this mean? Is this a module that registers a set of ASoC DAIs?
> 
> It's not clear to me what a 'backend driver' means either in a USB or
> ASoC context.
> 

Will fix this up next time.  It refers to a Q6DSP DPCM ASoC backend, as 
you mentioned above.

>> resources needed to initiate a playback stream using the Q6DSP.  Will
>> be the entity that checks to make sure the connected USB audio device
>> supports the requested PCM format.  If it does not, the PCM open call will
>> fail, and userpsace ALSA can take action accordingly.
> 
> If it's an ASoC backend, there is no PCM open call. You're probably
> referring to the hw_params, not the open/startup anyways.
> 

Correct.  Will fix this.

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
> 
> so how does this 'qc_audio_offload' interface with 'q6usb' described
> above? how are the roles different or complementary?
> 
So in general you can think that the qc_audio_offload is a complement to 
the USB SND USB class driver, while q6usb is to ASoC.  Since the ASoC 
framework doesn't have any communication with USB SND, the ASoC DPCM USB 
backend (q6usb) will have to be the entity that maintains what is going 
on in USB SND.  That way, sessions initiated through the ASoC managed 
sound card can evaluate what is available based on information reported 
by q6usb.

qc_audio_offload and q6usb will have some interaction between each 
other.  The majority of communication between qc_audio_offload and q6usb 
is reporting the device connection events.

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
> 
> I already voiced my concerns about exposing two cards, each with their
> own set of volume controls with the same device. It would be much better
> to have an additional offloaded PCM device for card0...
> 
> But if the consensus is to have two cards, it's still not clear how the
> routing would be selected. In the case where there are two USB audio
> devices attached, the offloaded path would only support one of the two.
> How would userspace know which of the two is selected?
> 

With patch#24:
https://lore.kernel.org/linux-usb/20230308235751.495-25-quic_wcheng@quicinc.com/T/#u

Now, userspace can at least choose which device it wants to offload. 
Part of doing that would mean userspace knows what USB SND card devices 
are available, so it is aware of which devices are shared (between the 
offload and USB SND path)

> And how would userspace know the difference anyways between two physical
> devices attached to the platform with no offload, and one physical
> device with one additional offload path? The names you selected can't be
> used to identify that card1 is the optimized version of card0.
> 

Is userspace currently able to differentiate between cards that are 
created by USB SND versus ASoC?  How complex can the userspace card 
discovery be?  Can it query kcontrols at this point in time?  If so, 
maybe we can change the names of the newly added ones to reflect that it 
is an offload device?

SND kcontrol names are currently:
Q6USB offload status
Q6USB offload SND device select

> Before we review low-level kernel plumbing, it would be good to give a
> better overview of how userspace applications are supposed to interact
> with the cards and identify the offloaded path. Testing with
> tinyplay/tinymix is fine, but that's a developer-level or CI unit test.
> we've got to see the broader picture of how a sound server would use
> this USB offload capability.

Sure, I think that is fine.  I was hoping that at least adding some of 
the new kcontrols would help userspace make use of this path in general, 
but we can add more information if required.

Thanks
Wesley Cheng
