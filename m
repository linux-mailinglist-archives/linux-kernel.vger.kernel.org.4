Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141386E1ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDNI5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Apr 2023 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDNI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:57:30 -0400
X-Greylist: delayed 694 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 01:57:27 PDT
Received: from gfmail2.glenfly.com (unknown [113.31.180.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D6D5B98
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:57:27 -0700 (PDT)
X-ASG-Debug-ID: 1681461947-196b9619469beb0001-xx1T2L
Received: from GFSHEXCH02.glenfly.com (GFSHEXCH02.glenfly.com [10.5.250.52]) by gfmail2.glenfly.com with ESMTP id 54d1DXRYsjdmbAuw; Fri, 14 Apr 2023 16:45:47 +0800 (CST)
X-Barracuda-Envelope-From: ReaperLi@glenfly.com
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.52
Received: from sqa-PC.glenfly.com (10.30.16.40) by GFSHEXCH02.glenfly.com
 (10.5.250.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 16:45:48 +0800
From:   ReaperLi <ReaperLi@glenfly.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.52
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, jasontao <jasontao@glenfly.com>
Subject: [PATCH] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.
Date:   Fri, 14 Apr 2023 16:50:55 +0800
X-ASG-Orig-Subj: [PATCH] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.
Message-ID: <20230414085055.27323-1-ReaperLi@glenfly.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.30.16.40]
X-ClientProxiedBy: GFSHEXCH02.glenfly.com (10.5.250.52) To
 GFSHEXCH02.glenfly.com (10.5.250.52)
X-Barracuda-Connect: GFSHEXCH02.glenfly.com[10.5.250.52]
X-Barracuda-Start-Time: 1681461947
X-Barracuda-URL: https://10.5.252.52:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at glenfly.com
X-Barracuda-Scan-Msg-Size: 4604
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0100
X-Barracuda-Spam-Score: 0.01
X-Barracuda-Spam-Status: No, SCORE=0.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107397
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jasontao <jasontao@glenfly.com>

Add a set of HD Audio PCI IDS, and the HDMI codec vendor IDs for
Glenfly Arise.

Signed-off-by: jasontao <jasontao@glenfly.com>
---
 sound/pci/hda/hda_intel.c  | 14 ++++++++++++++
 sound/pci/hda/patch_hdmi.c | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 77a592f21..6c4a559d9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -227,6 +227,7 @@ enum {
        AZX_DRIVER_ATI,
        AZX_DRIVER_ATIHDMI,
        AZX_DRIVER_ATIHDMI_NS,
+       AZX_DRIVER_GFHDMI,
        AZX_DRIVER_VIA,
        AZX_DRIVER_SIS,
        AZX_DRIVER_ULI,
@@ -349,6 +350,7 @@ static const char * const driver_short_names[] = {
        [AZX_DRIVER_ATI] = "HDA ATI SB",
        [AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
        [AZX_DRIVER_ATIHDMI_NS] = "HDA ATI HDMI",
+       [AZX_DRIVER_GFHDMI] = "HDA GF HDMI",
        [AZX_DRIVER_VIA] = "HDA VIA VT82xx",
        [AZX_DRIVER_SIS] = "HDA SIS966",
        [AZX_DRIVER_ULI] = "HDA ULI M5461",
@@ -1743,6 +1745,8 @@ static int default_bdl_pos_adj(struct azx *chip)
        }

        switch (chip->driver_type) {
+       case AZX_DRIVER_GFHDMI:
+               return 128;
        case AZX_DRIVER_ICH:
        case AZX_DRIVER_PCH:
                return 1;
@@ -1859,6 +1863,9 @@ static int azx_first_init(struct azx *chip)
        }
 #endif

+       if (chip->driver_type == AZX_DRIVER_GFHDMI)
+               bus->polling_mode = 1;
+
        err = pcim_iomap_regions(pci, 1 << 0, "ICH HD audio");
        if (err < 0)
                return err;
@@ -1959,6 +1966,7 @@ static int azx_first_init(struct azx *chip)
                        chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
                        chip->capture_streams = ATIHDMI_NUM_CAPTURE;
                        break;
+               case AZX_DRIVER_GFHDMI:
                case AZX_DRIVER_GENERIC:
                default:
                        chip->playback_streams = ICH6_NUM_PLAYBACK;
@@ -2724,6 +2732,12 @@ static const struct pci_device_id azx_ids[] = {
        { PCI_DEVICE(0x1002, 0xab38),
          .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
          AZX_DCAPS_PM_RUNTIME },
+       /* GLENFLY */
+       { PCI_DEVICE(0x6766, PCI_ANY_ID),
+         .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
+         .class_mask = 0xffffff,
+         .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
+         AZX_DCAPS_NO_MSI | AZX_DCAPS_NO_64BIT },
        /* VIA VT8251/VT8237A */
        { PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
        /* VIA GFX VT7122/VX900 */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4ffa3a59f..7ccdc375f 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4489,6 +4489,18 @@ static int patch_via_hdmi(struct hda_codec *codec)
        return patch_simple_hdmi(codec, VIAHDMI_CVT_NID, VIAHDMI_PIN_NID);
 }

+static int patch_gf_hdmi(struct hda_codec *codec)
+{
+       int err;
+
+       err = patch_generic_hdmi(codec);
+       if (err)
+               return err;
+
+       codec->no_sticky_stream = 1;
+       return 0;
+}
+
 /*
  * patch entries
  */
@@ -4579,6 +4591,12 @@ HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",    patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",  patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",      patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",   patch_nvhdmi_2ch),
+HDA_CODEC_ENTRY(0x67663d82, "Arise HDMI/DP",   patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d83, "Arise HDMI/DP",   patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d84, "Arise HDMI/DP",   patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d85, "Arise HDMI/DP",   patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d86, "Arise HDMI/DP",   patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d87, "Arise HDMI/DP",   patch_gf_hdmi),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",   patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",   patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",    patch_generic_hdmi),
--
2.20.1



保密声明：
本邮件含有保密或专有信息，仅供指定收件人使用。严禁对本邮件或其内容做任何未经授权的查阅、使用、复制或转发。
CONFIDENTIAL NOTE:
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or forwarding of this email or the content of this email is strictly prohibited.
