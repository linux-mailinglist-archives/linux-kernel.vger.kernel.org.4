Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D4741318
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjF1Nyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:54:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:49886 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231542AbjF1Ny1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:54:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8JjLR002642;
        Wed, 28 Jun 2023 13:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=9UCz4yEaBLsI1zCNNQCA7tKcSTDUIMBNJmFkNTE0KRI=;
 b=C4uWvpJHh2bV9CyOLmpfN9wuIXe4M4r/Q/4Amu4o0hqwq6DUgKQkuvS4FsM1TZM8FseZ
 vYV6o7Faur6wwj8csVoQgJFh+1cEMxMF66pewWfDDmH0O8cRCEKZfJwtE8V1BdO3/uP9
 IIu7Kh9ijP0a1pDcBpP7+Se2TRd5dIRBU7kgABWL4FRE7cr1MN6dbiwMdhteR1q7CqV1
 +roWNAZUpQzRYAxiUUMQkNSw3EDVkwM5ZH56Kd9/MARz4y2kq2UpE/8sxwRnf+srqtx0
 fxb6UeR0oRtpNhDTBvcagpwvnpTz2XlJ8OA6dDda7zh3or6P6mmTdwQShZ9av64noMv3 pQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetph1u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:53:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SDrOaL019508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:53:24 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 06:53:16 -0700
Date:   Wed, 28 Jun 2023 19:23:12 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
Message-ID: <a26f22d2-95a7-4143-bff5-45ef0b53b30b@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dvP17vLT4h84mAiuU6uJVhi4iE_WqiWm
X-Proofpoint-GUID: dvP17vLT4h84mAiuU6uJVhi4iE_WqiWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=869 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:29PM +0530, Mukesh Ojha wrote:
> Module like minidump providing debugging support will need to
> get the symbol information from the core kernel e.g to get
> the linux_banner, kernel section addresses bss, data, ro etc.
> 
One might ask why we would need such a debug driver to
be compiled as module? What would you do if we need to capture more
kernel data structures later? Do you plan to continue use
kallsyms_lookup_name() to query all the symbols?

I have seen v3 discussion where you are asked to compile this driver
as module but that time there was no reason why your driver needs to
be compiled as statically, now you have a reason (linux_banner) for
it.

> commit 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name()
>  and kallsyms_on_each_symbol()") unexports kallsyms_lookup_name
> due to lack of in-tree user of the symbol. Now, that minidump
> will one of its user, export it.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks,
Pavan
