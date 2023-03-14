Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA656B8D97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCNIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCNIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:39:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD6A98EA7;
        Tue, 14 Mar 2023 01:38:47 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E4OblT000537;
        Tue, 14 Mar 2023 08:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UUIGkRvipVGt2jtssCYaB5NikLL1+G8UZU/LbkOU06g=;
 b=jUpxlmCJw7HLqEthKSwSZMoUtJgd3wE8BOg2eq6gRHH6xQ7RFyxvENexMhP0YBGVA0Ko
 azBqIEP+VKyIVmys8OAylp0UuKaV6Nfn79vKZH9m4flCZaY2uV/pYlx6F7OeEH90pyg8
 QOqaq6/D2nFuY08lcTsv/XVfB2ei9CpLzdjTPUY4zt152omI5H6Ft5uFSJIhPXswWXcC
 PFC9tMoVzflO5B1WPx7/TAFrZXTtR9sKJlbG1uC306AFaOPA00fmHkzCDsMEv/ILWFcp
 PS4ArQlx1D4uAROOUgLQ9/eLQVQobmRxxwaTGZc7o1fFyw3MmKQVDcoBUR8gdcHMACMU qA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa35wb1c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 08:38:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E8cIle002962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 08:38:18 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 01:38:15 -0700
Message-ID: <f09bf4df-dbf9-578d-3dd2-a670b708bbfa@quicinc.com>
Date:   Tue, 14 Mar 2023 14:08:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 1/3] dt-bindings: mailbox: qcom: use fallback for
 IPQ8074 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230314050005.10409-1-quic_kathirav@quicinc.com>
 <20230314050005.10409-2-quic_kathirav@quicinc.com>
 <37cff42d-d6a4-8784-c70e-f0184ee84698@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <37cff42d-d6a4-8784-c70e-f0184ee84698@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sg1CZNwritAEpdfRGJ0zwqOwMPio1G4K
X-Proofpoint-GUID: Sg1CZNwritAEpdfRGJ0zwqOwMPio1G4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_02,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=531 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/2023 1:44 PM, Krzysztof Kozlowski wrote:
> On 14/03/2023 06:00, Kathiravan T wrote:
>> Since the IPQ8074 mailbox is compatible with the IPQ6018, lets create
>> the fallback to ipq6018 compatible, so that we don't bloat the of_device_id
>> table in the driver.
>>
>> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Fixed the dtbs_check warning for IPQ6018
>>
> I responded to v1, so for formality: NAK.

Thanks, I should have waited for some more time.. I see the V2 of your 
series. I'll drop this series.

Thanks, Kathiravan T.


