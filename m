Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED6917BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjBJEut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBJEuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:50:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D56E984;
        Thu,  9 Feb 2023 20:50:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id ay1so2754295pfb.7;
        Thu, 09 Feb 2023 20:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqShi3EgLDtgztLIgW/MuPsWv2vSLPgVWXrp/LobXww=;
        b=Om+u/6VnAJG9TE8AtmP7qvhlFAe++DibsHxfnKB/uw1rT0M0wwXXptoFr0Xv+20ydo
         eakNNTYlCCk2g+ALxRE6kmjCfzNbNOYJFbMBHqWvHvIm2k/uZfv6KIo0xugx3nQig2py
         J1no3BHk6c8ezYo6oWs4KfkhLQOu7YRb0G1aFzEpM6YreNPESvbQ4vwbkdQg1ll66Mfa
         qmCJAD9lIdQ09n5BrE3kzDSLu8s0jx5ZJ2hqM233WpFqKrLUDc8SXFgEQ8iWwYwFo7zR
         SkcsIvSD7qiSPHhO2o5OR47wO55x0ECXZiVlRFfBnNKUyj1V+gZQOOhi2rAshPHtOKDE
         yP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqShi3EgLDtgztLIgW/MuPsWv2vSLPgVWXrp/LobXww=;
        b=fEeGayo9oSAzFo55k3ySjp9dRHOLyVpkVHUAQLhs6NMfgpobzEcneEwX0GCGoAPL1k
         inzOgFbsc4FqjNOaeus3HcJXvryd6FpqmpQ1eRFaz2pKz7jt7wHqHeL7Ok4+LTJGlasA
         Gze1LK+dbPwy2xWFBv2dbPg0WbBz7cofpp6MxvGPwwCwnB33c8JKhBMUumMT7m0i5hhd
         GqqdQNvwZEGDklH6CwrRXYOUshe2YoPRFOLcvZFgj4KYYE7vlB4W7O+vbtpWG1pnUxVG
         uNh9kLANRm58vmpHNKMZmvZiXvvJE9JUAU+r/swii0C4TQEzxVWDMkruecn21TQQJDGQ
         Fg4w==
X-Gm-Message-State: AO0yUKUUFvCDhQ+cyw7Ve4kNvneNkPZs4ct4OKuGtN9xX+VE+kTgqzNW
        31sRkEG3DRJhUJFwTrLcNb9lpSzQMvJCMQ==
X-Google-Smtp-Source: AK7set//ZS0OEdNcYuTp0DRJ59S0YHaU7AVoVK7clC6F+urpcBjbK1/I7g8ZJg3rnX+smO5B0TtQfg==
X-Received: by 2002:a62:6458:0:b0:5a8:6bb7:5fc5 with SMTP id y85-20020a626458000000b005a86bb75fc5mr1170747pfb.19.1676004628485;
        Thu, 09 Feb 2023 20:50:28 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:50:28 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 3/9] apple-gmux: use first bit to check switch state
Date:   Fri, 10 Feb 2023 15:48:20 +1100
Message-Id: <20230210044826.9834-4-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On T2 Macs with MMIO gmux, when GMUX_PORT_SWITCH_DISPLAY is read, it can
have values of 2, 3, 4, and 5. Odd values correspond to the discrete gpu,
and even values correspond to the integrated gpu. The current logic is
that only 2 corresponds to IGD, but this doesn't work for T2 Macs.
Instead, check the first bit to determine the connected gpu.

As T2 Macs with gmux only can switch the internal display, it is
untested if this change (or a similar change) would be applicable
to GMUX_PORT_SWITCH_DDC and GMUX_PORT_SWITCH_EXTERNAL.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 67628104f31a..6109f4c2867c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -332,10 +332,10 @@ static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
 	else
 		gmux_data->switch_state_ddc = VGA_SWITCHEROO_DIS;
 
-	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) == 2)
-		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
-	else
+	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) & 1)
 		gmux_data->switch_state_display = VGA_SWITCHEROO_DIS;
+	else
+		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
 
 	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL) == 2)
 		gmux_data->switch_state_external = VGA_SWITCHEROO_IGD;
-- 
2.39.1

