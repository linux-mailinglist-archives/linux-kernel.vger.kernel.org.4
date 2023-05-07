Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC596F954E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEGAbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEGAbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86019D6E;
        Sat,  6 May 2023 17:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03DE161475;
        Sun,  7 May 2023 00:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3A1C433D2;
        Sun,  7 May 2023 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419469;
        bh=/O/XkNe3bHehvczqzHylKHJi+VXkUeymg+W/IzhvROw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5ERM1hEaloqAcTX4foZ73wUkklcEbNmHn5+zhTYBY/vAvt0TnLLD6YK0U/eBQLM4
         qcxI/l6y3vN1kJPUNw8+lkySeBQVLjiR68fK0UCGDm3ffL4n2G6H6Ah03KKiJnuKhL
         PkqnXBkB+I2XRz3tWsEkXBsch2waQOckky832feMyqZxmb1/iRFh916SMMDtJN+6Sz
         p4govuh2cLPkY61DZMjTL5gEmbAOv5mbfwjI6ZDxeKZuGIA3hrIKW6g+s0K4F3h9p4
         0FpOesOPA3akuxhvsGzgKsxVlPylZ24aSoG98apPXESOOAUSc9SAwj/DxlfW75rB8g
         P2Q1dFwGvgDgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fred Oh <fred.oh@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, rander.wang@intel.com,
        kai.vehmanen@linux.intel.com, bhelgaas@google.com,
        yong.zhi@intel.com, orlandoch.dev@gmail.com, evan.quan@amd.com,
        amadeuszx.slawinski@linux.intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 15/24] ALSA: hda: LNL: add HD Audio PCI ID
Date:   Sat,  6 May 2023 20:30:11 -0400
Message-Id: <20230507003022.4070535-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fred Oh <fred.oh@linux.intel.com>

[ Upstream commit 714b2f025d767e7df1fe9da18bd70537d64cc157 ]

Add HD Audio PCI ID for Intel Lunarlake platform.

Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230406152500.15104-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 77a592f219472..881b2f3a1551f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2528,6 +2528,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Meteorlake-P */
 	{ PCI_DEVICE(0x8086, 0x7e28),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Lunarlake-P */
+	{ PCI_DEVICE(0x8086, 0xa828),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.39.2

