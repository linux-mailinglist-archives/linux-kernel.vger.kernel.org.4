Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3336EE93D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbjDYUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjDYUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:49:26 -0400
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A6146D3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:49:25 -0700 (PDT)
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PJbZal013033
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=2SpjziBxMinJvCqJ5ONrJCSYQ5/Fm7e8HW8ZmGTQ0IU=;
 b=0vIGuUYyFUuWH/Nutk4PhpqX4jK95ddw5GduakQ5sVerOsqGgARbOv/GhETVNXtmmDBH
 PSqKCf2cJSaXjndQKHZguU4qYgRC/ZgYMyQ1OMicV0C6e2vOLXDZsMXVAnJpjdNiO9oy
 3kU3L3dUfXVr4SI8Yb8Bawhhqw22KXiUcR662IsFLShgEgto9J7KKAkCw1iSjiTt4xOK
 Hm5sAa5/63Fcm/YSpdT5gs1mKeCieKuePgfQZx5IQKlCi7AtiJfHnwU39CNcjv+i0fUC
 L6Peffl/R1i3GTAPGN0QFkwe0PHuY1+EuayYJKczL8Of1pTnbH8UaKrUoSgK87aBO8YR ag== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q6n6f913f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:49:24 -0400
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef35d8acc0so86497921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455764; x=1685047764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SpjziBxMinJvCqJ5ONrJCSYQ5/Fm7e8HW8ZmGTQ0IU=;
        b=Oidw4EMJbkT1TZ3lDuOlAMqHp+SVBLoSJ+hOseORF/uS5EVVqTJASopOmGZk1XCByq
         PIwqhsNz4UjwUweWI8BY3CSkr++FCawoRXw+jOcy/QMlNk7QsgJGJZ25+b2+zETXq1Zw
         Cp0LkFkxjD6zao/7vnUlZqi/X0VG+5DUQN13ByvtRphnYjOsLIQU5O4FlTXl2qANII3b
         Zi5b51IWNpMIyts8+1q1Rl+Fqn2Q6FajDEE7+18tJrykRr4xj+NT3EksXK3/V5cRUaU5
         YxKSZsTJrYqXlesnXM69zzzwkA3NpIBQ/1Q2EYwkvHBFS8Xi6qUBC0xNUXLHAA2dTLzz
         wFtg==
X-Gm-Message-State: AAQBX9e8Zl2KR9S3e2vGpOSo27xwVIUL8FOcwZBWj8O6wzp+zHtCFp0P
        xQUIPqzkBsiCOKak/HbOeqwi9ADqOmr3zJgh8WhMAnWB3UO4VD/NLC5+AzIIOH/BCAdfg1YYxnx
        3auF8zSVTIdyTBRhpd8ND4Gc=
X-Received: by 2002:ac8:5915:0:b0:3d9:45a4:e7b9 with SMTP id 21-20020ac85915000000b003d945a4e7b9mr31977216qty.45.1682455764159;
        Tue, 25 Apr 2023 13:49:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350b6F5UbwNqQllo6hDifdFdxhv68oGQoFJyHsJCyuacxs20tvumkml1OVP7Ld/N1FQaqGqKMMg==
X-Received: by 2002:ac8:5915:0:b0:3d9:45a4:e7b9 with SMTP id 21-20020ac85915000000b003d945a4e7b9mr31977193qty.45.1682455763915;
        Tue, 25 Apr 2023 13:49:23 -0700 (PDT)
Received: from enviable.nyu.edu (216-165-95-139.natpool.nyu.edu. [216.165.95.139])
        by smtp.gmail.com with ESMTPSA id h2-20020a05620a21c200b0074636e35405sm4626821qka.65.2023.04.25.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:49:23 -0700 (PDT)
From:   Jonathan Singer <jes965@nyu.edu>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jonathan Singer <jes965@nyu.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: hp-wmi: Add camera toggle switch to HP WMI
Date:   Tue, 25 Apr 2023 16:46:42 -0400
Message-Id: <20230425204643.11582-1-jes965@nyu.edu>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LZnF-5qOPEZJS2bHP1bGueN_RjfQNdES
X-Proofpoint-GUID: LZnF-5qOPEZJS2bHP1bGueN_RjfQNdES
X-Orig-IP: 209.85.160.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 bulkscore=0
 mlxlogscore=669 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304250185
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when the camera toggle switch was hit, the hp-wmi driver
would report an invalid event code. By adding a case for that in the
event handling switch statement we can eliminate that error code and
enable a framework for potential further kernel handling of that key.
This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
would likely work for any HP laptop with a camera toggle button.

Signed-off-by: Jonathan Singer <jes965@nyu.edu>
---
 drivers/platform/x86/hp/hp-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 873f59c3e280..b27362209b04 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
 	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
 	HPWMI_SANITIZATION_MODE		= 0x17,
+	HPWMI_CAMERA_TOGGLE		= 0x1A,
 	HPWMI_OMEN_KEY			= 0x1D,
 	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
 };
@@ -866,6 +867,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		break;
 	case HPWMI_SANITIZATION_MODE:
 		break;
+	case HPWMI_CAMERA_TOGGLE:
+		break;
 	case HPWMI_SMART_EXPERIENCE_APP:
 		break;
 	default:
-- 
2.40.0

