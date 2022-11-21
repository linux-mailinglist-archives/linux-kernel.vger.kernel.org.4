Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF79363193D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKUEh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:37:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA926ACD;
        Sun, 20 Nov 2022 20:37:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL4CL7t009844;
        Mon, 21 Nov 2022 04:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FjvjyMbxogD2B5MIMZ9a8YKs1+Kjs/gvLbcyBmr9uI8=;
 b=E6gxuLZeW3nAl290Rmau6ZghHHht4TelI1hNLEySng1P5ZakTYb+TUbGGRLA6TPSOhzj
 ZBeeZ81fewz+uwL1AS+6WSM8fepS0D3vFMxzEGsE7je8BHtnQPCryIN4jmM2MWkY0i8m
 M/0eBc9Ral+qzbAiVQDVsDsa0eqNBpclulzW5QNNc47zPsUrhUTgpMTu0m63O7Orv+Qp
 /4RrEejz1u2Z1AmNsMi0dcxxxQjGZDuFABW9aMltRJ85uadiN6cks+qb6+BzOrz05ojK
 4hku81JCjtnLBaqE/rhUou0mA6pWxRnA+oj1KnUYhsV+Lzm5YyMNVixtyNlcBqTqwNgb jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv3eep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:37:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL4bHGP013351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:37:17 GMT
Received: from [10.216.39.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 20:37:14 -0800
Message-ID: <6b88dc78-d116-242a-36b9-895abd9a70e1@quicinc.com>
Date:   Mon, 21 Nov 2022 10:07:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add a new herobrine Pro SKU
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>
References: <20221118073017.26128-1-quic_rjendra@quicinc.com>
 <20221118073017.26128-2-quic_rjendra@quicinc.com>
 <Y3ekpgpRxgFwEeo0@google.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <Y3ekpgpRxgFwEeo0@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QXCjOlDkuwcw3dy2WYzJEIVmO125sP52
X-Proofpoint-ORIG-GUID: QXCjOlDkuwcw3dy2WYzJEIVmO125sP52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=569 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2022 8:58 PM, Matthias Kaehlcke wrote:
> Hi Rajendra,
> 
> On Fri, Nov 18, 2022 at 01:00:17PM +0530, Rajendra Nayak wrote:
> 
>> Subject: arm64: dts: qcom: sc7280: Add a new herobrine Pro SKU
> 
> nit: this adds the herobrine *CRD* Pro SKU (though other Pro SKUs
> might follow), so 'CRD' should be part of the subject
> 
> uber-nit: 'new' is redundant in this context
> 
>> Some of the qualcomm qcard based herobrine devices can come with
>> a Pro variant of the chipset with some qcard level changes like
>> the smps9 from pm8350c which is ganged up with smps7 and smps8,
>> so we just end up removing smps9 from the herobrine pro sku dtsi.
> 
> This is a very long sentence :)
> 
>> We then use it to create a new dts for the Pro variant of the
>> herobrine CRD.
> 
> Using 'we' is a a bit colloquial for a commit message, how a about
> something like this: 'Add a .dtsi for pro skus that deletes the
> smps9 node and include it from the new dts for the CRD Pro'.

Done, send a v2 with the changes.

> 
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
[]..

>> +#include "sc7280-herobrine-crd.dts"
>> +#include "sc7280-herobrine-pro-sku.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. sc7280 CRD Pro platform (rev5+)";
>> +	compatible = "google,hoglin-sku1536", "qcom,sc7280";
>> +
>> +	/* FIXED REGULATORS */
>> +
>> +	/*
>> +	 * On most herobrine boards PPVAR_SYS directly provides VREG_EDP_BL.
>> +	 * However, on CRD there's an extra regulator in the way. Since this
>> +	 * is expected to be uncommon, we'll leave the "vreg_edp_bl" label
>> +	 * in the baseboard herobrine.dtsi point at "ppvar_sys" and then
>> +	 * make a "_crd" specific version here.
>> +	 */
>> +	vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg_edp_bl_crd";
>> +
>> +		gpio = <&pm8350c_gpios 6 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&edp_bl_reg_en>;
>> +
>> +		vin-supply = <&ppvar_sys>;
>> +	};
>> +};
> 
> Why is this node needed here, doesn't it already exist by including
> 'sc7280-herobrine-crd.dts'?

yes, its not needed, removed it in v2.
thanks,
Rajendra

