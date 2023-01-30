Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E9681664
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjA3Q3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbjA3Q3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:29:32 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2493F2A0;
        Mon, 30 Jan 2023 08:29:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 90050240008;
        Mon, 30 Jan 2023 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675096165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ttbkmJmfqMZ8rvI1K8Fpp/EYFmvyqrJCorPDwJm4m78=;
        b=RQfeahdOmqvClK8WcknKv+Vf5vhB11258ZbUQF0vuna0+IElaueM7GcIXzYgNRlWwth91t
        ryakmqmpmgbVkKMZfn+QthR3wAHnMO0HG2LtHtriYi2WRdi/0IYSpb6JlXrA9LFXujG1Wn
        KUhaGH8R3FKIGE8fNg3NQoG7Si2THyF04GXVlAJ64hlNABMXwTYVJwcw6q5PzaC18Fan3E
        iwU+jYgIAgdhZj4YDkGInEDg53M2ffBYb8C80Bcb5WimtWD6pxVgAieoU5vvs8kINiZc2T
        dUod2aevqFQByjZa/0vRhYRoNI+XbTcciRVmtvhe/8c8dHYNgBlMZ+Yny48DQw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RESEND] ALSA: doc: Fix PCM interface section typos
Date:   Mon, 30 Jan 2023 17:29:24 +0100
Message-Id: <20230130162924.119389-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two mistakes in the PCM interface section:
1/ Members of the snd_pcm_hardware structure are channels_{min,max}
   and not channel_{min,max} (mind the 's').
2/ Another sentence is incomplete as the reference to one structure
   member (period_bytes_max) is missing.

There is no relevant 'Fixes:' tag to apply as both typos predate the
Git era.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello, I wrote and sent this patch in 2019 but I likely only Cc'd Jon
and the doc ML, which might have not been enough, so just in case, here
is a resend.
Link: https://lore.kernel.org/linux-doc/20190829145512.3752-1-miquel.raynal@bootlin.com/

 .../sound/kernel-api/writing-an-alsa-driver.rst        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 07a620c5ca74..5c9523b7d55c 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -1720,16 +1720,16 @@ Typically, you'll have a hardware descriptor as below:
 -  ``rate_min`` and ``rate_max`` define the minimum and maximum sample
    rate. This should correspond somehow to ``rates`` bits.
 
--  ``channel_min`` and ``channel_max`` define, as you might already
+-  ``channels_min`` and ``channels_max`` define, as you might already
    expected, the minimum and maximum number of channels.
 
 -  ``buffer_bytes_max`` defines the maximum buffer size in
    bytes. There is no ``buffer_bytes_min`` field, since it can be
    calculated from the minimum period size and the minimum number of
-   periods. Meanwhile, ``period_bytes_min`` and define the minimum and
-   maximum size of the period in bytes. ``periods_max`` and
-   ``periods_min`` define the maximum and minimum number of periods in
-   the buffer.
+   periods. Meanwhile, ``period_bytes_min`` and ``period_bytes_max``
+   define the minimum and maximum size of the period in bytes.
+   ``periods_max`` and ``periods_min`` define the maximum and minimum
+   number of periods in the buffer.
 
    The “period” is a term that corresponds to a fragment in the OSS
    world. The period defines the size at which a PCM interrupt is
-- 
2.34.1

