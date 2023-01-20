Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD3674E37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjATHh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjATHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:37:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B75798C4;
        Thu, 19 Jan 2023 23:37:51 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7UiDM012953;
        Fri, 20 Jan 2023 07:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T+HRskxYu1v9Bh5a0v2OBHQYbed3GESNbOqvsftlHyk=;
 b=STsjpiGbsSLJL3G0unLvsaid7PcrnqNTLqFarwvimj/7T10gfdMX77q2yeIYr3fi16mH
 k3GnioLhekiZgDb7w8xagGCIc5Aq7QA1RhN5+jvBJh2SPBuBl1Y8CrdwIHmmmRPqhUo+
 7UCGaq5E7AeAvOkVnVuToedgl1CHMw8cMMuReQvABicycaI3mXvTmFojgnDi/5C6PiKK
 p5DaOue+6WpFLsiOCoclhUnA2LV81ZKl1hFYaPZ5hNUyvx+oeWVHm3rYuxq5CGVFTX2g
 sbclNx2ejdcXkkX0FPGi0YklMkduIlrP1BOqo/lo/qDbHjzHoXfP7WyLRBC6oNME7hVI RA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktkaag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:37:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K7b1f0000598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:37:01 GMT
Received: from [10.216.43.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 23:36:55 -0800
Message-ID: <9c4d2ce8-11e0-bfbb-7062-078255d1d60b@quicinc.com>
Date:   Fri, 20 Jan 2023 13:06:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ASoC: google: dt-bindings: sc7280: Add platform
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-3-git-send-email-quic_srivasam@quicinc.com>
 <f0c5e40e-e59d-152d-31f1-1ad3da0a6d34@kernel.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <f0c5e40e-e59d-152d-31f1-1ad3da0a6d34@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _wR1aeK0lfk6LSFW66KY625n85nZc-Ax
X-Proofpoint-GUID: _wR1aeK0lfk6LSFW66KY625n85nZc-Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/2023 5:43 PM, Krzysztof Kozlowski wrote:
> On 19/01/2023 07:11, Srinivasa Rao Mandadapu wrote:
>> Update sc7280 machine driver bindings with platform property for
>> supporting ADSP based platform's DAI links.
> Subject:
> ASoC: dt-bindings: google,sc7280-herobrine:
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>
> This tested tag is a bit unusual. How were they tested? If
> dt_bindings_check why this is not the same person as you (submitter)?
Okay. Will remove Tested-by tag.
>
>> ---
>>   .../devicetree/bindings/sound/google,sc7280-herobrine.yaml    | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
>> index 869b403..ccf1b1d 100644
>> --- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
>> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
>> @@ -75,6 +75,17 @@ patternProperties:
>>   
>>           additionalProperties: false
>>   
>> +      platform:
>> +        description: Holds subnode which indicates platform dai.
> Neither commit msg nor this here explains why do you need it and what it
> really represents. Basically description repeats "platform" name of
> property - there is no single new information.
Will modify accordingly and re-spin.
>
>> +        type: object
>> +        properties:
>> +          sound-dai: true
> maxItems
Sorry. why max items required here?
>
>> +
>> +        required:
>> +          - sound-dai
>> +
>> +        additionalProperties: false
>> +
>>       required:
>>         - link-name
>>         - cpu
> Best regards,
> Krzysztof
>
