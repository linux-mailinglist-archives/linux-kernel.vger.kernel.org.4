Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C796B8B57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCNGjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCNGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:39:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592365117;
        Mon, 13 Mar 2023 23:39:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3X29i003482;
        Tue, 14 Mar 2023 06:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NEzRuG9Z5STIZ+/qG/K5TkHB1rOyD+drxJB+56TwIB0=;
 b=PF08+xpdl2/SnzVqcF8GknDzG8tSIHynk9sGz3qwJD5JjZRS+EIDexPhDdmgUUrGcQUN
 6zuVDzGAsG6XYIkq34yN/yPkZlW++WTrA1lRXAD84I0GcEtWLR6VZMdou0rqoXKdB97V
 WPWzVknjlh09FGZ0kcR641UxjFTWGFhYsFez7aVK0a+oqMdl5rP54WyRkM0vwHgqA3Kj
 yfoMAFLKwT2N8HbTkulMy+SmFPtLJ77uhupglLindTUPqKWUcmNzc9JE4XQmVBCRZzOs
 QiNfLiPxF3KAGp92Ha6XArEpZfNrgpRjzlOW7bi5JNqVMsMg6ff9RKechh0bm++gJIh4 EQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa3pttjkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:39:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E6d2ec024651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:39:02 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 23:38:58 -0700
Message-ID: <5e515b02-b5c0-bfbe-851b-49f57508eb9e@quicinc.com>
Date:   Tue, 14 Mar 2023 12:08:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ9574 and its
 variants
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
References: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
 <1678774414-14414-3-git-send-email-quic_varada@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1678774414-14414-3-git-send-email-quic_varada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MvdGoaWEAxDYJ3xXVgpbln_wfQfu1gRg
X-Proofpoint-ORIG-GUID: MvdGoaWEAxDYJ3xXVgpbln_wfQfu1gRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=490 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/2023 11:43 AM, Varadarajan Narayanan wrote:
> Add SOC ID for Qualcomm IPQ9574, IPQ9570, IPQ9554, IPQ9550,
> IPQ9514 and IPQ9510


Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>

