Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E56F0CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbjD0T4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0T4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:56:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3C26BE;
        Thu, 27 Apr 2023 12:56:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIu9mG030617;
        Thu, 27 Apr 2023 19:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=MKO5YUBbdKYU/+/8wr7vYHMx2PmNWLsN+ARcXKBVVd0=;
 b=FIY5QQd4123Yi2e9+2sBPHaMD+kIk5qceZt57QCbgkjyJkYOXZKu4v0EMg5a388oZHqg
 ECivY1KxrdfZnq/anB83pV+OPgZlwtlR9Ateoe3PXZ72W9UJXvgiN0y2REe4+xiw20lX
 rd7w1dWqDXr/6nTDgKP3Xja30oVB2La/XsTxWq1AXnaC/PS8cs9Ez1TTTs69irulai2a
 If8lFWAYSzASgF8muGzsaBTkKGTJqn59MUUOkkLG8MFRLBbEnoH3BaI79ur8138MATbY
 Kk97I9/nEB6gh3ehwqRGX3VAnXI0+9SrZThjQLV3HfmsOKkTUqB3JjCEgLqsPOJ4JFc8 mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7q9ahdws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:55:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33RJtk2d019850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:55:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 12:55:46 -0700
Date:   Thu, 27 Apr 2023 12:55:45 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
Message-ID: <20230427195545.GC870858@hu-bjorande-lv.qualcomm.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-6-quic_bjorande@quicinc.com>
 <CAJB8c04ah3YfK2VGxDhHMHK4KVJ7kZQv0b5JfPBu7jOk3mFQRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJB8c04ah3YfK2VGxDhHMHK4KVJ7kZQv0b5JfPBu7jOk3mFQRA@mail.gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wR14JqRWEtxqZ4s1lXOzmaAvpdJ6QQMp
X-Proofpoint-ORIG-GUID: wR14JqRWEtxqZ4s1lXOzmaAvpdJ6QQMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:33:40AM +0100, Bryan O'Donoghue wrote:
> On Tue, Apr 25, 2023 at 4:40 AM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
> >
[..]
> You need to add some or all of these
>        select DRM_DISPLAY_DP_HELPER
>        select DRM_DISPLAY_HELPER
>        select DRM_DP_AUX_BUS
>        select DRM_KMS_HELPER
>        select DRM_MIPI_DSI
>        select DRM_PANEL
> 
> 
> /opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> Unexpected GOT/PLT entries detected!
> /opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> Unexpected run-time procedure linkages detected!
> drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function
> `qmp_combo_bridge_attach':
> phy-qcom-qmp-combo.c:(.text+0xb50): undefined reference to
> `devm_drm_of_get_bridge'
> phy-qcom-qmp-combo.c:(.text+0xb6c): undefined reference to `drm_bridge_attach'
> drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function `qmp_combo_probe':
> phy-qcom-qmp-combo.c:(.text+0x13fc): undefined reference to
> `devm_drm_bridge_add'
> 

You're correct, and TYPEC. Realized that I forgot these once I had
posted the patches. Will figure out the actual set for v2.

Thanks,
Bjorn
