Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49917625830
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiKKKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiKKKYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:24:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F860CE;
        Fri, 11 Nov 2022 02:24:35 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB8meQd001392;
        Fri, 11 Nov 2022 10:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=npLcM6gr/zz94Q8Xz7G85PNSqJnFQNfh6csWyHhKTzs=;
 b=iAE0Ct533U810BJYRV+X5YdTRXbN38QU7EaAgBMtw7sdo9a+b/b5NomhpoIdWaITTlpm
 RyyUhhkrvslvFlsu0bGl8MMVwxLX6UwFFWJlwsQoVPWa2VzY2BgumxnlXX3gmHC+oFvM
 J5WJMG00fbipbMXjoSepIr/J04GKzoL+PtwBAOnJ5xsaIctUHrcfp++V4mELvliuIauY
 Zc5LdIgyH48woOBGZcxDYtkeSZWQBeAd0n2xYZuxjGAvwowaD6J/cZNfwi6DoGmaovM0
 8upRdy/QE+XlDaL8URq67SNknttNEb3qxR+lfa4iLk7BT5ScnGhrvb9RrCbq4xmzS2ZL yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksada1hw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:24:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABAORcm021553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:24:27 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:24:23 -0800
Message-ID: <54982867-6495-ee1e-889f-65fa5e5b2912@quicinc.com>
Date:   Fri, 11 Nov 2022 15:54:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/10] interconnect: qcom: osm-l3: Squash common
 descriptors
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-3-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XMLW4QkeJWLqHVrcXxHNJrKle1q6-Zmv
X-Proofpoint-GUID: XMLW4QkeJWLqHVrcXxHNJrKle1q6-Zmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> Each platform defines their own OSM L3 descriptor, but in practice
> there's only two: one for OSM and one for EPSS. Remove the duplicated
> definitions.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> 
> Changes since v1:
> - None
> 
>   drivers/interconnect/qcom/osm-l3.c | 48 +++++-------------------------
>   1 file changed, 8 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index d23769844419..7d6844253241 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -104,7 +104,7 @@ static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>   	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>   };
>   
> -static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
> +static const struct qcom_osm_l3_desc osm_l3 = {
>   	.nodes = osm_l3_nodes,
>   	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
>   	.lut_row_size = OSM_LUT_ROW_SIZE,
> @@ -112,39 +112,7 @@ static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
> -	.nodes = osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
> -	.lut_row_size = OSM_LUT_ROW_SIZE,
> -	.reg_freq_lut = OSM_REG_FREQ_LUT,
> -	.reg_perf_state = OSM_REG_PERF_STATE,
> -};
> -
> -static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
> -	.nodes = epss_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
> -	.lut_row_size = EPSS_LUT_ROW_SIZE,
> -	.reg_freq_lut = EPSS_REG_FREQ_LUT,
> -	.reg_perf_state = EPSS_REG_PERF_STATE,
> -};
> -
> -static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
> -	.nodes = osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
> -	.lut_row_size = OSM_LUT_ROW_SIZE,
> -	.reg_freq_lut = OSM_REG_FREQ_LUT,
> -	.reg_perf_state = OSM_REG_PERF_STATE,
> -};
> -
> -static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
> -	.nodes = osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
> -	.lut_row_size = OSM_LUT_ROW_SIZE,
> -	.reg_freq_lut = OSM_REG_FREQ_LUT,
> -	.reg_perf_state = OSM_REG_PERF_STATE,
> -};
> -
> -static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
> +static const struct qcom_osm_l3_desc epss_l3 = {
>   	.nodes = epss_l3_nodes,
>   	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>   	.lut_row_size = EPSS_LUT_ROW_SIZE,
> @@ -317,12 +285,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id osm_l3_of_match[] = {
> -	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
> -	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
> -	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
> -	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
> -	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
> -	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
> +	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3 },
> +	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, osm_l3_of_match);
