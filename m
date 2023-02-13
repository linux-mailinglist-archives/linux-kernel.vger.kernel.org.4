Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8A69424B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjBMKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBMKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:08:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF17D91;
        Mon, 13 Feb 2023 02:08:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o13so11438626pjg.2;
        Mon, 13 Feb 2023 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSb5TYkdB9G4jnI9bUCr3hAVvO3iDDQHthy8SxXwjvs=;
        b=a1X/jFBs7OtWuqzMWQfSh3xYWRqeXcUUhCfDy+hM5hFw8cyrOX8XKmbH0UOcnV/ppW
         flTy8YVTIB5Y9E7WQtJuVGLPNk6xl9vWJTE4yj52ao3WOVV9+Zy6Ns4dH3y7yqOXfRDp
         8rXLBHXz0NCVdi3CHOxkNIQ92CvgiekmMQ3smf4+w3Vpf8SQtElCwGpml6bo//QOBLrn
         ejG9WV5GVtoSF6EKoYkbvJfz9yV0dKRVd52+a65VCX5EDQpyTxdrER6RFf7V0tAajhoz
         /9pdANUWkpwvqPPSGXlBi5fUoOala0jhG5oRMVZe+VpIx/SvU2Al7zF3mkTliruoKQVs
         6AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSb5TYkdB9G4jnI9bUCr3hAVvO3iDDQHthy8SxXwjvs=;
        b=VnGc4Tmv6irynMxRJXqPDZzmjSevh1lVEOPBJN+NI1ciI8384VhET+X63Luy2gfB4H
         MI1IbLqwOFFTufS/o8Zxv8ak/BF+CGzAl3CRcmAii4a7/FTGrIQk9Jq20S0uHJlzQugB
         pzild0c1+GjnJtm7bdxsPRDR2/kyEfDm0CPa7AvfT8oGb36vxeDJzyrs/RpGylmf7WAQ
         qO4iBjL8Ybw5rJqwKmRjC+TvfJWxG76/lDj5htrqwstSdhOPkpS0PBEnDjEfxWWvBf9m
         Ohbjzl82BZDRo456GpqPwvku+80uGv0sDisze3FVKxurdE3W66liTXuQVG5t0QZOuYJv
         LsEw==
X-Gm-Message-State: AO0yUKXDlkuMOcpBWTD6/ShkdiIufgwE/4KLHbMjWecBYwBY1aIiHC0X
        Ts5cSZTlon/vX8nsIoMZwic=
X-Google-Smtp-Source: AK7set/1mDlWXPufSlSR1JgQBOltAxYUmTovtOkeakO8YxwtOuPU3VzdYPJe0LvoLiOplw3lXEnqPA==
X-Received: by 2002:a17:902:c408:b0:19a:9610:b237 with SMTP id k8-20020a170902c40800b0019a9610b237mr7151879plk.45.1676282894758;
        Mon, 13 Feb 2023 02:08:14 -0800 (PST)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b0019aa8149cc9sm914946plz.35.2023.02.13.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 02:08:14 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id F249310490E; Mon, 13 Feb 2023 17:08:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] Documentation: powerclamp: Escape wildcard in cpumask description
Date:   Mon, 13 Feb 2023 17:08:00 +0700
Message-Id: <20230213100800.28333-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213100800.28333-1-bagasdotme@gmail.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=bagasdotme@gmail.com; h=from:subject; bh=nv91/uDsBT2EzdDEqnJFzYqflcFa6tyGT6hcxp3xXRY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMmveBgWlWedOKSa7ajIeDjv/Ioz7iLyJwTst+vW/fmz6lnN PJ0vHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI5xyG/16JCsnfT9z88M9v9+6XYU v5niwwDb2syLnI5KWY4aagfxMY/ofelPBijW56os2t/bz+KJfZsZmTX92ef++a4WJtgU1zPvABAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warning:

Documentation/admin-guide/thermal/intel_powerclamp.rst:328: WARNING: Inline emphasis start-string without end-string.

The mistaken asterisk in /proc/irq/*/smp_affinity is rendered as hyperlink
as the result.

Escape the asterisk to fix above warning.

Link: https://lore.kernel.org/linux-doc/202302122247.N4S791c4-lkp@intel.com/
Fixes: ebf51971021881 ("thermal: intel: powerclamp: Add two module parameters")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/thermal/intel_powerclamp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/thermal/intel_powerclamp.rst b/Documentation/admin-guide/thermal/intel_powerclamp.rst
index 2d9d2d739f0256..f919fbe1cdd942 100644
--- a/Documentation/admin-guide/thermal/intel_powerclamp.rst
+++ b/Documentation/admin-guide/thermal/intel_powerclamp.rst
@@ -326,7 +326,7 @@ Module Parameters
 
 ``cpumask`` (RW)
 	A bit mask of CPUs to inject idle. The format of the bitmask is same as
-	used in other subsystems like in /proc/irq/*/smp_affinity. The mask is
+	used in other subsystems like in /proc/irq/\*/smp_affinity. The mask is
 	comma separated 32 bit groups. Each CPU is one bit. For example for a 256
 	CPU system the full mask is:
 	ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
-- 
An old man doll... just what I always wanted! - Clara

