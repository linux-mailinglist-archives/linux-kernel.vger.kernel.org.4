Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF871882F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEaRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjEaRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:11:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA3133;
        Wed, 31 May 2023 10:11:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VETEqH032254;
        Wed, 31 May 2023 17:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=/Kj6AS/TnqEEItEU3nofU6kwgoDlOE903p9vfMYKykI=;
 b=ZWD3sSt7BgcyzgAFK8JZnIylD2R+K78r4EMNlQ9BCQvMSXC1PPLjvCpgw35d/fWgoJxf
 eKdRZSb6clwfO8Zv/YPKXppu0GB0KIFVoHO3aptjQ5So8TlEUjljf61iD7/2Tzk3NHLI
 IMP9G5h9GUCvg1c0irgUNRTpE40RFiBaSvTeOg4fBz2b/81J/Um7YV/yOz0gbPWPggiJ
 G3GvLKv0xPs9Rqq8V3k1Ba4TbBInNlFN8bIftHa33XfzmtxdY16G2PUwECZ9PNdIgX4d
 Dvk4G7zC3iRB4bNvbI4Nuqknsahk9lyrn4vW3WJT13Em28Hh4oRDirS7e/R/PNO/Xops Kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx81x8ehk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:11:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VHBUnr001235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:11:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 10:11:30 -0700
Date:   Wed, 31 May 2023 10:11:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <mani@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc8280xp: Add GPU related nodes
Message-ID: <20230531171129.GA112802@hu-bjorande-lv.qualcomm.com>
References: <20230531030945.4109453-1-quic_bjorande@quicinc.com>
 <20230531030945.4109453-3-quic_bjorande@quicinc.com>
 <ZHb3I6NUcjHZ64wD@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHb3I6NUcjHZ64wD@hovoldconsulting.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ziteT-qECaU_xNzTvlVnNvSsdwLrK-P3
X-Proofpoint-ORIG-GUID: ziteT-qECaU_xNzTvlVnNvSsdwLrK-P3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_12,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=720 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:28:35AM +0200, Johan Hovold wrote:
> On Tue, May 30, 2023 at 08:09:44PM -0700, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Add Adreno SMMU, GPU clock controller, GMU and GPU nodes for the
> > SC8280XP.
> > 
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v2:
> > - Added missing opp level (both gpu and gmu)
> > - Corrected opp-level for highest gpu opp
> > - Added dma-coherent to gpu smmu
> > 
> > Note that in order for the GPU driver to probe, the last change
> > requires:
> > https://lore.kernel.org/linux-arm-msm/20230410185226.3240336-1-dmitry.baryshkov@linaro.org/
> 
> That's a pretty well-hidden notice about a critical dependency. I just
> spent the morning debugging why this series broke the probe of the GPU
> and only saw this when I was going to report my findings.
> 
> Please consider putting information like this in the cover letter in the
> future.
> 
> > Changes since v1:
> > - Dropped gmu_pdc_seq region from &gmu, as it shouldn't have been used.
> > - Added missing compatible to &adreno_smmu.
> > - Dropped aoss_qmp clock in &gmu and &adreno_smmu.
> 
> Changelogs are also preferably placed in the cover letter so that you
> don't have to read through N patches to determine what changed from one
> revision of a series to the next.
> 

I've always put the changelog in the patches. But I can see the value of
using the cover-letter for that purpose. I will consider doing so...

Regards,
Bjorn
