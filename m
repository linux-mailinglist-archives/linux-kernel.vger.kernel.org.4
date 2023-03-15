Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD6BA3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCOAJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCOAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:09:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B81E5F4;
        Tue, 14 Mar 2023 17:09:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ENsmTf020172;
        Wed, 15 Mar 2023 00:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zPCKRMsCsahaKMMtUZONdVc2bCCbvpGfOwWv8AHGsX8=;
 b=M/f1aIdLUwLJX0or8MQP2kMH3LKKYiMCpwQuvdKtRNLT/EIYYMCB25Sg7zLO9OUKJr3t
 w2Hgj3isSUJQizWEfbtECqlbtLUN1beEpGQa9tv0l8l1IJK5w6H3rjhm9Nmj9zpGYylV
 n3l/9x6KLp9o1FCQe8KNzYj2wk/4vwRLfdjUCdCV4IAdjzhFkQiNnRfc2Q8OC+y68jUS
 oV3rqxLYTD/PJ3lLFCRXWw7xJzsvWaCh/42HF0W3Up1xgcKTnPwZhoQ5Y2305WvS5Ple
 mxim5qae79OgNOaL0jUlhBkGHvwctiGbcMdDG/bQjaAS08qA24sYskKj6SOIyxfdoB/t 0A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c5r2u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:08:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F08Z63016019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:08:35 GMT
Received: from [10.110.94.159] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 17:08:34 -0700
Message-ID: <14d726a7-6ffc-705c-b012-0c08d7dd7b9b@quicinc.com>
Date:   Tue, 14 Mar 2023 17:08:34 -0700
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
 <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
 <a211f26d-a045-0729-871f-248d5fce3f3f@linux.intel.com>
 <684daf86-6c3f-7310-eebf-4ebfc3c480ca@quicinc.com>
 <8a37ccd3-f19e-b30d-d736-04e81b49f3a0@linux.intel.com>
 <0810f951-f4a6-a51d-97e3-43691b05f702@quicinc.com>
 <b671e263-5cb8-18e5-dc28-648ab1133c6c@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <b671e263-5cb8-18e5-dc28-648ab1133c6c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eh5qg_cLyOsw1BTykY6OR-YGSTjVMMfX
