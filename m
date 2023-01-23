Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49367799F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAWKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:53:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8286AA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:53:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j17so8680331wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJJNcufNtuaisjvQK2ChXy93daPNKRKW1qtkKLWAQ4=;
        b=yEVqAbeWLluveXp/VTFrrCJYUrV4elpQpWZWdW21Wauk98Xo7klhAO3oAHWpjvOqHU
         W51Nx2DzBJSM36+25bPjyHrvimxXlPIZUbkiTYmUkB9VQKvvBNO2Y5Xfbs0F4sM2+nsU
         D4/icgc0CI0AB7QU1HHjcBYmDSa6E+mOsudetMmQS3WLjeTIC+1PeXvmyVgOlFKv/JVI
         xnFlnjCLFJQj/p8CmvLJNB3RPZyT8vFkw2VPZOGYSS7eb6xwj+U8VUCOGTFTB8MVoM5p
         mXl1Z/ZBr2tEcwo7ihH687hnYjo7lC5O8/ioxE930GrlA8thIsJwOXAauKUbttFoiQhB
         4HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdJJNcufNtuaisjvQK2ChXy93daPNKRKW1qtkKLWAQ4=;
        b=bUu9auhE4N9oy2DJNcAM7npK+UhY6vZRm36+vTnjJGrc1fVONyWoLXNg8n7qFBvYta
         SfPhQ8Oz3Si9HbnuPpyd6BXRtd4WwyR1PXIYwpiM3Kv+6d1V4G1FjQUgDjOTy10IPuj0
         QRybPKSBaJcmoc/qyyPkvTkVUFJRcp0K9Q7hYwWXCKHSJ4pb0y+hmCcwKH01znboy1PH
         lAwlsN2Wwz04elSf4fTzXzSMdT92FPKzt7iztNHIZX/sm0f7TEHl6E6Cxsz6XdcjE3tv
         nmN0E/V3i8NwsFARp/EmrAGEp/ZDVHcAZzY/o7eI6jIC1pv0Ou/dRthZyvNPwgctOY5j
         tbyw==
X-Gm-Message-State: AFqh2krkYM7I8aqoKAtlkSqwxkbuoAV4P1ourI0GRvzMGtfiXBv3UzA6
        Ayl1emX0TeWPGgB7eL3nolqBaQ==
X-Google-Smtp-Source: AMrXdXvCUzBZ7lNA/yyyDLkfzfr7k8v1XZckOCzSEcaqREsi/y3xn7LlyZaKArybPHRgG7gssZYxgA==
X-Received: by 2002:a05:600c:4f96:b0:3db:2df0:f2b8 with SMTP id n22-20020a05600c4f9600b003db2df0f2b8mr12762253wmq.36.1674471213842;
        Mon, 23 Jan 2023 02:53:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003d990372dd5sm11382125wms.20.2023.01.23.02.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:53:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [GIT PULL] memory: drivers for v6.3, corrected, v2
Date:   Mon, 23 Jan 2023 11:53:30 +0100
Message-Id: <20230123105330.63709-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 2 of the same pull request - dropped one patch which was not needed.

Best regards,
Krzysztof


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.3-2

for you to fetch changes up to bbaf6624f23d6e538401382be97ba3d4bcba963e:

  memory: ti-emif-pm: Use device_get_match_data() to simplify the code (2023-01-23 11:48:31 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.3

1. TI Emif: simplify device_get_match_data().
2. Renesas RPC IF:
   - Few fixes (decouple driver's private data structure from other
     drivers; unbind and rebind due to triggering managed resources
     allocation from other drivers);
   - Bigger rework around improved runtime Power Management.

----------------------------------------------------------------
Geert Uytterhoeven (6):
      memory: renesas-rpc-if: Split-off private data from struct rpcif
      memory: renesas-rpc-if: Move resource acquisition to .probe()
      memory: renesas-rpc-if: Always use dev in rpcif_probe()
      memory: renesas-rpc-if: Improve Runtime PM handling
      memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
      memory: renesas-rpc-if: Remove Runtime PM wrappers

ye xingchen (1):
      memory: ti-emif-pm: Use device_get_match_data() to simplify the code

 drivers/memory/renesas-rpc-if.c | 152 ++++++++++++++++++++++++++--------------
 drivers/memory/ti-emif-pm.c     |   7 +-
 drivers/mtd/hyperbus/rpc-if.c   |  18 ++---
 drivers/spi/spi-rpc-if.c        |  14 ++--
 include/memory/renesas-rpc-if.h |  34 ++-------
 5 files changed, 119 insertions(+), 106 deletions(-)
