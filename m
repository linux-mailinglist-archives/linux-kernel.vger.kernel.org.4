Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404D06C42ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCVGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:19:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125D1FEE;
        Tue, 21 Mar 2023 23:19:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M5ODN6017443;
        Wed, 22 Mar 2023 06:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=xi1R7lRkXD/lKHVkZ4mgBjQ8EbAACSsqoT+12EbXACg=;
 b=YbR8X4R60yAbBUwNcp4AyJtjm1PbDDOVcJe99BDVV1XUveuGn1MoKClGYJt5temubV0p
 8NtcvUMieBjZISwPKQTmbex6EVQ4vwk2FWiEM9cjkvz1V8drXfv0hWUlK6eYKsbl7ZG4
 VBIj/6N+HEykKKW+xC5iYS4ttJTntZBir/dlJ+xUcQdgnVmBP51IRUpS9KkQBhmBfY+I
 XIczPyWim0UitKqRAxUmzxL57loEDoExibmq0tMKXV2FhOPc9pDCoZEjhULQQof9x1Nf
 UTbYTXN2J42QqlQyHvJHhoxCP+cKnNvWSFOk9GAxMjKUpsW/e9Hz2zbk67kRo5m8Yf1M Hg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhnx19vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:19:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M6J4XK002105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 06:19:04 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 23:18:59 -0700
Date:   Wed, 22 Mar 2023 11:48:55 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] Enable IPQ9754 USB
Message-ID: <20230322061854.GD12808@varda-linux.qualcomm.com>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
 <1cb44e37-9881-3c71-816f-a492c917c494@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1cb44e37-9881-3c71-816f-a492c917c494@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RJQHagLzEj7Q8rT-BYhg-wMBxa2Aig2W
X-Proofpoint-ORIG-GUID: RJQHagLzEj7Q8rT-BYhg-wMBxa2Aig2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=631
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220044
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:53:41PM +0100, Konrad Dybcio wrote:
>
>
> On 21.03.2023 09:54, Varadarajan Narayanan wrote:
> > This patch series adds the relevant phy and controller
> > configurations for enabling USB on IPQ9754
> I got this as a reply to the v1 thread. Please don't do that
> and send it as a new mail thread the next time around.
>
> Konrad

Sorry. Will take care next time.

Thanks
Varada

> >
> > Depends on:
> > https://lore.kernel.org/all/20230217142030.16012-1-quic_devipriy@quicinc.com/
> >
> > [v2]:
> >         - Incorporated review comments regarding coding styler,
> >           maintaining sorted order of entries and unused phy register
> >           offsets
> >         - Removed NOC clock entries from DT node (will be implemented
> >           later with interconnect support)
> >         - Fixed 'make dtbs_check' errors/warnings
> >
> > [v1]:
> >         https://lore.kernel.org/linux-arm-msm/5dac3aa4-8dc7-f9eb-5cf3-b361efdc9494@linaro.org/T/
> >
> > Varadarajan Narayanan (8):
> >   dt-bindings: phy: qcom,qusb2: Document IPQ9574 compatible
> >   dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
> >   dt-bindings: usb: dwc3: Add IPQ9574 compatible
> >   clk: qcom: gcc-ipq9574: Add USB related clocks
> >   phy: qcom-qusb2: add QUSB2 support for IPQ9574
> >   phy: qcom: qmp: Update IPQ9574 USB Phy initialization Sequence
> >   arm64: dts: qcom: ipq9574: Add USB related nodes
> >   arm64: dts: qcom: ipq9574: Enable USB
> >
> >  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    |  22 ++++
> >  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   3 +-
> >  .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
> >  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts       |  12 +++
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  86 +++++++++++++++
> >  drivers/clk/qcom/gcc-ipq9574.c                     |  37 +++++++
> >  drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 119 +++++++++++++++++++++
> >  drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
> >  include/dt-bindings/clock/qcom,ipq9574-gcc.h       |   2 +
> >  9 files changed, 284 insertions(+), 1 deletion(-)
> >
