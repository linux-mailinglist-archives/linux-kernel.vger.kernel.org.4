Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF54731266
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjFOIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjFOIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:38:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A3C1FF9;
        Thu, 15 Jun 2023 01:38:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8bwct004498;
        Thu, 15 Jun 2023 08:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=JOVReWYgp4mslzJesoiZdVQJcoj3RCwTIfRIcLjnaFw=;
 b=AdLA/qI3jSK3D76F6xIniVB63F+D7pWYqpoFtSZELYTKk2DoPP2uvBgYip4ZYlYmCNHz
 WTWZIjR8zA+dHY7CbHABSAGz2ahUbt/aDHiPLy5JwKfXh5PyaEeey4KwkL9MvGi0rty/
 rABK5tu3OHtGfZTfxHq2OzPqettf7QW/uC23dba2b5o8FNaqjWCUmOtjGLFnD5lqrUJc
 E//NORVFpJ17En7Be2tfnbQbLevK8Ml+zOAvItWSeRWcPRKL6pXpIZEKrcaPSNhtDtqY
 AL4Ymczb6H3DdWVY66XpwHGVrLOsmaQouTFeSrumQMODroSU1HNcwjI0a963tvF1Jc/1 Fg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7va2gd6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:38:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F8c0IL025490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:38:00 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 01:37:49 -0700
Date:   Thu, 15 Jun 2023 14:07:45 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
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
Subject: Re: [PATCH 9/9] arm64: defconfig: Enable QCOM M31 USB phy driver
Message-ID: <20230615083744.GB9973@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <55f51785b36b9725fe5283a58230aee4e89b4d6f.1686126439.git.quic_varada@quicinc.com>
 <21bfe86f-8257-d0ff-883b-bbe451d8f77b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21bfe86f-8257-d0ff-883b-bbe451d8f77b@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WuvZapCsfPSz5iUrxf8InvxK0I-vISEu
X-Proofpoint-ORIG-GUID: WuvZapCsfPSz5iUrxf8InvxK0I-vISEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=257
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:36:21PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 12:56, Varadarajan Narayanan wrote:
> > Enable QCOM M31 USB phy driver present in IPQ5332
>
> What is "QCOM"? If acronym, extend. IPQ5332 - provide full name, so
> "Qualcomm IPQ....".

Will remove 'QCOM'.

Thanks
Varada

> Best regards,
> Krzysztof
>
