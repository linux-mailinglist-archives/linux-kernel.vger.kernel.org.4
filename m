Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501815E8696
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiIXALl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiIXALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:11:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928832BBF;
        Fri, 23 Sep 2022 17:09:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NNJkTx032306;
        Sat, 24 Sep 2022 00:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=a7nDO7ohfYGnTWh7ONt+gbaTWPaULiS/JkfZBmleIpc=;
 b=lYChOzqnjiGhJxskAVQ8Jo1G7s+TkmFNu7ZVWFdL+qqIlBHWujZ12RkNw+m2M3h+nzIn
 546efAq+g98DnDPvGNfUuOjOQSrG9jvvXpwkyYxx6eNOiBJkIaYNcoH4stXGOM/LnLt2
 m0MQ02uDlAm2YiS0yDWDB94HVxYaztwq+2Dq0P9tLUfWVyt1IPVgAQYv0SqCdaBZYHiw
 8VYOCGQiUZsiqIx/KEos//6tDbqUWP7RIeF3xROSSUvLT7QwixCbJ4GjgUQ+P7tz1PSm
 qGniACNCPkENmudBzopIT06U/9odAb41o31uiuhpzUM/0vCTAZZ92P2l7z7Zf8+wNfEi SA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrpqnvpyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 00:09:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28O09YZb019390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 00:09:34 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 17:09:33 -0700
Date:   Fri, 23 Sep 2022 17:09:32 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <20220924000932.GA1450@quicinc.com>
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t7244SlhJEQ1FUYFuitfzHvBzA_Hi1C-
X-Proofpoint-GUID: t7244SlhJEQ1FUYFuitfzHvBzA_Hi1C-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=927
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 21 2022 20:43, Konrad Dybcio wrote:
> Does it? I did not define this compatible in the driver, so it does
> not consume any clocks.

The bindings should describe only those compatibles that the driver supports -
that is, both the driver and its bindings should be in sync.

Could you please update the driver with this compatible as well? Let's not
merge this change without that first.

Thank you.

Guru Das.
