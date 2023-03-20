Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7536C261F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCTXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCTXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:53:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465AB77F;
        Mon, 20 Mar 2023 16:52:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KLqTpg018316;
        Mon, 20 Mar 2023 23:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3NValqBeu7axcEivrOR5Cicr8D7Zw172uAmb15xsnOI=;
 b=WaEFODT8hJIBGHZm/Ylg/2wiu8feIz2K+gWh7do0YAP5NkK3IJeqfY2tCijyNTK7JEUL
 AmLR/Bgd6zLmkIzYGBYm58vMKqZmwBCWNL8TwCp/GI7ddhz009DPvhUZPZHWXr1FheEl
 LGEGGqYuTfuLdGxn89D2HE0scQl6AFinKrv0zyxQI1dszKCp9ceR/XKsBlwD0DBpxqPi
 dfnmYUYw6n0GKQDgCxQwsGQ1T+elKPS4PAaxeueo01lWknY3dOONK/HuSaQzHCwEhaJq
 upOGez1qQHPAToKlXj5oCsSWRClyaCO5kypCsMqOrCnZpxugGG+hvFaXjEhpMIey6iJz CA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pes8p19uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:51:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KNpcoX016942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:51:38 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Mar
 2023 16:51:37 -0700
Message-ID: <35d71338-3524-a46c-e434-bee47cfba0cb@quicinc.com>
Date:   Mon, 20 Mar 2023 16:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v3 0/3] thermal: qcom-spmi-temp-alarm: add support
 for new TEMP_ALARM subtypes
Content-Language: en-US
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1674602698.git.quic_collinsd@quicinc.com>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <cover.1674602698.git.quic_collinsd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k6ws1zNRtx6lWPsyDjuLceJdJYDDYNQJ
X-Proofpoint-ORIG-GUID: k6ws1zNRtx6lWPsyDjuLceJdJYDDYNQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200201
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 15:46, David Collins wrote:
> Add support in the qcom-spmi-temp-alarm driver for the new PMIC
> TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE.  The GEN2 rev 2
> subtype provides greater flexibility in temperature threshold
> specification by using an independent register value to configure
> each of the three thresholds.  The LITE subtype utilizes a simplified
> set of control registers to configure two thresholds: warning and
> shutdown.
> 
> Also add support to avoid a potential issue on certain versions of
> the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
> is disabled.
> 
> Changes since v2 [1]:
> * Added missing header <linux/bitfield.h> in the third patch
> 
> Changes since v1 [2]:
> * Updated the thermal API usage in the patches to work with the recent commit
>   ca1b9a9eb3fd ("thermal/drivers/qcom: Switch to new of API")
> 
> [1]: https://lore.kernel.org/lkml/cover.1670375556.git.quic_collinsd@quicinc.com/
> [2]: https://lore.kernel.org/lkml/cover.1663282895.git.quic_collinsd@quicinc.com/
> 
> David Collins (3):
>   thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
>   thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
>     peripherals
>   thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
> 
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 407 +++++++++++++++++++-
>  1 file changed, 392 insertions(+), 15 deletions(-)

Hello Amit and Thara,

Could you please take a look at this patch series when you have some
time?  It hasn't received any feedback yet after being sent out on
1/24/2023.

According to the MAINTAINERS files, you are the maintainers for all
files in the drivers/thermal/qcom/ directory:

QUALCOMM TSENS THERMAL DRIVER
M:	Amit Kucheria <amitk@kernel.org>
M:	Thara Gopinath <thara.gopinath@gmail.com>
L:	linux-pm@vger.kernel.org
L:	linux-arm-msm@vger.kernel.org
S:	Maintained
F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
F:	drivers/thermal/qcom/

Can you please check if this entry needs to be updated?  The
drivers/thermal/qcom directory now contains the qcom-tsens driver as
well as three other independent QCOM thermal drivers:
qcom-spmi-temp-alarm, qcom-spmi-adc-tm5, and lmh.

Thanks,
David

