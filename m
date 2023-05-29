Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4BC7147EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjE2K2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2K2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:28:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0CD2;
        Mon, 29 May 2023 03:28:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T9rMiu022431;
        Mon, 29 May 2023 10:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Rs1mi9gWmQIfDbvGTLgd04OsxOpZ3oQ8tps4lRW1rrA=;
 b=oLTzApGh8+OTmsWuT2EW/R6MgqEHEXxCV7zlFCTMFaKBMNJgxlrR7BszbkzD5cWNF879
 1KHqJF6WqqsCGZi37YK98YA3ZufEkgQc/ixJikTTPLMluaFktOhMLx9equLR+BZPdyNY
 q4YbxSM9h8P3XXO4ZXX5c6mZuKkOIVQRM2XqQV9ls//+tQmK/6K3reUj89cX+7p36VDL
 BO5f6J1y4qh8TR7vH/uT8bkWKTvjiSuE8MHhxaLUMA1UaysrUbFVE+AxBKmmUlFsEzCl
 0bFewi1UxTRdYNMqYVmVItbMGvk2bZ/faLp8JiNiAdmNdJR81b7i5zj1xQ5ZyI03r2qk Ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quarb36mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:28:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TASMDb005077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:28:22 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 03:28:15 -0700
Message-ID: <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
Date:   Mon, 29 May 2023 15:58:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
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
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ltzP87ZWyRWccROl2ys61M-QiTsFO8-L
X-Proofpoint-ORIG-GUID: ltzP87ZWyRWccROl2ys61M-QiTsFO8-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_07,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxlogscore=860 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290090
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
> On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>>
>> Add pinctrl definitions for the TLMM of IPQ5018.
> 
> A couple of remarks either for the next version of the series or for
> the follow ups.
> 
> ...
> 
>> +config PINCTRL_IPQ5018
>> +       tristate "Qualcomm Technologies, Inc. IPQ5018 pin controller driver"
> 
>> +       depends on GPIOLIB && OF
> 
> I'm wondering why OF.
> If it's a functional dependency (I do not see compile-time one) the
> compile test can be added, no?
> 
>    depends on GPIOLIB
>    depends on OF || COMPILE_TEST
> 

  Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.

>> +       select PINCTRL_MSM
>> +       help
>> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for
>> +         the Qualcomm Technologies Inc. TLMM block found on the
>> +         Qualcomm Technologies Inc. IPQ5018 platform. Select this for
>> +         IPQ5018.
> 
> ...
> 
>> +#include <linux/module.h>
> 
>> +#include <linux/of.h>
> 
> There is a wrong header (the code doesn't use this one).
> You meant mod_devicetable.h
> 

  ho ok, let me check this part.

>> +#include <linux/platform_device.h>
> 
> Besides that kernel.h for ARRAY_SIZE() init.h for arch_initcall() and
> others might be missing.
> 

  init.h is getting included from module.h. Will check for kernel.h and
  update accordingly.

Regards,
  Sricharan
