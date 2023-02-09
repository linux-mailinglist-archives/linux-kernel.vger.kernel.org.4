Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAE690884
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBIMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjBIMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:17:15 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 025B8DBD5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:16:53 -0800 (PST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHE+eD4+RjqhtVDw--.64601S2;
        Thu, 09 Feb 2023 20:13:55 +0800 (CST)
Received: from phytium.com.cn (unknown [218.68.211.205])
        by mail (Coremail) with SMTP id AQAAfwAnNCGa4+Rj12gRAA--.4289S3;
        Thu, 09 Feb 2023 20:14:19 +0800 (CST)
From:   Zhang Yiqun <zhangyiqun@phytium.com.cn>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, ckeepax@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhang Yiqun <zhangyiqun@phytium.com.cn>
Subject: [PATCH] ALSA: hda: remove redundent varible in snd_hdac_stream_start()
Date:   Thu,  9 Feb 2023 20:14:00 +0800
Message-Id: <20230209121400.14253-1-zhangyiqun@phytium.com.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAfwAnNCGa4+Rj12gRAA--.4289S3
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhangyiqun
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4rGF4kXF4xJw47ZF1rXrb_yoW7ArW5pw
        4kZa4rKFW3tF10vF4UGw15KF17KF1kKasxtry5t348Aw4UJr1FqFyjkryxZryFkry5Wr9x
        Z3W2y34UGw43WFDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 2nd varibles are all set as true in treewide. So I think
it can be removed for easy understanding.

Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
---
 include/sound/hdaudio.h           | 2 +-
 sound/hda/hdac_stream.c           | 7 ++-----
 sound/pci/hda/hda_controller.c    | 2 +-
 sound/soc/intel/avs/pcm.c         | 2 +-
 sound/soc/intel/avs/probes.c      | 2 +-
 sound/soc/intel/skylake/skl-pcm.c | 4 ++--
 6 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index a6872537724d..536612c6ab0c 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -575,7 +575,7 @@ void snd_hdac_stream_cleanup(struct hdac_stream *azx_dev);
 int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev);
 int snd_hdac_stream_set_params(struct hdac_stream *azx_dev,
 				unsigned int format_val);
-void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start);
+void snd_hdac_stream_start(struct hdac_stream *azx_dev);
 void snd_hdac_stream_stop(struct hdac_stream *azx_dev);
 void snd_hdac_stop_streams(struct hdac_bus *bus);
 void snd_hdac_stop_streams_and_chip(struct hdac_bus *bus);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 547adbc22590..1f56fd33b9af 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -124,11 +124,10 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_init);
 /**
  * snd_hdac_stream_start - start a stream
  * @azx_dev: HD-audio core stream to start
- * @fresh_start: false = wallclock timestamp relative to period wallclock
  *
  * Start a stream, set start_wallclk and set the running flag.
  */
-void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
+void snd_hdac_stream_start(struct hdac_stream *azx_dev)
 {
 	struct hdac_bus *bus = azx_dev->bus;
 	int stripe_ctl;
@@ -136,8 +135,6 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 	trace_snd_hdac_stream_start(bus, azx_dev);
 
 	azx_dev->start_wallclk = snd_hdac_chip_readl(bus, WALLCLK);
-	if (!fresh_start)
-		azx_dev->start_wallclk -= azx_dev->period_wallclk;
 
 	/* enable SIE */
 	snd_hdac_chip_updatel(bus, INTCTL,
@@ -966,7 +963,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_dsp_prepare);
 void snd_hdac_dsp_trigger(struct hdac_stream *azx_dev, bool start)
 {
 	if (start)
-		snd_hdac_stream_start(azx_dev, true);
+		snd_hdac_stream_start(azx_dev);
 	else
 		snd_hdac_stream_stop(azx_dev);
 }
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 0ff286b7b66b..c19d45618a09 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -257,7 +257,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		azx_dev = get_azx_dev(s);
 		if (start) {
 			azx_dev->insufficient = 1;
-			snd_hdac_stream_start(azx_stream(azx_dev), true);
+			snd_hdac_stream_start(azx_stream(azx_dev));
 		} else {
 			snd_hdac_stream_stop(azx_stream(azx_dev));
 		}
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index f930c5e86a84..b673b84ead32 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -647,7 +647,7 @@ static int avs_dai_fe_trigger(struct snd_pcm_substream *substream, int cmd, stru
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		spin_lock_irqsave(&bus->reg_lock, flags);
-		snd_hdac_stream_start(hdac_stream(host_stream), true);
+		snd_hdac_stream_start(hdac_stream(host_stream));
 		spin_unlock_irqrestore(&bus->reg_lock, flags);
 
 		/* Timeout on DRSM poll shall not stop the resume so ignore the result. */
diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 29d63f2a9616..741565c6465a 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -190,7 +190,7 @@ static int avs_probe_compr_trigger(struct snd_compr_stream *cstream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		spin_lock_irqsave(&bus->reg_lock, cookie);
-		snd_hdac_stream_start(hdac_stream(host_stream), true);
+		snd_hdac_stream_start(hdac_stream(host_stream));
 		spin_unlock_irqrestore(&bus->reg_lock, cookie);
 		break;
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index dc627d18518d..a4209d88b0c6 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -449,7 +449,7 @@ static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
 	spin_lock_irqsave(&bus->reg_lock, cookie);
 
 	if (start) {
-		snd_hdac_stream_start(hdac_stream(stream), true);
+		snd_hdac_stream_start(hdac_stream(stream));
 		snd_hdac_stream_timecounter_init(hstr, 0);
 	} else {
 		snd_hdac_stream_stop(hdac_stream(stream));
@@ -1134,7 +1134,7 @@ static int skl_coupled_trigger(struct snd_pcm_substream *substream,
 			continue;
 		stream = get_hdac_ext_stream(s);
 		if (start)
-			snd_hdac_stream_start(hdac_stream(stream), true);
+			snd_hdac_stream_start(hdac_stream(stream));
 		else
 			snd_hdac_stream_stop(hdac_stream(stream));
 	}
-- 
2.17.1

