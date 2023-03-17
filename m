Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A26BE0AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCQFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCQFe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:34:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7B59D1;
        Thu, 16 Mar 2023 22:34:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c19so4520051qtn.13;
        Thu, 16 Mar 2023 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679031267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx3gGRqx4/m3lfeWgeatzDd6uUaWaW5VuukOqSePRZY=;
        b=Tgxr8XwSRFXtwH425wTKOTzzXXDRE2NjNQ/YMkLbf5tokfRWq7pFzV1AJjHrmw1U9T
         Rsm68aBG4HtA8dg+R2h3AIOf8mMKImW3JQne6Xqu/JsNAZybJimZIqqssA3he02wSuug
         DBjjw3b8TtCxpSJm/+SxBsbU61TcO/lcYTOO4g8bOLJYM4bWIXkjovrvvRKuFXih/xLP
         PXA5ZHCeJYFwunrUXOuu3tQWm3ZKoTtilVulJdjC9LMKuNJTa6rLA4YD/2+f+btb96oS
         2UlgansAsts0zyDBGnvBTLmVO/Letd1gWEUkCXdNUt9SM8Z6GtlYHGeZn8VFMTrpknvt
         2Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679031267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx3gGRqx4/m3lfeWgeatzDd6uUaWaW5VuukOqSePRZY=;
        b=0uUTkgzNeLmu6reElQEnqKCUD6fzf1mgEakdCBaWFm+eqW5/5bPP0Jnid8rf/vICTJ
         j0yJYelwmxc59zqxy30nq84aOYSi3WPCa/cY0PSx5A+eotE8wsYHvA50VJQ/SayHTWoz
         1JkrPrrl4ryoflHCxoAsDqFQIsV2NWAXu4KIJcZnS/zwTJNGJFlvxwUjJhZrR8TOlBhd
         1g5UGVavP95igAV7l1CbTOWfbuSWdBH0SnVwBcA6A4/Fy21MZzeDFjE0Z0lPs+IXYOQ6
         6jYDwJeQLq88LGl9HcsFk7VVeXgi5+Jca1JFeWBThNMUl80+rn4NzicMkF4BWLyzx9yH
         vC8g==
X-Gm-Message-State: AO0yUKXKqlWYJanPzoVTfMHR1E02xQXfiwy6pn9fOaFoM54VGMMntJB6
        wknG32Ybu3fIUCNbcu3N+w8=
X-Google-Smtp-Source: AK7set+2aHVOS1fP3CvFLZRdYjosnmYIllmPb4Bs2xC51KZ/lqGIbv8LJvJDotSguh6yu6Up+O6f8w==
X-Received: by 2002:a05:622a:28f:b0:3b6:3a12:2bf9 with SMTP id z15-20020a05622a028f00b003b63a122bf9mr10209230qtw.2.1679031267500;
        Thu, 16 Mar 2023 22:34:27 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:557c:9772:415e:adc7])
        by smtp.gmail.com with ESMTPSA id i5-20020ac860c5000000b003b34650039bsm737649qtm.76.2023.03.16.22.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:34:27 -0700 (PDT)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/2] of: populate of_root_node if not set (alternate)
Date:   Fri, 17 Mar 2023 00:34:13 -0500
Message-Id: <20230317053415.2254616-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This series is a different implementation to achieve the goals of
https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin.com

In order to apply overlays or create new nodes under the root node, the
kernel expects of_root to be set. On some system where a device-tree was
not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
then we will end up with a null of_root. This series adds support to
create this root node using a builtin dtb and removes the manual
creation of the root node done in unittests.c.

Changes since version 3: (all)
  - also tested on UML (previously only tested on arm)

Changes since version 3: (patch 1/2)
  - refresh for 6.3-rc1
  - unflatten_device_tree() - calculate of_fdt_crc32 if setting
    initial_boot_params to __dtb_empty_root_begin so CRC check
    in of_fdt_raw_init() will not fail

Changes since version 3: (patch 2/2)
  - refresh for 6.3-rc1
  - remove the CONFIG_UML case of populating the devicetree
  - unittest_data_add() - move an EXPECT_BEGIN() to after an error
    check that can result in an early return

Changes since version 2: (patch 1/2)
  - change of __dtb_empty_root_* from "void *" to "uint8_t []"

Changes since version 1: (patch 1/2)
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix typo in of_fdt.h: s/of_setup/setup_of
  - unflatten_device_tree(): validate size in header field dtb_empty_root
    that will be used to copy dtb_empty_root
  - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE

Changes since version 1: (patch 2/2)
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix formatting error (leading space) in patch comment



Frank Rowand (2):
  of: create of_root if no dtb provided
  of: unittest: treat missing of_root as error instead of fixing up

 drivers/of/Kconfig        |  7 ++++++-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 29 ++++++++++++++++++++++++++++-
 drivers/of/unittest.c     | 16 ++++------------
 include/linux/of_fdt.h    |  2 ++
 init/main.c               |  2 ++
 7 files changed, 49 insertions(+), 15 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

-- 
Frank Rowand <frowand.list@gmail.com>

