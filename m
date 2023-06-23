Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9673B042
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjFWFq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFWFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:46:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99B2969;
        Thu, 22 Jun 2023 22:45:56 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N5KbxJ013113;
        Fri, 23 Jun 2023 05:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=m0eZon9twmkZkc434FGAkX2VJzOfYrElusM5ziWPVSY=;
 b=g86zOIowtThYIcHa+a9e5SMYhYYGRs9VCGV2uIjiSC3Qyj+CyyZfcBLDiHRY/ar3/oXl
 9UDanKdYuYc4+g53axKTZh3P62Rx/ZPBYX+ocdNzEGZucj9KMBI7tZIiHGilqTD7gxG9
 U56MwdDEtsysNWcmgdoTCsNCwZ+fmpQ6xj2fRaz/w8m1oWu4CKK0iGNSSfJdaxyRk5vE
 bZzVMGs8pF9Y6NzdfGyQknSH+Cp/a0KP9tqipo+JBnr7DcJbtz/dfI2CdCkKGCAn1Vsv
 jAu7zRNpzfkd570Xw7oAyQuntCMh3z+LMibBTVPgxcbJC7PCDHT+yVvP0fn36QaVBQne /Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcurrgyfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 05:45:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N5jLUl006922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 05:45:21 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 22:45:14 -0700
Date:   Fri, 23 Jun 2023 11:15:10 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230623054508.GA13261@varda-linux.qualcomm.com>
References: <cover.1687414716.git.quic_varada@quicinc.com>
 <4f4136a91b24d3ad35fa12bd19fe14b83da9affe.1687414716.git.quic_varada@quicinc.com>
 <20230622144627.GA1672260-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622144627.GA1672260-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8CorgTQKjorILKJnvr3SkE_IEfgEMSoy
X-Proofpoint-ORIG-GUID: 8CorgTQKjorILKJnvr3SkE_IEfgEMSoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:46:27AM -0600, Rob Herring wrote:
> On Thu, Jun 22, 2023 at 11:52:09AM +0530, Varadarajan Narayanan wrote:
> > Document the M31 USB2 phy present in IPQ5332.
> >
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v1:
> > 	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
> > 	Drop default binding "m31,usb-hsphy"
> > 	Add clock
> > 	Remove 'oneOf' from compatible
> > 	Remove 'qscratch' region from register space as it is not needed
> > 	Remove reset-names
> > 	Fix the example definition
> > ---
> >  .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> > new file mode 100644
> > index 0000000..ab2e945
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: M31 (https://www.m31tech.com) USB PHY
>
> Put the URL in 'description'.

Ok.

> > +
> > +maintainers:
> > +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > +  - Varadarajan Narayanan <quic_varada@quicinc.org>
>
> .org? It's .com everywhere else.

Ok.

> > +
> > +description:
> > +  USB M31 PHY found in Qualcomm IPQ5018, IPQ5332 SoCs.
>
> Where's the IPQ5018 compatible?

In the previous version had a default and IPQ5332 specific
compatible. IPQ5018 would have used the default compatible.
However, in the review was asked to drop the default compatible.
Hence planned to include ipq5018 compatible and post it in
separate patchset while enabling IPQ5018 USB. IPQ5018 init is
also diffferent from the init used here.

> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,ipq5332-usb-hsphy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    maxItems: 1
> > +    contains:
>
> 'contains' is not appropriate here. Drop.
>
> > +      items:
> > +        - const: cfg_ahb
>
> Don't need both items list and maxItems. Really, you don't need
> 'clock-names' at all because there is only 1 clock.

Will drop 'clock-names'.

> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > +    usbphy0: ipq5332-hsphy@7b000 {
>
> Drop unused labels.

Ok.

> > +    	compatible = "qcom,ipq5332-usb-hsphy";
> > +    	reg = <0x0007b000 0x12c>;
> > +
> > +    	clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> > +    	clock-names = "cfg_ahb";
> > +
> > +    	resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>
> Whitespace errors in here.

Ok.

Thanks
Varada

> > +    };
> > +
> > --
> > 2.7.4
> >
