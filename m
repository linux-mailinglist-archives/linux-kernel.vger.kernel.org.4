Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799D5ED4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiI1G1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI1G1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:27:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7511E97A;
        Tue, 27 Sep 2022 23:27:03 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5vOZN032745;
        Wed, 28 Sep 2022 06:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=96GX6WGAtIGy7fAFvigC5uxOtxBtb05yV5CxoED/WjM=;
 b=GU48KVCJvHW4HtOLjVWaoZSk9DM0k/RU83CrH2Qg3AhfuKWbgpFPnYq6XHbOYelZHRyR
 H28n5vyk7lRwpMHwyVhLyKUhNGo30/aioDDc+MAkvRCltUDI2qea4EHLPiN5YiU6h34H
 WG4LYGPUyWt84S07LU+BWJR4+Qvh/SUpNY+asHPMatrl6DM5Z2H1yOpXU3HJPUUi6pyQ
 W+HnPt0FP/6N5seJVaNvV4ecbQYscLpmIoBbV/vhE5hxkbJXFkRZkJ4fMgtuIflw6kMw
 nCgMfCwiOsr6UEn7rlSOHsx0PFKo5HU3rh0qdFF43coa6K/acUxSXUU+dxXgHjtxU4ez dA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juw262u4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 06:26:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S6Qriv022437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 06:26:53 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 23:26:52 -0700
Date:   Tue, 27 Sep 2022 23:26:51 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <martin.botka@somainline.org>,
        <angelogioacchino.delregno@somainline.org>,
        <marijn.suijten@somainline.org>, <jamipkettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM6375 SCM
Message-ID: <20220928062651.GA9662@quicinc.com>
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <20220924000932.GA1450@quicinc.com>
 <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
 <20220926165904.GA17938@quicinc.com>
 <90185f20-f91a-54b9-bb46-d186419b5169@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90185f20-f91a-54b9-bb46-d186419b5169@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OB53b7PgTQxNLfEVIL6dSAGKPrs8CnYw
X-Proofpoint-ORIG-GUID: OB53b7PgTQxNLfEVIL6dSAGKPrs8CnYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=994 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27 2022 13:42, Krzysztof Kozlowski wrote:
> On 26/09/2022 18:59, Guru Das Srinagesh wrote:
> > On Sep 24 2022 10:17, Krzysztof Kozlowski wrote:
> >> On 24/09/2022 02:09, Guru Das Srinagesh wrote:
> >>> On Sep 21 2022 20:43, Konrad Dybcio wrote:
> >>>> Does it? I did not define this compatible in the driver, so it does
> >>>> not consume any clocks.
> >>>
> >>> The bindings should describe only those compatibles that the driver supports -
> >>> that is, both the driver and its bindings should be in sync.
> >>
> >> That's not entirely true. Bindings describe the hardware in the most
> >> complete way we can. Not the driver. Whether driver supports something
> >> or not, is not relevant here, except that we don't want to document
> >> non-existing things or stuff out of tree.
> > 
> > Is this only applicable to compatibles or device tree properties in general?
> 
> This applies to everything.
> 
> > 
> >>>
> >>> Could you please update the driver with this compatible as well? Let's not
> >>> merge this change without that first.
> >>
> >> This could be even merged without change in the driver. However it's not
> >> the case here as driver already supports it, so your request is fulfilled.
> > 
> > My concern is that if somebody specifies a compatible/device tree property that
> > the driver doesn't support, their expectations from adding that change will not
> > be met. In addition to having the bindings describe HW in full, I think the
> > driver should also be in sync with it for this reason.
> 
> As Rob answered, it might be difficult to keep all drivers in all
> operating systems, bootloaders and firmware components to be in sync. :)

Ack.
