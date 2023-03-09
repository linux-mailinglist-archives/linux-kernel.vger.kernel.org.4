Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16486B2DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCITkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCITkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:40:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DFEB8BE;
        Thu,  9 Mar 2023 11:40:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IXdSK020454;
        Thu, 9 Mar 2023 19:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sRNeP2T1XPb5a8n/b7EOgeAZVOwYAVFLqGl65EupL2c=;
 b=FapmyhM5N3/f0vZX4Ka+Gh7xoBt1rcaH0WztJG2fxDH4NUbkHmRnjY7gonorfdF7o9Jr
 K73n82fQT3ZDZsvHcG3DgsvNEcy1nWShYRHDbbG/WfjkAZ00tazjK1rxp66nh56TEbO7
 TwQ4Ne4GtaxUMoJXW9Bg4exF/DlRfbeY/WRheflMbC263N5sVp9M/4aW1p2HMh6J1rSz
 Xa+bBj0cpO8N8EJ3y+s3qsmaj7Dm3+noT+vJtKn/LEQhm+Fl2BcOn9P39r9mXtz2RxzL
 ps/SavLLslNSVwiKKrgSjhiC1qdAxx2DvDAwfTyNWuL98qTo1p5jNnADfeOcOM2kygO4 0Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7jutrj1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 19:39:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329Jd7Nj023363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 19:39:07 GMT
Received: from [10.110.90.116] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 11:39:06 -0800
Message-ID: <b27911c3-0da4-e7e8-3b0a-3788a3998bd3@quicinc.com>
Date:   Thu, 9 Mar 2023 11:39:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 22/28] ASoC: qcom: qdsp6: q6afe: Split USB AFE
 dev_token param into separate API
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <mathias.nyman@intel.com>, <perex@perex.cz>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-23-quic_wcheng@quicinc.com>
 <ae214ad1-3eb0-3a54-d0d2-ac9812aad186@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ae214ad1-3eb0-3a54-d0d2-ac9812aad186@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UW2SVZh4x3-qfcP6dvK8g1IjL0R7sy3u
X-Proofpoint-ORIG-GUID: UW2SVZh4x3-qfcP6dvK8g1IjL0R7sy3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_11,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 3/9/2023 1:01 AM, Srinivas Kandagatla wrote:
> 
> 
> On 08/03/2023 23:57, Wesley Cheng wrote:
>> The Q6USB backend can carry information about the available USB SND cards
>> and PCM devices discovered on the USB bus.  The dev_token field is 
>> used by
>> the audio DSP to notify the USB offload driver of which card and PCM 
>> index
>> to enable playback on.  Separate this into a dedicated API, so the USB
>> backend can set the dev_token accordingly.  The audio DSP does not 
>> utilize
>> this information until the AFE port start command is sent, which is done
>> during the PCM prepare phase.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe.c | 49 +++++++++++++++++++++++++-----------
>>   sound/soc/qcom/qdsp6/q6afe.h |  1 +
>>   2 files changed, 36 insertions(+), 14 deletions(-)
>>
> Looks like this could be part of [06/28] ASoC: qcom: qdsp6: Introduce 
> USB AFE port to q6dsp
> 
> you are modifying the 06/28 patch in this patch.
> 
> other than that it looks fine to me.
> 

Sure I'll squash the two.

Thanks
Wesley Cheng
