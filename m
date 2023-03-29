Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54856CD652
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2JZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjC2JZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:25:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBFF30D8;
        Wed, 29 Mar 2023 02:25:05 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9IH3g023884;
        Wed, 29 Mar 2023 09:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FnliORwFo6RM4w2NuP/huI2taPY0SuqrkgBObjK8CWw=;
 b=HowNSw1YjDkLIMi+qs5WO8p3X7h9orncq8r6Vcs8H9Q5O09yOmhi/yzPTdbJE4+Ur4kW
 k52xk1BvYtoCxwaAxV7CKGvZrpw60QLDzoNJ30/rCG5e7ffMtI6mcyHNDsioGyu6icut
 nRhflyT1MmfrpI5ZlF3Iz1bDzQNWiF1uhAqnFRx+XjIbAmoej1TRKGpEsYMVDjcxLMhy
 gaHjOFpng5tyU7969DsR9NOFtQzKObqKmgBuh88fQs5/oSN2e8I3g2WBaBePY9xuWyt/
 hLXx6dq5beUuuU4b2p7216vv08yu21XpkUN6/tIbaTpPLBLCeTsgFMv/k3waWlVaoqLb oA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pm5v1smhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:24:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T9OpHt011030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:24:51 GMT
Received: from [10.216.46.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 29 Mar
 2023 02:24:46 -0700
Message-ID: <41d84c24-a363-7f73-1590-c23cc2ecbdc5@quicinc.com>
Date:   Wed, 29 Mar 2023 14:54:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 4/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock
 registration
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <quic_visr@quicinc.com>, <robh+dt@kernel.org>,
        <swboyd@chromium.org>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
 <20230327163249.1081824-5-quic_mohs@quicinc.com>
 <f2fa0b0813b26c0eb1893ef4c4c4c672.sboyd@kernel.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <f2fa0b0813b26c0eb1893ef4c4c4c672.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jC5ZuTD7YUZz5u_kg7swU-UawilAtR4t
X-Proofpoint-ORIG-GUID: jC5ZuTD7YUZz5u_kg7swU-UawilAtR4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_03,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290077
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2023 8:41 AM, Stephen Boyd wrote:
> Quoting Mohammad Rafi Shaik (2023-03-27 09:32:49)
>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>> index 48432010ce24..4719e3fa8b05 100644
>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>> @@ -121,17 +67,10 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>>                  goto destroy_pm_clk;
>>          }
>>   
>> -       lpass_regmap_config.name = "qdsp6ss";
>> -       desc = &lpass_qdsp6ss_sc7280_desc;
>> -
>> -       ret = qcom_cc_probe_by_index(pdev, 0, desc);
>> -       if (ret)
>> -               goto destroy_pm_clk;
>> -
>>          lpass_regmap_config.name = "top_cc";
>>          desc = &lpass_cc_top_sc7280_desc;
>>   
>> -       ret = qcom_cc_probe_by_index(pdev, 1, desc);
>> +       ret = qcom_cc_probe_by_index(pdev, 0, desc);
> Instead of changing the binding, it may be better to leave it as is and
> ignore the first reg property in the driver. Then you don't need any DTS
> patch or binding patch. You can just have this one patch. After that you
> can introduce a new compatible string for the proper design and make it
> have only a single reg property and deprecate the old binding. The
> driver can then pick index 0 if the new compatible is present.

Thanks for comment,

The main issue with sc7280.dtsi file.

Required to upstream remoteproc_adsp node for audioreach adsp based 
solution.
The base address for remoteproc_adsp dts node is 0x3000000.

Please refer below link audioreach dts patch:
https://patchwork.kernel.org/project/linux-arm-msm/patch/1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com/

remoteproc_adsp: remoteproc@3000000 {
             compatible = "qcom,sc7280-adsp-pil";
             reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
             reg-names = "qdsp6ss_base", "lpass_efuse";

and in sc7280.dtsi lpasscc node base address also same.

lpasscc: lpasscc@3000000 {
             compatible = "qcom,sc7280-lpasscc";
             reg = <0 0x03000000 0 0x40>,
                       <0 0x03c04000 0 0x4>,

In single dtsi file should not have same physical address node.
Required to sort the nodes based on physical address.

As the qdsp6ss clocks are being enabled in remoteproc driver,
removing the qdsp6ss reg region from lpasscc in sc7280.dtsi.
