Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C66F9EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjEHFRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjEHFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:17:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1AAD0E;
        Sun,  7 May 2023 22:17:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3485H9Zc024000;
        Mon, 8 May 2023 05:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=TYmfJr7HHvsCMYz1MiZH4pwIzylWNmQxGfoSFBWza8I=;
 b=fF4abupXW4DeZCHGNHsgY95T+i5anWG2nDbBlO9LL/fM/FUk+L9L4keLAxnqJ0lZTzmR
 wPhcD2LFW/4xGxJm+c9Dr3ysODTh0q7O18Wd+MoDyXaCOV3/qmEq/dx4hfndPQHhAxpg
 /rT0tDqMiHGuZ2WQkbF5Iet3CraXPl2Fl5tiZrzlfE3nWLdf1NTKTwiF5MyrUDSXRNTe
 pEAfzr0PgqI3WNeTBe/FGc+aBMNERUcodioPR/wXOa3mVNx/pnuYVwVUrSm8VcEBd/bW
 VT2Lp5S+pHMO5F6WNNZaEPbLIqIlZQNtN9qL29EM6XbTNLgWEQhMWrj+/bS2L6EB5CBZ og== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qddwhjtcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 05:17:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3485H7fT007437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 05:17:07 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 7 May 2023 22:17:02 -0700
Date:   Mon, 8 May 2023 10:46:58 +0530
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
Subject: Re: [PATCH v10 8/9] arm64: dts: qcom: ipq9574: Add LDO regulator node
Message-ID: <20230508051657.GA24472@varda-linux.qualcomm.com>
References: <cover.1683183860.git.quic_varada@quicinc.com>
 <8894bf2c44eaf4959c7a1966b66229e6cf5cda96.1683183860.git.quic_varada@quicinc.com>
 <CAA8EJppvj2nzqwdsC+Xct4cJg2-_yPpiGDELjHJG4HyAH3zGMA@mail.gmail.com>
 <20230506110918.GC10918@varda-linux.qualcomm.com>
 <CAA8EJpqg2htfa2QZ7q6SP58N5YAABa8knBn4c5eYqYOU6HQNiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqg2htfa2QZ7q6SP58N5YAABa8knBn4c5eYqYOU6HQNiA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rai6O2lzCM5Y5S4XD8ywvDXPGmLwmYiT
X-Proofpoint-ORIG-GUID: rai6O2lzCM5Y5S4XD8ywvDXPGmLwmYiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=844
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 02:33:11PM +0300, Dmitry Baryshkov wrote:
> On Sat, 6 May 2023 at 14:09, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Fri, May 05, 2023 at 12:29:54PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 5 May 2023 at 11:23, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > Add LDO regulator node
> > >
> > > As this LDO is provided by the PMIC, it would be nice to know why it
> > > is modelled as an always-on regulator instead of the proper PMIC
> > > regulator. Up to now we were doing this only for the outstanding power
> > > rails like CX/MX or EBI.
> >
> > These are always ON because USB phy doesn't support power
> > collapse, and there is a chance that other IP blocks might be
> > sharing the rail.
>
> You are describing the software side here. From the hardware point of
> view, it is an I2C regulator, which is probably also exported as an
> SMD_RPM regulator. Unless you have a good reason not to do so, there
> should be a node under rpm-requests, which describes mp5496 regulators
> exported via RPM. then USB should refer to those regulators.

Yes. It is a part of rpm-requests. That is why have mentioned V10
is dependent on
https://lore.kernel.org/lkml/20230407155727.20615-1-quic_devipriy@quicinc.com/T/.
The 4th patch of the above series
(https://lore.kernel.org/lkml/20230407155727.20615-1-quic_devipriy@quicinc.com/T/#mea3f0ea37c53cf5e39e10cd6cf3bed5243cec629)
adds the rpm_requests node and this regulator definition is added
to it. Hope that is ok.

Thanks
Varada

> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  Changes in v10:
> > > >         - Add LDO regulator node
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > index bdc1434..1f5d14f 100644
> > > > --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > @@ -60,6 +60,13 @@
> > > >                         regulator-min-microvolt = <725000>;
> > > >                         regulator-max-microvolt = <1075000>;
> > > >                 };
> > > > +
> > > > +               mp5496_l2: l2 {
> > > > +                       regulator-min-microvolt = <1800000>;
> > > > +                       regulator-max-microvolt = <1800000>;
> > > > +                       regulator-boot-on;
> > > > +                       regulator-always-on;
> > > > +               };
> > > >         };
> > > >  };
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry
