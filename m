Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556EC6FEBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjEKGTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjEKGTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:19:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938243A89;
        Wed, 10 May 2023 23:19:34 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B6JKtS022130;
        Thu, 11 May 2023 06:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MFmlOXzWKlh6xmSzF7dgNVpK+OIYZ+my/PD5cZRH0Tk=;
 b=at7kA05jLfwkpUtE+uP0nW2kx43EWJMeQyT8Qpo96asw/C8HlLDHePVoi73bkTVTZ4ir
 QTt4VcbsoD5A7Oeme82hPHWU9/yxmPgpC6XN8Ge7gLtFJxRxXCZgn8nFyYneIBumjkat
 7jhHv23jkvzeaW3IHczKg3p7NpqdMF1xxbzjRBqlJ9kaue5s8zLG63LrG8d2dCCxLFXQ
 bcOsHT+SCVWQeuODzetRp73SVHWIeW7UXzMbctutoxM35VVy8d+appt3lhoSh0R8G/os
 ayQGVVTAgIDuanu2FeMkk26y+MJiifHUlRdN0Zght5pj7Y0qhTaDnty32vn6ZSsffU2G uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qggen92k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 06:19:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B6JI98010116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 06:19:18 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 23:19:12 -0700
Message-ID: <a9437620-6946-16a9-1b13-faaf34fa5d48@quicinc.com>
Date:   Thu, 11 May 2023 11:49:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
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
        <linux-arm-kernel@lists.infradead.org>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-5-quic_srichara@quicinc.com>
 <ZFupNrdrcsrIFpYq@surfacebook>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <ZFupNrdrcsrIFpYq@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Er7DcdvxmzTkegwCefZsH92-86EqJDQ
X-Proofpoint-GUID: 8Er7DcdvxmzTkegwCefZsH92-86EqJDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110053
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 7:54 PM, andy.shevchenko@gmail.com wrote:
> Wed, May 10, 2023 at 07:11:17PM +0530, Sricharan Ramabadhran kirjoitti:
>> Add pinctrl definitions for the TLMM of IPQ5018.
> 
> ...
> 
>> +#define FUNCTION(fname)			                \
>> +	[msm_mux_##fname] = {		                \
>> +		.name = #fname,				\
>> +		.groups = fname##_groups,               \
>> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
>> +	}
> 
> Can you coordinate with Rohit Agarwal <quic_rohiagar@quicinc.com> and use
> his work [1] which moves the QCom drivers to use struct pingroup and struct
> pinfunction?
> 
> [1]: https://lore.kernel.org/r/1683718725-14869-1-git-send-email-quic_rohiagar@quicinc.com
> 

  ok, will do.

> ...
> 
>> +static const struct of_device_id ipq5018_pinctrl_of_match[] = {
>> +	{ .compatible = "qcom,ipq5018-tlmm", },
> 
>> +	{ },
> 
> No comma for the terminator entry.
> 

  ok.

>> +};
> 
> Move MODULE_DEVICE_TABLE() here.
> 

  ok

Regards,
  Sricharan
