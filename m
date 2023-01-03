Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016565BB53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjACHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjACHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:41:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0752B8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672731683; x=1704267683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxhstbNSuFJ+RInMZSQu3SmUKm5bWQPMvSyQYhXUpk8=;
  b=WokTHkUY3kMzFmtVEw2oJ5q7lqVwtjsYXVbFLij0vs1/gVUx4IgkL8oh
   mItfZG2UGNrboDx3Zl+f3blGChH+msaQwBgAmgzyGmHpzDYMe1yIthoyB
   3ETMtq5jnaXwzC010oc7p8ebr73jGWj5CmbfQv9SKnFbpEPtfz548xEc+
   6uBGU9UpJ2aGTZlcaqVNJ1msqVTYCfpK5/gms3ZVH1XzWv0trdggWb1xh
   dNLbIyt6fJs2nv6VCHnmrepcrkAMnTallUUmom4/FSiSUXfoNY6yrJjOU
   9LcY0LVAN//iufvB826TiQgUH93/6RvUk15LdqbWB7vTypu2EEqXR++ll
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="348822890"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="348822890"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 23:41:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="723174876"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="723174876"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2023 23:41:20 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof_ssp_amp: remove unused variable
Date:   Tue,  3 Jan 2023 15:37:04 +0800
Message-Id: <20230103073704.722027-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable becomes useless since we moved the snd_soc_jack
structure from a static array to sof_hdmi_pcm structure.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_ssp_amp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
index 94d25aeb6e7c..f75800d9d6de 100644
--- a/sound/soc/intel/boards/sof_ssp_amp.c
+++ b/sound/soc/intel/boards/sof_ssp_amp.c
@@ -105,7 +105,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 	char jack_name[NAME_SIZE];
 	struct sof_hdmi_pcm *pcm;
 	int err;
-	int i;
 
 	if (!(sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT))
 		return 0;
@@ -124,7 +123,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		return hda_dsp_hdmi_build_controls(card, component);
 	}
 
-	i = 0;
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
@@ -139,8 +137,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 					  &pcm->sof_hdmi);
 		if (err < 0)
 			return err;
-
-		i++;
 	}
 
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
-- 
2.25.1

