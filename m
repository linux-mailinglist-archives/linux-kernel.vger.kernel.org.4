Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F0620FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiKHL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiKHL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:57:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026E12AFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:57:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id y14so37936381ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVfGNdtNg+zCQhJb8JnZXraJEUpvWY2XlNM2DVwiefU=;
        b=Es1qARbsX7RS0Xd92HZZOXqamwXebEAT3D2rXZ3242oq86HzzlEKeouCKkE0VHuTdS
         wV5oVWbgvc1NgAKIFqN8aujoG++ihft46CuIV9EBKh+8ZOeAr+ECVeYP3n7kbgEcJzqU
         PASmZvErmpFvngKyJXPLWQGHor2Qink3rJUPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVfGNdtNg+zCQhJb8JnZXraJEUpvWY2XlNM2DVwiefU=;
        b=6CUE40CDq0wavtbJdBNkUwY+CaQHPSKbvqC+qjeznmiLREl8KZXRGgYz/CFObOG0qo
         /i22lVHJ0zsiSjzEmat+rIjgh4Pnu0G0bWF5nWOrqbInMSzNKtW/4lhsMNf5x/SCoGLs
         LXt3Vndio+Jxud6xC52zdyB88UALUMPX2j3GHmT6bAzH4bol8qmRtkMQaP8TgpVQsrsL
         tJ6QQIUzWFbLBFdUo2HT6CRy0Nv4aEOkfn88spPzJ1bcSKU0ZPofGdlmnOhHCME4wF9i
         vvznC1xeDRyG8oORyBV3JeEfGa6zyXF1t2Z9SZltjfBwFDxhrf4roY3FAYbnZXzeXHvA
         VmEg==
X-Gm-Message-State: ACrzQf2KO8inEi+GtxfiHEgrAPlBj0waapsPGWeYEVtGwK8rRW6/6+Fg
        96zBZp7L/eposVv9sprTvRalbA==
X-Google-Smtp-Source: AMsMyM5BuaFCyJpqFWdC5RbAV59Rp2Hk0lf/tuzgBE7M6wyhtpIcHG60tUWHoycUppUGF1bFN6wtdw==
X-Received: by 2002:a17:907:e8f:b0:7ad:923a:5a2c with SMTP id ho15-20020a1709070e8f00b007ad923a5a2cmr51867849ejc.736.1667908633613;
        Tue, 08 Nov 2022 03:57:13 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id ky26-20020a170907779a00b0073cd7cc2c81sm4513201ejc.181.2022.11.08.03.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:57:12 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] docs/sphinx: More depth in the rtd sidebar toc
Date:   Tue,  8 Nov 2022 12:57:07 +0100
Message-Id: <20221108115707.1232621-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We love to nest our documenation for good structure, but that means
the table of contents needs to keep up or you can't navigate them.

Realized this trying to find the drm property documentation, which
with some shuffling around disappeared. Why I didn't realize we can do
this earlier, no idea.

Since the relevant parts of the toc are only loaded if you're in the
right .html file there's no harm in going all the way to unlimited.

Note that this has no impact on the alabaster theme (which has a much
simpler sidebar toc which doesn't show the entire hierarchy, only
what's in the local rendered file) nor on the various :toctree:
rendered inline in the output.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: Rebase onto linux-next, reword commit message to take into account
that alabaster is the default now.
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c715610d6297..a5c45df0bd83 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -296,6 +296,10 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
                 # Add color-specific RTD normal mode
                 html_css_files.append('theme_rtd_colors.css')
 
+        html_theme_options = {
+            'navigation_depth': -1,
+        }
+
     except ImportError:
         html_theme = 'alabaster'
 
-- 
2.37.2

