Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DB7197AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjFAJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjFAJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:51:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8684185;
        Thu,  1 Jun 2023 02:50:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3517KIdN030232;
        Thu, 1 Jun 2023 09:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M2ACdLiI80TB334uM9ffG2qmS8AIr+NJm3xsnYzYQx0=;
 b=GkytSWUSi6y+cGWu6BP7xm6CJpyBz+SkRRP6pgmA9h1rL8E/rO3McOY0JpPXngYALjdA
 aKwvK2IuM22a09MRwyBvBak1vuVU7AD//a0T8paF/yaiMgm/T9D7w3XrlmHyCWDVH3Oo
 WExH8iU1PQgwLA013DlmxcHw4klvqLyxtxKPpwm6OhKL4LtUz0P3HDIMK9Jk83DjIis8
 BPlV0btqczu4oiA2xGlAqjit/heb8BUNTm3PocguGAljzVzaZE/jcg873IVIdTif5ytO
 x0gDcmllLvj5JoEu/Oqd/PoegE66cVySOHjLj2++R7RiVRxHvv1SnoOTYVVk1/1ANQ+a Zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxjk2rum4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:50:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3519oeki018623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:50:40 GMT
Received: from [10.216.52.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:50:33 -0700
Message-ID: <aefd0df1-8dfb-1b69-589b-974dea312845@quicinc.com>
Date:   Thu, 1 Jun 2023 15:20:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>
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
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
 <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
 <ZHTK7uEzO7kcx_cV@surfacebook>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <ZHTK7uEzO7kcx_cV@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OdNCsxv-v28It_m775SSj3OsKAR8huPz
X-Proofpoint-ORIG-GUID: OdNCsxv-v28It_m775SSj3OsKAR8huPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=652 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010088
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2023 9:25 PM, andy.shevchenko@gmail.com wrote:
> Mon, May 29, 2023 at 03:58:09PM +0530, Sricharan Ramabadhran kirjoitti:
>> On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
>>> On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
>>> <quic_srichara@quicinc.com> wrote:
> 
> ...
> 
>>>     depends on OF || COMPILE_TEST
>>
>>   Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.
> 
> Standalone COMPILE_TEST will give you definitely NOT what you want.
> And actually it's strange to have it standalone.
> 

  Ho ok, i meant like this, "depends on ARM64 || COMPILE_TEST"

Regards,
  Sricharan
