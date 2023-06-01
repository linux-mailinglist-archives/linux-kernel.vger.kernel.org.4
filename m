Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E0719FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjFAOVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjFAOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:21:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6617E5B;
        Thu,  1 Jun 2023 07:21:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351DhCWQ030316;
        Thu, 1 Jun 2023 14:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8jVwNXOhLX3ySZX+usj472rMyUf3rSUPDttHfO6hxa0=;
 b=e3A9jd3eW6yf103QE894U4ibE8mMoFwmAYAmC412clsCqY4laiF3eKRK1QaBcaJMw8Zt
 +bYHZUuXJYgMEZWpUxARC7AXPw/1aaPZyHgjBwQ+NAplmdpCMH0jalD3MYnQ/X0AbjZ0
 HCTg68dqRecD04vfiiSyU+3Ogoix1ZhAyOXExt8ojTQiQcTm+rbYOdbkxiGQ1/i2MV2X
 f/+oSqR2/5ZkY1QGpFtU5MyukRp2lyEVaVDpZrQsbZcWGsxeBfJUohhdzJM4k3/nHXI3
 bY6pggWuBhPnyWisdGkMwJvo5MCF21QHFjpna7HVDB9e5kFc9ghhcmPyNiLJKsDGJpMH lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugrr8aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:20:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EKusV012559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:20:56 GMT
Received: from [10.217.216.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 07:20:50 -0700
Message-ID: <42f94fbc-ca0a-7441-2e4f-9dbc276da04f@quicinc.com>
Date:   Thu, 1 Jun 2023 19:50:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 2/6] clk: qcom: Update l value configuration for lucid
 ole and evo plls
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-3-quic_jkona@quicinc.com>
 <76343325-b06c-9329-2d0a-e1d351bcafac@nexus-software.ie>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <76343325-b06c-9329-2d0a-e1d351bcafac@nexus-software.ie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V58mWVqgjHFx6Yc36z6E8lzFE7BV2a3g
X-Proofpoint-GUID: V58mWVqgjHFx6Yc36z6E8lzFE7BV2a3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=786 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010126
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thanks for your review!

On 5/26/2023 6:52 PM, Bryan O'Donoghue wrote:
> On 25/05/2023 18:21, Jagadeesh Kona wrote:
>> -    .config_ctl_hi1_val = 0x32AA299C,
>> +    .config_ctl_hi1_val = 0x32aa299c,
> 
> You should separate out this change from this patch.
> 
> There's nothing wrong with having a preliminary patch to change all 
> upper-case HEX to lowercase hex.
> 
> You should do that since the log here "update l value" != change UCASE 
> to lcase hex.
> 
Sure, will remove this in the next series.
> ---
> 0xb0d

Thanks & Regards,
Jagadeesh
