Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF868AC6A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBDVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjBDVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:02:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA6620D00
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:02:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a23so5835254pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iy74VsRO4WDPI6duqo1jqOxf/w5vgZYHdL8GT2SYMKg=;
        b=3w2YiAyNJtEQDGuv+q7PteQbxAc90iPxEhXnUrO3pypsg9+j3VEF6mDjcBvK2d6wcS
         HIA47XOx8JQMCuEL9QMqJ6ePxyG6xNYxnP6Ua5JnkAMN2wiu+gUpM+ZThpofkVWVfAlj
         T7RepGAQshvpe0Q59PUc5VTkj08UpWL71psGPVyphDalykOLecEuf+dN+mkjzPgvMyT0
         dTroAiVxWHhwN+qDjQzIdL7wAyfGoI3xNZ6w6gGOesYEgD+RNS+YpVorOx1SH+fOeBVH
         vbi4W0huTNQ4wLDgJsHnjsgY+aPSfXYhBT9yWQfwmkZCNighdfNn+seKdpZvO39nN+8U
         K7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:references:in-reply-to:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy74VsRO4WDPI6duqo1jqOxf/w5vgZYHdL8GT2SYMKg=;
        b=GdRGJDf21j84N2Fvbb/dCv0XiLZ6ZCU6GTYTw1Idsn6I8qSuLYlY1pD5ybblILUqUJ
         +i1lTl84Oy6Lz15qlwh9lHnNB/w8F9z99ZQL7RtcFRcO5lv4kb4QCY5jU23cn2niiLyV
         QzlSi3BaFZ+H+K8JV5AsLQdqYTlxcz8HIy7FaAtnRlNNuJz8uiL95uBMUeR08Up8iVJ9
         3ng+40L9cfFcqyOO+WfqH7uaQ+7SLFanNjlCvQCKrt6PMi+ePBRZ8Fc3C194XV4ROfb0
         afRAjylL9bTXXzi9vF9HLrCsUa7qLgwtL84uh4XqOlwZJ3eX/Xh1hMwmbBcFW0jOXeld
         mMQQ==
X-Gm-Message-State: AO0yUKVApc3DUuM8bbg1lm+IFB6bupqVFqE8FXeBBGMGiNt6OSb2nJFT
        GwQHBXaxkGUsb7x0LkNL+YpGvymcAiWp52zY
X-Google-Smtp-Source: AK7set/RHBlFpv8T3OLVL5wC59M32m9IYL76JHfQskGRevwysuhNbGGfCrdmUEkCXh5ukykwH4hIhQ==
X-Received: by 2002:a05:6a00:c87:b0:593:af2e:b872 with SMTP id a7-20020a056a000c8700b00593af2eb872mr17898882pfv.2.1675544530517;
        Sat, 04 Feb 2023 13:02:10 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id h30-20020a056a00001e00b0058bbaa5200dsm4106116pfk.214.2023.02.04.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 13:02:10 -0800 (PST)
Message-Id: <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
In-Reply-To: <cover.1675497326.git.daniel.beer@igorinstitute.com>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Thu, 27 Oct 2022 21:38:38 +1300
Subject: [PATCH v3 2/2] ASoC: tas5805m: add missing page switch.
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Andy Liu <andy-liu@ti.com>, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tas5805m_refresh, we switch pages to update the DSP volume control,
but we need to switch back to page 0 before trying to alter the
soft-mute control. This latter page-switch was missing.

Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifier")
Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
---
 sound/soc/codecs/tas5805m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
index 6e2edf045446..4e38eb7acea1 100644
--- a/sound/soc/codecs/tas5805m.c
+++ b/sound/soc/codecs/tas5805m.c
@@ -203,6 +203,9 @@ static void tas5805m_refresh(struct tas5805m_priv *tas5805m)
 	set_dsp_scale(rm, 0x24, tas5805m->vol[0]);
 	set_dsp_scale(rm, 0x28, tas5805m->vol[1]);
 
+	regmap_write(rm, REG_PAGE, 0x00);
+	regmap_write(rm, REG_BOOK, 0x00);
+
 	/* Set/clear digital soft-mute */
 	regmap_write(rm, REG_DEVICE_CTRL_2,
 		(tas5805m->is_muted ? DCTRL2_MUTE : 0) |
-- 
2.38.1

