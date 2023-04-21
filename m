Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E156EA7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDUJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjDUJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:59:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B8AF38;
        Fri, 21 Apr 2023 02:59:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L9Zl95013077;
        Fri, 21 Apr 2023 09:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=mH1yRwdyfBGlx7ue1iz6rfx3JzGxQNBiTPZdXuAKA20=;
 b=gnXAnoEu3DjamoQMVwxHSzwbt4OWXcBgneGzmScoe0XZubpD0XNvTGOFbBglCf9i4v3b
 xt8qhwymRk432lsTO2Zdu5ueuCyXRTPqDdvP+zZPFVS19jb+/Ius3hdwWxUXSxEa9F6w
 BxNpswsJzdOUu3sgpDcbSEWIjkRaEwfHLSkVktKAvP7B92CTVuGuHfVU//P76QOFiP3d
 SgM+LFbVsHxfg6/SkP/hky3+t29L40GqU8gi1vYfEqNtjtA51OTnUrcsOtkTc9Ttx+4C
 /eNOHxHBtfHVn26rJTHiiYWs/xnlUzrHpoZHSba4SYmCmEnIckseagv8OfJBJQ9uiYWl ZQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3dcmh9cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 09:58:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33L9wnt1026221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 09:58:49 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 02:58:43 -0700
Date:   Fri, 21 Apr 2023 15:28:39 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <20230421095838.GA5813@varda-linux.qualcomm.com>
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <1efa9a64499767d939efadd0aef897ac4a6e54eb.1680693149.git.quic_varada@quicinc.com>
 <0a66e291-a86d-1ff9-e674-839b8cc8f1da@linaro.org>
 <ZDz9t9TkBqZ1fcfn@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDz9t9TkBqZ1fcfn@hovoldconsulting.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HkjpSBWiKHcIpBqiN8ceaiazLMOuKFFz
X-Proofpoint-GUID: HkjpSBWiKHcIpBqiN8ceaiazLMOuKFFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_03,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:05:11AM +0200, Johan Hovold wrote:
> On Thu, Apr 06, 2023 at 09:41:49AM +0200, Krzysztof Kozlowski wrote:
> > On 05/04/2023 13:41, Varadarajan Narayanan wrote:
> > > Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  Changes in v8:
> > > 	- Update clock names for ipq9574
> > >
> > >  Changes in v6:
> > > 	- Made power-domains optional
> > >
> > > Note: In the earlier patch sets, had used the (legacy)
> > > specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
> > > to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > ---
> > >  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
> > >  1 file changed, 37 insertions(+), 6 deletions(-)
>
> > > +        clock-names:
> > > +          items:
> > > +            - const: aux
> > > +            - const: ref
> > > +            - const: com_aux
> >
> > Can anyone explain me why do we name these (here and other Qualcomm
> > bindings) based on clock name, not input? Just because different clock
> > is fed to the block, does not necessarily mean the input should be named
> > differently.
>
> I guess part of the answer is that this has just been copied from the
> vendor dts and (almost) no one but Qualcomm has access to the
> documentation. What would the input names be here?
>
> Also note that there are SoCs that enable both 'cfg_ahb' and 'com_aux'
> (e.g. sc7180).

The clock name definitions are auto-generated based on the clock
tree definitions provided by the h/w team. We followed the naming
pattern done in the previous SoCs.

Thanks
Varada

>
> > > +            - const: pipe
> > > +
> > >  examples:
> > >    - |
> > >      #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>
> Johan
