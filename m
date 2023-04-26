Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E36EFA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjDZSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjDZSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:50:20 -0400
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F07DBD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:50:19 -0700 (PDT)
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QHOkd2016581
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=XV2wqMr3rLVla/Q1+jvkjZWpSpctS4mVbTncMGH1DqY=;
 b=bHSqJg7ez/I4TuVMByJuyx/BtBmqshlst/hFGwZ8/kD6uD5D58B6zSRZUaByNfkSTSxA
 2HbVLTEWh32RLdzG6eWh76D+lPmpjxMmJWwVoUnsYI0Rcmhr4wz0Gn9r4jglyekqqnf5
 cR1YgwBmpp86YNHL3meL9uKDjbLmFCFDFbzV38k8sP4zcYAaDkY2qN6Tb8I+JLmVPgV6
 xKKFFxVPQNh42TxmH74+aNHiHSH9fcJvnlkAa5EnBW2Yr4Ttm2ujruYQTYhIYzFQ2wop
 /BaO5AnLeXXBE+E3kCsOf5MdeIyixLTBpaELJTr078maMPVLyP66Sy3q02tSAdWgllV7 iA== 
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q60k87vxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:50:19 -0400
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ed2ac02709so46909411cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535018; x=1685127018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV2wqMr3rLVla/Q1+jvkjZWpSpctS4mVbTncMGH1DqY=;
        b=lLm8myY2WhPlCp+CiJlQmfRIDbi5LPXLreoQ4VfP9rSnsaTJl0Jg2TH9Unxse6PPmp
         VlnKv2IPdNla346+KbbaoMD5RCDjLQdgfM5B+7IiU9LWZIo/srENevNVLqLYjYxs9dlD
         mTk3nsSw8ZpF/cWq57JhCcqW6nDaUxFvcKsT9VSDYh0xyeNiAM6r6+r+OZKGAA0NyL5K
         zG76jR3ibkNaZACvbhxeIO55MbNclGb3KRDbzrAfspy2EnWAgr1pF5dEv3JoiKcPbS57
         yiwXljwM3rzr/MtzKmlJhh/Yho0iUxzXuuMhjz43G1i2rXO41VhKdd0afrpqAWbO5aFW
         mbeQ==
X-Gm-Message-State: AAQBX9dHmBlMglpKdncIset68u5TbxHypHwacvVHaNwdpWJq11kHcYFy
        p9qgcN0Y0ztbmdAsEer965hCKiSfP9UI49gBRqKcvYbngAQPNilOTUQnlPdehX+xx5XgMVZuSZc
        LEqumpFHAYN4919KK2FGlkxs=
X-Received: by 2002:ac8:4e4c:0:b0:3e1:59e8:744c with SMTP id e12-20020ac84e4c000000b003e159e8744cmr36267942qtw.13.1682535017880;
        Wed, 26 Apr 2023 11:50:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bpUAwWS6FzTmvw/jZeyQJ4yw19CgN2t92yeJFla8/OubC04yb0TWI3d1ER5r21rPsJ9tzcMA==
X-Received: by 2002:ac8:4e4c:0:b0:3e1:59e8:744c with SMTP id e12-20020ac84e4c000000b003e159e8744cmr36267918qtw.13.1682535017633;
        Wed, 26 Apr 2023 11:50:17 -0700 (PDT)
Received: from enviable.nyu.edu (216-165-95-156.natpool.nyu.edu. [216.165.95.156])
        by smtp.gmail.com with ESMTPSA id 206-20020a3705d7000000b007469b5bc2c4sm5373476qkf.13.2023.04.26.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:50:17 -0700 (PDT)
From:   Jonathan Singer <jes965@nyu.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jonathan Singer <jes965@nyu.edu>
Subject: [PATCH v3 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Date:   Wed, 26 Apr 2023 14:48:52 -0400
Message-Id: <20230426184852.2100-1-jes965@nyu.edu>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6eoRBDlY2r1CIGEnaaXgENM6ncg82bTG
X-Proofpoint-GUID: 6eoRBDlY2r1CIGEnaaXgENM6ncg82bTG
X-Orig-IP: 209.85.160.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260167
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

Previously, when the camera toggle switch was hit, the hp-wmi driver
would report an invalid event code. By adding a case for that in the
event handling switch statement we can eliminate that error code and
enable a framework for potential further kernel handling of that key.
This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
would likely work for any HP laptop with a camera toggle button. Now
we emit an SW_CAMERA_LENS_COVER event, on a device that gets created
on the first such event so as to not report incorrectly the state of
the camera shutter before we can know its state.

Signed-off-by: Jonathan Singer <jes965@nyu.edu>
---
V2 changes: Added SW_CAMERA_LENS_COVER switch event
V3 changes: removed input dev sync, changed pr_info to pr_err/pr_warn

 drivers/platform/x86/hp/hp-wmi.c | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 873f59c3e280..18d40270aa0d 100644
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
@@ -228,6 +229,7 @@ static const struct key_entry hp_wmi_keymap[] = {
 };
 
 static struct input_dev *hp_wmi_input_dev;
+static struct input_dev *camera_shutter_input_dev;
 static struct platform_device *hp_wmi_platform_dev;
 static struct platform_profile_handler platform_profile_handler;
 static bool platform_profile_support;
@@ -739,6 +741,33 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static int camera_shutter_input_setup(void)
+{
+	int err;
+
+	camera_shutter_input_dev = input_allocate_device();
+	if (!camera_shutter_input_dev)
+		return -ENOMEM;
+
+	camera_shutter_input_dev->name = "HP WMI camera shutter";
+	camera_shutter_input_dev->phys = "wmi/input1";
+	camera_shutter_input_dev->id.bustype = BUS_HOST;
+
+	__set_bit(EV_SW, camera_shutter_input_dev->evbit);
+	__set_bit(SW_CAMERA_LENS_COVER, camera_shutter_input_dev->swbit);
+
+	err = input_register_device(camera_shutter_input_dev);
+	if (err)
+		goto err_free_dev;
+
+	return 0;
+
+ err_free_dev:
+	input_free_device(camera_shutter_input_dev);
+	camera_shutter_input_dev = NULL;
+	return err;
+}
+
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
@@ -866,6 +895,20 @@ static void hp_wmi_notify(u32 value, void *context)
 		break;
 	case HPWMI_SANITIZATION_MODE:
 		break;
+	case HPWMI_CAMERA_TOGGLE:
+		if (!camera_shutter_input_dev)
+			if (camera_shutter_input_setup()) {
+				pr_err("Failed to setup camera shutter input device\n");
+				break;
+			}
+		if (event_data == 0xff)
+			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 1);
+		else if (event_data == 0xfe)
+			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 0);
+		else
+			pr_warn("Unknown camera shutter state - 0x%x\n", event_data);
+		input_sync(camera_shutter_input_dev);
+		break;
 	case HPWMI_SMART_EXPERIENCE_APP:
 		break;
 	default:
@@ -1564,6 +1607,9 @@ static void __exit hp_wmi_exit(void)
 	if (wmi_has_guid(HPWMI_EVENT_GUID))
 		hp_wmi_input_destroy();
 
+	if (camera_shutter_input_dev)
+		input_unregister_device(camera_shutter_input_dev);
+
 	if (hp_wmi_platform_dev) {
 		platform_device_unregister(hp_wmi_platform_dev);
 		platform_driver_unregister(&hp_wmi_driver);
-- 
2.40.0

