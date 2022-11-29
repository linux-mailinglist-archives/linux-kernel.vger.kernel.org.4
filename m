Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D782563C483
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiK2QBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiK2QBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:01:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34169A8B;
        Tue, 29 Nov 2022 07:59:41 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATFmncM016736;
        Tue, 29 Nov 2022 15:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O1zHUKyMYg/N5w80x5NsEXIV4fzGlq8CSJOktCGLEoc=;
 b=j0PVXACHfpFiyiV3rnlCeFwBcG1yGYvTRRpsz9jkx5zIW59HM4QxuMVk79qmbgT+hktG
 iz14heoVMlFAzwEC9mtcaWwo8WMhh4olSeBDBBixOzm/XqHmH+RpybeHKrOFzITq14/I
 pQOqCyfxWs6uuIbJt/2jrQYDSErW7LXIWsXbMlDyfaLAA1aiUKibiDdL3mBIEgfgKAro
 s0I1NNWkrhnw3PIp4towyuNsE769NKX2bBvzzQrROjT0gVXiILVSZpgzxn3H2L/yiPUx
 PKBqq1hMChU4NmU8naQRiNLVE0ZquYFA9FYp2+BwQzJRZM4lLIBGN3WARjhkBhb6zWZu Zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5n1vg0v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 15:58:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATFwh5f029584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 15:58:43 GMT
Received: from [10.216.9.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 07:58:37 -0800
Message-ID: <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
Date:   Tue, 29 Nov 2022 21:28:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system
 PM ops
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c5Gnbz93EI3y_DZwAkv2U-Y1I-f7G-L1
X-Proofpoint-ORIG-GUID: c5Gnbz93EI3y_DZwAkv2U-Y1I-f7G-L1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290089
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your tie Nathan!!!

On 11/29/2022 9:15 PM, Nathan Chancellor wrote:
> On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add __maybe_unused tag for system PM ops suspend and resume.
>> This is required to fix allmodconfig compilation issue.
>> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> A better solution would be replacing SET_SYSTEM_SLEEP_PM_OPS() with
> SYSTEM_SLEEP_PM_OPS(), which was added to avoid needing to add these
> '__maybe_unused' attributes to these functions. See commit 1a3c7bb08826
> ("PM: core: Add new *_PM_OPS macros, deprecate old ones") for more info.

Tried this option but as this patch required for Kernel 5.4 version code 
base,

SYSTEM_SLEEP_PM_OPS didn't work.

>> ---
>>   sound/soc/qcom/lpass-sc7180.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
>> index b96b85a..41db661 100644
>> --- a/sound/soc/qcom/lpass-sc7180.c
>> +++ b/sound/soc/qcom/lpass-sc7180.c
>> @@ -163,14 +163,14 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static int sc7180_lpass_dev_resume(struct device *dev)
>> +static int __maybe_unused sc7180_lpass_dev_resume(struct device *dev)
>>   {
>>   	struct lpass_data *drvdata = dev_get_drvdata(dev);
>>   
>>   	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
>>   }
>>   
>> -static int sc7180_lpass_dev_suspend(struct device *dev)
>> +static int __maybe_unused sc7180_lpass_dev_suspend(struct device *dev)
>>   {
>>   	struct lpass_data *drvdata = dev_get_drvdata(dev);
>>   
>> -- 
>> 2.7.4
>>
>>
