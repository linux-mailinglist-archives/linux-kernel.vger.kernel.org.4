Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD663F448
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiLAPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLAPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:39:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884A5803C;
        Thu,  1 Dec 2022 07:38:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so3258571wrw.13;
        Thu, 01 Dec 2022 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIaQOgfMcE/GO6nbKr8PgFmDaCwOiD/COdGZXSFPO3M=;
        b=E3geviGqKB2TzYiRvQ/grhwJZrK6KFqLZIp05t0haGJET64z82MLT+1yuZXlRebIv/
         Awss+4bqdFtJ0O6w0GDKVLHe5yhkmhxfAUFYuzq78lhbY9a5/Ox+7rscSqdKFIkii6S7
         GnzTh1/tvJCdzNEVBraZJcaxVZBXaA8J2182usY+yKeigIAgog/id+4u/8KVIxI6+x5K
         +QxP50LSWrpC6r1IJisjte42Ookkx3z8ao7cVYuIoVVL55UdAOIQWC+9JuBR1A0dMMsF
         vswhKpzAdW8bQziBwqkiDeCKpui/siNW98btnRDADIsdb3KNGJQPkfSJI/PKuaTOLS07
         EhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIaQOgfMcE/GO6nbKr8PgFmDaCwOiD/COdGZXSFPO3M=;
        b=8MqzpzaQzaeKJYRLGeSTQnAyq9AdIxWtulvhw/BZUFsVf902C4xQHxzQF/hPOz6b2X
         Zk6bwgdlKMy0J4gp9e3ZYg2s47yQbEWbUnfm/Hy9SjGvFohNXHB59vObvDvxmqxTgU1W
         TxaexDYHW6R+YLhBWfMzPjn82xt6NUEXflCzDa1AGlsghtTIBuqMSOx+kWKJadBD7kbn
         gCIXQyvw/jdSqm2L6QWGzVr4rmOKRdgJSFqsmUGGLOxgr3Br44f+9BH/BubUQZGar4a5
         5cCXTKYOzNJsUfBxryLy6Ulkx938E1dL3XK3n9Q435U6EaHxw/IwJHwFlpwCTpVUPYrq
         1L5Q==
X-Gm-Message-State: ANoB5plHRK934FJe47YiYstyah8PHrufygfePrR4fggx/OfUYOlFQpE0
        Y7IgUcpfiZ1vfslJdqdAM5c=
X-Google-Smtp-Source: AA0mqf5ysOVW/Kh9k2qAFFRO9E3GopXIGKrpSXH9FsDqiC/hwM1sNXt1+Gei6ZSSMh8u0cUZy9H63Q==
X-Received: by 2002:a05:6000:1208:b0:236:4838:515d with SMTP id e8-20020a056000120800b002364838515dmr40090363wrx.541.1669909127076;
        Thu, 01 Dec 2022 07:38:47 -0800 (PST)
Received: from wlan-cl-kit-cs-172-17-20-201.scc.kit.edu ([2a00:1398:9:fb03:6341:588f:5b6d:9173])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm5523597wmb.42.2022.12.01.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:38:46 -0800 (PST)
From:   Peter Maucher <bellosilicio@gmail.com>
To:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Maucher <bellosilicio@gmail.com>
Subject: [PATCH 0/3] amdgpu/drm: Documentation updates
Date:   Thu,  1 Dec 2022 16:38:18 +0100
Message-Id: <20221201153820.257570-1-bellosilicio@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Explain difference between gttsize and gartsize
module parameters, and amend related documentation.
Also, amdgpu does support RDNA GPUs.


Peter Maucher (3):
  drm/amdgpu: improve GART and GTT documentation
  drm/amdgpu: add GART and GTT to glossary
  drm/amdgpu: mention RDNA support in docu

 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  6 ++++++
 Documentation/gpu/amdgpu/index.rst           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 11 ++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.38.1

