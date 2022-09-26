Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9D5EAE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIZRhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIZRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:37:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EABC0E;
        Mon, 26 Sep 2022 09:59:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QF0AF5025993;
        Mon, 26 Sep 2022 16:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+PHttfptqZAAP87O1z2h3TnIUx513ASyRdQuwlYwMHA=;
 b=Ux8pYaEgZDXjhNg75OM3feddd8HqkSAHV0qJ4D3FmHBEGHr3iPxhGmyjf/HHEIJb7Pl6
 FxxQPuWrWSlB5Ydz/3IsxchZ8yg0MM4axPKoVrxKtJ4a/ZNaev6A3E1cv5/02MIrnFhG
 32j1SNxqKU0cuswr/KfEaVllCDrHHJJ6TUQOVo3o0s8rvlFMQFovjHhBTZZEO4ncQ/SL
 XcMtU622xTY3uS81lNtDm6L53GUj01v07HiI4bpbpz7p53MiqkG1g5yoCIb2FuNf2HEh
 hTFKxudpPOn3TGCuock/P4nGRK5wRwaF3xamwI7IYf0Mg2pm9Xmv9xTdMSiWRfeRlDUd mw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jue008dts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 16:59:06 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QGx6UO010843
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 16:59:06 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 09:59:05 -0700
Date:   Mon, 26 Sep 2022 09:59:04 -0700
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
Message-ID: <20220926165904.GA17938@quicinc.com>
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <20220924000932.GA1450@quicinc.com>
 <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8opTOlmVR14iX-kUQiFXEJInD6HMrkME
X-Proofpoint-ORIG-GUID: 8opTOlmVR14iX-kUQiFXEJInD6HMrkME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=872 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24 2022 10:17, Krzysztof Kozlowski wrote:
> On 24/09/2022 02:09, Guru Das Srinagesh wrote:
> > On Sep 21 2022 20:43, Konrad Dybcio wrote:
> >> Does it? I did not define this compatible in the driver, so it does
> >> not consume any clocks.
> > 
> > The bindings should describe only those compatibles that the driver supports -
> > that is, both the driver and its bindings should be in sync.
> 
> That's not entirely true. Bindings describe the hardware in the most
> complete way we can. Not the driver. Whether driver supports something
> or not, is not relevant here, except that we don't want to document
> non-existing things or stuff out of tree.

Is this only applicable to compatibles or device tree properties in general?

> > 
> > Could you please update the driver with this compatible as well? Let's not
> > merge this change without that first.
> 
> This could be even merged without change in the driver. However it's not
> the case here as driver already supports it, so your request is fulfilled.

My concern is that if somebody specifies a compatible/device tree property that
the driver doesn't support, their expectations from adding that change will not
be met. In addition to having the bindings describe HW in full, I think the
driver should also be in sync with it for this reason.

Thank you.

Guru Das.
