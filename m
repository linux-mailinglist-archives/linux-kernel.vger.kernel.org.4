Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF875FF72D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJNX4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJNX4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:56:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F05E33B;
        Fri, 14 Oct 2022 16:56:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ENmwdP000760;
        Fri, 14 Oct 2022 23:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w4xIEIZz9YbOBI9jY/V86GcIZ3XzPR/n7jHqoPSTZD0=;
 b=ZpDk8IpESxPjxXKfSLQkjNtrlZ+GcQ+Cm/V56T05taOiv/1JmFe+pR0/WhltOdOJVLnx
 U4yfF3Juhpc+9Ca59SuudkhN0mXC+zu9eAu1C2WZpHvVjkFyfQ8pn92XpWcbRuUzF8Hr
 d//CBD05vC9n85tFxYsubVFC2QIox5f5ee8yXCyMUVyrbPrja4RyVHDq7hHxK3TIEln7
 CJnYi5r5BxZmUg0sSm6XqetYiTrNqRNavQwbvtKK5jz8HKVA1WHQaGRfPtuFrp60ggDm
 p4GPft+cbc5JIbDQQTirlfWzQClz0ieioE/7rZGyTvQ6sdyR7Ivuvk60v7PVnFCeNIFd +g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7hqu80nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:55:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ENtm9W014111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:55:48 GMT
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:55:47 -0700
Message-ID: <ef500d21-2855-b929-ee8f-f6ec744c416a@quicinc.com>
Date:   Fri, 14 Oct 2022 16:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221051.7434-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221051.7434-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YRzZmbVrP6xR1MqSDY5qS1HRWtKVq0Ze
X-Proofpoint-ORIG-GUID: YRzZmbVrP6xR1MqSDY5qS1HRWtKVq0Ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=791 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140132
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:10 PM, Melody Olvera wrote:
> This patchset adds smmu bindings and driver support for the QDU1000
> and QRU1000 SoCs.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
Changes from v1:
- fixed ordering
>
> Melody Olvera (2):
>   dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
>   drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation
>
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 2 ++
>  2 files changed, 4 insertions(+)
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d

