Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA015E5F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIVKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIVKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:00:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8FA0327;
        Thu, 22 Sep 2022 03:00:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so19749722ejb.13;
        Thu, 22 Sep 2022 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hiz8j1ueWdpy1uTExZ+MoWZWMdqOcerL2IyS7vev/Lo=;
        b=qve8F367vri9vq2lNgPzzRwLYLQxb4ZdSpnBQTTL3sibXPY22aLAjYVTCNNfQ0UIY6
         UTyii6rVby5uvqqz48Leh7jQKfCazE0bn/1rSUdcfZClCza1CCIlbV6j0ejDjYqgduxx
         1nLfxzcz3u+oKQu4jdJpqsF/k1rU3852PwU0YkGR+9VpeRSwO4dsAn+p18sJbtykzS5p
         hryazIZMHBz//afiNf6gbWpi0lCSvAj4ZDKqTrmDNIPowqPOx1YvPHal1LlR/s2j0UjR
         sjm0AO+9mS2J9ygnNNUNkqeuWnPN5xVinCG7U7Em3EbnhaI90WLm0++wtrqlvzhW2zRN
         Mqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hiz8j1ueWdpy1uTExZ+MoWZWMdqOcerL2IyS7vev/Lo=;
        b=SQbYDrAncCWrhyWUpK/8bQi+H5KHT8wE0ARg17NqxcFnIJs1zsR/mDU/Tln3HGI81K
         LK3CfrlBjjtuudLvKVwvNF2QBbp9BiOFXTvZq9V0Pfl9ojlX2OCQQew2zilzDPcZB4UH
         VDlHaQXCB/vRlFcvqKAI5FG3Gxg7kmrXraA+ZZGQEikBrQKOADuphQN2uIFILef36+fe
         OBUR96u+ZXHj68FhaulCcP5SzjG4KoqR5C85mY3GYUOgwsNyQB4B1IRFSeEVmJhXk+mH
         qj4wG1+3VAgwS0ERoplgnQeTJLd4Ju0rVpTeSnlzAfbL0a1Ingf2aet905TKzjnL/dCv
         RfdQ==
X-Gm-Message-State: ACrzQf2rUSq8bk0M63cgBfViw3ngMqHBZDEgZe9dBlF5pD5vfaXY2fv+
        TcyL5bf9Yaa6eqwt7QIuY0o=
X-Google-Smtp-Source: AMsMyM6unBwC8/e3r0Rtx0/Sohl7J4lUQssMjBKp3vA8rOlQMATFFO0WHs0QwvNvk0svfi+Y3KP3/A==
X-Received: by 2002:a17:907:b15:b0:782:f8:8695 with SMTP id h21-20020a1709070b1500b0078200f88695mr1966054ejl.693.1663840826832;
        Thu, 22 Sep 2022 03:00:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826ee9d002d7918fb932a6deb.dip.versatel-1u1.de. [2001:16b8:26ee:9d00:2d79:18fb:932a:6deb])
        by smtp.gmail.com with ESMTPSA id ez24-20020a1709070bd800b00741383c1c5bsm2344770ejc.196.2022.09.22.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:00:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] MAINTAINERS: merge SWIOTLB SUBSYSTEM into DMA MAPPING HELPERS
Date:   Thu, 22 Sep 2022 12:00:01 +0200
Message-Id: <20220922100001.12964-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 78013eaadf69 ("x86: remove the IOMMU table infrastructure")
refactored the generic swiotlb/swiotlb-xen setup into pci-dma.c, but
misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

As only include/linux/swiotlb.h is unique to the SWIOTLB SUBSYSTEM section
and Christoph is maintainer of DMA MAPPING HELPERS and SWIOTLB SUBSYSTEM,
just merge those two sections.

Leave the small architecture-dependent pieces to the arch maintainers.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
v1: https://lore.kernel.org/lkml/20220601075613.28245-1-lukas.bulwahn@gmail.com/
v1 -> v2: https://lore.kernel.org/lkml/20220919084744.3043-1-lukas.bulwahn@gmail.com/
  addressed Christoph's comment, removed arch/*/kernel/pci-swiotlb.c
  added Juergen's ack
v2 -> v3: 
  merged sections as requested by Christoph

Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d06f0b2861a..52f31f11bb0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6166,6 +6166,7 @@ F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
+F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
@@ -19739,16 +19740,6 @@ S:	Maintained
 F:	Documentation/admin-guide/svga.rst
 F:	arch/x86/boot/video*
 
-SWIOTLB SUBSYSTEM
-M:	Christoph Hellwig <hch@infradead.org>
-L:	iommu@lists.linux.dev
-S:	Supported
-W:	http://git.infradead.org/users/hch/dma-mapping.git
-T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
-F:	include/linux/swiotlb.h
-F:	kernel/dma/swiotlb.c
-
 SWITCHDEV
 M:	Jiri Pirko <jiri@resnulli.us>
 M:	Ivan Vecera <ivecera@redhat.com>
@@ -22457,8 +22448,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux.dev
 S:	Supported
-F:	arch/x86/xen/*swiotlb*
-F:	drivers/xen/*swiotlb*
+F:	arch/*/include/asm/xen/swiotlb-xen.h
+F:	drivers/xen/swiotlb-xen.c
+F:	include/xen/arm/swiotlb-xen.h
+F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
 C:	irc://irc.oftc.net/xfs
-- 
2.17.1

