Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C95629833
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKOMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKOMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:10:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5BF205;
        Tue, 15 Nov 2022 04:10:16 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFBp4JD024603;
        Tue, 15 Nov 2022 12:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=OiEtkInJN1H+cUbk1AcUr0St1ccwdHQqzyvzbPnaXeU=;
 b=Z4JVjEdUPnTVvZgDSxTz9nXkOjV0iOgKc5ki/YhoY+HdyPL2WmqlcnHa3ExnULxfwO/v
 bZiTfSiATRrdfhuXtiJW7Q2Qdo+uSO9IXtFp/6iawkPGN5K/FrNl/9IybvTs2FeYJLpV
 RYGqiKhCJu9CeVAJ1/N3nV/dW9NpFgZ5oGNWuWnx0j6+MHKF+4EuYljxbzTij39WDwFH
 nhkMhCJE00tqWq4+x4onWA4soUs+m3e+Wh3e1YGgiH4pkMJY/bVGtKNmfOvY8emXKetD
 M4QongdkX9LwA6rA1Ze1KF2nDRlpEuO2XsTID1dlmsDtl17Gd63kE39+JLnac079vG1v LQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kv4yf1mnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:10:12 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFCA8OP024583;
        Tue, 15 Nov 2022 12:10:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kt4jkds70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Nov 2022 12:10:08 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFCA71p024578;
        Tue, 15 Nov 2022 12:10:07 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AFCA7QZ024577;
        Tue, 15 Nov 2022 12:10:07 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 9CADA900889; Tue, 15 Nov 2022 17:40:06 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 0/1] Fix for H265 decoding failure .
Date:   Tue, 15 Nov 2022 17:40:03 +0530
Message-Id: <20221115121004.28197-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TzVjGWPUQtuoiMSH39exatFh2VbUZJL5
X-Proofpoint-ORIG-GUID: TzVjGWPUQtuoiMSH39exatFh2VbUZJL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=974 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Fixed the buffer size calculation mismatch with firmware requirements.
Tested  on v5.15 and v5.4 kernels .
For testing utilised the chrome utilities .


Viswanath Boma (1):
  venus : Fix for H265 decoding failure.

 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

