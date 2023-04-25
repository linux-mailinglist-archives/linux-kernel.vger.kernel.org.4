Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755186EE989
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjDYVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjDYVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:21:47 -0400
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A21358D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:21:46 -0700 (PDT)
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PHiuCT018357
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=2SpjziBxMinJvCqJ5ONrJCSYQ5/Fm7e8HW8ZmGTQ0IU=;
 b=NltmGxBw5oyCDqQgPx6Sv/Y0OUVsyRsh3xi58I1eE/xlkPE5zbVWtaF2wo0EfqJyz3aO
 en375iirgj5XlIO11PMiLH9pf9J+SrfQZ3prnn2XXs4shJoxJT9BSaWeU4+AzNmePE6Y
 ZZMX15Iliw3Yax/edPTyVLws71z6aZzWheJ3KhOulg7uJ/nb4yV3dxjGvmI+BcqaZ5/v
 6/7hoyOfmiCqYzk58ia9GEKpWWU8QzyaYD2b8+izuIipyo51Pb/c+ABPtjGvU9btEoco
 jij/giYeButPMiZZHMPeU1uRddqamr6/TmRS7vSyxu2ygE51dNFKJ98WgTOquDWA1hPA vw== 
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q6jaq3x3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:21:19 -0400
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef4ebcf172so74775816d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454078; x=1685046078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SpjziBxMinJvCqJ5ONrJCSYQ5/Fm7e8HW8ZmGTQ0IU=;
        b=jRyOstcvfcPVjd8l4cjAk5Qj65NagI6YZTdniZ4nXOJ04NINyyk1jBsXcDQeREL3TE
         3E85AhFPdExOgTfZZmB5VP17JFGOEzzPRsFGCpZauWwSte8+YqWa7eBDJEhhlFkmM8zc
         cZJPeyN0+ZwsPiGrK+sWgZKBb94rxbOvRiZMaxdxjcm5yOhn2QSTDLNQNneOnHxrbE/B
         uOU2dRjNndLtLbxm5N/2e6PZKYfNslL0mC3KLggn0oLv2z6mLRoOQA8ODHonu/pVDQ+J
         6g4toIlDOe3gVKPxCURNrHUjfUW0FcIxG6sxuBxzxBS8ODDc7U9EnR8R05SifRvZBw0J
         LONg==
X-Gm-Message-State: AAQBX9ew1+1ZVrqbganOymKb72QpUNVMei41OKnEPZ4EGXB/N0pERW5j
        O7WD1MOszBC9hdIq+ERiBS2KKX8GnXpDAGu2eU4ax8PloAwn9VGK0xqKX+pgD63eXaDnNfMD/mk
        57R/6+CGI9KwCMknrTaKX4IM=
X-Received: by 2002:a05:6214:240c:b0:5dd:aee7:dffb with SMTP id fv12-20020a056214240c00b005ddaee7dffbmr35019601qvb.22.1682454078412;
        Tue, 25 Apr 2023 13:21:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350bHn4obS6vlyRZW6yWoCDcG+7xnvKnFW0oXHlgMKJyEXGo6kzWVIpSAdvkrzhHKW9ZbzuuG2A==
X-Received: by 2002:a05:6214:240c:b0:5dd:aee7:dffb with SMTP id fv12-20020a056214240c00b005ddaee7dffbmr35019571qvb.22.1682454078160;
        Tue, 25 Apr 2023 13:21:18 -0700 (PDT)
Received: from enviable.nyu.edu (216-165-95-139.natpool.nyu.edu. [216.165.95.139])
        by smtp.gmail.com with ESMTPSA id p13-20020a0cf54d000000b005ea34e69373sm4339822qvm.37.2023.04.25.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:21:17 -0700 (PDT)
From:   Jonathan Singer <jes965@nyu.edu>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jonathan Singer <jes965@nyu.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Bedant Patnaik <bedant.patnaik@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: hp-wmi: Add camera toggle switch to HP WMI
Date:   Tue, 25 Apr 2023 16:20:36 -0400
Message-Id: <20230425202038.7403-1-jes965@nyu.edu>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bSbxHMmqwyd0LVi--wJeNTV7qibCcRrT
X-Proofpoint-ORIG-GUID: bSbxHMmqwyd0LVi--wJeNTV7qibCcRrT
X-Orig-IP: 209.85.219.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=669
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304250182
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

