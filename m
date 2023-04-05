Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79B6D77C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbjDEJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbjDEJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:07:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94324C31;
        Wed,  5 Apr 2023 02:07:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3350fO77006850;
        Wed, 5 Apr 2023 08:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=tfeCTwscVhChaxXdNWUUPdUPQorf+0lrNukgnolz91Y=;
 b=P80Xj+zDsJNQPFukVg3BIvbZz7vDRimJRvMH5lOS1Ui6qffh8ejureGj9Ne3+mwi8oDD
 hf6D91CtbX6uiAOrNT3R/+hkvrCqBms/2509LVniYdupgm/d8bDNZ17ZOjdu3k9zFUph
 McXILQmfa+eEDrpT2GeJrQh3znM059kbmTvyTLvkAFBS1PWVXCnobuxVco7e7NqDIFLa
 buwqaNrWW+Zzw83xr+y9GKGEJRcL6Aw6zRWcu+XQb9oZ3Xb3d/yS1XR4n2f9FJguQEN4
 hK01I8OYx0itgxas/w89DguVtuUxWEuhqiE3TDgdFB+nK+H2UxJtC+v72rTKiNOXv2Qj 6A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prppuj2yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 08:58:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3358whes006874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 08:58:43 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 01:58:36 -0700
Date:   Wed, 5 Apr 2023 14:28:32 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230405085831.GA26156@varda-linux.qualcomm.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
 <c46b542b112b59002ab965be1d3fcae8c372d545.1680162377.git.quic_varada@quicinc.com>
 <CAA8EJpo_ckJtYV4aU613X5L6+wj-1i9vZkud5p72PLdCSnj5ng@mail.gmail.com>
 <20230331092710.GB19162@varda-linux.qualcomm.com>
 <ZCaznloORtzgioOP@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCaznloORtzgioOP@hovoldconsulting.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M1LODQcyTa-eleXSBAkeNfjSdwR-KcDR
X-Proofpoint-ORIG-GUID: M1LODQcyTa-eleXSBAkeNfjSdwR-KcDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_05,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=941 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050082
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:19:10PM +0200, Johan Hovold wrote:
> On Fri, Mar 31, 2023 at 02:57:11PM +0530, Varadarajan Narayanan wrote:
> > On Thu, Mar 30, 2023 at 12:44:40PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, 30 Mar 2023 at 11:42, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > Add USB phy and controller related nodes
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  Changes in v5:
> > > >         - Fix additional comments
> > > >         - Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > >         - 'make dtbs_check' giving the following messages since
> > > >           ipq9574 doesn't have power domains. Hope this is ok
> > > >
> > > >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
> > > >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
> > > >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > >
> > > No, I think it is not.
> >
> > There are no GDSCs in IPQ9574. Can you suggest how to proceed.
>
> You need to update the binding and either make the power domains
> property optional in the binding or dependent on the SoC.
>
> > > > +               ssphy_0: phy@7d000 {
> > >
> > > Nit: usually the label usb_0_qmpphy
> > >
> > > > +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> > > > +                       reg = <0x0007d000 0xa00>;
> > > > +                       #phy-cells = <0>;
> > > > +
> > > > +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> > > > +                                <&xo_board_clk>,
> > > > +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > > > +                                <&gcc GCC_USB0_PIPE_CLK>;
> > > > +                       clock-names = "aux",
> > > > +                                     "ref",
> > > > +                                     "com_aux",
>
> This is not the right name for this clock so you need to update the
> binding first.
>
> Please be more careful.

Thanks for your feedback. Have posted v6 with the above corrections.

-Varada
>
> > > > +                                     "pipe";
> > > > +
> > > > +                       resets = <&gcc GCC_USB0_PHY_BCR>,
> > > > +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> > > > +                       reset-names = "phy",
> > > > +                                     "phy_phy";
> > > > +
> > > > +                       vdda-pll-supply = <&reg_usb_1p8>;
> > > > +                       vdda-phy-supply = <&reg_usb_0p925>;
> > > > +
> > > > +                       status = "disabled";
> > > > +
> > > > +                       #clock-cells = <0>;
> > > > +                       clock-output-names = "usb0_pipe_clk";
> > > > +               };
>
> Johan
