Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894F16947DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBMOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBMOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:19:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F307BBA0;
        Mon, 13 Feb 2023 06:19:43 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DE3CMn017464;
        Mon, 13 Feb 2023 14:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1afekj1atS6B7HHZ4RVIl8IvPNbTbmPEAs1NhaFYRLM=;
 b=S6zEKUguj8+EXZUxYQDBgvSB9dGCEe5CnaQPFFt/NrNLaovcGyi/9oBqXrFK48mw04Jy
 nVRIJ87P7GLabD5rBnUDetzijCmwN421neKvQxI8J/zMF0dfQR/Nn0ZUceXVm+iWqlQv
 LPr7/qRVu5+vOmev520NNFuOzikKVAIWHLHrkr0SvNbUuSJ25MG21if6nzNoOyLp6OzD
 9GgOAxeL8EIC/g+auLaQpeGF6cpCV5XoEF5OtHrEG9kujgDNVZyRa0y4qtiyixu3iI8r
 oJwvPNNTAjrXFs7wvOA7kZYAvmhddSC4S8ZpekHHfCJF0fgHxH7CC5t3bGRxzQiKRgYO hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmg11w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 14:19:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DEJBI5012083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 14:19:11 GMT
Received: from [10.50.58.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 06:19:02 -0800
Message-ID: <ed3637e4-7a5a-55be-be49-cdb0ec978752@quicinc.com>
Date:   Mon, 13 Feb 2023 19:48:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230130125528.11509-1-quic_devipriy@quicinc.com>
 <20230130125528.11509-5-quic_devipriy@quicinc.com>
 <20230208231412.yqp3rvokvmbb7ixi@ripper>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230208231412.yqp3rvokvmbb7ixi@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kGUNY5cHUYA7GmZTQqdqsb8JBsXsBBvo
X-Proofpoint-GUID: kGUNY5cHUYA7GmZTQqdqsb8JBsXsBBvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=606 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130129
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for taking time to review the patch

On 2/9/2023 4:44 AM, Bjorn Andersson wrote:
> On Mon, Jan 30, 2023 at 06:25:25PM +0530, devi priya wrote:
>> +static const struct msm_pingroup ipq9574_groups[] = {
>> +	PINGROUP(0, sdc_data, qspi_data, qdss_traceclk_b, _, _, _, _, _, _),
>> +	PINGROUP(1, sdc_data, qspi_data, qdss_tracectl_b, _, _, _, _, _, _),
>> +	PINGROUP(2, sdc_data, qspi_data, qdss_tracedata_b, _, _, _, _, _, _),
>> +	PINGROUP(3, sdc_data, qspi_data, qdss_tracedata_b, _, _, _, _, _, _),
>> +	PINGROUP(4, sdc_cmd, qspi_cs, qdss_tracedata_b, _, _, _, _, _, _),
>> +	PINGROUP(5, sdc_clk, qspi_clk, qdss_tracedata_b, _, _, _, _, _,
>> +		 _),
> 
> Please avoid line wrapping these, it just makes it hard to read.
Yes, we have addressed this comment part of V7 series
https://lore.kernel.org/linux-arm-kernel/20230206103337.21000-5-quic_devipriy@quicinc.com/
> 
> [..]
>> +};
>> +
>> +/* Reserving GPIO59 for controlling the QFPROM LDO regulator */
> 
> This seems like a property of the board, please use gpio-reserved-ranges
> in the DT node instead.
As the GPIO is forbidden on SoC IPQ9574,
we have moved it to the pinctrl driver based on the suggestions received
in V1 series
https://lore.kernel.org/linux-arm-kernel/675ed9f7-da31-6206-5089-1db22025ef4b@linaro.org/
> 
> Thanks,
> Bjorn
Best Regards,
Devi Priya
