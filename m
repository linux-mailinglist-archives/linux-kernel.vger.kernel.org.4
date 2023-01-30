Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56443681FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjA3Xdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA3Xdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:33:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22102125BF;
        Mon, 30 Jan 2023 15:33:34 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMsALJ005548;
        Mon, 30 Jan 2023 22:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6fxjjo1nbreWFlb8E9g3odYg5fD2O61G5CQNJWWru+8=;
 b=ZWIQegOioxMwzuBpp935Mm6fMOEpoC1LB4XVedRKJey3epzCvtg8quQ2lhI0Nt00AwS/
 2p6M0h1clCTkyWz2UGfpdNBb0IUKBc3Or4+P9UiZrobTXUj4r9kVYqNPip7jo/B+UDHm
 TNS8Yw5C7W/sJQWTWwUBQtt7CfZl9gQDSO3Sl6dMPzy2LplpyXBqS87kWP8zpFk5FQK2
 gcDmCcPi57TGxme6NDLAXgJDN/vc93l1Y8g9Go5t+9LKxroLuXYZu+A9PaI3CXEt8vUm
 hcEcDOE3GSfCQMrZGq6AbKB9EQ6vzothBZ/Yz4R6PFUxhb912pB2XvXVZpx2gN+n7PFn Yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncua8w665-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:59:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UMxeRF003188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:59:40 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 14:59:38 -0800
Message-ID: <4a255518-6fbb-122a-ba97-1e995785c35f@quicinc.com>
Date:   Mon, 30 Jan 2023 14:59:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 11/22] ASoC: qcom: Add USB backend ASoC driver for
 Q6
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
 <20230126031424.14582-12-quic_wcheng@quicinc.com>
 <7f471960-0909-4680-e192-261d1fdfe6d7@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <7f471960-0909-4680-e192-261d1fdfe6d7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yWxw15GvJRq-rxCkcrEaSdgqXMWsMmDp
X-Proofpoint-ORIG-GUID: yWxw15GvJRq-rxCkcrEaSdgqXMWsMmDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=874 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300210
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/26/2023 7:44 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/25/23 21:14, Wesley Cheng wrote:
>> Create a USB BE component that will register a new USB port to the ASoC USB
>> framework.  This will handle determination on if the requested audio
>> profile is supported by the USB device currently selected.
> 
> Can you clarify how? because ...
> 
> 
>> +static struct snd_soc_dai_driver q6usb_be_dais[] = {
>> +	{
>> +		.playback = {
>> +			.stream_name = "USB BE RX",
>> +			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
>> +				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
>> +				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
>> +				SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
>> +				SNDRV_PCM_RATE_192000,
>> +			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
>> +				SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
>> +				SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
>> +				SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
>> +			.channels_min = 1,
>> +			.channels_max = 2,
>> +			.rate_max =     192000,
>> +			.rate_min =	8000,
>> +		},
>> +		.id = USB_RX,
>> +		.name = "USB_RX_BE",
>> +		.ops = &q6usb_ops,
>> +	},
>> +};
> 
> ... here I see a single DAI, so presumably ONE endpoint can be supported?
> 

One USB audio device can be supported.
one AFE port = one USB audio device

> I didn't see in the rest of the code how a card with multiple endpoint
> would be rejected, nor how the capabilities are checked?
> 

Need to take a look at this query a bit more.  Let me try to pass in a 
format that can't be supported by the audio DSP, and see if the formats 
specified in this structure will not allow userspace to start the session.

When you say a "card with multiple endpoints" are you referring to a USB 
device that exposes multiple data (ISOC let's say) eps for its data 
interface?  I haven't run into a device like that.

Thanks
Wesley Cheng
