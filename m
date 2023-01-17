Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40A66D423
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjAQCNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjAQCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:13:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805631F5F7;
        Mon, 16 Jan 2023 18:13:48 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H2BBg0026230;
        Tue, 17 Jan 2023 02:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Ff4WTlZVH+V7lmYyeny0SbjMnOVONDUYtgsdY67rfzo=;
 b=JnTVNBQbR+TOAHn+VyJvYNBuruMF1J2qaBJeAu51DOpFs+LXrtTyqpqQmuj1BmSJ5WR1
 CEgKvPGrFWpKfGo+8NKk6rJkTpmBZ+pWK5CmsD816KLAuEI1z9M4EKaUSbLN7GOc5RzL
 +A9dgkDDFNHfPkoN2JZ1DpTQxFI9WJcW2aHtvWJDVKqfdvUjoRCNfUTqQF0k9+m2E8l7
 VqGsQ/PlHs2Jz3+WdaujvrpwQIsGYMyFZLkGWnwLME3L/YKcGad1KxC0KjT1tp6VzsfK
 Jz+PS175AipXdjasXQ+hauaDWTj3Cp+26HX5xvaOdwmY5IB5Lvncv5RvQW61Mplqr9Fs EA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3njvc9vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:13:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H2DiKu026328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:13:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 16 Jan 2023 18:13:44 -0800
Date:   Mon, 16 Jan 2023 18:13:43 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
Message-ID: <20230117021343.GA2350793@hu-bjorande-lv.qualcomm.com>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <bcf497a7-66bb-9cd9-bada-4081000747a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcf497a7-66bb-9cd9-bada-4081000747a6@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tUMq3C-9vkAFwHb6tUq7GWxnyiXvZL9J
X-Proofpoint-ORIG-GUID: tUMq3C-9vkAFwHb6tUq7GWxnyiXvZL9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170013
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:56:59PM +0100, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 05:11, Bjorn Andersson wrote:
> > This implements the base PMIC GLINK driver, a power_supply driver and a
> > driver for the USB Type-C altmode protocol. This has been tested and
> > shown to provide battery information, USB Type-C switch and mux requests
> > and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
> > 
> For the series:
> 
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> 
> Thanks a lot for working on this!
> 

Thank you for testing it :)

> One thing, /sys/class/power_supply/qcom-battmgr-usb/input_current_limit
> is stuck at zero and so is the current_now as a result (the voltage
> readout is 5V + some noise, so that looks good), but I don't see any
> SET paths for it in the driver, so I suppose that's what the firmware
> default is?
> 

I have not experimented with adjusting any configuration in this initial
set, but there are a few knobs that could/should be introduced on top of
this.

That said, I believe input_current_limit should somehow come from the
USB stack, rather than user space?

Regards,
Bjorn