X-Proofpoint-GUID: eh5qg_cLyOsw1BTykY6OR-YGSTjVMMfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_15,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303140194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 3/13/2023 7:22 PM, Pierre-Louis Bossart wrote:
> 
> <snip>
> 
>>>
>>>>
>>>>        USB                          |            ASoC
>>>> --------------------------------------------------------------------
>>>>                                     |  _________________________
>>>>                                     | |sm8250 platform card     |
>>>>                                     | |_________________________|
>>>>                                     |         |           |
>>>>                                     |      ___V____   ____V____
>>>>                                     |     |Q6USB   | |Q6AFE    |  #5
>>>>                                     |     |"codec" | |"cpu"    |
>>>>                                     |     |________| |_________|
>>>>                                     |         ^
>>>>                                     |         |  #6
>>>>                                     |      ___V____
>>>>                                     |     |SOC-USB |
>>>>     ________   #1  ________         #7    |        |
>>>>    |USB SND |<--->|QC offld|<------------>|________|
>>>>    |(card.c)|     |        |<----------       ^
>>>>    |________|     |________|___ #4  | |       |
>>>>        ^               ^       |    | |    ___V__________________
>>>>        | #2            |  #2   |    | |   |APR/GLINK             |
>>>>     __ V_______________V_____  |    | |   |______________________|
>>>>    |USB SND (endpoint.c)     | |    | |              ^
>>>>    |_________________________| |    | | #8           |
>>>>                ^               |    | |   ___________V___________
>>>>                | #3            |    | |->|audio DSP              |
>>>>     ___________V_____________  |    |    |_______________________|
>>>>    |XHCI HCD                 |<-    |
>>>>    |_________________________|      |
>>>>
>>>>
>>>> #1 - USB SND and QC offload:
>>>> Initialization:
>>>> - Register platform operations, to receive connect/disconnect events
>>>>     from USB SND.
>>>> - QC offload creates a QMI handle, in order to receive QMI requests
>>>>     from the audio DSP.
>>>>
>>>> Runtime:
>>>> - USB SND passes along "struct snd_usb_audio" in order for QC offload
>>>>     to reference USB UAC desc parsing/USB SND helper APIs.
>>>> - USB device disconnection events will result in clearing of the chip
>>>>     entry.
>>>>
>>>> #2 - USB SND and QC offload endpoints:
>>>> Runtime:
>>>> - In the non-offloaded path, USB snd will utilize functions exposed by
>>>>     USB SND endpoint, to help with fetching USB EP references and queuing
>>>>     URBs.
>>>> - In the offload path, qc offload will utilize the functions to fetch
>>>>     USB EP references, so that it can use that information to query the
>>>>     XHCI HCD.
>>>> - Likewise, both will clean up endpoints when audio stream is not in
>>>> use.
>>>>
>>>> #3 - XHCI HCD:
>>>> Initialization:
>>>> - During XHCI probe timing, when the USB HCD is added to the system, it
>>>>     will also initialize the secondary event rings.
>>>>
>>>> Runtime:
>>>> - During USB device plug ins/outs, allocates device slot, assigns eps,
>>>>     and initializes transfer rings.
>>>>
>>>> #4 - QC offload and XHCI:
>>>> Runtime:
>>>> - QC offload needs to reference the transfer ring and secondary event
>>>> ring
>>>>     addresses by executing XHCI offload management APIs.
>>>> - This happens when audio DSP receives a USB QMI stream request.
>>>>
>>>> #5 - ASoC components:
>>>> Initialization:
>>>> - The SM8250 platform sound card driver fetches DT node entries defining
>>>>     the ASoC links. This chain/link has the components involved for a
>>>>     particular Q6AFE path. (not only USB offload)
>>>>       - "cpu" - this is the ASoC CPU DAI that handles interaction with
>>>> the
>>>>                 Q6 DSP's audio protocol. (AFE ports)
>>>>       - "codec" - the ASoC codec (backend) DAI defined
>>>> - Registers ASoC platform sound card based on links defined in the DT
>>>> node.
>>>>     - Probes DAI components involved, ie Q6USB and Q6AFE
>>>>
>>>> Runtime:
>>>> - Q6AFE has the bulk of the interaction w/ the audio DSP to start an
>>>> audio
>>>>     session, such as issuing AFE port start commands (part of the
>>>> protocol
>>>>     used to communicate the audio session info)
>>>> - Q6USB will be there to now check for if format requested is
>>>> supported by
>>>>     the device, and maintain offloading status.
>>>>
>>>> #6 - Q6USB and SOC-USB:
>>>> Initialization:
>>>> - Q6USB will query QC offload for USB device connection states. (through
>>>>     soc-usb)
>>>> - Creates a SOC USB entry, that carries information about resources,
>>>>     such as audio DSP memory information and requested XHCI event ring
>>>>     index.
>>>>
>>>> Runtime:
>>>> - SOC-USB will receive connect/disconnect events and propagate to Q6USB.
>>>>     - Q6USB makes devices available for offloading based on these events.
>>>> - Sets Q6AFE port configurations to select the USB SND card# and PCM#.
>>>>
>>>> #7 - SOC-USB and QC offload:
>>>> Initialization:
>>>> - Rediscover USB SND devices when the SOC-USB entry is created (if
>>>> needed)
>>>>       - For situations where the Q6USB DAI hasn't been probed.
>>>>
>>>> Runtime:
>>>> - Propagate connect/disconnect events.
>>>
>>> Is the SOC-USB module or building blocks intended to be generic or
>>> Qualcomm agnostic?
>>>
>>
>> This should be generic.
> 
> ok, but then how would it communicate with APR/GLINK described below [1]

To make the diagram a bit more compact, I left out our Q6ASM DAI, which 
is the path that handles the PCM data/buffers. (not really involved in 
initializing any part of the offload path)

Sorry made a mistake on the diagram.  There is no connection from 
SOC-USB to the APR/GLINK.  The Q6USB driver will be the one that is 
going to configure some of the Q6AFE ports along withe the Q6AFE DAI driver.

|            ASoC
----------------------------------
|  _________________________
| |sm8250 platform card     |
| |_________________________|
|         |           |
|      ___V____   ____V____
|     |Q6USB   | |Q6AFE    |  #5
|     |"codec" | |"cpu"    |
|     |________| |_________|
|         ^  ^        ^
|      #6 |  |________|
|      ___V____     |
|     |SOC-USB |    |
#7    |        |    |
----->|________|    |
---                 |
| |                 |
| |    _____________V________
| |   |APR/GLINK             |
| |   |______________________|
| |              ^
| | #8           |
| |   ___________V___________
| |->|audio DSP              |
|    |_______________________|
|
|

