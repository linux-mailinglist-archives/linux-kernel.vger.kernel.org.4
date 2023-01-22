Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32D6772B9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjAVVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAVVg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:36:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCB16AE0;
        Sun, 22 Jan 2023 13:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1DEAB80B45;
        Sun, 22 Jan 2023 21:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7E3C433D2;
        Sun, 22 Jan 2023 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423415;
        bh=+kFCj2QmQqaqkQtiLOFfyT0VJOQjHQOx/aIvyvGdoLs=;
        h=From:To:Cc:Subject:Date:From;
        b=qdLvj6w6684w6d/X9zYg2BFZL54G4t/TuI0Ru07Dj8kOCPAVoymyXtBQGBX0RPJgO
         vFWVq0fHA9L+aPQE+N5MOg+6YTtOcP4dTjZmtyPALYNYrzyNnIhD9D4Cg+s1dLoWRn
         MTJ0fd1Mc4eMZu8t+o6Ry0xiUg+4vXPCoYAc9LUiLo09CPpbxmYMwjiHz020m3S/KF
         r0/s0x+hi+U9rpO1ef709JJU1EFLq9kdQwc68nhiBS1+PYEhvp8sB6o3uWPwvR8rBs
         YtF0hwHJxaiHHqqishvWLDP0UhZxVIOo4CWWoXdjGwNsbqYkC59+fkVed2OcOVwT1C
         rPI2g6AG2BcFw==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Docs: Add missing SPDX license identifiers of
Date:   Sun, 22 Jan 2023 21:36:42 +0000
Message-Id: <20230122213650.187710-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some subsystem documents are missing SPDX license identifiers on index
files.  This patchset adds those.

Changes from v1
(https://lore.kernel.org/lkml/20230114194741.115855-2-sj@kernel.org/)
- Separate from index file content changes
- Separate patch for each subsystem doc (Alex Deucher)
- Use MIT license for gpu (Alex Deucher)

SeongJae Park (8):
  Docs/crypto/index: Add missing SPDX License Identifier
  Docs/driver-api/index: Add missing SPDX License Identifier
  Docs/gpu/index: Add missing SPDX License Identifier
  Docs/hwmon/index: Add missing SPDX License Identifier
  Docs/input/index: Add missing SPDX License Identifier
  Docs/mm/index: Add missing SPDX License Identifier
  Docs/scheduler/index: Add missing SPDX License Identifier
  Docs/sound/index: Add missing SPDX License Identifier

 Documentation/crypto/index.rst     | 2 ++
 Documentation/driver-api/index.rst | 2 ++
 Documentation/gpu/index.rst        | 2 ++
 Documentation/hwmon/index.rst      | 2 ++
 Documentation/input/index.rst      | 2 ++
 Documentation/mm/index.rst         | 2 ++
 Documentation/scheduler/index.rst  | 2 ++
 Documentation/sound/index.rst      | 2 ++
 8 files changed, 16 insertions(+)

-- 
2.25.1

