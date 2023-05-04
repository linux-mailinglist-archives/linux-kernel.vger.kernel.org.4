Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922BD6F642F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDE6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDE6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:58:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF61992;
        Wed,  3 May 2023 21:58:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3444a2JF016832;
        Thu, 4 May 2023 04:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=XOez8aIhSf+YdRgRsaYBvkI2AQ5HgrExKkF0OV2wdf4=;
 b=D94yAvxnbIoKNGkwC90wF5uDpyAzwF3CKWaSNJ75lThPY6KVd007I0q7bkdVcCN7txA/
 6mf2dImNVA9jCerRW1ZNfW6WAr6tqzF8oeV9lZQNHVuMKvhzW72w2LRytS1VSoAevTs4
 NwxeLeVXw7cJuNQRt72pIaAWrR7ZEuxCXa9c7Bdq35Gj95MJgIZONviUSM4XsMan7uHk
 3zTrqBISyfiV7c1VRwBB4RA9TipRD+pfXMU224A8gBb9XF8hNe6pwBVB2uX1yo3IuC1s
 HS01jA0YH3C0GZ68mX99L6Lgs1htxl8R2rLvHC1fjfKnxDpKyyMWDuXNziSwHRk5wwwz EA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbbsw36nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:58:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3444w8RT032412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:58:08 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 21:58:03 -0700
Date:   Thu, 4 May 2023 10:27:58 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Message-ID: <20230504045757.GA13434@varda-linux.qualcomm.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <3c6f7510d175ba5a3c81730b010f6c421b2fbf2d.1682682753.git.quic_varada@quicinc.com>
 <16443d11-7948-d224-cfef-b6c1b5c3d60d@linaro.org>
 <20230503071055.GB1087@varda-linux.qualcomm.com>
 <915eea5b-6cef-d346-7cbd-b679726113ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <915eea5b-6cef-d346-7cbd-b679726113ad@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IIGMl5GEIhuIyR1Tkq8seYgGcw_g0vZw
X-Proofpoint-ORIG-GUID: IIGMl5GEIhuIyR1Tkq8seYgGcw_g0vZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=965 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:42:28AM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2023 09:10, Varadarajan Narayanan wrote:
> > On Mon, May 01, 2023 at 09:08:49AM +0200, Krzysztof Kozlowski wrote:
> >> On 28/04/2023 16:52, Varadarajan Narayanan wrote:
> >>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >>>
> >>> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> >>>
> >>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> >>> index d1ec963..8e2208c 100644
> >>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> >>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> >>> @@ -66,6 +66,7 @@ properties:
> >>>        - description: v2 of TSENS with combined interrupt
> >>>          enum:
> >>>            - qcom,ipq8074-tsens
> >>> +          - qcom,ipq9574-tsens
> >>
> >> Your drive change indicates they are compatible, so make them
> >> compatible. 9574 followed by 8074.
> >
> > Not able to understand. You want IPQ9574 to use "qcom,ipq8074-tsens"
> > instead of adding a "qcom,ipq9574-tsens" and no need to add an extra
> > entry to the driver like
>
> Assuming the devices are really compatible, which your driver change
> suggests, I want to use two compatibles. 9574 followed by 8074 fallback,
> just like we do for all Qualcomm IP blocks. Then as you said - no need
> for driver change.

With schema like this
	items:
	  - enum:
	      - qcom,ipq8074-tsens
	      - qcom,ipq9574-tsens
and DTS as
	compatible = "qcom,ipq9574-tsens", "qcom,ipq8074-tsens";

'make dtbs_check' gives the following error

arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long

To fix the above error, I have to change the schema as

	items:
	  - enum:
	      - qcom,ipq8074-tsens
	      - qcom,ipq9574-tsens
	  - const: qcom,tsens-v2-combined-int

and change ipq8074 & ipq9754 DTS as

	compatible = "qcom,ipq8074-tsens", "qcom,tsens-v2-combined-int";
	compatible = "qcom,ipq9574-tsens", "qcom,tsens-v2-combined-int";

For this to work, have to introduce qcom,tsens-v2-combined-int in
the driver with
	}, {
		.compatible = "qcom,tsens-v2-combined-int",
		.data = &data_ipq8074,
	},

This i guess will defeat the purpose. So shall we leave it as it
is now, or shall I change driver, schema and ipq8074 + ip9574 DTS
with qcom,tsens-v2-combined-int? Let me know.

Thanks
Varada



> Best regards,
> Krzysztof
