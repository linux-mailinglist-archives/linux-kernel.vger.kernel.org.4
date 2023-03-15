Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9DA6BBD73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOTnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCOTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:43:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9DE6A7E;
        Wed, 15 Mar 2023 12:43:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHWBGh009822;
        Wed, 15 Mar 2023 19:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UnNZ0Qza82ZwkIodDa+CZPI1WtPjgaViLzXC+xG7KXM=;
 b=GrKcb3jTcyKeKoXJgD3dmQ981zcorIM1VswdoAGx5+oEDTWzLPUtxLMz079LJxE6zu5Y
 oujKGx95bUFB7tW8WWxRzVNH7BMBcRKBoyZugsJ1EQ/thKOlkR6eARoYoCM6pUpz6k+Y
 53URSVsbw05wcJAJupadxlfyCPdbYuKZcrcSC3H4v18x0CjREAxqWU+aK7zRo1Tbp6Jn
 2nV0eSuHKdwV8oWWknP7C9/ekgfblcPJY1oMfUfpIUE2RhfY3+9bNKlADPV4QbyEQDJx
 16YGt/BtwCHxYY4wXshrY1of2XKr9BoBhkG3n6NFO1islieVlNvTEpmnXOP9FL5383q2 8A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2csarxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 19:42:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FJgGTf009399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 19:42:16 GMT
Received: from [10.110.29.17] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 12:42:15 -0700
Message-ID: <3d332f71-cccd-651a-88b1-9e33a81592e5@quicinc.com>
Date:   Wed, 15 Mar 2023 12:42:08 -0700
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
 <14d726a7-6ffc-705c-b012-0c08d7dd7b9b@quicinc.com>
 <6b811766-cd2a-54c0-d090-640812686a45@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <6b811766-cd2a-54c0-d090-640812686a45@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZZbgBR25cZPwlBw3awt6TXvZlDFYrySt
X-Proofpoint-GUID: ZZbgBR25cZPwlBw3awt6TXvZlDFYrySt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 3/15/2023 7:30 AM, Pierre-Louis Bossart wrote:
> Hi Wesley,
> 
>> Sorry made a mistake on the diagram.  There is no connection from
>> SOC-USB to the APR/GLINK.  The Q6USB driver will be the one that is
>> going to configure some of the Q6AFE ports along withe the Q6AFE DAI
>> driver.
>>
>> |            ASoC
>> ----------------------------------
>> |  _________________________
>> | |sm8250 platform card     |
>> | |_________________________|
>> |         |           |
>> |      ___V____   ____V____
>> |     |Q6USB   | |Q6AFE    |  #5
>> |     |"codec" | |"cpu"    |
>> |     |________| |_________|
>> |         ^  ^        ^
>> |      #6 |  |________|
>> |      ___V____     |
>> |     |SOC-USB |    |
>> #7    |        |    |
>> ----->|________|    |
>> ---                 |
>> | |                 |
>> | |    _____________V________
>> | |   |APR/GLINK             |
>> | |   |______________________|
>> | |              ^
>> | | #8           |
>> | |   ___________V___________
>> | |->|audio DSP              |
>> |    |_______________________|
>> |
>> |
>>
>>>>
> 
> Makes sense now, thank you for the clarification.
> 
> I'll have to dig more in this 'soc-usb' block, it's clearly a key
> component that will have to maintain a consistent state across two
> different parts of the stack and deal with probe/remove/shutdown.
> 
>>> My initial thought was to add a 'DSP offload' PCM to the USB card, you
>>> added a "USB offload" PCM to the DSP card. Nice logical swap!
>>>
>>> Your proposal might be easier in practice since there's typically a
>>> vendor-specific configuration file (UCM or custom) file for the DSP,
>>> where USB information can be added.
>>>
>>> It's more problematic to change a generic USB card as we know it today
>>> and bolt vendor-specific DSP information on top.
>>>
>>> The only open I have with your option is that there are still two
>>> control paths to e.g. set the volume. It would be so much easier for
>>> userspace if there was a single volume control no matter what path is
>>> used for data, or make sure the kcontrols are 'mirrored' somehow. If we
>>> found a way to address this issue that would be ideal.
>>>
>>
>> Got it.  Let me look to see if that is something we can address/add.  I
>> think the current implementation is that USB SND will expose some mixer
>> controls based on the UAC descriptor parsing.  Then when they want to
>> change the volume (for example) it will result in a USB SETUP transaction.
>>
>> So USB SND will eventually be the entity controlling these changes.
> 
> That's probably ok then, am I getting this right that the the DSP card
> would not expose any USB-related kcontrols then, i.e. the ONLY path to
> change volumes, etc.,  would through the regular USB card kcontrols?
> 
> That would limit the changes in the platform sound card to the addition
> of a PCM USB device.

Yes, that's correct.  There won't be any exposed USB volume controls 
from the DSP card.

Thanks
Wesley Cheng
