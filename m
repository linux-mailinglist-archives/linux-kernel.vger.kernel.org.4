Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29615BC4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiISIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiISIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:48:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE49BE36;
        Mon, 19 Sep 2022 01:48:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so46399935wrx.8;
        Mon, 19 Sep 2022 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=pkwi8nsN9NDMEjsY4MvvhMCnG4OoSO3psLEaN68e788BwWN6q9jdox1XHrguwF/rWf
         0uohS/6e5t9zS0hiDt36er3Qojp0Hao0/EYZ0buUTekrv22g+IAQhXl/aD6aV0bPcH0O
         bul1armvjAHpjbEez6cA4c3j5xQaFS5Xg5f+7itr8ZHVoms9QIXHmG7NhvqFUZeUKhMK
         +sstfbrP2ig3wiwhnlsaJr4huN846qt5SA1qJ2R/uin97XRzvsdlV7qtEC82jzlolOKC
         D+bwlxwPtICnlKZHxgv9NUGkUn3EiOIdrCWsFWLP6BGyzbEAF/swiXA+DuFkcjl8hw1w
         xxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sJ05nwhQyH1wMzlPk+xM6G6uKn99zlu7sIdHkCfF+5Q=;
        b=YhkbgDkhfvGMRjSCU5EPcx2ex9Mte+2rSI/pB54j6C5Tg/JoJT1MXlNmP6tHC0m9yH
         /wPpUtBhLVdW+5VfxX0w/UAsyXhsnlIOAzhOOPCjOa6IXj39lzy1WQo4sbJoWNAiw4jF
         lOdbBUTdTOVhWBJFVuwObRrHRi+L7CLCediti+H8TdxMvTO0LGXFwnCzPJk4cHxpyHIi
         dLCBdG4hyD/T2M10ndyeVaqMhZOwgZ1ZH6kUXx6xPItMZLjc+RQ9UGer8vPu/Dn327XU
         EM6yZ1gdA/SD5HVWOwnspdqZgWYoCwz5H02gVx4j0IMbfbWMnwIoY1WBNwtafieCawmb
         i2bA==
X-Gm-Message-State: ACrzQf1zm5hVOHfca0rMr7cqn7ClqUeeizWQznoi9kwklLWvN7aHkduY
        3jG8BVi0npA2mT5kKLPrllSYje5bC7Y=
X-Google-Smtp-Source: AMsMyM5HeTIRifF54cDZV5YELSwKmAEMfl1TCa7MzD5pz4j0ErB/1h+iX+/jTt7GGSJhH+Pt79VWsQ==
X-Received: by 2002:a05:6000:124f:b0:228:8713:ced9 with SMTP id j15-20020a056000124f00b002288713ced9mr10175266wrx.198.1663577299621;
        Mon, 19 Sep 2022 01:48:19 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0022aeba020casm7540610wrb.83.2022.09.19.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:48:19 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after refactoring
Date:   Mon, 19 Sep 2022 10:47:44 +0200
Message-Id: <20220919084744.3043-1-lukas.bulwahn@gmail.com>
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

