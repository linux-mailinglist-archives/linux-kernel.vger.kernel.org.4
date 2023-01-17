Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3266E35D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjAQQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAQQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:21:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265A3EFE0;
        Tue, 17 Jan 2023 08:21:39 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEbExR003566;
        Tue, 17 Jan 2023 16:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=cg96SnQCqORoWKdPdsLknlM+aptVO8mCOtYYDlx2JgY=;
 b=XmksmQGJat8kWnfxVIbK4EiyeHNk/px5J8lsPCZcwo7j1TlOTE88sTCmMGDF2JjqXpFD
 aB+tkfzk1Amogju1q6IF/NTqPP9roDku3zsUNew6aozUhFiJDFQ1JBAjzrNzEzqCnygj
 YDcuUDfcFHy+la0zS21tRHgbvnq70assq5edO1/ckN+0/k+kTY1HUWxeWoyhsHpxee9s
 A8TQZAGdgH4exJY+RTMSMUYutZNQJlDdlJjqTt+8lKxBK/UAahneMbDyBNV3hOD3SmSo
 v/AmqEU7aZZYwcn8npo5CMXmcET9ug224YXVsSIKfD0K9jNw2r3HtiCZ3w+zIjhr8tXX qA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nnyya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 16:21:36 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30HGLWG5014779;
        Tue, 17 Jan 2023 16:21:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3n3nfk7sum-1;
        Tue, 17 Jan 2023 16:21:32 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HGLWg1014774;
        Tue, 17 Jan 2023 16:21:32 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 30HGLVJ2014773;
        Tue, 17 Jan 2023 16:21:32 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id B31314B06; Tue, 17 Jan 2023 08:21:30 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [PATCH 0/3] Allow composer fallbacks for color features
Date:   Tue, 17 Jan 2023 08:21:25 -0800
Message-Id: <1673972488-30140-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cB_wSQ1_KLobwF_95PJA3bCadlxkTVGp
X-Proofpoint-ORIG-GUID: cB_wSQ1_KLobwF_95PJA3bCadlxkTVGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=530 phishscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170130
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will enable color features on sc7280 target which has primary panel as eDP

The series removes dspp allocation based on encoder type and allows the datapath reservation
even if dspps are not available.

The series also adds a check to fail the composition during atomic check , if color management is requested 
and no dspps are allocated in the datapath.

This can allow composer fallbacks for color features if no relevant HW blocks are available.

Kalyan Thota (3):
  drm/msm/disp/dpu1: allow reservation even if dspps are not available.
  drm/msm/disp/dpu1: allow dspp selection for all the interfaces
  drm/msm/disp/dpu1: fail atomic check if color feature is requested
    with no dspp

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 11 +++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 18 +++++++++---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  8 +++++++-
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.7.4

