Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF565F92D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAFBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAFBds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:33:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DD18B32;
        Thu,  5 Jan 2023 17:33:41 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30617lYa002491;
        Fri, 6 Jan 2023 01:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EPPJJquUmVF7Qc2Iy/gHw+vCbRk1oBfl7WGwMVHjjxw=;
 b=BqdXZR1xIWucXLvhoM9kyeLFMB0vlS/Xe3PU92pVOX/+BiPm9GqtVwOM3P7YNxnD7ObF
 1vhcbCjKky9iiwYUvAaozfnopkY1+MR87tvnAe0KJaLSudWe7LKeMaNByIWg/bdRfOwa
 cTcVLXhrNP9Q6hg1b4xXdDnij9esIemBKNmqltdVNuS7OcURvZ0SZQh3cYuZfMM13gRN
 DCmvrv1XlsvqIqtBN5IB1a1M6oGnVgCo7NzdLzq2BYLFGTpqi+wd0sQ+3I515Ou0IAoF
 Gd7uoO5zExcPsqUoquYttblzp18wyVzyXr8lYXzRDfnKnhL1LanrDX23ilVh9yNUIJRy HQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx9jfg1ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 01:32:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3061Wn5i031136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 01:32:49 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 17:32:48 -0800
Message-ID: <dd0bb92f-036e-3ba7-4c0a-9536ba0c179a@quicinc.com>
Date:   Thu, 5 Jan 2023 17:32:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 02/14] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-3-quic_wcheng@quicinc.com>
 <5b4d657c-1acf-f90b-be64-3e36cca96686@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <5b4d657c-1acf-f90b-be64-3e36cca96686@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1gRGGqNwZdkAeANIiLhfXAm7SBUBRYkT
X-Proofpoint-ORIG-GUID: 1gRGGqNwZdkAeANIiLhfXAm7SBUBRYkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=731 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060009
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/5/2023 10:09 AM, Krzysztof Kozlowski wrote:
> On 24/12/2022 00:31, Wesley Cheng wrote:
>> The QC ADSP is able to support USB playback and capture, so that the
>> main application processor can be placed into lower CPU power modes.  This
>> adds the required AFE port configurations and port start command to start
>> an audio session.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   .../sound/qcom,q6dsp-lpass-ports.h            |   1 +
>>   sound/soc/qcom/qdsp6/q6afe-dai.c              |  47 +++++
>>   sound/soc/qcom/qdsp6/q6afe.c                  | 183 ++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6afe.h                  |  46 ++++-
>>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |  23 +++
>>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |   1 +
>>   sound/soc/qcom/qdsp6/q6routing.c              |   8 +
>>   7 files changed, 308 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> index 9f7c5103bc82..746bc462bb2e 100644
>> --- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> +++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> @@ -131,6 +131,7 @@
>>   #define RX_CODEC_DMA_RX_7	126
>>   #define QUINARY_MI2S_RX		127
>>   #define QUINARY_MI2S_TX		128
>> +#define USB_RX				129
>>   
>>   #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
> 
> Bindings are separate patches. Please split.
> 

Thanks for catching this.  Will do.

Thanks
Wesley Cheng
