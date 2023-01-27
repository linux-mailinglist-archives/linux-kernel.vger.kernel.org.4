Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAD67E875
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjA0Ojd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjA0Ojb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:39:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF41711;
        Fri, 27 Jan 2023 06:39:30 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REc2cQ015961;
        Fri, 27 Jan 2023 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Azi2zrZkJ0JoCxD5w7zQtz9tjVFvDjWbyLvEkV/iUkQ=;
 b=Iq41qq7r66B7cympnf+xBxbwlMggIZCdT8ss/fS3qOJCSA95uFXug7grnKQ41P7jFtXh
 As34Ri+yo0/RSpdlxLwaG92htz2mTjfaJyXgKv0LhGmCPOSzenLEs+kL3L9GNaA3e2f8
 nUSWG0gBGHp6dSA6UHefU/U6FUHN3p0w8op/8Z688Ch3zO2mXYy/fdBDYANLHAr+EyIy
 l7ApnaCmUm/jTI7D5ngKrqcrGKuLbLbDJG28GKDHx4K8X8Jc+oaZg/jNyiZKZE7SWQQ7
 FQqXGac5sk+uFZEIPh9vDKb5NuvEPWP/zeO+OKk5mF2CV4Nn5+fEvmevkZ4VSi6QEeVI jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc95jrnhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 14:39:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30REd8lu022873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 14:39:08 GMT
Received: from [10.216.31.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 06:38:59 -0800
Message-ID: <d2a938c4-c89d-96d2-d4ce-ea11c6faed6b@quicinc.com>
Date:   Fri, 27 Jan 2023 20:08:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] dt-bindings: scm: Add compatible for IPQ9574
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230113160012.14893-1-quic_poovendh@quicinc.com>
 <20230113160012.14893-2-quic_poovendh@quicinc.com>
 <8a305883-7f7f-2f2d-a7a1-8c2a6b5e72fd@linaro.org>
Content-Language: en-US
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
In-Reply-To: <8a305883-7f7f-2f2d-a7a1-8c2a6b5e72fd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: InEbBL1TS81fJvNmPBPmKAoZ8OI9gD5G
X-Proofpoint-ORIG-GUID: InEbBL1TS81fJvNmPBPmKAoZ8OI9gD5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=757
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270139
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2023 10:05 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 17:00, Poovendhan Selvaraj wrote:
>> Add the scm compatible string for IPQ9574 SoC
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Three people were co-developing single compatible line? I have some
> doubts... Please include only real entries.
  Co-developed by tags were added for those who  contributed to all the 
patches related to the series. But as suggested, we will drop the tags  
for patches with minimal changes.

> Anyway you miss changes to allOf (and/or rebasing on
> https://lore.kernel.org/all/20221122092345.44369-2-krzysztof.kozlowski@linaro.org/
> )
> Yeah, Agreed and will rebase it on linux-next.
>
> Best regards,
> Krzysztof
>
> Best Regards,
> Poovendhan S
