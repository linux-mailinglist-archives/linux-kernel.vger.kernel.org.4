Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554A5EED19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiI2FLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2FL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:11:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A4C842D;
        Wed, 28 Sep 2022 22:11:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T4PHgl002837;
        Thu, 29 Sep 2022 05:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dU/SEjbxtKnvNwS9YPhhLnRPIVmG98hXeidNmM+5oUE=;
 b=TpR8GCxaqs2I8MrVlxbN5T2ynyTfxuvACv8yLtXHVX5S/J8p6A7k0hv/S40jvt8MF8Zj
 vaI5G3IdJL590+rVfCBNEinuy3n9Y1GrjH5gl/3hd+CbzqysvxYJJZE4HWGm+ZMXOOUD
 F/uOPfhQSVpIceYOpT5nEHrg+9IVfhChqtlW/C2CZgR0sAKQnQ5NjX9daicIrtpnV0ZB
 qqkxk/9N82mkVz5D5Bct1vco6ulsMnkOVDa/6qV5cseNNSJi/WKRQ3rherzOl1omexhz
 2OtCUHb2Qp9i+CZQJDnSa2McgsZ6re/j/mQtZJaBuOayP3T9w4FUnugRPKzWKh3D5yaT /A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jva6qvp9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 05:11:18 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28T5BH4m028392;
        Thu, 29 Sep 2022 05:11:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jvm5sk7rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 05:11:17 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28T56XWq023360;
        Thu, 29 Sep 2022 05:11:17 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 28T5BHax028385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 05:11:17 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 22:11:13 -0700
Date:   Thu, 29 Sep 2022 10:41:10 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Message-ID: <20220929051110.GA1397@hu-ppareek-blr.qualcomm.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
 <20220920120802.14321-4-quic_ppareek@quicinc.com>
 <Yyq0dFvCI54QMqAl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yyq0dFvCI54QMqAl@hovoldconsulting.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8WecGTwbsWO7HLwSDrr4k4OuZcANW9Vq
X-Proofpoint-ORIG-GUID: 8WecGTwbsWO7HLwSDrr4k4OuZcANW9Vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_02,2022-09-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=842 bulkscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:51:32AM +0200, Johan Hovold wrote:
> On Tue, Sep 20, 2022 at 05:38:02PM +0530, Parikshit Pareek wrote:
> > Create new dts file specific for Qdrive board based on sa8540p chipset.
> > Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> > Qdrive board.
> > 
> > This is quite similar to sa8295 ADP development board. Main differences
> > are related to connectors, and interface cards, like USB external ports,
> > ethernet-switch, and PCIe switch etc.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > Reported-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> > ---
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> > new file mode 100644
> > index 000000000000..bd79866b80e1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sa8540p-adp.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm SA8540 ADP";
> > +	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
> > +};
> > +
> > +&ufs_card_hc {
> > +	status = "disabled";
> > +};
> 
> What about the UFS phy, etc?
Really missed that. Will add phy nodes too.
> 
> This opt-out scheme seems quite fragile.
> 
> > +&usb_1 {
> > +	status = "disabled";
> > +};
> > +
> > +&usb_1_hsphy {
> > +	status = "disabled";
> > +};
> > +
> > +&usb_1_qmpphy {
> > +	status = "disabled";
> > +};
> 
> Johan
Regards,
Parikshit Pareek
