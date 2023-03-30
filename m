Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446F6CFC51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjC3HKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjC3HKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:10:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BCD6195;
        Thu, 30 Mar 2023 00:10:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U2pkdx006462;
        Thu, 30 Mar 2023 07:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=5fX5B9Q2BVkwuM7B9UYaH7QjBXrTk5UeN4scDRz2vRw=;
 b=G2nJ5oTWYcWQZLg7f5c084VFO0cQV+HQ302xW9B8K/gPYzSI4hjNER4BQCT2EldPFJvm
 XotNLtHUqcKx/wMQtIZ4ztgEXWm5T6Bu37wycw4BlB4Y/qE69hu2JBw4L1L4u5qEGZJY
 EmVb36uM7NMlTI5F02GZNIqp26bYLAixcAalLDm04EnOrKCJJW07CQDGOqbfytvB+Mm9
 pTtcO9d14plNbOzsAzgXBCsH9a2JFguor3zT51Y5WPOzxt1zqYSjb/9zFJJfXMFKx3LN
 fnXP7RDxrMYoXw/BJrU1m/zFb2MpY36V8Kv0E+GJvpneQfN1Kz7bsiW5YDP0jSuOphri lQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmpbm2hs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:10:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32U7ASBD007377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:10:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 30 Mar 2023 00:10:22 -0700
Date:   Thu, 30 Mar 2023 12:40:17 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <20230330071016.GB13508@varda-linux.qualcomm.com>
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
 <3d49b4b0-587c-f7e5-4122-65b3e9f11583@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d49b4b0-587c-f7e5-4122-65b3e9f11583@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 87ChGyKcncQbXYejQSX4iRceP-vTJx2Y
X-Proofpoint-ORIG-GUID: 87ChGyKcncQbXYejQSX4iRceP-vTJx2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300056
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:02:52PM +0300, Dmitry Baryshkov wrote:
> On 27/03/2023 12:30, Varadarajan Narayanan wrote:
> >Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> >
> >Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >---
> >  Changes in v4:
> >	- Remove constraints not applicable to IPQ9574
> >  Changes in v3:
> >	- Update other mandatory fields to accomodate IPQ9574
> >  Changes in v2:
> >	- Updated sections missed in previous patch
> >---
> >  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 25 ++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >index e81a382..aa5b58c 100644
> >--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >@@ -21,6 +21,7 @@ properties:
> >      enum:
> >        - qcom,ipq6018-qmp-usb3-phy
> >        - qcom,ipq8074-qmp-usb3-phy
> >+      - qcom,ipq9574-qmp-usb3-phy
> >        - qcom,msm8996-qmp-usb3-phy
> >        - qcom,msm8998-qmp-usb3-phy
> >        - qcom,qcm2290-qmp-usb3-phy
> >@@ -122,8 +123,6 @@ required:
> >    - clock-names
> >    - resets
> >    - reset-names
> >-  - vdda-phy-supply
> >-  - vdda-pll-supply
>
> Same questions as for the qusb2 PHY. How is the PHY powered?

It is powered by always on regulators. Will create fixed
regulators and assign them to these.

Thanks
Varada

> >  additionalProperties: false
>
> --
> With best wishes
> Dmitry
>
