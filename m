Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BD6894AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBCKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjBCKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:02:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4F293AF0;
        Fri,  3 Feb 2023 02:02:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay1so3182855pfb.7;
        Fri, 03 Feb 2023 02:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZM2kRnUMq/5JxUqAj92h8CE9Ys20GpS+bcD8sHbxGY=;
        b=MoBwsiFh+PQwRc+ml6iuRDqdl5/NFddPFYIwdi7shrfKdxQojJlglETNVcoxcFbeq7
         UQJl43hvF2JW+oxHrqZ+PYm/8YFRae3V0NrPaa5mTWI15gXYGncVGae9cCjpG4CRqMiA
         9Pj/x71a+1UhhPgRzHSlzVh6c2OeFmzl6woB/kPM1ATos4UIxHPHaPyDOJtH8wzgGaPO
         DkOEa4bmsfqANA9W0VKMMobCnKbwjAegUkH6avPb67JGriW6ySxlSlYNDw8esdDqQ5tq
         zt+gRScqxTBmdYI7AEl0bwX4sIa2Wv8t0T5OYVEzI8GAeVcWMrOHsv8qoHjy703uRwYJ
         T6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZM2kRnUMq/5JxUqAj92h8CE9Ys20GpS+bcD8sHbxGY=;
        b=yWpB9vR5kwExjTmrJujLyl8oQ9owArNYiFDrnATnlYitXOO+D7Q/HV0ozAHnRw4FuO
         vjPfBIL0U1R/Wkm87YIoZdS2MH6VFpb/7CLoMSFShRUeNH1lltALWpuatIpP6NG8NRbr
         jYUFL+kwiQbZRsqFjGZEuMrzagEVRdp7qCDj6LUZ4H31Cksa011H/7SHMqm6ZPnBn2Jt
         aC4BVJvSeGJScTulQ2+d38Ce1U7aL3Byq4lUFuZ7HfXbTm5FJ2Zt1zCTIbx5aD7DWoNe
         p0rOFJ6uI0TOl6ickmeI2cFMcrXbHfh76a6sTvo72rlUcn3uBfwd5wJopG1md8j7aJG6
         cmmA==
X-Gm-Message-State: AO0yUKXt8sNxrldSSuWMFXLgBGIP6Ydv/vdcUzXS0xJTLlfSWSU9hj8O
        c8xvIScXhQZoCDnx/AL2Skg=
X-Google-Smtp-Source: AK7set90g3y3uA58nDdc57a7ikxwpTnV8UfDIaEQROixtGcb1zi0SwtESdeyB1ms4FZFJ3dF2+AdIg==
X-Received: by 2002:a05:6a00:1d85:b0:593:a3f1:7c04 with SMTP id z5-20020a056a001d8500b00593a3f17c04mr8761934pfw.8.1675418567508;
        Fri, 03 Feb 2023 02:02:47 -0800 (PST)
Received: from debian.me (subs10b-223-255-225-232.three.co.id. [223.255.225.232])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00230200b005898fcb7c1bsm1322187pfh.177.2023.02.03.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:02:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 01B981055BB; Fri,  3 Feb 2023 17:02:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Intel Graphics Development List <intel-gfx@lists.freedesktop.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Srinivasan Shanmugam <srinivasan.s@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] htmldocs fixes for next-20230203
Date:   Fri,  3 Feb 2023 17:02:12 +0700
Message-Id: <20230203100215.31852-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=683; i=bagasdotme@gmail.com; h=from:subject; bh=nAqFypAiZuomaGsgK+qGsO/TWXGkM+TOboIWhpu6fPE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl3bs/Zx6DeNWPyHO/4uWqzTIRO5L1fe3PivJY695cfLve9 2OpQ2lHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ9C1h+B84Z3HYYaODyTlujAbnnS eXeDVt2p+5bN2Vxf9OeC6IOjyBkWHPo5c2AmbLPigoTbEp/KQVInNX7vySwz7vK2fMMn66dg8fAA==
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

Here are small htmldocs fixes for htmldocs warnings that are recently
reported for next-20230203. Each patch can be applied separately by
respective maintainers.

Bagas Sanjaya (3):
  drm/i915/doc: Escape wildcard in method names
  drm/scheduler: Fix elapsed_ns kernel-doc error
  media: v4l2-core: Describe privacy_led field of v4l2_subdev

 drivers/gpu/drm/i915/gt/intel_workarounds.c | 6 +++---
 include/drm/gpu_scheduler.h                 | 2 +-
 include/media/v4l2-subdev.h                 | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)


base-commit: 4fafd96910add124586b549ad005dcd179de8a18
-- 
An old man doll... just what I always wanted! - Clara

