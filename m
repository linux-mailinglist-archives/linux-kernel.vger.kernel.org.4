Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751B70606F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEQGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEQGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:50:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE1F9;
        Tue, 16 May 2023 23:50:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6Uogf015953;
        Wed, 17 May 2023 06:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xjEHHe3G4oxpB5wTQRg3eTNM6AlEMH3zCXXumh2MKPA=;
 b=mdf7RlFiid6VuCbzv+gs8fqs0Njt9p6punb93Dfn95bUQHEJihquvFwi5PbzKFRYA6nF
 /1hSrSvK1ggpec6ZJrDNJ8zP+eXMLjLH+iYOlwADJuGlPrpirSADjJpHlnayKKErR0KH
 Zr2Ohhpq9TXSzkGoklnvaPVUNecnYsWEYGYwRU69sc48SeSu0/E4ni4xOs1ap7i/TR4z
 8eAx+sjGAmsxhDMqd2h4Q8ELw8D2ubpQxrUrLHYrASG1FOk+iCyGAG+ytZt7FA/1YUfw
 SLhWZX71LXpIoAlNPOlcvoFbchhqk9bnvGAy5/JgFV1irF4ihu0H9W63E6glj2uZZg12 JQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmrvhr4xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 06:50:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34H6o9OR032120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 06:50:09 GMT
Received: from [10.216.22.19] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 23:50:03 -0700
Message-ID: <4db69d3e-9aee-a0cd-aabd-88aaf7c6b210@quicinc.com>
Date:   Wed, 17 May 2023 12:19:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V5 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>
References: <20230516114523.3266419-1-quic_srichara@quicinc.com>
 <20230516114523.3266419-5-quic_srichara@quicinc.com>
 <02d1f821-4b1f-e4f2-0732-026f9b0b7ed9@quicinc.com>
 <CAHp75VdLm7o83x9keZEUv9pDK2ZkWkQtMcLU148KyHZgf_6VUw@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAHp75VdLm7o83x9keZEUv9pDK2ZkWkQtMcLU148KyHZgf_6VUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bUQbkQsSindQLwb6I5TtEpsnLVCPUJN3
X-Proofpoint-GUID: bUQbkQsSindQLwb6I5TtEpsnLVCPUJN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=743
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170056
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 10:23 PM, Andy Shevchenko wrote:
> On Tue, May 16, 2023 at 2:58 PM Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>> On 5/16/2023 5:15 PM, Sricharan Ramabadhran wrote:
> 
> ...
> 
>>>    [v5] Rebased patch on top of "Add pinctrl support for SDX75" series
>>>         and fixed other comments from andy.shevchenko@gmail.com
>>>
>>     I rebased this on top of [1] series. But if that takes time to merge,
>>     can i post this without that dependency and get this merged ?
>>
>> [1] https://lore.kernel.org/r/1683718725-14869-1-git-send-email-
>>      quic_rohiagar@quicinc.com
> 
> First of all, please remove so-o long context which is not related _at
> all_ in this conversation right now.
> 

   ok

> Regarding your question, you need to talk to the respective
> maintainers how to proceed. The best is that all stakeholders pull an
> immutable branch/tag with that series applied from pin control
> maintainer (Linus W) and your series on top of that.
> 
   Sure, I have anyways posted V6 on top of that series already.
   From [1], Linus already applied that and my V6 applied/works
   fine on top of that. So it should be all fine.


   [1] 
https://lore.kernel.org/netdev/CACRpkdbu95hkFWJtCKoUXCyLfS2hxUywD41iF45ZtgKzqjXAJw@mail.gmail.com/T/

Regards,
  Sricharan
