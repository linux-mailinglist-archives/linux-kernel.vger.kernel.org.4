Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5F6E0611
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMEke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:40:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763E46B9;
        Wed, 12 Apr 2023 21:40:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D4UAbt011805;
        Thu, 13 Apr 2023 04:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LgkUpL9fahPgWUMGVfvhX6dXOgHLpy5fD8oxPNuM8qU=;
 b=mtC0G25dExze9CooR/Ss1V11w3MHf4PsukpD6RuWE7btY//k5PHw+On2eEil37TFbjZ4
 SiWAx+wP6yrrk21P3KCGii8U7010giXQ8VuqqVrj1jpQlenlB5lR4o0J9DD6NoRlyTno
 SyBNJ7xq335VYCpETU6juh2UN9MMn9Z4QgT+qm2u48u33WtbPiDT4FpbNns/2b/lFZqr
 oIYHhdny+qpFtwt7DBahkx80aO99c3MJXLmuqctmbxvuAZLrxTvoUUJEOHwzI44gDXd/
 cP8Wp7uwiXw9lfi/UC57u7lXbbNyFneINDLLwiExP2+hc7sG1AtO4xTb+aihB1Bw628m fQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwchbupk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 04:40:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D4eA2a005449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 04:40:10 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 21:39:45 -0700
Message-ID: <0569ed09-2241-d981-4e0c-209caa7483ab@quicinc.com>
Date:   Thu, 13 Apr 2023 10:09:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 1/2] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-ipq5332 compatible
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
 <20230320104530.30411-2-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230320104530.30411-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hUN6L7TzGJio0I40f1xoaPM1z5Io0ua8
X-Proofpoint-GUID: hUN6L7TzGJio0I40f1xoaPM1z5Io0ua8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_01,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130041
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2023 4:15 PM, Kathiravan T wrote:
> Add a compatible for the IPQ5332 platform's APSS watchdog.

Guenter,


Without this patch, I see dtbs_check failure in linux-next.


I see you reviewed the V1 of this patch, can you pick up this patch? I don't see it in https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
I'm not sure if I am looking at the right tree, Please correct me if I am wrong.


Thanks,
Kathiravan T.


>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- Pick up R-b tag
>
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6448b633c970..8060a87d29da 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>         - items:
>             - enum:
>                 - qcom,kpss-wdt-ipq4019
> +              - qcom,apss-wdt-ipq5332
>                 - qcom,apss-wdt-msm8994
>                 - qcom,apss-wdt-qcs404
>                 - qcom,apss-wdt-sa8775p
