Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75769606B86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJTWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:47:53 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A222D5B4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Subject:Date:To:From:Resent-To:Resent-Message-ID:
        Resent-Date:Resent-From:Sender:Reply-To:Message-ID:Cc:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Sender:Resent-Cc:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ytGemd8TUUP6iR/VoFGETCFoSPfcw2IqvbDsWpHrIzE=; b=uCG1yeqtS22d7vaexpY6lNaFMk
        K7aTT+M0FCxW44f5pJPqFC6WN7hlevhyre6ru91EHdvEWQJm4p6lW4EDXltrPwj8U53TQ0m3NpMqR
        GQuptLKJu74TAso1AdYYrVuc5f3xLCgFQRQnHKh7HdD29qrEL7Z3yV42e/hxYDLtdI4Q=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oleJS-009Obi-Ix; Fri, 21 Oct 2022 00:46:54 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Oct 2022 08:17:12 +0200
Subject: [PATCH 6/6] ASoC: Intel: boards: add missing dependency from
 realtek-common
In-Reply-To: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_MID,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S229941AbiJTWr5/20221020224758Z+12922@vger.kernel.org>

These boards use code from sound/soc/sof/sof-audio.c

Fixes: e1d5e13324020c4b405e63cae34560c7992bec2e
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 sound/soc/intel/boards/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index aa12d7e3dd2f..3179ba061d87 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -34,6 +34,7 @@ config SND_SOC_INTEL_SOF_MAXIM_COMMON
 
 config SND_SOC_INTEL_SOF_REALTEK_COMMON
 	tristate
+	depends on SND_SOC_SOF
 
 config SND_SOC_INTEL_SOF_CIRRUS_COMMON
 	tristate
-- 
2.37.2.609.g9ff673ca1a
