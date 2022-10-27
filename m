Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23F60F596
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiJ0KoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0KoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:44:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DDA87AE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:44:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b12so1959485edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=giuiXYYLk+f5QLS50ASlMusr4jOA07sul4BoLmCP2Tg=;
        b=IN9rKSLQysrc1zS8/Aoy0aq5vrB08zsUfVBZNbxbclZikymid0Wk8I3Lp7v/HwF4GB
         rV8Ar7hRJgWBBNYj406pMQkOXFslXJbPhUoLOUPKAWyYwJWp1C532zZC3zoKvfAHbSjS
         KRHuRUanvg2fCyM5XUnSGVsrL4XRBVeVYoWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giuiXYYLk+f5QLS50ASlMusr4jOA07sul4BoLmCP2Tg=;
        b=C+lmwW2QAveiUPhSTbFS304ctbzud9hXgpPW9Io+EWJlsmhizjmAw4H6ntebApcwVK
         4u7IXLt6i9qxnci3U4BJGWMtwVQc+nMGQHjTEMyZpNhekk3MCMoiKRTQrlMrY8/rlvF2
         IMHA+YXR33im4Ot4R9d4EZuNKMIlI3lpEV0QIRfNi3wmmZEK8OudKatfip5D2htHa/+E
         uQDvaDjg8MoqGauCzV5hiEHAGqlaYAORSbLcsialJTphQecDPRg6E2vU//hkJdyCngDB
         y1ONsZt6cvhmugEIPLJK5P9w1ypL0yDnbEjspqiNR7sUNocCz3Lq/kVmqdfqknNuQW8V
         l/8Q==
X-Gm-Message-State: ACrzQf0vv4ziWxNOyNWjpv2xGd2UKFKgSoklWNfMezPC+ckeL/chbK8F
        ikkqP7QYgVADEPBESB9N5FBqezZISwSpdQ==
X-Google-Smtp-Source: AMsMyM7YmuQMOzkUROoct74BrEyBOXOY61+z4zYghz3wpEMzNkYu5jz8gJBxDNSYk3HcGTxe4XoSaQ==
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id en17-20020a056402529100b0045c3f6ad4bcmr44696532edb.285.1666867448979;
        Thu, 27 Oct 2022 03:44:08 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id n1-20020aa7c441000000b00461c6e8453dsm774012edr.23.2022.10.27.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:44:08 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] docs/sphinx: More depth in the rtd sidebar toc
Date:   Thu, 27 Oct 2022 12:44:06 +0200
Message-Id: <20221027104406.549734-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Note that this has no impact on the classic theme (which doesn't have
the sidebar) nor on the various :toctree: rendered inline in the
output.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 934727e23e0e..5dc141c66726 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -240,6 +240,10 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
                 # Add color-specific RTD normal mode
                 html_css_files.append('theme_rtd_colors.css')
 
+        html_theme_options = {
+            'navigation_depth': -1,
+        }
+
     except ImportError:
         html_theme = 'classic'
 
-- 
2.37.2

