Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3C63EA17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLAHDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLAHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:03:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60C862F6;
        Wed, 30 Nov 2022 23:03:36 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B15A2GJ009555;
        Thu, 1 Dec 2022 07:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2qT5K9rHZ2k+os7b5m3JWOjmTKB3v7jcnwxt+X1IumY=;
 b=I41ox6tU+lcR6OuITYdITgXsOjt517iMTGpRKC2I21OBsQx/JVi+v1pgjr0YAfEAghE5
 neEjeAZ5vQme8cz16pe0UQZ9vfD3Drzl99BmFObcn/1iUY14uRy+rSrCBAbcvmlhQPh6
 RD0rKvGLKar/lYyzkyD54wtEyl1Wrakk0QM8EMWSmcMIfIQTcKSTCNBjHjklpv70/ezD
 b84J8H1ubaDxUUQ5TUGYJGdt1ZbIn5A1xvwtVD757iVf/HwGxPxN6Zno2ZpPbz/mQerL
 o18dzwHgaUfYd7g4CeQX6qiaoBoG6D6sUdXAXXLmuf2+/5Ch1HSU1YzCexIRrJ96wFwN jA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6kgmgg02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 07:03:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1732P8018068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 07:03:02 GMT
Received: from [10.216.5.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 23:02:55 -0800
Message-ID: <85ddbbfd-15ea-dfda-bf52-bd35c4353aac@quicinc.com>
Date:   Thu, 1 Dec 2022 12:32:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system
 PM ops
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Nathan Chancellor <nathan@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
 <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
 <Y4ZmyO0o6SvrvaWq@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Y4ZmyO0o6SvrvaWq@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9WqrwfmDjSQiYRwThR4I3FM4PNKDZ-rx
X-Proofpoint-GUID: 9WqrwfmDjSQiYRwThR4I3FM4PNKDZ-rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010048
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time Matthias,

On 11/30/2022 1:38 AM, Matthias Kaehlcke wrote:
> On Tue, Nov 29, 2022 at 09:28:33PM +0530, Srinivasa Rao Mandadapu wrote:
>> Thanks for your tie Nathan!!!
>>
>> On 11/29/2022 9:15 PM, Nathan Chancellor wrote:
>>> On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
>>>> Add __maybe_unused tag for system PM ops suspend and resume.
>>>> This is required to fix allmodconfig compilation issue.
>>>> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> A better solution would be replacing SET_SYSTEM_SLEEP_PM_OPS() with
>>> SYSTEM_SLEEP_PM_OPS(), which was added to avoid needing to add these
>>> '__maybe_unused' attributes to these functions. See commit 1a3c7bb08826
>>> ("PM: core: Add new *_PM_OPS macros, deprecate old ones") for more info.
>> Tried this option but as this patch required for Kernel 5.4 version code
>> base,
>>
>> SYSTEM_SLEEP_PM_OPS didn't work.
> Older downstream trees needing a change shouldn't impact how a change is done
> upstream. The change should be what's best for the upstream kernel. Downstream
> kernels can do backports which might differ from the upstream solution or
> pick the missing dependencies (which might not be too hard in this case).
Okay. Will take care next time.
>
>>>> ---
>>>>    sound/soc/qcom/lpass-sc7180.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
>>>> index b96b85a..41db661 100644
>>>> --- a/sound/soc/qcom/lpass-sc7180.c
>>>> +++ b/sound/soc/qcom/lpass-sc7180.c
>>>> @@ -163,14 +163,14 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
>>>>    	return 0;
>>>>    }
>>>> -static int sc7180_lpass_dev_resume(struct device *dev)
>>>> +static int __maybe_unused sc7180_lpass_dev_resume(struct device *dev)
>>>>    {
>>>>    	struct lpass_data *drvdata = dev_get_drvdata(dev);
>>>>    	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
>>>>    }
>>>> -static int sc7180_lpass_dev_suspend(struct device *dev)
>>>> +static int __maybe_unused sc7180_lpass_dev_suspend(struct device *dev)
>>>>    {
>>>>    	struct lpass_data *drvdata = dev_get_drvdata(dev);
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
