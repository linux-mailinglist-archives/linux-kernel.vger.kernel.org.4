Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCF71117B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbjEYQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:58:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499EF135;
        Thu, 25 May 2023 09:58:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFAHul023388;
        Thu, 25 May 2023 16:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v3ifwnsMcKSTqVYUFaVpwmcfPvV69o1mSGOuxFfiRzc=;
 b=KLKnpX9U5LmbSBWqWS6KZ8RkXt3LjD4bqqvn4/rPNf1Nhxtvucf4XII71VqXZvyp8NJk
 bAKfDE7lMR53v30Qg5iWaqNeq7SB+1dfC/aH/xXiehh4FnoOXgh0EIYWmLB58Pk302p1
 0r+ndn/G0WP7F8ZrXw+HxuTy1km1IMZBbkSC4aKel7XRLqhX1QB3M9mxZgu1LGyy3dWZ
 d/gH4OTpWjVJCsw6zrSj0r9w2qj+ynC1z0YUBfEgWSxPNAEbn/Ch9pPuX92SPkg/UovB
 HHgY3b0S4twF2jI3yCICU6fxfNQkud28l+0Pcm0KgAHpwsKujS93wkLUM7cJk7Xfulw9 9Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qstg3t79g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:58:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PGwnOU024480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:58:49 GMT
Received: from [10.216.52.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:58:43 -0700
Message-ID: <86396e49-96e8-20d1-7753-0e2e5a9c0347@quicinc.com>
Date:   Thu, 25 May 2023 22:28:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] dt-bindings: clock: qcom: Add SM8550 camera clock
 controller
To:     Conor Dooley <conor@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <quic_ajipan@quicinc.com>, <quic_imrashai@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-3-quic_jkona@quicinc.com>
 <20230519-crumb-vividly-0d278146defe@spud>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <20230519-crumb-vividly-0d278146defe@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p2cKUfzz3COWO46kz_wvaZC7QDH5-Yn3
X-Proofpoint-ORIG-GUID: p2cKUfzz3COWO46kz_wvaZC7QDH5-Yn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=744 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250141
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for your review!

On 5/19/2023 10:18 PM, Conor Dooley wrote:
> On Fri, May 19, 2023 at 09:26:00PM +0530, Jagadeesh Kona wrote:
>> Add device tree bindings for the camera clock controller on
>> Qualcomm SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> 
> Should this SoB go with a Co-developed-by?
> I'll leave it up to Krzysztof or someone else familiar with qcom
> products as to whether there's an existing binding that this should be
> added to, but qcom,videocc.yaml seems "suspect" to an outsider.
> 
> Otherwise, what you have here looks fine to me.
> 
> Thanks,
> Conor.
Will reuse SM8450 CAMCC YAML file for SM8550

Thanks & Regards,
Jagadeesh
