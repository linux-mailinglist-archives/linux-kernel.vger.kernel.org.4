Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B75680489
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjA3D6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjA3D6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:58:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D130C7;
        Sun, 29 Jan 2023 19:57:50 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U33VBR004932;
        Mon, 30 Jan 2023 03:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=jvuo9x98ZykyHJXQRJx9msVvylzhmnUIuw1eTcBYGTU=;
 b=hlcW1yZcfeLe/rEY56XBsTOnVf30MKIlKNodLgkJEpcWeMbnEBuszBLF/OJ6X6lOngFi
 kSUdXzp5T62AQ9JiXafnQ531Jj61hjrBPSveEShIpsubW09gJ7EOpeO21RZGtRP845b1
 8zUf6o9ZvmZHJZyuS0D0qcn6ifV7b0DLgNKi/AGWqHN32pwIWXKd5URtO4VRsUA96PVq
 UbZKhlqirqzApO9JrYlbsJvQ1OZ8y9nr5Ng5l5I2so7gtXLt2D2QloMvKmTAUbEkkmkf
 C7UJrwTIB3IWZaYrnVyUA728h+4BC0y8gO7xCIU5uOQeWpYOWZy+YKQsFUpqvkt+o/cH Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxajntx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:57:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U3vi0b013333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:57:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 19:57:43 -0800
Date:   Sun, 29 Jan 2023 19:57:42 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on
 i2c12
Message-ID: <20230130035742.GB464800@hu-bjorande-lv.qualcomm.com>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
 <20230124184440.1421074-4-quic_bjorande@quicinc.com>
 <20230126225446.rjckq5p35zeozphq@halaney-x13s>
 <5a638130-89c3-871b-c233-55048a162870@linaro.org>
 <20230126234354.437bajx7lckafg4z@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126234354.437bajx7lckafg4z@halaney-x13s>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jp9vObkcHEqw-flJpBC5mVQmanl47lpG
X-Proofpoint-GUID: Jp9vObkcHEqw-flJpBC5mVQmanl47lpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:43:54PM -0600, Andrew Halaney wrote:
> On Fri, Jan 27, 2023 at 12:35:37AM +0100, Konrad Dybcio wrote:
> > 
> > 
> > On 26.01.2023 23:54, Andrew Halaney wrote:
> > > On Tue, Jan 24, 2023 at 10:44:40AM -0800, Bjorn Andersson wrote:
> > >> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >>
> > >> The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.
> > >>
> > >> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > >> ---
> > >>
> > >> Changes since v1:
> > >> - i2c node had changed name
> > >>
> > >>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
> > >>  1 file changed, 41 insertions(+)
> > > 
> > > I realized today this has to do with the comment over at:
> > > 
> > >     https://lore.kernel.org/all/30166208-ba9d-e6e6-1cd2-807a80536052@quicinc.com/
> > > 
> > > and I just didn't realize that the schematic I've started looking at
> > > black boxes the SOM/SIP which holds this... darn I thought I could see
> > > more than I could :(
> > > 
> > > I took a similiar patch for a spin on sa8540p-ride (which I'll later
> > > submit), and things worked fine (I'm not really consuming the output of
> > > the regulator mind you).
> > > 
> > > Downstream devicetree indicates all of this looks ok except for possibly
> > > the below comment:
> > > 
> > >>
> > >> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > >> index bb4270e8f551..642000d95812 100644
> > >> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > >> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > >> @@ -266,6 +266,27 @@ &dispcc1 {
> > >>  	status = "okay";
> > >>  };
> > >>  
> > >> +&i2c12 {
> > >> +	pinctrl-names = "default";
> > >> +	pinctrl-0 = <&i2c12_state>;
> > >> +
> > >> +	status = "okay";
> > >> +
> > >> +	vdd_gfx: regulator@39 {
> > >> +		compatible = "maxim,max20411";
> > >> +		reg = <0x39>;
> > >> +
> > >> +		regulator-name = "vdd_gfx";
> > >> +		regulator-min-microvolt = <800000>;
> > > 
> > > Is there a reason you chose this instead of the 500000 I see downstream?
> > > 
> > >> +		regulator-max-microvolt = <968750>;
> > > 
> > > Likewise, I see in this brief description of the regulator
> > > that the upper bound is higher than this (1.275 V). I am not sure if
> > > the values in the devicetree are supposed to describe the
> > > min/max of the regulator itself, or of what your board can really
> > > handle/needs (the latter I guess makes more sense since you wouldn't want to
> > > accidentally request a current draw that could melt something.. that can
> > > be fun). I do see you've got that min/max in the driver itself (now that
> > > I peaked at that patch).
> > Yes, your suspicions are correct and the DT sets the actual ranges
> > for the voltage regulators on this specific board while the
> > hardware reachable ranges are defined in the .c driver.
> > 
> > Konrad
> 
> Thanks Konrad, then I think:
> 
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> 
> is appropriate since things are within range on all accounts. I would
> appreciate an explanation on the current min/max values though if possible!
> 

I will add a line about the range as I resubmit the patch.

Thanks,
Bjorn

