Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22135BC48F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiISIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiISIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:44:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB17654;
        Mon, 19 Sep 2022 01:44:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so13873788wrq.1;
        Mon, 19 Sep 2022 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=ZKhCoRgmn8LuQoTolRKqrVMnp/EPBALX9sXITXMxrJ0YkLZ1Ep/JbSpVNuLmJ7zRlH
         /Rq7CsikEIRctWLajFAbXvmxIhg9elZpJAjV+nJTRK5GWxNEBZw9onIgjjXnI2Lrad00
         sgf29V/foxkRQyAz6hAGdc8Lo7gHwZ6rEsuDmbbq4AmoIPrsIs9c3crhmq7JfEoWleft
         +A1NnpNdScTN1k8Vrwew3e9tXhBYRrZH8O7n+1EYJhTkS+1JjRQCO9Ut68sGePVB29U7
         b1NPRiT+gH/zoNxdNXtddZNCpiQGk3N6MSd/Xc9lO60BOUo3EHQoqqAHeksNy8QkBqbx
         TmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=8PHIVA792/YaPWPV/OW3Kijmx4liLRPGH8LRsinpaors6JQCD/jm7Lr/gD9E0ETlrG
         KuzwEd7bk6GJDWBFKC2ldkFo4yvam7QoB3Togaj5hWBDIObfsmKw8UJeoQasRl8EWDM4
         yl1+rc7KAUC4Ad8cM5W5gsAmg/DES0O9hoYokWt2VZ3bSqCu0Ne4a5W1EeJcUSg5+425
         KgUsKDolqxdD6RfSO+BXDW/UhiyytTfgF77gIpyq2ZOc6I0kOg9Z5WBcUW96gUcm/0mI
         x2u69z9QkbG83d1lPy5Qt3tiOSIjuBZ0pE4fHtpmaQm57JYMb2dqkmDgH8vGsxF8KlaH
         sguw==
X-Gm-Message-State: ACrzQf2WaOv/RZ49eix879Msuxa9aBBl4OS98PrPiTKeGJuCV0CGrzag
        eMmBA/q1+yJvvkrYH7QVgJA=
X-Google-Smtp-Source: AMsMyM6exrwDfCfPms+cYpiKC3RUDiyPB8NFzSNHudM+h8ms8Fp4eWcDOTYIZp4OshTomZhFlZTJLA==
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id r16-20020a5d52d0000000b0021e4923fa09mr10302271wrv.244.1663577077539;
        Mon, 19 Sep 2022 01:44:37 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b00228cd9f6349sm12892254wrp.106.2022.09.19.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:44:37 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after refactoring
Date:   Mon, 19 Sep 2022 10:44:25 +0200
Message-Id: <20220919084425.32746-1-lukas.bulwahn@gmail.com>
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

Update the SWIOTLB SUBSYSTEM to contain the architecture-independent
pieces for swiotlb, but leave the small architecture-dependent pieces to
the architecture maintainers.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
v1: https://lore.kernel.org/lkml/20220601075613.28245-1-lukas.bulwahn@gmail.com/
v1 -> v2:
  addressed Christoph's comment, removed arch/*/kernel/pci-swiotlb.c
  added Juergen's ack

Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index babb441f7474..69d58c43bd6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19699,7 +19699,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
 F:	include/linux/swiotlb.h
 F:	kernel/dma/swiotlb.c
 
@@ -22403,8 +22402,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
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