>>
>>> It's not clear to me how it would handle "audio DSP memory information
>>> and requested XHCI event ring index."
>>>
>>
>> Each soc-usb entry that is created by the ASoC DPCM backend DAI (q6usb)
>> will be able to hold "private data" that, in QC case, is defined as:
>> struct q6usb_offload
>>
>> This is passed within the snd_soc_usb_add_port() call:
>> snd_soc_usb_add_port(component->dev, &data->priv,
>> q6usb_alsa_connection_cb);
>>
>> So depending on the user, the private data can contain their own struct
>> with the information they require.
> 
> ok, so "handle private data such as audio DSP memory information
>>> and requested XHCI event ring index" is what you meant. That'd fine.
> 
>>> In addition, it seems to be the "bridge" or means of communication
>>> between qc_audio_offload and q6usb, is this not based on custom events
>>> or triggers?
>>>
>>
>> Ideally, no, it shouldn't be based on custom events.  Intention for the
>> connect_cb() that is defined is just to receive USB device discovery
>> events from USB SND.  From the qc_audio_offload, we call
>> snd_soc_usb_connect() within our platform op that we register to USB SND.
>>
>> //Platform connect_cb() - called from USB SND probe (device connected)
>> static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
>> {
>> ...
>> snd_soc_usb_connect(usb_get_usb_backend(udev), chip->card->number,
>>                  chip->index, chip->pcm_devs);
>>
>> In the QC situation, we used this to build a list of active devices
>> connected.
>>
>>> Along the same lines, this SOC-USB entity interfaces with APR/GLINK
>>> which doesn't speak to me so it must be a QCOM interface?>>
>>
>> Sorry for not labeling those in the diagram, but yes, those are QC
>> specific interfaces.  You can just think of it as a type of IPC transport.
> 
> [1] ... something's not clear on how a generic 'soc-usb' component can
> directly talk to a vendor-specific IPC.
> 
> Is there a missing layer?
> 

:) hopefully the updated diagram clarifies this.

