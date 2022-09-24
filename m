Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5365E8BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiIXLQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiIXLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:16:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5EF6F41;
        Sat, 24 Sep 2022 04:16:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28OBFphv001358;
        Sat, 24 Sep 2022 11:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ys8zOk2h9kpRR719RCT9t13HbSNgmyp1IeIvR+aHRBk=;
 b=WdmxaJ/XJRlPZH5OBI3o/dRkrhio1Gbkp6a0KQnGjmvoEawA21ho4d/QxbzcvrOmmFg+
 Uem+H696NSZDFEnMVQaSaxMFno3X997oUpwuDdQZCNN7xsp2JDPFxxD32UlxjidNo1Kg
 XnFhmsPQ+tmyE1dGNuXatafvI4hnwsEt2+kdEbYBxa5lXOqbQNvHT2m2yJEy/Ro8YNBc
 dDjVKz9+qrbSmeTEgjGKDqvPNnA4rmFMOYWSWBCFKVo7pfk50LSTaEVTY55xvpQewUkk
 TZdsnYzBG2yG/2k0qoFjcHUsMwyKB1DX3SXs6lE7LCWduprt6iJgesvQkwzU3vcGGyXl 2A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jst018h4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:15:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28OBFoKu010815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:15:50 GMT
Received: from [10.110.112.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 24 Sep
 2022 04:15:44 -0700
Message-ID: <2f1a6f8f-009e-79ab-5f37-8549f50bbeb4@quicinc.com>
Date:   Sat, 24 Sep 2022 16:45:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V13 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <c6b55a5b44a8add13ea9015542522b2562cf8f60.1663642052.git.quic_schowdhu@quicinc.com>
 <f09fabec-f5a3-df21-f776-956732d60359@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <f09fabec-f5a3-df21-f776-956732d60359@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OQAQ1nD51ltXtl5cnpYI-RlJL73X2jLw
X-Proofpoint-ORIG-GUID: OQAQ1nD51ltXtl5cnpYI-RlJL73X2jLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=740 clxscore=1011 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209240084
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2022 12:57 AM, Krzysztof Kozlowski wrote:
> On 20/09/2022 05:56, Souradeep Chowdhury wrote:
>> Documentation for Data Capture and Compare(DCC) device tree bindings
>> in yaml format.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
> Rebase your tree on some current Linux kernel (and use
> scripts/get_maintainers.pl).
Ack
>
> Best regards,
> Krzysztof
>
