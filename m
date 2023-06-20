Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15897367CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjFTJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:33:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF42A3;
        Tue, 20 Jun 2023 02:33:24 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K7qkfO030100;
        Tue, 20 Jun 2023 09:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ky61XlTFvnA7lVh5OyfvaMQHiiNipeR+9XCFDt37Dwk=;
 b=WJJudu5ihbSzoI/GwMqVJJs6kk+CC9UMvWpbMMTS6FL7ccnm0bl1q635GOd6dEug4d1n
 uqP6+503Oawhj8muKEIWZmukfDBV2x+8CQlGrlHSkImP+4mhuj0v32GQTAXXT50CuxD2
 f3/T030jYt4PtLfFo+JQXYy800Nx1YB+H2GdFZHcuIiPqpzSjpD+h7eWrrP4OfPYEHt5
 Ftw6lW4YbXGFHsGvJrYEsBcWXnKYqNxcrosY/rE9NgThETpcA02MDqQkDRnCMzPSqZq3
 yzrh6L+XrN+Vo46Q7VRFvurCYIVANXa4SYdAJ261EuKqqeQkoBSBSb5XzpR+oDbj0rC3 cA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb1dtgykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 09:32:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35K9WqXi010487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 09:32:52 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 02:32:43 -0700
Date:   Tue, 20 Jun 2023 15:02:33 +0530
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
Message-ID: <20230620093225.GA9966@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
 <98960024-7dbc-91a3-75de-90b529637916@linaro.org>
 <20230615052746.GB22186@varda-linux.qualcomm.com>
 <aca54f67-cc09-ff4f-93ca-6973d153db2c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aca54f67-cc09-ff4f-93ca-6973d153db2c@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aP3VCaexHP-8vPhMErFKpkN7DtlWrrC8
X-Proofpoint-GUID: aP3VCaexHP-8vPhMErFKpkN7DtlWrrC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 10:48:41AM +0200, Krzysztof Kozlowski wrote:
> On 15/06/2023 07:27, Varadarajan Narayanan wrote:
> >>> +          - enum:
> >>> +              - qcom,m31-usb-hsphy
> >>
> >> I am confused what's this. If m31 is coming from some IP block provider,
> >> then you are using wrong vendor prefix.
> >> https://www.m31tech.com/download_file/M31_USB.pdf
> >>
> >>
> >>> +              - qcom,ipq5332-m31-usb-hsphy
> >>
> >> This confuses me even more. IPQ m31?
> >
> > Will change this to m31,usb-hsphy and m31,ipq5332-usb-hsphy respectively.
> > Will that be acceptable?
>
> m31,ipq5332 seems wrong, as m31 did not create ipq5332. Does the m31
> device have some name/version/model? If it is not really known, then I
> would just propose to go with qcom,ipq5332-usb-hsphy.
>
> Skip generic compatible ("usb-hsphy") entirely.

Ok.

> And then we have... existing bindings qcom,usb-hs-phy.yaml. Don't create
> something similar with difference in the hyphen. Just use device
> specific compatible thus device specific filename.

qcom,usb-hs-phy.yaml seems to be for ULPI mode phy and the
driver we are introducing is for UTMI. We would have to
modify phy-qcom-usb-hs.c to accomodate M31. Will that be
acceptable to phy-qcom-usb-hs.c owners/maintainers?

> >>> +
> >>> +  reg:
> >>> +    description:
> >>> +      Offset and length of the M31 PHY register set
> >>
> >> Drop description, obvious.
> >
> > Ok.
> >
> >>> +    maxItems: 2
> >>> +
> >>> +  reg-names:
> >>> +    items:
> >>> +      - const: m31usb_phy_base
> >>> +      - const: qscratch_base
> >>
> >> Drop "_base" from both.
> >
> > Ok. Will drop qscratch_base. This is in the controller space.
> > Should not come here.
>
> Then drop reg-names entirely.

Ok.

> >>> +
> >>> +  phy_type:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - enum:
> >>> +              - utmi
> >>> +              - ulpi
> >>
> >> This does not belong to phy, but to USB node.
> >
> > This is used by the driver to set a bit during phy init. Hence
> > have it as a replication of the USB node's entry. If this is not
> > permissible, is there some way to get this from the USB node,
> > or any other alternative mechanism?
>
> Shouldn't USB controller choose what type of PHY type it wants?

Will remove this. IPQ5332 uses it in UTMI mode only.

> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> >>> +    hs_m31phy_0: hs_m31phy@5b00 {
> >>
> >> Node names should be generic. See also explanation and list of examples
> >> in DT specification:
> >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> >>
> >> Also, no underscores in node names.
> >
> > Will change this as usbphy0:hs_m31phy@7b000
>
> This does not solve my comments. I did not write "label" but "node name".

Sorry. will fix it.

Thanks
Varada
