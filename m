Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0A6D312E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDAOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjDAOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:03:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56FB45E;
        Sat,  1 Apr 2023 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NKxwm21XjGgUdSW0+D1bTw1sMwz5rzkfKXeghzRuYj0=; b=AEFwoGNnpXLeMA+AiUz2B7UCEi
        vDMiQP2OWooMbPHAS2IcJF/E9vkC4ZM5uWQbcAmgJgtSgeIGco4qbI5BzH1hBKc05i6WxlcnbD+s3
        WNJn46hRCnWF9t+TUT5omN/H0YHNNBdJ12bozsHdi2jeWBd7Vl0NmAd4GdmKaMGc8S0E+kFqV9pOs
        O4QtbfJ+rvZxkOnP+W+7Lnh6i+6pYT9DELgHP3vbTBhHLyA9jfkQ9l/tYmm45APreqWALx3BzqNVz
        Jb0CGQzv3arE4L3TxhoocIHmjAoYLkrXoG3UE9GGV8X1A+RQ2H0YJY6R+Fwxw/9D1fggR2n1G9DTn
        4L9llH1g==;
Received: from p200300ccff2d4a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2d:4a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pibpg-0006g6-9L; Sat, 01 Apr 2023 16:03:53 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pibpf-00E73Z-34;
        Sat, 01 Apr 2023 16:03:51 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@kernel.org,
        Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/2] MAINTAINERS: add board bindings list to OMAP2+ files
Date:   Sat,  1 Apr 2023 16:02:48 +0200
Message-Id: <20230401140248.3363674-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401140248.3363674-1-andreas@kemnade.info>
References: <20230401140248.3363674-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add list of OMAP2+ boards to the corresponding section

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99b665e85f0a..e6c1d54a4d08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15354,6 +15354,7 @@ W:	http://www.muru.com/linux/omap/
 W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
+F:	Documentation/devicetree/bindings/arm/ti.yaml
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	drivers/bus/ti-sysc.c
-- 
2.30.2

