Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52DC63E859
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLADcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLADcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:32:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC05B5BD69;
        Wed, 30 Nov 2022 19:32:06 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12ioum019070;
        Thu, 1 Dec 2022 03:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BfBVfHL55y4El2LYn+90PYn4HEvJdNfd0rEfXcfans8=;
 b=d2Bx1PlwMWwhIAG7DwvtHLc+p62MU1u4nuXX640KzeoPIyJMZ0woHtPpOvpbXdSJe0Gb
 D/+iJRbIottkcTyumxQzMMz/9JQhOeZzMvoFf5irAjau1JM3wWTAoOnw6KBWfFHUJ1Tw
 lkdE6ND7gGj+NcN0i0cut1H6Gy3zg7UAV7lt6+1P3Y3f9eMa8/wrLnBpbKrXw1V/JOee
 P2XT1zrCHpopTYrGMIbaiP3ApAqoWiTdvYWGW2LxvmPdPjAefFYj6bZ1il3+OTPpnvf9
 k1QNNnt8IMNOgUOJrKq68GK/EvirkF67QOup/gplEpNyQ/0lPsQ1CcaBw5tZWv6osD/D jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k3yg67t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 03:31:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B13VXGY004783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 03:31:33 GMT
Received: from [10.216.5.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 19:31:26 -0800
Message-ID: <24f8252f-b843-4a48-0a98-addf1f56cab5@quicinc.com>
Date:   Thu, 1 Dec 2022 09:01:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system
 PM ops
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
        <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4eN4utrDnEnKu/8@google.com> <Y4eP2yFKsmxzyX/4@sirena.org.uk>
 <Y4eU7ra4w3Fm+wLM@google.com> <Y4erFaRfGXbSJLMm@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Y4erFaRfGXbSJLMm@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PgCB5VPgXqdJlAIFZEeTFpcNsyD3VJyQ
X-Proofpoint-ORIG-GUID: PgCB5VPgXqdJlAIFZEeTFpcNsyD3VJyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=703 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010020
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2022 12:42 AM, Mark Brown wrote:
> On Wed, Nov 30, 2022 at 05:37:50PM +0000, Matthias Kaehlcke wrote:
>
>> The tag of the applied patch is incorrect too, which is actually what I noticed:
>>
>> Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
>>
>> This patch is for sc7180, so it should be:
>>
>> Fixes: 2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops")
Actually with the fix already posted v2.
> Oh, well.  It's just a fixes tag for something that has only been in
> -next, it doesn't really matter that much.
Okay. Sorry for Inconvenience.
