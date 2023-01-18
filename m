Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7971067266B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjARSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:13:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E4A9;
        Wed, 18 Jan 2023 10:12:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IHg6bT013725;
        Wed, 18 Jan 2023 18:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=tNDW5Z5FfWRU2ZvezRgERgXKcaw2HRi53+wjPgcTQq8=;
 b=edc22gJU1MgKp1N7OLA1fq0LAWEDH/0zmS+ktoxtNhtxw8yFz///xN+KWDZNizPCMObt
 eLdOQyP76yUf1b+aZuM4sfmvQZuNHMBz52PGXqxMM1ZASzrVRzMmJWdDLb1SvAVNrv8u
 Wa5UKd3XHHKnMDA1PoNeba5p4obxIB7eRMvgkqWzArgv6Cx1kfEiY+w3zOezvn30Qr6k
 ZwEVDTRc6/D6jwJIa2ylfhN/iZcCSRU4D2szrhWWtsGrrY7fa++4bCJV8qDtckekCkdm
 b3j/qJkQGetvjoNsqKi1ok53/ToV7gZghqfV+GEAqig+DZtMWBAuiswl1UgnR7O3/hA6 wA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5nkqc3a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:12:55 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IICsH0024143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:12:54 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 10:12:54 -0800
Date:   Wed, 18 Jan 2023 10:12:52 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK
 binding
Message-ID: <20230118181252.GC3322341@hu-bjorande-lv.qualcomm.com>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <20230113041132.4189268-2-quic_bjorande@quicinc.com>
 <20230117180058.GA3314512-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230117180058.GA3314512-robh@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j4FepsETTAT2pHP7BWO3SeDm-EQS5guX
X-Proofpoint-ORIG-GUID: j4FepsETTAT2pHP7BWO3SeDm-EQS5guX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=918 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:00:58PM -0600, Rob Herring wrote:
> On Thu, Jan 12, 2023 at 08:11:29PM -0800, Bjorn Andersson wrote:
[..]
> > +patternProperties:
> > +  '^connector@\d$':
> > +    $ref: /schemas/connector/usb-connector.yaml#
> > +
> > +    properties:
> > +      reg: true
> 
>        required:
>          - reg
> 
> Or '@\d' needs to be optional.
> 

You're right, and as the identifier is significant in the firmware
interface I'll add it as required.

Thanks,
Bjorn