>>> I am trying to see if this design could be used for other architectures,
>>> and the QCOM-specific and generic parts are not obvious.
>>>
>>>> #8 - audio DSP and QC offload:
>>>> Runtime:
>>>> - Handle QMI requests coming from audio DSP.  These requests come AFTER
>>>>     the Q6AFE port is opened by the Q6AFE DAI(#6)
>>>> - Returns memory information about resources allocated by XHCI.
>>>> - Enables audio playback when this QMI transaction is completed.
>>>>
>>>>>>
>>>>>>>> When the audio DSP wants to enable a playback stream, the request is
>>>>>>>> first
>>>>>>>> received by the ASoC platform sound card.  Depending on the selected
>>>>>>>> route,
>>>>>>>> ASoC will bring up the individual DAIs in the path.  The Q6USB
>>>>>>>> backend DAI
>>>>>>>> will send an AFE port start command (with enabling the USB playback
>>>>>>>> path), and
>>>>>>>> the audio DSP will handle the request accordingly.
>>>>>>>>
>>>>>>>> Part of the AFE USB port start handling will have an exchange of
>>>>>>>> control
>>>>>>>> messages using the QMI protocol.  The qc_audio_offload driver will
>>>>>>>> populate the
>>>>>>>> buffer information:
>>>>>>>> - Event ring base address
>>>>>>>> - EP transfer ring base address
>>>>>>>>
>>>>>>>> and pass it along to the audio DSP.  All endpoint management will
>>>>>>>> now
>>>>>>>> be handed
>>>>>>>> over to the DSP, and the main processor is not involved in
>>>>>>>> transfers.
>>>>>>>>
>>>>>>>> Overall, implementing this feature will still expose separate sound
>>>>>>>> card and PCM
>>>>>>>> devices for both the platorm card and USB audio device:
>>>>>>>>      0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>>>>>>                           SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>>>>>>      1 [Audio          ]: USB-Audio - USB Audio
>>>>>>>>                           Generic USB Audio at
>>>>>>>> usb-xhci-hcd.1.auto-1.4,
>>>>>>>> high speed
>>>>>>>>
>>>>>>>> This is to ensure that userspace ALSA entities can decide which
>>>>>>>> route
>>>>>>>> to take
>>>>>>>> when executing the audio playback.  In the above, if card#1 is
>>>>>>>> selected, then
>>>>>>>> USB audio data will take the legacy path over the USB PCM drivers,
>>>>>>>> etc...
>>>>>>>
>>>>>>> I already voiced my concerns about exposing two cards, each with
>>>>>>> their
>>>>>>> own set of volume controls with the same device. It would be much
>>>>>>> better
>>>>>>> to have an additional offloaded PCM device for card0...
>>>>>>>
>>>>>>> But if the consensus is to have two cards, it's still not clear
>>>>>>> how the
>>>>>>> routing would be selected. In the case where there are two USB audio
>>>>>>> devices attached, the offloaded path would only support one of the
>>>>>>> two.
>>>>>>> How would userspace know which of the two is selected?
>>>>>>>
>>>>>>
>>>>>> With patch#24:
>>>>>> https://lore.kernel.org/linux-usb/20230308235751.495-25-quic_wcheng@quicinc.com/T/#u
>>>>>>
>>>>>> Now, userspace can at least choose which device it wants to offload.
>>>>>> Part of doing that would mean userspace knows what USB SND card
>>>>>> devices
>>>>>> are available, so it is aware of which devices are shared (between the
>>>>>> offload and USB SND path)
>>>>>>
>>>>>>> And how would userspace know the difference anyways between two
>>>>>>> physical
>>>>>>> devices attached to the platform with no offload, and one physical
>>>>>>> device with one additional offload path? The names you selected
>>>>>>> can't be
>>>>>>> used to identify that card1 is the optimized version of card0.
>>>>>>>
>>>>>>
>>>>>> Is userspace currently able to differentiate between cards that are
>>>>>> created by USB SND versus ASoC?  How complex can the userspace card
>>>>>> discovery be?  Can it query kcontrols at this point in time?  If so,
>>>>>> maybe we can change the names of the newly added ones to reflect
>>>>>> that it
>>>>>> is an offload device?
>>>>>>
>>>>>> SND kcontrol names are currently:
>>>>>> Q6USB offload status
>>>>>> Q6USB offload SND device select
>>>>>
>>>>> I must admit I've never seen kcontrols being used to identify what the
>>>>> card is, and in this case it's a pretend-card that's just an improved
>>>>> version of another. It might be easier to use something else, such as
>>>>> the component strings.
>>>>
>>>> Its not exactly a pretend card, right?  This is part of the overall
>>>> platform sound card we have in the system.  At the moment, I'm only
>>>> testing by adding the USB audio routing, but there can be several ASoC
>>>> links defined in the overall platform card.
>>>
>>> Sorry, I misunderstood the proposal. I thought there would be one card
>>> for "generic USB Audio", and another one for "DSP-offloaded USB Audio".
>>> I assumed, probably mistakenly, that all local audio endpoints
>>> (speaker,mics) would be exposed as a separate card.
>>>
>>
>> Ah got it.  No, that isn't the case here.
>>
>>> It looks like it's more "generic USB Audio" and "DSP Audio", with the
>>> USB offload being exposed as a PCM device of the latter.
>>>
>>> Did I get this right? In this case, presumably there can be some sort of
>>
>> Yep that's correct!
> 
> ok, that's good.
> 
> My initial thought was to add a 'DSP offload' PCM to the USB card, you
> added a "USB offload" PCM to the DSP card. Nice logical swap!
> 
> Your proposal might be easier in practice since there's typically a
> vendor-specific configuration file (UCM or custom) file for the DSP,
> where USB information can be added.
> 
> It's more problematic to change a generic USB card as we know it today
> and bolt vendor-specific DSP information on top.
> 
> The only open I have with your option is that there are still two
> control paths to e.g. set the volume. It would be so much easier for
> userspace if there was a single volume control no matter what path is
> used for data, or make sure the kcontrols are 'mirrored' somehow. If we
> found a way to address this issue that would be ideal.
> 

Got it.  Let me look to see if that is something we can address/add.  I 
think the current implementation is that USB SND will expose some mixer 
controls based on the UAC descriptor parsing.  Then when they want to 
change the volume (for example) it will result in a USB SETUP transaction.

So USB SND will eventually be the entity controlling these changes.

>>> UCM file for the "DSP Audio card" that contains the configuration or
>>> knows which kcontrols to look for. But my point about detection hold.
>>> You could perfectly well have a 'Jack control' that tells userspace when
>>> a device is connected. That way there's no guess work, it's similar to
>>> HDMI for Intel: the device is exposed but only valid when the jack
>>> control is set.
>>>
>>
>> Hmm, ok.  Let me see if I can switch up some things.  Maybe replace the
>> current snd_soc_dapm_enable_pin() calls in the q6usb connection_cb and
>> replace that with a snd jack report. (the snd jack implementation
>> already takes care of updating the pin if needed)
> 
> The jack is useful to let userspace know if a PCM device, i.e. a
> Front-End, can be used. But if you expose a PCM device, nothing prevents
> an application from trying to open and use it, we recently had such an
> issue due to a change in PipeWire that tried to open a non-functional
> HDMI device. So you do need something to bail if the PCM device is
> mistakenly used.
> 
> DAPM pin management seems different, it will turn-on/off parts of the
> graph connected to an endpoint. Userpace will typically not know
> anything about pin management, it's an in-kernel concept.
> 
> Not sure if you have to choose, those are two different layers, no?

Will review this more and fix it in the next rev.  Thanks for the inputs!

Thanks
Wesley Cheng
