Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D56E3EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDQEu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:50:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A166930CF;
        Sun, 16 Apr 2023 21:50:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H4mVql012485;
        Mon, 17 Apr 2023 04:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4RmQFL5U0JeOtmh5MfyrMmpzlM43CpOrwVrcnDdeCF4=;
 b=KDKy42Se3jWOQwbvqcnxU9k1EYDvpqB8yt1M2QktLNYyqTHYhvW2LB1vIuGipFWghhD1
 W0qCdZeG4aGTIBlgweXjCuVG88fElDFV5cxI0yuLRycAqHAF55gGtlM5TT1ZRiFVgOQF
 iWjDPdkD6xhhcRvmkueqsKA+JB8KH6Yc3ulJO8FO02lk0yqWxhtpaojMawIX3eUa+coT
 2EZR3gQwA2Gzx7MzMTJNR7DLYPP+klvY7gSFZqSY6OEAp0D1S2bzYPhmIeLHstuDoaz2
 oS+sPKf7Hhkj4liJDyAY4LTbXeIuhK0sY5ZEUyVRmJLAObBVTDwidWGDuLNmzsqd8F53 mQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymnf2k9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:50:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H4oVXL025564
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:50:31 GMT
Received: from [10.216.30.175] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 21:50:25 -0700
Message-ID: <abbc41e4-08dc-04e9-4c05-0bd1994405b7@quicinc.com>
Date:   Mon, 17 Apr 2023 10:20:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 0/9] Add minimal boot support for IPQ5018
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <de891705-bce9-7610-340d-b4bc284dfaca@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <de891705-bce9-7610-340d-b4bc284dfaca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _KTBngNGr2rSc1lkvP1_pYnpPJbD8qlN
X-Proofpoint-ORIG-GUID: _KTBngNGr2rSc1lkvP1_pYnpPJbD8qlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=758 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170043
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof,

On 4/16/2023 2:37 PM, Krzysztof Kozlowski wrote:
> On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
>> The IPQ5018 is Qualcomm's 802.11ax SoC for Routers,
>> Gateways and Access Points.
>>
>> This series adds minimal board boot support for ipq5018-mp03.1-c2 board.
>>
>> [v3]
>> 	Fixed all comments for clocks, schema fixes
>>          Picked up Reviewed-by from Bjorn for pinctrl driver
> 
> Didn't you just ignore all the tags you got? I was already acking and
> reviewing a lot of these...
> 

   While i got review comments for V2, only one tag from
   Bjorn (reviewed-by) for the pinctrl driver. That one i picked.

Regards,
  Sricharan
