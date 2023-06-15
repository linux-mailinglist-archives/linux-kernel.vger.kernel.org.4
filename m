Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F6730EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjFOF2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbjFOF2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:28:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC9326B8;
        Wed, 14 Jun 2023 22:28:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F5RMsw013905;
        Thu, 15 Jun 2023 05:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=JzYgkcS+xjpO5zjTAPM30RHvptVH8EP1NWTFiI7sVfk=;
 b=mfs0hXPiSmbJ7E1CROAhuafdu7rIUX5xAzIZlbkKvM4+YmmtQ9YDqMGDMp7jcKeRMAYZ
 gXcyGleQl0tXoAdHQ8DnkmBzu55LePuoPRM03vrgnXU7Lr/JwhR1+P6NrIVw7bIYWhbq
 jmwgCSr+/4NGNPRDWJHrD9AhTZxPeDJ9vEXLkWpDorDuTR/amdT5nDf2WTvmpqw98gw8
 a4NhKgVJrOQzr1pyo50ceBnAgDWl5os8ZGjChSGghsy3JsAOfRDo6sX20qZfA0wYKCqi
 /iKGEEX89/VOmsqlyhhKa/tuqJskHRflY46iW8zcmgI4xJj28PSJ2uuvMyq+bFbYS2z8 Lw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7fae9g7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 05:28:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F5S1YQ013748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 05:28:01 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 22:27:51 -0700
Date:   Thu, 15 Jun 2023 10:57:47 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Message-ID: <20230615052746.GB22186@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
 <98960024-7dbc-91a3-75de-90b529637916@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98960024-7dbc-91a3-75de-90b529637916@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HQxXuzhjPPT6BMwONL5mJFqqsvTWLvxK
X-Proofpoint-GUID: HQxXuzhjPPT6BMwONL5mJFqqsvTWLvxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_02,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:31:50PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 12:56, Varadarajan Narayanan wrote:
> > Document the M31 USB2 phy present in IPQ5332
>
> Full stop.

Ok.

> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  .../devicetree/bindings/phy/qcom,m31.yaml          | 69 ++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,m31.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,m31.yaml b/Documentation/devicetree/bindings/phy/qcom,m31.yaml
> > new file mode 100644
> > index 0000000..8ad4ba4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,m31.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
>
> Drop stray blank lines.

Ok.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,m31.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm M31 USB PHY
>
> What is M31?

M31 is an external IP integrated into IPQ5332 SoC.

> > +
> > +maintainers:
> > +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > +  - Varadarajan Narayanan <quic_varada@quicinc.org>
> > +
> > +description:
> > +  This file contains documentation for the USB M31 PHY found in Qualcomm
>
> Drop redundant parts ("This file contains documentation for the").

Ok.

> > +  IPQ5018, IPQ5332 SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> That's not oneOf.

Ok.

> > +      - items:
>
> No items.

Ok.

> > +          - enum:
> > +              - qcom,m31-usb-hsphy
>
> I am confused what's this. If m31 is coming from some IP block provider,
> then you are using wrong vendor prefix.
> https://www.m31tech.com/download_file/M31_USB.pdf
>
>
> > +              - qcom,ipq5332-m31-usb-hsphy
>
> This confuses me even more. IPQ m31?

Will change this to m31,usb-hsphy and m31,ipq5332-usb-hsphy respectively.
Will that be acceptable?

> > +
> > +  reg:
> > +    description:
> > +      Offset and length of the M31 PHY register set
>
> Drop description, obvious.

Ok.

> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: m31usb_phy_base
> > +      - const: qscratch_base
>
> Drop "_base" from both.

Ok. Will drop qscratch_base. This is in the controller space.
Should not come here.

> > +
> > +  phy_type:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - utmi
> > +              - ulpi
>
> This does not belong to phy, but to USB node.

This is used by the driver to set a bit during phy init. Hence
have it as a replication of the USB node's entry. If this is not
permissible, is there some way to get this from the USB node,
or any other alternative mechanism?

> > +
> > +  resets:
> > +    maxItems: 1
> > +    description:
> > +      List of phandles and reset pairs, one for each entry in reset-names.
>
> Drop useless description.

Ok.

> > +
> > +  reset-names:
> > +    items:
> > +      - const:
> > +          usb2_phy_reset
>
> Drop entire reset-names.

Ok.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > +    hs_m31phy_0: hs_m31phy@5b00 {
>
> Node names should be generic. See also explanation and list of examples
> in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Also, no underscores in node names.

Will change this as usbphy0:hs_m31phy@7b000

> > +        compatible = "qcom,m31-usb-hsphy";
> > +        reg = <0x5b000 0x3000>,
>
> This is not what your unit address is saying.

Will change to 0x0007b000.

> > +            <0x08af8800 0x400>;
>
> Align it.

Will drop this. This is in the controller space.

> > +        reg-names = "m31usb_phy_base",
> > +                "qscratch_base";
>
> Align it.

Ok.

> > +        phy_type = "utmi";
> > +        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +        reset-names = "usb2_phy_reset";
> > +
> > +        status = "ok";
>
> Drop.

Ok. Hopefully will get an alternative for the phy_type.

Thanks
Varada

> > +    };
>
> Best regards,
> Krzysztof
>
