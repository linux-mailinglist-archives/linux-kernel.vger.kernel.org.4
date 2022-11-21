Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEF631C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKUJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiKUJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:08:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1385EDC;
        Mon, 21 Nov 2022 01:08:27 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8QEW8008997;
        Mon, 21 Nov 2022 09:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=dN/1OORLXDrlZjcUzz/iXvTANCZiAd8xkDrk+zHW4pA=;
 b=AgcEVlua7hAsgrsGAq4gQFJW+Qf/YK/gP8yxKe3zYWZQHRQgkz58OPpF9qILR8MUTp7w
 fsU1ZbUqk4ShFdgOfhi4e2hLZdYp7R3nPI3H04KOPTEVTJ9Fdx8o1CI0XQ3NllYVniy4
 SojZmso1+neKXI4eqI44SUk+3oLUIpvJRuzxDubahEh582M30vtFz82bk49SPW2vYBf+
 R48dbUapzCBqjxq3QY3uQ5TqhVgKUaIlFjTw5rck8qn8PB62W+7OJ0dwNgVEVplHSNkk
 sU1VvXuseqTCi00sG+j3WaUBK6uVteWAP/gvlMoQmTeAErw5o1cJGWGZ5DpLEWrk38bv Tg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxraubyp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 09:08:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AL98JbC032742;
        Mon, 21 Nov 2022 09:08:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3kxr7k3t7q-1;
        Mon, 21 Nov 2022 09:08:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AL98JXD032737;
        Mon, 21 Nov 2022 09:08:19 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AL98J3u032736;
        Mon, 21 Nov 2022 09:08:19 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 4939A349C; Mon, 21 Nov 2022 01:08:18 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [PATCH v4 0/3] add color management support for the crtc
Date:   Mon, 21 Nov 2022 01:08:12 -0800
Message-Id: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m01uVsgwOT6c2IUr64XUT93OOfpZtC0h
X-Proofpoint-ORIG-GUID: m01uVsgwOT6c2IUr64XUT93OOfpZtC0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=563 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210071
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add color management support for the crtc provided there are
enough dspps that can be allocated from the catalog

Kalyan Thota (3):
  drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
  drm/msm/disp/dpu1: add helper to know if display is builtin
  drm/msm/disp/dpu1: add color management support for the crtc

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  5 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  5 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 33 +++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 24 ++++++++++++++-------
 5 files changed, 60 insertions(+), 13 deletions(-)

-- 
2.7.4

