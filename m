Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CA7404CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF0UQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjF0UQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:16:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181C4295B;
        Tue, 27 Jun 2023 13:16:08 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RJJTPL014439;
        Tue, 27 Jun 2023 20:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2CCHtuv2h6RPc7xyDAV09O/VTb/DZHoqqtDJwiZkPzc=;
 b=o2lp6rjLbcSWuD2XBbWqz41Ho9UbimY2FGAxixjDzEHnkDwwPI9IV7YAvniyRr/KNwI4
 DvN1qucfPZm0oFrdbgIYWCzXe/+RtBZWvtxFrbA/H20i52hQhPLKkDn8QU82RJ6ZsreX
 C4yzN2+n+E2z4ZvZPYJv2w+0f+YrkVFnyD3ImLI+nifkJI3LAm9zjvPy5TYWUyxBTW0m
 ADEmTxDPdxIQ4JJYNN6ArXIUg/TG6bHsZeKaD7DILt1953Amy82vCXuyfhGj4l/e/rgr
 ssAVOOm5xXywo7MRxzj4z7Nu1gStHVWtKyG+CHYENg5ohqiLTWmgp3yfsoOceV/Me6wi jA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfpd8aaen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 20:15:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RKFAta021198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 20:15:11 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 13:15:10 -0700
Message-ID: <2e11a98a-3e44-7164-84cc-7bbd519b608a@quicinc.com>
Date:   Tue, 27 Jun 2023 14:15:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v11 6/9] soc: qcom: cpr: Use u64 for frequency
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Robert Marko <robimarko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
 <20230217-topic-cpr3h-v11-6-ba22b4daa5d6@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230217-topic-cpr3h-v11-6-ba22b4daa5d6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2PzFoOEPkv9f_AtAEEWMbxga3q8X1a21
X-Proofpoint-GUID: 2PzFoOEPkv9f_AtAEEWMbxga3q8X1a21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 mlxlogscore=936 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270184
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 12:30 PM, Konrad Dybcio wrote:
> 32 bits is not enough for over-2.changeGHz frequencies. Move all variables
> that operate on Hz to u64 to avoid overflows.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


I get the following warning when building this -

   CC      drivers/soc/qcom/cpr-common.o
In file included from ./include/linux/device.h:15:0,
                  from ./include/linux/platform_device.h:13,
                  from ./include/linux/of_device.h:5,
                  from drivers/soc/qcom/cpr.c:18:
drivers/soc/qcom/cpr.c: In function ‘cpr_corner_init’:
drivers/soc/qcom/cpr.c:870:21: warning: format ‘%lu’ expects argument of 
type ‘long unsigned int’, but argument 4 has type ‘u64 {aka long long 
unsigned int}’ [-Wformat=]
    dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
                      ^
./include/linux/dev_printk.h:129:27: note: in definition of macro 
‘dev_printk’
    _dev_printk(level, dev, fmt, ##__VA_ARGS__);  \
                            ^~~
./include/linux/dev_printk.h:163:31: note: in expansion of macro ‘dev_fmt’
    dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                ^~~~~~~
drivers/soc/qcom/cpr.c:870:3: note: in expansion of macro ‘dev_dbg’
    dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
    ^~~~~~~
