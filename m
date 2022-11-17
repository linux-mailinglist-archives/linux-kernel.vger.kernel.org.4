Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E162E847
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiKQWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiKQWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52D898D8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:18:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z26so3141781pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYzob4348nYU+2Eh2QmU2auy9qKtGqawS3+SiTC3pr8=;
        b=mT6f5gl1eMimurIMmfHra1ZzdxxC44UxnmLk9ya83XFZxxCWVmAJlNJsuQm9+hWqo9
         clAArb97Lztgdt9fUawtaUPdSOcO3YtzWHrw3P6moc6Dh0+MA3W56f7CCeSMPYplF2h3
         a7COln0GoeKLRrAgBqCQmkPuOYTL1GDqAZjjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYzob4348nYU+2Eh2QmU2auy9qKtGqawS3+SiTC3pr8=;
        b=RYXHLXgeVfCe8VgVwpo/8PZp+UHCIu5sxMxvoNJNfFM0HrBlYb0sTdnbJlOV3kQWKF
         LQRBhWclBHsvIP4fcUQe0iwbz8JOnzOaXxwNz5N2eQS8W1CSA5Oj0OqVzLzCmSH3Ygrj
         20ebSpJcSF95YPP4XtZNhmC00p/KxZHXWh/VS4bckerKAx41TyoYr4JfM7rKIiTX1upd
         SxeaWUq+QUcFZoC8j1OQF9Nzpht1fHb6rSYoXEC+l7+xsNLWJYKbctEtaaMsmBhY347A
         IalgL/0m5/98DMhRa1TB3MbzyvfBp+a3fy/IQusjHr9HZJKiWVY8GuHqMDQX5QK0V81B
         hvUA==
X-Gm-Message-State: ANoB5pmI6InVKsbKdG6ihEmVqYgnETYAKiSFtjIDQCdFj8Z7ja5iOHGp
        xFasyTKEj2IoAgEhojDnURQ3kg==
X-Google-Smtp-Source: AA0mqf4WXJ8bLo8CDx+tvlgGvCwBPESTcqzdM/ckT0mWIDLw4npKCloTa0mrn276bHYnkJex23nlEg==
X-Received: by 2002:a63:f047:0:b0:476:7742:de19 with SMTP id s7-20020a63f047000000b004767742de19mr3827473pgj.343.1668723498884;
        Thu, 17 Nov 2022 14:18:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b00188ef3ea2b6sm1901208plc.262.2022.11.17.14.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:18:18 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 17 Nov 2022 14:18:18 -0800
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: drm_mode_parse_cmdline_named_mode(): Security best
 practices violations
Message-ID: <202211171417.5A924A838@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221117 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Nov 15 10:09:44 2022 +0100
    a7ab155397dd ("drm/modes: Switch to named mode descriptors")

Coverity reported the following:

*** CID 1527354:  Security best practices violations  (STRING_OVERFLOW)
drivers/gpu/drm/drm_modes.c:1812 in drm_mode_parse_cmdline_named_mode()
1806     		int ret;
1807
1808     		ret = str_has_prefix(name, mode->name);
1809     		if (ret != name_end)
1810     			continue;
1811
vvv     CID 1527354:  Security best practices violations  (STRING_OVERFLOW)
vvv     You might overrun the 32-character fixed-size string "cmdline_mode->name" by copying "mode->name" without checking the length.
1812     		strcpy(cmdline_mode->name, mode->name);
1813     		cmdline_mode->pixel_clock = mode->pixel_clock_khz;
1814     		cmdline_mode->xres = mode->xres;
1815     		cmdline_mode->yres = mode->yres;
1816     		cmdline_mode->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
1817     		cmdline_mode->specified = true;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527354 ("Security best practices violations")
Fixes: a7ab155397dd ("drm/modes: Switch to named mode descriptors")

Since mode->name is unbounded, this may overrun cmdline_mode->name
without CONFIG_FORTIFY_SOURCE=y. Please use strscpy().

Thanks for your attention!

-- 
Coverity-bot
