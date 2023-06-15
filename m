Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D568730F10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjFOGH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjFOGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:07:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC1D2975;
        Wed, 14 Jun 2023 23:06:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F54gCO012998;
        Thu, 15 Jun 2023 06:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=rZrcYOGgNAGIojSS1//Lwf9G0BVqC5oeL2SJ+WOtc6k=;
 b=kuN0aquf8OQ85UR/hZVGuDooUDadbdedal0/RBn2UE32b3Gg7r7pAxBIFWgVhBk2eJC1
 myjNGcZiDVr4KDPfkL6BQEPGEuc7HzXhQAxrr2ubCSkmpxZpqVG64kKzO4EUeofNQ2ZH
 9X0WHMYLfWKqV9Sss3OxWcKpNGlWusoJ80WOIalOY65MRPGqXhg5q+CBOuL3o6X+4XYm
 tq0BT5C7NsRprvVLM9IFBgUpmr7GoZguQhW3pmzBHtqdbc+bI8YGuDnnotNabnsWQkQS
 4JKbVp6jzXIn+lIG3GyDCm6er+qoJ/WAcU7I2kut1QtSPv7jRU25ko7FSFldImbKdqkw YA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7ukm856f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:05:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F65dML018330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:05:39 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 23:05:30 -0700
Date:   Thu, 15 Jun 2023 11:35:26 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
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
Subject: Re: [PATCH 5/9] phy: qcom-m31: Introduce qcom,m31 USB phy
Message-ID: <20230615060525.GF22186@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <636308462efb579734de829fb6e9cbda81b982f7.1686126439.git.quic_varada@quicinc.com>
 <f007fbf0-b1a7-cb44-d662-c30bf114365e@linaro.org>
 <cba3834a-8ed3-b3a8-32cc-b0397fa5ae41@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cba3834a-8ed3-b3a8-32cc-b0397fa5ae41@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zXxp3tJD1rQq6534dlYRBpPltmkRdgja
X-Proofpoint-ORIG-GUID: zXxp3tJD1rQq6534dlYRBpPltmkRdgja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_03,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=611 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:37:05PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 13:20, Dmitry Baryshkov wrote:
> > On 07/06/2023 13:56, Varadarajan Narayanan wrote:
> >> Introduce CONFIG_PHY_QCOM_M31_USB for including the M31 phy driver
> >>
> >> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >
> > Is there any reason to keep Kconfig, Makefile and driver in different
> > commits?
>
> KPI? Yearly objectives/goals?

No :-). Was not sure, hence split them.
Will combine in the next version.

Thanks
Varada
