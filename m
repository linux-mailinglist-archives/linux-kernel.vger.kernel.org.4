Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0156B8977
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCNETD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCNETA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:19:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895D7B48B;
        Mon, 13 Mar 2023 21:18:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j11so56945756edq.4;
        Mon, 13 Mar 2023 21:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678767534;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ7QQfw5FkuIei/cI2/povdDw4YVh92kNRopK67KOaU=;
        b=hf9G36pJEd0q3oRNqsR0+UcJ2hf1QLXVFpTC51sPFQz7JQUXaMrdxdJ/8smJc8kM7L
         K7AW8Rfc1KGAa6oOIkCgzaulTIJDTYP//vMFuHWJTCqK+IGiq8FT2cSTMxcg6B0etO58
         tdX5pV/C1iZ6w7gUJ939t/5/V91u4dfQ0BGHnturmzHVSpFS1dt9xvdCt/coUYvZv4O9
         z1/xTpTqx3jEGOe3UJG/dCyqDqGh6VUAU3KIr6nV6U8c1sJ6cMw0QvBnU8DxKseiqAMh
         bnuNFFd4vfiBxKFwn48pmQOhqzKm1HGQrEpecfhD9v68h8WLg7npTvwpJEv18MGsa/vr
         nsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678767534;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ7QQfw5FkuIei/cI2/povdDw4YVh92kNRopK67KOaU=;
        b=ygB4B++9TPrhoLpd1Hxxj1jrWBJiLVxfrnH43UoZw8H9MzJnThjvQJoPAUoxQ3kXa3
         aprICCrfoxo3Zk3F3SqcL9GCragyrmFheyL3B/qw9KgwtsLOYUpLjaKZOaDKHkPfH1aD
         ECNO3zALRP2GEAM58gwFO93Kdm5od1aK2uh1Nd3Bp11VvoznzCJe0rNyfuTrSXOy+NgF
         L86E3JoTVfdeNXYQH4Qqw7KwIcX8nVf7jI00ZlECKnAS2nqtlckdhvTuDNEbk1bU55YE
         6ZahguBfCDiNCE6VLPGMF567UDT3PajRF4i7o6QlMdLEgYfvyJZB8D8RmkzpcTixBtHe
         /H1Q==
X-Gm-Message-State: AO0yUKUZLw740zsJgBvcu43hRRn1mAPMiR3BHQty4B2NMvfgEFWgSsWW
        A8eSLszgJgQs2NF0FM1Xu23mWtPoNC4r1w==
X-Google-Smtp-Source: AK7set8WaRvILSlswipSW/7mqGRZgz1V+baskJ9GNgwqCyY6TUQFybXrFgF6FCsYW+ZBgzh+vud/EQ==
X-Received: by 2002:a17:906:c244:b0:877:a9d2:e5e9 with SMTP id bl4-20020a170906c24400b00877a9d2e5e9mr894889ejb.42.1678767534526;
        Mon, 13 Mar 2023 21:18:54 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:e097:f710:4dc1:9ec4])
        by smtp.gmail.com with ESMTPSA id zk6-20020a17090733c600b00927e0fb3e50sm540390ejb.100.2023.03.13.21.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:18:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entries after wifi driver movement
Date:   Tue, 14 Mar 2023 05:18:48 +0100
Message-Id: <20230314041848.5120-1-lukas.bulwahn@gmail.com>
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

Commit f79cbc77abde ("wifi: move mac80211_hwsim and virt_wifi to virtual
directory") and commit 298e50ad8eb8 ("wifi: move raycs, wl3501 and
rndis_wlan to legacy directory") move remaining wireless drivers into
subdirectories, but does not adjust the entries in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Repair these file references in those wireless driver sections.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25a0981c74b6..8b38772e27dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12309,7 +12309,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
 F:	Documentation/networking/mac80211-injection.rst
 F:	Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst
-F:	drivers/net/wireless/mac80211_hwsim.[ch]
+F:	drivers/net/wireless/virtual/mac80211_hwsim.[ch]
 F:	include/net/mac80211.h
 F:	net/mac80211/
 
@@ -17574,7 +17574,7 @@ F:	include/ras/ras_event.h
 RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-F:	drivers/net/wireless/ray*
+F:	drivers/net/wireless/legacy/ray*
 
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
@@ -21815,7 +21815,7 @@ USB WIRELESS RNDIS DRIVER (rndis_wlan)
 M:	Jussi Kivilinna <jussi.kivilinna@iki.fi>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-F:	drivers/net/wireless/rndis_wlan.c
+F:	drivers/net/wireless/legacy/rndis_wlan.c
 
 USB XHCI DRIVER
 M:	Mathias Nyman <mathias.nyman@intel.com>
@@ -22571,7 +22571,7 @@ F:	drivers/input/misc/wistron_btns.c
 WL3501 WIRELESS PCMCIA CARD DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Odd fixes
-F:	drivers/net/wireless/wl3501*
+F:	drivers/net/wireless/legacy/wl3501*
 
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.cirrus.com
-- 
2.17.1

