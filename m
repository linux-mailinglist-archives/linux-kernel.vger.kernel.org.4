Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC94172B0C6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjFKIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjFKIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 04:16:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043A3589;
        Sun, 11 Jun 2023 01:16:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f623adec61so34073285e9.0;
        Sun, 11 Jun 2023 01:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686471388; x=1689063388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=905cpt816UbdZmkAKTALR8SANtBmtQIMIITLaVtiS6c=;
        b=h/MSSj10JRL6ApDF6iyYGMohmvTHQ3M+eHoRkh5i7V7TCeqBorEhray69e0r/hc5lV
         JtI8UypsimaqLqMVlgh1J/hxp+Qu2Y3DXmorq0GSaanD8hRfUAgrBf687XK9fZ13xj6j
         NucacfbiQlUsN4KcOJ7qXcNTI7KPuV0s892RSQwqGSTl6nzOCPnaAIQTUXSTBGll/Pyv
         BY166lKAQ+32ZfTUWp4EIJmMkWbC0gCH+pnCRXhaHvsfq8Q9mgq1Rzr3OjheYvHqqAuU
         bhU9i3vcBPLmYQc8Uu3mZ4xFJpAv5fS4dynHzvgrDRxjImAtwG60KFq3d4TwPOeWTLq2
         46ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686471388; x=1689063388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=905cpt816UbdZmkAKTALR8SANtBmtQIMIITLaVtiS6c=;
        b=OsRB9kaswIALZ4bzQggn4++beUN4Bi27X2qQVDaoLF0mRQtR7nFLB+bhpEovRrI2FE
         xysbotJtysj+Q6F1/jKUHWCHpIqnGYWvaRLZLqFNCPrA6gLvSwce2Az+ZDAckdYTBMRh
         04K1qTw+jphpYbepv6ASBR8EeOgqz4S2M5L++w2gXurhbdIOMdrXWqsmRUQ/zaHls3KJ
         IGnoiq6vVi+QoUeomYEfElYC3S7QjoH3U/Q/aogkz9Y2lJL9dAoGErp0/duwVxY7L+nt
         OYDbF5jZh3dmX6XhhWVZGa6duh/eaOXPHs4JXPHF/EG8isR+QKTbWrNONKgHPgcEComu
         QIyw==
X-Gm-Message-State: AC+VfDwpaEPqtAK8Hg7PvfCtYlumEiYnMO/ZRevOS4IV380RgT2TzeAp
        oqw/6LfD2Q4NFqBXy/whbWc=
X-Google-Smtp-Source: ACHHUZ5UKivwW7FrZH24UXmp1MZ5paa9KqLvGS94uFeZPAjfJ06aSKFu6O7nwjmYS7Koeofs9Q1RUQ==
X-Received: by 2002:a05:600c:21c7:b0:3f5:fb98:729e with SMTP id x7-20020a05600c21c700b003f5fb98729emr4963298wmj.22.1686471383710;
        Sun, 11 Jun 2023 01:16:23 -0700 (PDT)
Received: from arinc9-Xeront.lan (178-147-169-233.haap.dm.cosmote.net. [178.147.169.233])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003f6132f95e6sm7748979wmj.35.2023.06.11.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 01:16:23 -0700 (PDT)
From:   "=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?=" <arinc9.unal@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 7/7] MAINTAINERS: add me as maintainer of MEDIATEK SWITCH DRIVER
Date:   Sun, 11 Jun 2023 11:15:47 +0300
Message-Id: <20230611081547.26747-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611081547.26747-1-arinc.unal@arinc9.com>
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add me as a maintainer of the MediaTek MT7530 DSA subdriver.

List maintainers in alphabetical order by first name.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73e5a98503a..c58d7fbb40ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13259,10 +13259,11 @@ F:	drivers/memory/mtk-smi.c
 F:	include/soc/mediatek/smi.h
 
 MEDIATEK SWITCH DRIVER
-M:	Sean Wang <sean.wang@mediatek.com>
+M:	Arınç ÜNAL <arinc.unal@arinc9.com>
+M:	Daniel Golle <daniel@makrotopia.org>
 M:	Landen Chao <Landen.Chao@mediatek.com>
 M:	DENG Qingfang <dqfext@gmail.com>
-M:	Daniel Golle <daniel@makrotopia.org>
+M:	Sean Wang <sean.wang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/mt7530-mdio.c
-- 
2.39.2

