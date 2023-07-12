Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08E75060F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGLL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGLL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:28:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BD8F;
        Wed, 12 Jul 2023 04:28:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8e4Ke000755;
        Wed, 12 Jul 2023 11:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=1EcoW+wlGQ5CTc/t9tZEXNWbjBWaWne5QYIsFjlMLpo=;
 b=V34iHIfmnl7JzMZdtGGkdxdZHa/X1qgtSBlvct8CATMRWyanZc8MkXmswnf78imRp5DE
 /4KgkKheKv+tCFLqJcKAf4rhVj+B8BHuDBoiICP/aDX82wCfttgMg4ry69NZ073gph6A
 U0Es/gMDpImy7KgIWvbUHTjB/gVhluHzqlPgpgj8Ro7WlIF4U6jlPCjrmV06rZTYgNxV
 ch2nYEKL2Ke1w5YNMBHoo9LMXF+lc5RHH/SSLp5gzLIGoELlg4awURkcibvDRUtb8gjc
 aIB12ibbTEaFk/pHNoa76pgP9kPyT3bzx4vEK5w69Iq9J0ipe52TF/uq76b+jYCPMmp/ bQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf51ha5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:28:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBSSxM014916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:28:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:28:20 -0700
Date:   Wed, 12 Jul 2023 16:58:16 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Message-ID: <20230712112815.GA21004@varda-linux.qualcomm.com>
References: <cover.1689065318.git.quic_varada@quicinc.com>
 <23b259b72c8f6faad99f09c37ac8b7b6b027cea1.1689065318.git.quic_varada@quicinc.com>
 <ddd97ecd-bf4b-85c8-1f0b-8ca175799076@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddd97ecd-bf4b-85c8-1f0b-8ca175799076@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8r-Fn5dAZEVUVdaFlOX_oVsR2EH9pKM6
X-Proofpoint-GUID: 8r-Fn5dAZEVUVdaFlOX_oVsR2EH9pKM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=814 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:01:03AM +0200, Krzysztof Kozlowski wrote:
> On 11/07/2023 10:51, Varadarajan Narayanan wrote:
> > Add USB phy and controller nodes.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v1:
> > 	Rename phy node
>
> I don't see any improvements.

Will fix and post a new patch

> > 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> > 	Remove 'qscratch' from phy node
> > 	Fix alignment and upper-case hex no.s
> > 	Add clock definition for the phy
> > 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> > 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> > 	as appropriate.
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 54 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > index 8bfc2db..c945ff6 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > @@ -405,6 +405,60 @@
> >  				status = "disabled";
> >  			};
> >  		};
> > +
> > +		usbphy0: ipq5332-hsphy@7b000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> "phy"

Will fix and post a new patch

> > +			compatible = "qcom,ipq5332-usb-hsphy";
> > +			reg = <0x0007b000 0x12c>;
> > +
> > +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> > +			clock-names = "cfg_ahb";
> > +
> > +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		usb2: usb2@8a00000 {
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

'make dtbs_check' passed. The '2' in 'usb2' is to indicate USB v2.
There is one more USB v3 controller in this SoC. Hence, to
differentiate between the two used 'usb2'.

Hope that is ok.

> > +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> > +
>
> No need for blank line.

Will remove.

Thanks
Varada

> > +			reg = <0x08af8800 0x400>;
> > +
> > +			interrupts = <GIC_SPI 62 IRQ_
>
>
> Best regards,
> Krzysztof
>
