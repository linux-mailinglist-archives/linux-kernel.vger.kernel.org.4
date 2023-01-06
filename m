Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728665F8A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjAFBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjAFBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:06:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F66E435;
        Thu,  5 Jan 2023 17:06:53 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305N8x3o008970;
        Fri, 6 Jan 2023 01:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FcuAOQbllRhmH8qhEZKJY9Hw6HNDVm92HvBhxZczYDQ=;
 b=porboc8+tR1WTFp5opFaP3VOlLpToAKQamRr/twhlhaGhuMrbHMm++UhtqcEaZVA60Wc
 5XoM0BrhgJKagE8vYpIt1RW1FDoRUryrAe51fkidYN/H01grpz9myLqcp0DaU46YUqVQ
 oVoWvTWF+h4JSHu0wu4mi0d853SZH6i26qOTE6eTGhmjJEQYMv8LDAH304Tfbe1p2sDY
 z08rVnsNpTSlQLhfNAaQtF+LNfZH0X6iuWzKGz4M9tAmruuisZMVmJqinyXohWx5vAdg
 u9bduvjY17V1L4gXbeZcuJ/JmA0K1TJcRNobsbDROd6tNFo6ndmlZ/X245S04o7bmTkp nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwvaphnau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 01:05:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30615uO7019008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 01:05:56 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 17:05:55 -0800
Message-ID: <0f903c49-a989-14a6-bac1-c4cae21839eb@quicinc.com>
Date:   Thu, 5 Jan 2023 17:05:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
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
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <e29060b1-df65-c0d1-5777-023879a5863e@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <e29060b1-df65-c0d1-5777-023879a5863e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6_IpYtxD6uzAwC3wkpJuW8wRxLMR9ea2
X-Proofpoint-ORIG-GUID: 6_IpYtxD6uzAwC3wkpJuW8wRxLMR9ea2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=789 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060006
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/4/2023 3:41 PM, Pierre-Louis Bossart wrote:
> 
>> +int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>> +			int connected)
>> +{
>> +	struct snd_soc_dapm_context *dapm;
>> +	struct q6usb_port_data *data;
>> +
>> +	if (!usb->component)
>> +		return 0;
>> +
>> +	dapm = snd_soc_component_get_dapm(usb->component);
>> +	data = dev_get_drvdata(usb->component->dev);
>> +
>> +	if (connected) {
>> +		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>> +		/* We only track the latest USB headset plugged in */
> 
> that answers to my earlier question on how to deal with multiple
> devices, but is this a desirable policy? This could lead to a lot of
> confusion. If there are restrictions to a single device, then it might
> be more interesting for userspace or the user to indicate which USB
> device gets to use USB offload and all others use legacy.
> 

Yeah, as mentioned its still pretty open ended.  I think from the 
feedback received from Mark/Takashi, this was a viable option for now. 
Would you happen to have any insight/input on how the userspace can pass 
down that selection to the ASoC framework?  Maybe some kind of PCM IOCTL 
call?

Thanks
Wesley Cheng
