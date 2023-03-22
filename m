Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1C6C42BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCVGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:13:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA082B61E;
        Tue, 21 Mar 2023 23:13:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M4g94D007513;
        Wed, 22 Mar 2023 06:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hHAfzpcHF2GEhMuQgofbcWV7RtabrQqEYW56Lla2qMc=;
 b=nhyS4LGbEPddSqVpG3cnXQZ8lT6ngzaelhuM0F+Q+IrOq+dYHDxpxe/fogzajudiXREJ
 ZFmcu5GJDTxksRqsJe+Z6hGPqNdcFPUWf8pgVYydxp5KHS26TgoKPxxIHu+I/xXK4b6d
 1mGo0ZGFgISG3eSHHrj1Gcugw1tQOnPFXMTyMUxrawbRY5ut3MtjMKzcLD39zVNbnmop
 7mK/ng2vF0RJwS7z42L3DljEsXv73ONmjbcrCXUzqejvpUnWu44i2G4sEXEP+76f7eFj
 HfDg72jGALqzaQvkZFTfvLulJz3oFBBhCYhHXBMdivwyCfB6CvEroBUqlsIcQ1KlmkT5 cA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfpfgrqhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:13:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M6Dm0O013886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:13:48 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 23:13:42 -0700
Date:   Wed, 22 Mar 2023 11:43:38 +0530
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
Subject: Re: [PATCH v2 1/8] dt-bindings: phy: qcom,qusb2: Document IPQ9574
 compatible
Message-ID: <20230322061337.GA12808@varda-linux.qualcomm.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
 <ef5af2e581203e2101773863aa7e1667b4d1b705.1679388632.git.quic_varada@quicinc.com>
 <69120CDC-19C5-4087-BF71-0ECAB87D018B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69120CDC-19C5-4087-BF71-0ECAB87D018B@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1Fj7nyTG_scV7NoXTOnXufnv9wBUKIGf
X-Proofpoint-ORIG-GUID: 1Fj7nyTG_scV7NoXTOnXufnv9wBUKIGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220044
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:17:13PM +0300, Dmitry Baryshkov wrote:
>
>
> On 21 March 2023 11:54:19 GMT+03:00, Varadarajan Narayanan <quic_varada@quicinc.com> wrote:
> >Document the compatible string used for the qusb2 phy in IPQ9574.
> >
> >Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >
> >---
> > Changes in v2:
> >	- Moved ipq6018 to the proper place and placed ipq9574
> >	  next to it as suggested by Dmitry
> >---
> > Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> >index 7f403e7..eaecf9b 100644
> >--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> >+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> >@@ -19,12 +19,13 @@ properties:
> >       - items:
> >           - enum:
> >               - qcom,ipq8074-qusb2-phy
> >+              - qcom,ipq6018-qusb2-phy
> >+              - qcom,ipq9574-qusb2-phy
>
> This still isn't sorted

Sorry. Will fix this.

Thanks
Varada

>
> >               - qcom,msm8953-qusb2-phy
> >               - qcom,msm8996-qusb2-phy
> >               - qcom,msm8998-qusb2-phy
> >               - qcom,qcm2290-qusb2-phy
> >               - qcom,sdm660-qusb2-phy
> >-              - qcom,ipq6018-qusb2-phy
> >               - qcom,sm4250-qusb2-phy
> >               - qcom,sm6115-qusb2-phy
> >       - items:
>
> --
> With best wishes
> Dmitry
