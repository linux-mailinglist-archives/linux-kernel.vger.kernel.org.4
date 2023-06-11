Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE872B047
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 06:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFKEuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKEun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 00:50:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A426AD;
        Sat, 10 Jun 2023 21:50:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35B4h4KM009524;
        Sun, 11 Jun 2023 04:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0CNloHrquHQMvmc+4hDQ+f1JhsN0G1wIV9bJDTOOqQs=;
 b=HayVU8gJor39utzAXsJYRHY1iPVlDbuo3ddgqxLXYYCX3Ql8cWmPedcoltOFDhptXlg+
 vjuqREoCk23Rs7gPdMcJWfkj4O2ZTpdYoMvfsza2c7Ahu2bW6jKGbdNr+gLIuT+E2dGi
 eGAZJdh4rWEnokwDidi8mgGUctGux1B8UDdO8f7yoHnru8uZjgUzmgSNQ1x2Dx2IyWOM
 B5XkoGk0BMEGgCvoK1fiYB9yXvI4iyr9muPJopZHT7U5+MJ8OA/6Dkp8XgLWGUORPohL
 DqtIxeBeW4+yhH84sJO4Zqv/N7UhDpwnfFbiw0leOQDcn8D7Ef2fquRbFWuKpX+VhB+4 bQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4hxns6mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 04:50:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35B4o6OJ005158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 04:50:06 GMT
Received: from [10.216.24.161] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 10 Jun
 2023 21:49:59 -0700
Message-ID: <d073f2de-559e-7e76-2c38-114cda2d9948@quicinc.com>
Date:   Sun, 11 Jun 2023 10:19:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [v9 2/8] clk: qcom: Add Global Clock controller (GCC) driver for
 IPQ5018
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <andy.shevchenko@gmail.com>
References: <20230608122152.3930377-1-quic_srichara@quicinc.com>
 <20230608122152.3930377-3-quic_srichara@quicinc.com>
 <7e915a4b-d2e8-c162-2e45-d08aced5a5d1@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <7e915a4b-d2e8-c162-2e45-d08aced5a5d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SFyXHq_2eFwcKahelHTQytglkQvjhxIw
X-Proofpoint-GUID: SFyXHq_2eFwcKahelHTQytglkQvjhxIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_02,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=455 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306110044
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 7:22 PM, Konrad Dybcio wrote:
> 
> 
> On 8.06.2023 14:21, Sricharan Ramabadhran wrote:
>> Add support for the global clock controller found on IPQ5018
>> based devices.
>>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>> [v9]       Sorted the headers and cleaned the unwanted ones
>>             Added trailing comma for .parent_hws member
>>             Removed the hunk touching ipq5332 kconfig  (unintentionally)
>>
> You did not address the comments I made in v4.
> 
> https://lore.kernel.org/linux-arm-msm/21a5642c-e6e5-9323-7db1-383a18616ac0@linaro.org/

  oops, sorry, i guess, missed it, will send with fixed.

Regards,
  Sricharan
