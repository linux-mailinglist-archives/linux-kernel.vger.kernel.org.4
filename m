Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB606FDB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjEJKXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjEJKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:23:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B22D7B;
        Wed, 10 May 2023 03:23:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9D4ud030035;
        Wed, 10 May 2023 10:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ZoXXvx1KrUmrm6J8q0QWOx2OVpxXGbg1USHSHzeCXcU=;
 b=CO4YWD1spiikNUO4Je2K8BJXaKPi+CDg3zYbv1RgLjGTinejPMxvQiTWueTPCXW1yYOW
 DRd9anPkcomLHFbnIjtU+X2S0k5P9A5vFL53MlrtlD8PZplEInrEmWSdc6ImW52jdd2R
 XB7v6RJD32okUgudOQJq8ViX3zwomb3PnC1Q71BFGYsEFDDyUz/T7XkM7jvYfFJ1pHc/
 AmuxCZuK5oRO7DEDKTrRMR9VMQ7OmqMmzI89c7j5sFwE6R1N9uld+dwvCouA9Z3gmuLU
 T8fesIEp89VMvRuEayGAzA5kmHKdjOhqbfuNa2YUUGdjOEosiUJ0uuvaZpCEEkAuZjqo Kw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg5mprer1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:22:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AAMtTd027369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:22:55 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 03:22:49 -0700
Date:   Wed, 10 May 2023 15:52:45 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v11 8/9] arm64: dts: qcom: ipq9574: Add LDO regulator node
Message-ID: <20230510102244.GA21530@varda-linux.qualcomm.com>
References: <cover.1683630932.git.quic_varada@quicinc.com>
 <42bf6244582d6208f51db1a9299fe1c8afab4e14.1683630932.git.quic_varada@quicinc.com>
 <CAA8EJpqkSNzx=73JS1Csw+ivVovhrFeM0R5j2tpruEfNqvT48Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqkSNzx=73JS1Csw+ivVovhrFeM0R5j2tpruEfNqvT48Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n9j7NvPT3oQR1Gs-DzZ4KCoQp_4YgHjt
X-Proofpoint-GUID: n9j7NvPT3oQR1Gs-DzZ4KCoQp_4YgHjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 04:08:59PM +0300, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 14:56, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Add LDO regulator node
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Changes in v10:
> >         - Add LDO regulator node
> > ---
> >  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Minor question below:
>
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > index bdc1434..1f5d14f 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > @@ -60,6 +60,13 @@
> >                         regulator-min-microvolt = <725000>;
> >                         regulator-max-microvolt = <1075000>;
> >                 };
> > +
> > +               mp5496_l2: l2 {
> > +                       regulator-min-microvolt = <1800000>;
> > +                       regulator-max-microvolt = <1800000>;
> > +                       regulator-boot-on;
> > +                       regulator-always-on;
>
> This usually points out that there are other users which are not yet
> enabled/properly specified. What users are there for this supply which
> demand it to be always on?

The 1.8v rail is used by PCIe PHY, PLL for Ethernet SerDes
interface and PLLs that generate SoC clocks. The voting for this
rail is managed by the RPM f/w.

Thanks
Varada

> > +               };
> >         };
> >  };
> >
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry
