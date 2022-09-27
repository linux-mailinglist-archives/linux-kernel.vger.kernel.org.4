Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE895EC49D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiI0NgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiI0NgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:36:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95546627;
        Tue, 27 Sep 2022 06:36:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RCj3r0013468;
        Tue, 27 Sep 2022 13:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AqIVjE7sOkQk2cFONEI5pyLpWUikOEqvDbz2phXaTGc=;
 b=DWcBtaJ1jKK1NIlyhxfsXmhpTBw/Ak7vl1gsUiTm1q4gMPo3KDIgpd6zeau+w2c7EA9P
 Dk7ixqjI/rtBX9zJFRa+uqz/CyyyX2lSbnhKo6mSsSX651sKIJkwbCaTDX8sW8mbYM4X
 Ovg9kxX8SH9cQVDNS32n//1R5SuPxy0jzVIj8NDsYET8djZDaohGk+4yI/V0j06qMdfV
 QK+jvEsJwDiHk1kzssrK7XGIihV0+GdfWRTK99TJhQVERQF7fzXQhkh6SyYq2fK93Mh5
 pcn6C43Cz7FG9arhJv8th5krCQCt5GelUYtLey8MxwYDcR3RgVMTNxPmnBRaWT2pJN9H og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juwru0q3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:20:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RDKqdX015577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:20:52 GMT
Received: from [10.216.22.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 06:20:46 -0700
Message-ID: <cfe05eec-f3bc-36bc-405f-b3355945ec51@quicinc.com>
Date:   Tue, 27 Sep 2022 18:50:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 6/7] remoteproc: qcom: Add efuse evb selection control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
 <1663938340-24345-7-git-send-email-quic_srivasam@quicinc.com>
 <da5902dd-1a2d-7669-fb91-c7df5bb1addb@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <da5902dd-1a2d-7669-fb91-c7df5bb1addb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vGCPi4xZCQ4VllQvtYM-fSg4WmYmjlih
X-Proofpoint-ORIG-GUID: vGCPi4xZCQ4VllQvtYM-fSg4WmYmjlih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=895 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270081
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/23/2022 10:55 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzyszto!!!
> On 23/09/2022 15:05, Srinivasa Rao Mandadapu wrote:
>> Add efuse evb selection control and enable it for starting ADSP.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> Thank you for your patch. There is something to discuss/improve.
>
>> @@ -543,6 +549,17 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>>   		return PTR_ERR(adsp->qdsp6ss_base);
>>   	}
>>   
>> +	efuse_region = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!efuse_region) {
>> +		adsp->lpass_efuse = NULL;
>> +		dev_dbg(adsp->dev, "failed to get efuse memory region\n");
>> +	} else {
> This needs bindings updates in all users.

Actually this is being used in SC7280 platform only. I am not sure if it 
applicable for other platforms.

If required, it can be posted as new series after this series got main 
lined.

>
> Best regards,
> Krzysztof
>
