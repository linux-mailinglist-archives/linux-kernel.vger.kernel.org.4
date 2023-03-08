Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5F6B16D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCHXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCHXvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:51:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F4C3E04;
        Wed,  8 Mar 2023 15:51:23 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328K8Avd017405;
        Wed, 8 Mar 2023 23:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MIyrhwp58wZlHfLe0OjzP8x3D+NkfuLwl9azQdXJsoc=;
 b=kTajWl4EgFazB+n1P+7RIEldnH+/oXZG+SQ+GevdtfOeDEFGaLYrxkWpO910fKAXOI+E
 HYM3eKiyPuWYQeg4lZVuIzO8kJscODsscIBvjHVqEfWGf8flSPl/h5kjm/DFiTiaAeQI
 Uusx5zSmNXU5uNJVvF5dvgl+ezvfgYDeNnBog+Z0sZ9KtTQG57A9blHBBhGL9fLhepSN
 FYWB9GRy5zt9EY8PB1Y/GjiqBF/RDC2yFqdz42KPf5UopdeVa3iVpLlooiONQuBGpEOz
 gScgoa+5Ei8C7JDZfQhm0bwjX7fjp6PREf8Pca+CDsMspPzPmY6NcpyreQc+ne5cRds+ tw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vnah7td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:51:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Np962027329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:51:09 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 15:51:08 -0800
Message-ID: <a72443b6-5f4e-7e5d-edf3-95cfe36179c5@quicinc.com>
Date:   Wed, 8 Mar 2023 15:51:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 10/11] arm64: dts: qcom: sm8350-hdk: Enable display &
 dsi nodes
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, <robdclark@gmail.com>,
        <quic_abhinavk@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <sean@poorly.run>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <angelogioacchino.delregno@somainline.org>,
        <loic.poulain@linaro.org>, <vkoul@kernel.org>, <a39.skl@gmail.com>,
        <quic_khsieh@quicinc.com>, <quic_vpolimer@quicinc.com>,
        <swboyd@chromium.org>, <dianders@chromium.org>,
        <liushixin2@huawei.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>,
        <vinod.koul@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
 <20221230153554.105856-11-robert.foss@linaro.org>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20221230153554.105856-11-robert.foss@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YoJwFmHIIpKrD1-nxGyJJi6MT-M7_mwH
X-Proofpoint-ORIG-GUID: YoJwFmHIIpKrD1-nxGyJJi6MT-M7_mwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/2022 7:35 AM, Robert Foss wrote:
> Enable the display subsystem and the dsi0 output for
> the sm8350-hdk board.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com> #SM8350 (HDK)

> ---
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index e6deb08c6da0..1961f941ff83 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -213,10 +213,32 @@ &cdsp {
>   	firmware-name = "qcom/sm8350/cdsp.mbn";
>   };
>   
> +&dispcc {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l6b_1p2>;
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_phy  {
> +	vdds-supply = <&vreg_l5b_0p88>;
> +	status = "okay";
> +};
> +
>   &gpi_dma1 {
>   	status = "okay";
>   };
>   
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>   &mpss {
>   	status = "okay";
>   	firmware-name = "qcom/sm8350/modem.mbn";
> -- 
> 2.34.1
> 
