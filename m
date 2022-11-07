Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2546203A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKGXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:20:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504B2716C;
        Mon,  7 Nov 2022 15:20:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7MfR8e007676;
        Mon, 7 Nov 2022 23:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F+JBdY5GCv5NYpZ5AGOqeyM6zH5lr5JUXnXKw9APh6o=;
 b=fOaeSEiW8QbGtTYTXl9X61E4sn9m2SyG+u/Vv+CTncIQrN3wKa1/5Q1a7aULvFR7Sbs3
 TOhVNB3Bvzftdq6oZWRqz93AanzE+laebYYgaRh6aWIEqPZF9ZG+nr4rws/0lFg9cjvZ
 eh4PoAybMxNjLba705PtoZ6bjJWGpQBAGE+pooTFo0i0NJn2VVDdIWYMdk2iosfbgxbt
 5QlhmVZ/sHiTlDwSXitjQTT/w2yRLcj0ExKlleTzceP68t9m9DMCFN2YuQmFL1525e8m
 Z+xOCCWDIxr2W9M42/4m3+duAVkOI/sI/B8jAofp/FJ5X0G24/n54mzwIeW3p2RUpwmw kw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq62y923j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:20:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7NKIck001363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 23:20:18 GMT
Received: from [10.110.0.244] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 15:20:17 -0800
Message-ID: <c5af2329-7cc5-9909-b630-70fb102229fd@quicinc.com>
Date:   Mon, 7 Nov 2022 15:20:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 5/5] dt-bindings: qcom,pdc: Introduce pdc bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-6-quic_molvera@quicinc.com>
 <20221027182240.E9FA0C433D6@smtp.kernel.org>
 <eeb3e06d-316a-1ff8-b4b8-c257fa03a206@quicinc.com>
 <20221107171622.nh62m4bf635rl2ae@builder.lan>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221107171622.nh62m4bf635rl2ae@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LThGWXAiHqvhHPpaSiBiLjy9k2WoaIH1
X-Proofpoint-GUID: LThGWXAiHqvhHPpaSiBiLjy9k2WoaIH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=931 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 9:16 AM, Bjorn Andersson wrote:
> On Thu, Oct 27, 2022 at 02:31:08PM -0700, Melody Olvera wrote:
>>
>> On 10/27/2022 11:22 AM, Stephen Boyd wrote:
>>> Quoting Melody Olvera (2022-10-26 12:04:41)
>>>> Add compatible fields for QDU1000 and QRU1000 pdcs.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>> Is there a reason why this patch continues to be included in what is
>>> otherwise a clk driver patch series? Can this patch be sent separately
>>> from the clk patches (and not Cced to clk maintainers/list) in the
>>> future?
>> Sure thing. On reflection, this belongs with the misc support patches.
>>
> Even better, the "misc" series goes through my tree but this patch is
> unrelated. So if you send it on it's own it could just be picked up by
> the PDC maintainer (or Rob).
>
>
Sure thing. I'll just send each on their own.

Thanks,
Melody
