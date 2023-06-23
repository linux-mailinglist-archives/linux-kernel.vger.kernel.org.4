Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3873BEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFWS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFWS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:58:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73491FCE;
        Fri, 23 Jun 2023 11:58:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NHScY6006660;
        Fri, 23 Jun 2023 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=nn4S/UTExuHhumcH/0O3TdCgnEhlwonUpMWQlXPcsag=;
 b=AuRGSPZ1kIgbVyuyxgz0P+l7O+Oo4P7hSzK03DGA3UflttuuNxQhqGy4nidfuIuKbdaV
 4WSE9ffYQK/LzQAY9F6d/HuGVwienKigANDMVw7sk3zjKjpW3VvdRYimg3wDHNJ6iim3
 ilqrcnAUNAfNJoDTydFhlj0cntwP3nASmrHdvL1zBLhMnDItMdX5GwSdAxONiUAy84fw
 vm//efnHxHnQIp1M5H+BCDRkjiYx6vGzFcmvjqmtcxR4XLI0X8oaeavKU7acYKkxKt85
 n6Acb9DnoUCpE3IPONRZMGpXNyWQnJ158VYVRXhFuf+voOxmzhX7bwF/Y8RK86/91Ajf TQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcju849gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 18:58:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NIwGA1007065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 18:58:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 11:58:15 -0700
Date:   Fri, 23 Jun 2023 11:58:14 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <neil.armstrong@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        "Mike Tipton" <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH v2 0/4] interconnect: qcom: rpmh: sm8550: mask to send as
 vote
Message-ID: <20230623185814.GA1775967@hu-bjorande-lv.qualcomm.com>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
 <5b68b9ba-157b-067c-3926-9c5ecfecc311@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b68b9ba-157b-067c-3926-9c5ecfecc311@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F3a5MqwWTQUBSzATLVutSExqQXBtZ2A_
X-Proofpoint-GUID: F3a5MqwWTQUBSzATLVutSExqQXBtZ2A_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306230169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 03:58:09PM +0200, Konrad Dybcio wrote:
> On 23.06.2023 14:50, neil.armstrong@linaro.org wrote:
> > On the SM8550 SoC, some nodes requires a specific bit mark
> > instead of a bandwidth when voting.
> > 
> > Add an enable_mask variable to be used instead of bandwidth.
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> After reviewing this patchset and taking a peek at older downstream,
> it looks like ACV should be using 0x8 bmask on *all RPMh SoCs*.
> 
> It's worth noting however, that 8350's downstream (the first msm
> kernel using the icc framework) did not incorporate that change.
> Not sure if intentionally or not. Probably not. Might be worth to
> poke Qcom to backport it in such case. If 8350 is still supported.
> Probably not.
> 

Your observation is correct.

But, note further that command db reports ACV to have data-width of 0,
resulting in the numerator, and thereby vote_x and vote_y always being
0.

This is downstream worked around by:
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/4d2818084015df1e05274ebcc5a0d21e6d256f93

Which should cause vote_x and vote_y to be non-zero. However without
this series (and enable_mask defined for ACV on all platforms) the votes
placed in the BCM would then be garbage...



That said, unless I'm missing something the math involved here is
unnecessary.For BCMs with enable_mask, if for any node sum_avg[bucket]
or max_peak[bucket] is non-zero then the calculated vote_x and vote_y
comes out non-zero and we write the mask, otherwise 0.

Rewritten to avoid all the unnecessary multiplication and divisions, we
wouldn't care about the unit or width and thereby don't need above
referenced patch.


A further tangent here is that a BCM with enable_mask != BIT(0) but
keepalive set, a 0-bandwidth vote in AMC would result in an invalid
(undefined?) BCM value being written out in the snippet below the loop.

> Check out these snippets:
> 
> https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L556-567
> 
> https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L475-495
> 
> Notice how acv is never updated beyond effectively setting =0 or =bmask,
> perhaps Qualcomm never implemented something else..
> 
> Since this series is fine as-is, I'd be happy to see an incremental one.
> Reported-by would be cool as well :D

I agree, let's get this merged, backported to stable, and then fix ACV
handling in a follow up commit (which doesn't necessarily need to hit
stable).

You should have a Jira card for this one already, but I don't mind
sharing the Reported-by with you ;)

Regards,
Bjorn

> 
> Konrad
> > Changes in v2:
> > - Took downstream patch for patch 1
> > - Added konrad's reviewed tag
> > - Added changes for sm8450 and sa8775p
> > - Link to v1: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org
> > 
> > ---
> > Mike Tipton (1):
> >       interconnect: qcom: Add support for mask-based BCMs
> > 
> > Neil Armstrong (3):
> >       interconnect: qcom: sm8450: add enable_mask for bcm nodes
> >       interconnect: qcom: sm8550: add enable_mask for bcm nodes
> >       interconnect: qcom: sa8775p: add enable_mask for bcm nodes
> > 
> >  drivers/interconnect/qcom/bcm-voter.c |  5 +++++
> >  drivers/interconnect/qcom/icc-rpmh.h  |  2 ++
> >  drivers/interconnect/qcom/sa8775p.c   |  1 +
> >  drivers/interconnect/qcom/sm8450.c    |  9 +++++++++
> >  drivers/interconnect/qcom/sm8550.c    | 17 +++++++++++++++++
> >  5 files changed, 34 insertions(+)
> > ---
> > base-commit: 47045630bc409ce6606d97b790895210dd1d517d
> > change-id: 20230619-topic-sm8550-upstream-interconnect-mask-vote-96aa20355158
> > 
> > Best regards,
