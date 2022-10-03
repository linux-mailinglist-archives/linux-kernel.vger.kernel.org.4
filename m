Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7102F5F3681
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJCTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJCTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:40:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2021F2DC;
        Mon,  3 Oct 2022 12:40:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293FpebR028705;
        Mon, 3 Oct 2022 19:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BUAicsS2jrYnYK820MtCQMqZHEz4ueixoRj9lmzM/BE=;
 b=RjT6xB4YYvVankFj18mnLWeUNqjx86MtY35Q1aNSG7zfEzhLIZpZmBvzJJ6ClJMWOiMX
 5de03F6Wgn6Lo/buo901afn+e8HW0yM5WhVnyfFQVjmzs610oPsiOIlKMRXPNDjRHXqD
 i9aI09KKDJwLXjR8qyjCr+vTK3VnPy2TfYrPv9cGvCM7wwq3lesWsKzcUD/glRErad8j
 13P3I5mAUcIi6IqVt8QZnrGprpSxruBxgBRTGIbL/LwJE/0/BwkNwSCMXl4X57/84O8K
 vDsKQhyy/dK8oqh64ypGUft4Q2YLDC1ioMb+0tsWBhaqqcV3eMQDsqi2R7DajsSE8YL/ lQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxd58mfvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 19:40:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293JeEmj029134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 19:40:14 GMT
Received: from [10.110.93.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 12:40:12 -0700
Message-ID: <12e69213-c09d-fe48-8fa3-022a3e6f76cc@quicinc.com>
Date:   Mon, 3 Oct 2022 14:40:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] clk: qcom: Add support for QDU1000 and QRU1000 RPMh
 clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-5-quic_molvera@quicinc.com>
 <CAA8EJppBfYST2VQrv6-LZBvtLcNUMkpLgXcic-fSUzFXhiYbaA@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJppBfYST2VQrv6-LZBvtLcNUMkpLgXcic-fSUzFXhiYbaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cvmEuxHGarCPFeMc0rWH_adGrBGBgcFn
X-Proofpoint-ORIG-GUID: cvmEuxHGarCPFeMc0rWH_adGrBGBgcFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030118
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 2:03 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:05, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add support for RMPh clocks for QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/clk/qcom/clk-rpmh.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index c07cab6905cb..27d11ffac71e 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -628,6 +628,18 @@ static const struct clk_rpmh_desc clk_rpmh_sdx65 = {
>>         .num_clks = ARRAY_SIZE(sdx65_rpmh_clocks),
>>  };
>>
>> +DEFINE_CLK_RPMH_ARC(qdru1000, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 1);
>> +
>> +static struct clk_hw *qdru1000_rpmh_clocks[] = {
>> +       [RPMH_CXO_CLK]      = &qdru1000_bi_tcxo.hw,
>> +       [RPMH_CXO_CLK_A]    = &qdru1000_bi_tcxo_ao.hw,
>> +};
>> +
>> +static const struct clk_rpmh_desc clk_rpmh_qdru1000 = {
>> +       .clks = qdru1000_rpmh_clocks,
>> +       .num_clks = ARRAY_SIZE(qdru1000_rpmh_clocks),
>> +};
>> +
>>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>>                                          void *data)
>>  {
>> @@ -723,6 +735,8 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>>         { .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>>         { .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
>>         { .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>> +       { .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdru1000},
>> +       { .compatible = "qcom,qru1000-rpmh-clk", .data = &clk_rpmh_qdru1000},
> Also the list isn't fully sorted, let's target that. Please move your
> compat strings into the beginning.
Sure thing.
>
>>         { }
>>  };
>>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
>> --
>> 2.37.3
>>
Thanks,

Melody

