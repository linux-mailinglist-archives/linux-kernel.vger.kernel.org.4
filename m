Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388862582A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiKKKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiKKKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:23:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FF1E088;
        Fri, 11 Nov 2022 02:23:41 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB6f9Ix002819;
        Fri, 11 Nov 2022 10:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wacIboVDm3CMWwN7iuKwYJz2pTNcSm2fNbXRv5TKfqI=;
 b=M5fYFbWI3i/EUYX77OUaWD5+FGo92xhJqlDqg7FyC7koQFh9LAtNc+4Mq3lYJ0qX63O+
 JWcVDHQ+ta/da+qaHzv5oQOfQH9HFg/NETrUOTKRzyQnXdVfd+r7hTxKT9h+GOCiss5e
 FqWhDP/4alrISIXoic0PaqCh3D6PNj6GRk0x2xVtu1GCI6mmI88OCILlR4unsfYnzQhe
 f8RJpXHU9URMwwdN8klvAupFTzAg9WbYy8eICSvfyX4v+6pZh1j1lkfaoPkfI0fClLmL
 pyjoGfge7Ay197wJvk9QFdqVEjzhReDQ9mRJPMS9x2UYm0NM1v1tOosP97+nA2chaoEM yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kshbgrrmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:23:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABANXqD005659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:23:33 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:23:29 -0800
Message-ID: <f77fd45d-56b7-ad79-efbf-472805f0b6ed@quicinc.com>
Date:   Fri, 11 Nov 2022 15:53:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 01/10] interconnect: qcom: osm-l3: Use
 platform-independent node ids
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
 <20221111032515.3460-2-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wzDCtqJnlc167nyC6RhGKPzOoJq3zpzh
X-Proofpoint-ORIG-GUID: wzDCtqJnlc167nyC6RhGKPzOoJq3zpzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 suspectscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn
Thanks for the patch.

On 11/11/22 08:55, Bjorn Andersson wrote:
> The identifiers used for nodes needs to be unique in the running system,
> but defining them per platform results in a lot of duplicated
> definitions and prevents us from using generic compatibles.
> 
> As these identifiers are not exposed outside the kernel, change to use
> driver-local numbers, picked completely at random.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>

With the change in implementation, you can remove now remove the per soc
node id headers included in the driver. With ^^ done.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> 
> Changes since v1:
> - None
> 
>   drivers/interconnect/qcom/osm-l3.c | 87 +++++++++++-------------------
>   1 file changed, 30 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index ddbdf0943f94..d23769844419 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -74,6 +74,11 @@ struct qcom_osm_l3_desc {
>   	unsigned int reg_perf_state;
>   };
>   
> +enum {
> +	OSM_L3_MASTER_NODE = 10000,
> +	OSM_L3_SLAVE_NODE,
> +};
> +
>   #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
>   	static const struct qcom_osm_l3_node _name = {			\
>   		.name = #_name,						\
> @@ -83,97 +88,65 @@ struct qcom_osm_l3_desc {
>   		.links = { __VA_ARGS__ },				\
>   	}
>   
> -DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
> -DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
> +DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
> +DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
> +
> +static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
> +	[MASTER_OSM_L3_APPS] = &osm_l3_master,
> +	[SLAVE_OSM_L3] = &osm_l3_slave,
> +};
> +
> +DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
> +DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>   
> -static const struct qcom_osm_l3_node * const sdm845_osm_l3_nodes[] = {
> -	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
> -	[SLAVE_OSM_L3] = &sdm845_osm_l3,
> +static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
> +	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
> +	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>   };
>   
>   static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
> -	.nodes = sdm845_osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
> +	.nodes = osm_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
>   	.lut_row_size = OSM_LUT_ROW_SIZE,
>   	.reg_freq_lut = OSM_REG_FREQ_LUT,
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
> -DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
> -
> -static const struct qcom_osm_l3_node * const sc7180_osm_l3_nodes[] = {
> -	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
> -	[SLAVE_OSM_L3] = &sc7180_osm_l3,
> -};
> -
>   static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
> -	.nodes = sc7180_osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
> +	.nodes = osm_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
>   	.lut_row_size = OSM_LUT_ROW_SIZE,
>   	.reg_freq_lut = OSM_REG_FREQ_LUT,
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, SC7280_SLAVE_EPSS_L3);
> -DEFINE_QNODE(sc7280_epss_l3, SC7280_SLAVE_EPSS_L3, 32);
> -
> -static const struct qcom_osm_l3_node * const sc7280_epss_l3_nodes[] = {
> -	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
> -	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3,
> -};
> -
>   static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
> -	.nodes = sc7280_epss_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
> +	.nodes = epss_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>   	.lut_row_size = EPSS_LUT_ROW_SIZE,
>   	.reg_freq_lut = EPSS_REG_FREQ_LUT,
>   	.reg_perf_state = EPSS_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
> -DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
> -
> -static const struct qcom_osm_l3_node * const sc8180x_osm_l3_nodes[] = {
> -	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
> -	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
> -};
> -
>   static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
> -	.nodes = sc8180x_osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sc8180x_osm_l3_nodes),
> +	.nodes = osm_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
>   	.lut_row_size = OSM_LUT_ROW_SIZE,
>   	.reg_freq_lut = OSM_REG_FREQ_LUT,
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
> -DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
> -
> -static const struct qcom_osm_l3_node * const sm8150_osm_l3_nodes[] = {
> -	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
> -	[SLAVE_OSM_L3] = &sm8150_osm_l3,
> -};
> -
>   static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
> -	.nodes = sm8150_osm_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
> +	.nodes = osm_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
>   	.lut_row_size = OSM_LUT_ROW_SIZE,
>   	.reg_freq_lut = OSM_REG_FREQ_LUT,
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
> -DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
> -
> -static const struct qcom_osm_l3_node * const sm8250_epss_l3_nodes[] = {
> -	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
> -	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
> -};
> -
>   static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
> -	.nodes = sm8250_epss_l3_nodes,
> -	.num_nodes = ARRAY_SIZE(sm8250_epss_l3_nodes),
> +	.nodes = epss_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>   	.lut_row_size = EPSS_LUT_ROW_SIZE,
>   	.reg_freq_lut = EPSS_REG_FREQ_LUT,
>   	.reg_perf_state = EPSS_REG_PERF_STATE,
