Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8446EFA51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjDZSuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjDZSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:50:44 -0400
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0BD7EEC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:50:39 -0700 (PDT)
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIQoqh011660
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180315;
 bh=tz6yrnf+dTN5LZdbLmwKWiSYYpiy3j5Ue6bS4NbkEBg=;
 b=hYKHC94D2uj85bsIJ0MlNmhNPcIr3/LoYiawSIm8QzYIc5NMYxolKV9LoYk/PBm6o55T
 FQQq8hC/OrJAabGkiyQSSBAVuzItA/sogNwYOvAwNjVQBg4CKMc2sY39quEgGppM9vQN
 jl/vtfk0oLIFJt6DULmUQwMp/H2kRiEI2CPwYWx6tQo/nfdINQKB8RqKpP2zdr/FzQeE
 sp88rKGxhD5v9a0AumrDut17mnJouMvw6HR0ml1MTLjBHo4tGyx3bEuGRRij8y3ycaZT
 Ypf1qzCeqF2dIuF9wzJeJgV15/EX5HMVrWyBKN/gZdfJ4gl7gC/AbwYKrJa7Nj8MlpiS gg== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q4vkkedjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:50:39 -0400
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef30a89abbso49048371cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535038; x=1685127038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz6yrnf+dTN5LZdbLmwKWiSYYpiy3j5Ue6bS4NbkEBg=;
        b=KAbUO1IUtK4v/5qaPvH0T9OuK1APsIsdmSoK/06C8wL/BEColWzGjp6k+t6z2BKJIo
         duNT6SxAZvSb/yWxbmJXLdrS4s+M/EpLAfQpG1ReXj1T7iCqjN/hzlD9l9u4shcYfEW9
         mjBp/hu4vUZa2SD2m5SnYVrCkbVTr0h3YlTnovRwfKe5yMrbm0bHqQBT0OyxORc8//l3
         g8W4ZWlsjb4jbwZyqpA5FnlRrBhlepaiZV9TRIuZUVgUa37jooRh/SqviHW99kAqpXvK
         mJYmoj88Ns5Waeh0whaBeva4GIQOBBjcGTE3NmPwnUuShXiM5jIy06yQ7O/RiGtEk0V8
         IQVA==
X-Gm-Message-State: AAQBX9eXKGPyu1M8HGIQt+wqAiXP43N/ft91PmVcrWOa4gm8l2afD6ih
        ErdXH0hJWbdMXctTmqcPZDSA3ZWh78+FalB2aR6g7cyqzv6F/vFETqHMAkltyj9N9m/bmHBOCat
        g47mi/SacWmAYiZopUSAlZyA=
X-Received: by 2002:ac8:5f87:0:b0:3e3:7e6f:423c with SMTP id j7-20020ac85f87000000b003e37e6f423cmr35438900qta.34.1682535038288;
        Wed, 26 Apr 2023 11:50:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAbNMSNv3vXSvimA1YFuF+ofgEQxxujSpwrw7k8sY4TA3t9c1ebic7COYrEyM7LyyyAXqHaA==
X-Received: by 2002:ac8:5f87:0:b0:3e3:7e6f:423c with SMTP id j7-20020ac85f87000000b003e37e6f423cmr35438881qta.34.1682535038039;
        Wed, 26 Apr 2023 11:50:38 -0700 (PDT)
Received: from enviable.nyu.edu (216-165-95-156.natpool.nyu.edu. [216.165.95.156])
        by smtp.gmail.com with ESMTPSA id 206-20020a3705d7000000b007469b5bc2c4sm5373476qkf.13.2023.04.26.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:50:37 -0700 (PDT)
From:   Jonathan Singer <jes965@nyu.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jonathan Singer <jes965@nyu.edu>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/2] platform/x86: hp-wmi: Add HP Envy special key support
Date:   Wed, 26 Apr 2023 14:48:54 -0400
Message-Id: <20230426184852.2100-2-jes965@nyu.edu>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426184852.2100-1-jes965@nyu.edu>
References: <20230426184852.2100-1-jes965@nyu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZhmzCl2DxJnkxT-VU2HN2XCVKasC-SSZ
X-Proofpoint-GUID: ZhmzCl2DxJnkxT-VU2HN2XCVKasC-SSZ
X-Orig-IP: 209.85.160.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260167
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, some support for certain keys on the HP keyboard has been
added already in commit 3ee5447b2048 ("platform/x86: hp-wmi: Handle Omen
Key event"), however this as tested did not allow even the fn+esc key on
my HP Envy which uses the same keycode on my HP Envy x360 laptop to work
--the keycode rather than being passed in as a separate int from WMI, was
being passed in as the event_data for the HPWMI_OMEN_KEY event.

This patch, as tested was able to properly get the keycode for fn+esc,
and for fn+f12 which is supposed to be a programmable key according to
HP's keyboard diagram and is thus mapped to KEY_PROG2. The fn+f8 key
combination (mute microphone) was a standard HPWMI_BEZEL_BUTTON key,
however it did not previously have an entry in the sparse keymap. This
patch preserves the original HPWMI_OMEN_KEY behavior for laptops that
use it by only taking the keycode from the event_data only when the
event_data is nonzero.

Signed-off-by: Jonathan Singer <jes965@nyu.edu>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
V2 changes: Removed confusing comment

 drivers/platform/x86/hp/hp-wmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 18d40270aa0d..2749433b713f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -212,6 +212,7 @@ struct bios_rfkill2_state {
 static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
 	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
 	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
 	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
@@ -222,6 +223,7 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_IGNORE, 0x121a4, }, /* Win Lock Off */
 	{ KE_KEY, 0x21a5,  { KEY_PROG2 } }, /* HP Omen Key */
 	{ KE_KEY, 0x21a7,  { KEY_FN_ESC } },
+	{ KE_KEY, 0x21a8,  { KEY_PROG2 } }, /* HP Envy x360 programmable key */
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
@@ -844,11 +846,20 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_SMART_ADAPTER:
 		break;
 	case HPWMI_BEZEL_BUTTON:
-	case HPWMI_OMEN_KEY:
 		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
 		if (key_code < 0)
 			break;
 
+		if (!sparse_keymap_report_event(hp_wmi_input_dev,
+						key_code, 1, true))
+			pr_info("Unknown key code - 0x%x\n", key_code);
+		break;
+	case HPWMI_OMEN_KEY:
+		if (event_data) /* Only should be true for HP Omen */
+			key_code = event_data;
+		else
+			key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
+
 		if (!sparse_keymap_report_event(hp_wmi_input_dev,
 						key_code, 1, true))
 			pr_info("Unknown key code - 0x%x\n", key_code);
-- 
2.40.0

