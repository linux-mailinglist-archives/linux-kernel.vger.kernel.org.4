Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2587D67EA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjA0Pyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjA0Pym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:54:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3779F2F;
        Fri, 27 Jan 2023 07:54:41 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REtukc016281;
        Fri, 27 Jan 2023 15:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t2dYPpz3UZYdEtdmlskh7wuq6K08Q/6kAgphXiMGzq0=;
 b=L3ixwtTHKpICTtkL6sIQaPFdCz+HVjY3VuTjMU7OUZh/yp8vUct7SKChSyYZmlIe9uq2
 cV6R/YQB3PXcQVe9U/uX/PFJoCldozF2WrFOjjNzX/PrPSUfwWRZcTT+0zMVhGhT3OPb
 cKZ4XhPgvOOKnE1X6DYh9t6+rb+j2+n68SGlVu3U08ddPE+CUBdQDJI6nPe9ZSAMWVL7
 S2/U0GSAKcONL0+FI1gFo5kvBCM0+5lWWZD7gJq90nhhaWxwPGIgpEzpsZQd+ybs1y+V
 OJpNmkM8PRFUkQm2HdaofvsfbIMlvGrHrNyd3CNl4rNipfgkqA8ilJWDwGG4vgaLpsay RA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncavc0mxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:54:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFsajN014826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:54:36 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 07:54:31 -0800
Message-ID: <707a8e33-f138-d9ef-bb98-6732bf7e7c83@quicinc.com>
Date:   Fri, 27 Jan 2023 21:24:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-2-quic_devipriy@quicinc.com>
 <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fVpjDeNWE_MELuswf4O-53OLvE1ovNka
X-Proofpoint-ORIG-GUID: fVpjDeNWE_MELuswf4O-53OLvE1ovNka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=841 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270147
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 10:12 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 16:03, devi priya wrote:
>> Adding compatible string to support RPM communication over SMD for
>> IPQ9574 SoC
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> What exactly was developed here but the other author?
> 
The intention was to mention folks who supported with the patch series 
development using the co-developed-by tag on the individual patches.
But yeah, for patches with minimal changes, will trim down the tag as 
suggested.


>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/soc/qcom/smd-rpm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
