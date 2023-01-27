Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8F67DDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjA0Glg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjA0GkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4996B98D;
        Thu, 26 Jan 2023 22:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mH4Qi2qcMAmiKadOvXwS3HJsLvAWFbZOF0NHQSwuRKU=; b=zEpGUxm4rAs4i++xIIUDYdKJLm
        7brwKHX+V9iQl0/jYbJ/qzJQymFWBi46fEYRPYqzXrtd/t2F9Mv9pf+GaMZwUS5hFIBh6y8C/S/fQ
        V0ntxM1i3vj3h7keonhwh5kFfV+gnIr3pTRtjN59BK+Tj64hewGx5Y4fO90kj8pwBUwNwIKl6LDo1
        XPRLxkZQLPeRkgd3PrONhp/P4pKDvTedAoQQpWGYJUK3dakckMesTooK0oBDNGqCI+rZbXvYZXfQP
        DpKlgsJe3pPX479wDTak5ExQSvwt2OWQm1S9M9f0acHMLyM0uoCvGcNh4k09mS2v5RuInpUAhTaVd
        YHJHJZuQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPO-00DM0u-BD; Fri, 27 Jan 2023 06:40:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 26/35] Documentation: sound: correct spelling
Date:   Thu, 26 Jan 2023 22:39:56 -0800
Message-Id: <20230127064005.1558-27-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/sound/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/sound/alsa-configuration.rst    |    8 ++++----
 Documentation/sound/cards/audigy-mixer.rst    |    2 +-
 Documentation/sound/cards/maya44.rst          |    2 +-
 Documentation/sound/cards/sb-live-mixer.rst   |    2 +-
 Documentation/sound/designs/jack-controls.rst |    2 +-
 Documentation/sound/designs/seq-oss.rst       |    2 +-
 Documentation/sound/hd-audio/notes.rst        |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff -- a/Documentation/sound/cards/audigy-mixer.rst b/Documentation/sound/cards/audigy-mixer.rst
--- a/Documentation/sound/cards/audigy-mixer.rst
+++ b/Documentation/sound/cards/audigy-mixer.rst
@@ -17,7 +17,7 @@ Digital mixer controls
 ======================
 
 These controls are built using the DSP instructions. They offer extended
-functionality. Only the default build-in code in the ALSA driver is described
+functionality. Only the default built-in code in the ALSA driver is described
 here. Note that the controls work as attenuators: the maximum value is the 
 neutral position leaving the signal unchanged. Note that if the  same destination 
 is mentioned in multiple controls, the signal is accumulated and can be wrapped 
diff -- a/Documentation/sound/cards/maya44.rst b/Documentation/sound/cards/maya44.rst
--- a/Documentation/sound/cards/maya44.rst
+++ b/Documentation/sound/cards/maya44.rst
@@ -156,7 +156,7 @@ IEC958 Output
     S/PDIF should output the same signal as channel 3+4. [untested!]
 
 
-Digitial output selectors
+Digital output selectors
     These switches allow a direct digital routing from the ADCs to the DACs.
     Each switch determines where the digital input data to one of the DACs comes from.
     They are not supported by the ESI windows driver.
diff -- a/Documentation/sound/designs/jack-controls.rst b/Documentation/sound/designs/jack-controls.rst
--- a/Documentation/sound/designs/jack-controls.rst
+++ b/Documentation/sound/designs/jack-controls.rst
@@ -8,7 +8,7 @@ Why we need Jack kcontrols
 ALSA uses kcontrols to export audio controls(switch, volume, Mux, ...)
 to user space. This means userspace applications like pulseaudio can
 switch off headphones and switch on speakers when no headphones are
-pluged in.
+plugged in.
 
 The old ALSA jack code only created input devices for each registered
 jack. These jack input devices are not readable by userspace devices
diff -- a/Documentation/sound/designs/seq-oss.rst b/Documentation/sound/designs/seq-oss.rst
--- a/Documentation/sound/designs/seq-oss.rst
+++ b/Documentation/sound/designs/seq-oss.rst
@@ -96,7 +96,7 @@ if you use an AWE64 card, you'll see lik
     Number of synth devices: 1
     synth 0: [EMU8000]
       type 0x1 : subtype 0x20 : voices 32
-      capabilties : ioctl enabled / load_patch enabled
+      capabilities : ioctl enabled / load_patch enabled
 
     Number of MIDI devices: 3
     midi 0: [Emu8000 Port-0] ALSA port 65:0
diff -- a/Documentation/sound/cards/sb-live-mixer.rst b/Documentation/sound/cards/sb-live-mixer.rst
--- a/Documentation/sound/cards/sb-live-mixer.rst
+++ b/Documentation/sound/cards/sb-live-mixer.rst
@@ -31,7 +31,7 @@ Digital mixer controls
 ======================
 
 These controls are built using the DSP instructions. They offer extended
-functionality. Only the default build-in code in the ALSA driver is described
+functionality. Only the default built-in code in the ALSA driver is described
 here. Note that the controls work as attenuators: the maximum value is the 
 neutral position leaving the signal unchanged. Note that if the  same destination 
 is mentioned in multiple controls, the signal is accumulated and can be wrapped 
diff -- a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -500,7 +500,7 @@ add_jack_modes (bool)
     change the headphone amp and mic bias VREF capabilities
 power_save_node (bool)
     advanced power management for each widget, controlling the power
-    sate (D0/D3) of each widget node depending on the actual pin and
+    state (D0/D3) of each widget node depending on the actual pin and
     stream states
 power_down_unused (bool)
     power down the unused widgets, a subset of power_save_node, and
diff -- a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -70,7 +70,7 @@ dsp_map
     PCM device number maps assigned to the 1st OSS device;
     Default: 0
 adsp_map
-    PCM device number maps assigned to the 2st OSS device;
+    PCM device number maps assigned to the 2nd OSS device;
     Default: 1
 nonblock_open
     Don't block opening busy PCM devices;
@@ -97,7 +97,7 @@ midi_map
     MIDI device number maps assigned to the 1st OSS device;
     Default: 0
 amidi_map
-    MIDI device number maps assigned to the 2st OSS device;
+    MIDI device number maps assigned to the 2nd OSS device;
     Default: 1
 
 Module snd-soc-core
@@ -727,9 +727,9 @@ Module for EMU10K1/EMU10k2 based PCI sou
 * Sound Blaster Audigy
 	
 extin
-    bitmap of available external inputs for FX8010 (see bellow)
+    bitmap of available external inputs for FX8010 (see below)
 extout
-    bitmap of available external outputs for FX8010 (see bellow)
+    bitmap of available external outputs for FX8010 (see below)
 seq_ports
     allocated sequencer ports (4 by default)
 max_synth_voices
