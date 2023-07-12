Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB674FF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGLGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjGLGdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:33:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2E1FE0;
        Tue, 11 Jul 2023 23:32:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C5QMKI006708;
        Wed, 12 Jul 2023 06:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l4GSwNcYz45Z7kHbz6leKQCTC7P1L7teTt+V2+ddnHk=;
 b=UUBIDpTbP4pPPe1hE0pu4Bk2jes/BKe5QbggNynx0EVRFhPma9ljH2JYEj0pb/eAR3DO
 jfAjcaFdfUOQ34l/mCov7x7cU5uU9e06SwaZteJgvbKVTuTWNG1zBXuRePTeG0pleBQH
 V8UQ4Ej4Ky6sMnJDtSCTBWHCegn05hNWBOXOLr9BvL4Hzmb8Aju4/qtLGlhQgHyY8Txn
 cMcXxRE4nooHPbzw/RMlsSn1NVV2JGF+YEN2l1jO6syn0hLe5LOCCqER4oHokqTzpG4r
 41OgVVmxHx7WzjTdrayc0/ui2SdZI74N2M5J2MM+l6pHail5QsEDVXuLqiMK4lj2OnKk +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq0q3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 06:30:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C6UGgN020800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 06:30:16 GMT
Received: from [10.216.14.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 23:30:09 -0700
Message-ID: <42bee6c5-6e1f-2b41-3013-023bd95fe8b7@quicinc.com>
Date:   Wed, 12 Jul 2023 12:00:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V4 3/4] dt-bindings: qcom-qce: add SoC compatible string
 for ipq9574
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <bhupesh.sharma@linaro.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <quic_arajkuma@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_poovendh@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <thara.gopinath@gmail.com>
References: <20230526161129.1454-4-quic_anusha@quicinc.com>
 <20230623115525.7300-1-quic_anusha@quicinc.com>
 <7ceba3df-bee8-9f1d-a27d-85e0b5f35d83@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <7ceba3df-bee8-9f1d-a27d-85e0b5f35d83@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6sSh4cedaofY5TvIYKyQIB2E656d8RkO
X-Proofpoint-GUID: 6sSh4cedaofY5TvIYKyQIB2E656d8RkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_03,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=741 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 6:23 PM, Krzysztof Kozlowski wrote:
> On 23/06/2023 13:55, Anusha Rao wrote:
>>> Document the compatible string for ipq9574.
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> ---
>>>   Changes in V4:
>>> 	- Picked up Reviewed-by tag.
>> A gentle reminder to pick the dt-binding patch.
>> As the dts change is picked, this patch is required to resolve dt-bindings check issues.
> One patchset with four patches targeting three different subsystems, so
> no wonder it gets missed. You will usually receive better results with
> splitting such patchsets per subsystems.
>
> One more thing is lack of proper subject prefix which indicates the
> subsystem. Without it why anyone would pick it up? For example me, I
> would just ignore it for my subsystem...
Ok..Referred previous commit titles of this file and added subject 
prefix. Do you suggest to repost it with
"dt-bindings: crypto: qcom-qce: add SoC compatible string for ipq9574" ?

Thanks,
Anusha
>
> Best regards,
> Krzysztof
>

