Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B473723FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjFFKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjFFKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:34:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71BE42;
        Tue,  6 Jun 2023 03:34:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3567GQVM002049;
        Tue, 6 Jun 2023 10:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=i9Rvne1JjTYZ/ypfVKCw95t74IgXT4Np+ksPCaAY24k=;
 b=Tie28ARwQLbryfYKumOz5+aJdQxAspVYZwGvIja6JmbOmSlEnjpnTkzfq4LUzkTjP/xG
 hSeu3jQE6OMHPnjzmoHCfSey8cnoQy8/DOs0z8jzL3RhVmYDWZJ4KZwvPZ3sEBTUVvbY
 YdTlKLklNaiA4aR17AOIkH+JTkihhcg9D9rjYOnPcnNeNkpEZ/jIT9LuvkwerMSemLbu
 rmztMo9oViKPpfupyGDMsWMWwftTNulXJMANDkdXuHfREKSVD3dom8MElxnZvNFumz8X
 rx42/HHiZI5KsdOcQengNB1hzrOOh6Tc2EnK99inHnhcwPg0Mk5brT8eXYLW1GRWlQ5x JQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1s4uh5r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 10:33:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356AXwCb026081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 10:33:58 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 03:33:53 -0700
Date:   Tue, 6 Jun 2023 16:03:49 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] Enable IPQ9574 TSENS support
Message-ID: <20230606103349.GA675@varda-linux.qualcomm.com>
References: <cover.1685703605.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1685703605.git.quic_varada@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xTn3_lGA0rZMujC2FP7xnrbhfsZgpH54
X-Proofpoint-GUID: xTn3_lGA0rZMujC2FP7xnrbhfsZgpH54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=954 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 04:33:49PM +0530, Varadarajan Narayanan wrote:
> This patch set enables tsens in IPQ9574
>
> Depends on
> 	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
> [v5]:
> 	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors without removing existing entries
>
> [v4]:
> 	Drop the sm6375-tsens and qcm2290-tsens related bindings
> 	fix as it is already posted
>
> 	Remove unnecessary changes from previous version
>
> [v3]:
> 	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors
>
> [v2]:
> 	Drop the driver change (https://lore.kernel.org/lkml/b45d33d38a334aabbd52c83b0d6028af1f4c74c8.1682682753.git.quic_varada@quicinc.com/)
> 	since the tsens device is compatible with 8074's tsens
> 	and use 8074's compatible itself
>
> 	Rename clusterX nodes as cpussX
>
> [v1]:
> 	Fix DT node names
>
> [v0]:
> 	Initial patch introducing TSENS support
>
> Praveenkumar I (1):
>   dt-bindings: thermal: tsens: Add ipq9574 compatible
>
> Varadarajan Narayanan (2):
>   arm64: dts: qcom: ipq9574: add tsens node
>   arm64: dts: qcom: ipq9574: add thermal zone nodes
>
>  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   6 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 218 +++++++++++++++++++++
>  2 files changed, 224 insertions(+)
>
> --
> 2.7.4
>

Bjorn,

Can this series be taken for 6.5?
All comments have been addressed.

Thanks
Varada
