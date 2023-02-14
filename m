Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3276957C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 05:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjBNEMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 23:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjBNEMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 23:12:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F1193E9;
        Mon, 13 Feb 2023 20:12:36 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMXDV7021046;
        Tue, 14 Feb 2023 04:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kLd+/Xj3vG3ZXa0ORXHsNiBzfre06yH3VV2BY5VrgyY=;
 b=SXpNIo3k2MjblCKAfHiUU5eXFImRGRshgrXv8eayIKmgFQHx5yiiujfr4YnQimGyn0pt
 Fsx0p4bKhV/hS1Hx0jbEtzsjOsKuFRaQt/Fq6HXKqLLmscyCf6Xf0szw7E04LVUekoXI
 tUcw+6Zq26V6/UDkCbS4M6tF9bmQWeLzEpFO9UX/h/Maqk0QMYnFEaDtVbpfN3bwu5jQ
 7QTx93AEHoNTgQ7WvK68oqvTIRaFOFqIXcNTL6LkhiuhSTgiExcRX+w9PsjNvLLCvLST
 kS1Q95kc+Qu+WjiUXCV0/kZVtOXC017LBaOOlVUrI3WV5Q1dPrBG3zhIbBqVCiOfTpdb xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0cw69ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 04:12:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E4CV5M028212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 04:12:31 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 20:12:28 -0800
Message-ID: <a0bfd20c-4f3e-b4e1-bdf4-3b84f75262ab@quicinc.com>
Date:   Tue, 14 Feb 2023 09:42:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V5] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>
References: <20230120082631.22053-1-quic_kathirav@quicinc.com>
 <2987f2ce9377bd17d1cd85fce4bd3c28.sboyd@kernel.org>
 <99c91609-61ce-fa30-96b1-ba45e9fe1e1e@quicinc.com>
Content-Language: en-US
In-Reply-To: <99c91609-61ce-fa30-96b1-ba45e9fe1e1e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RswkWzJRoXGrRkl6BuFbjmOwPOLdPGit
X-Proofpoint-ORIG-GUID: RswkWzJRoXGrRkl6BuFbjmOwPOLdPGit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_01,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=740 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140031
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2023 10:22 AM, Kathiravan Thirumoorthy wrote:
>
> On 1/26/2023 2:59 AM, Stephen Boyd wrote:
>> Quoting Kathiravan Thirumoorthy (2023-01-20 00:26:31)
>>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>
>>> Add programming sequence support for managing the Stromer
>>> PLLs.
>>>
>>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Thanks Stephen. Bjorn, is it possible to pick up this patch for v6.3?
>
> Thanks, Kathiravan T.

Hi Bjorn,

Gentle Ping!

Thanks,

