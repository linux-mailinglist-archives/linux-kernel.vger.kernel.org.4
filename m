Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DE72B986
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjFLIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFLIAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:00:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546B2127;
        Mon, 12 Jun 2023 01:00:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so29075305e9.0;
        Mon, 12 Jun 2023 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556800; x=1689148800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXYm2hz4kTxElsLw4X9ny+JM0G1qOYMFtL4G8lKVhQM=;
        b=lyoz+qj3DjC6mSttnlFKGyFtZPlMrL34MoqEv0ofoVqEUCNY1tOVgvitKJAsDLI+f6
         4ZY6ASXRe/ClSVw+VyOcIg8fiDZOMZ7NBqF8GsBaW8Tl0dGzFNzz7BAmX4OB19q4UEb5
         vvoc1HDwFthTiF4cr1Mai6bvKet1yeImUnLRU5i3pxI/I7CyTWDEGWMLYYPXlX7C+VUa
         YuDKBnetuJtREytacpWZsyK3X5+weChm5kQQxLINcSu53yALZVCnPS40cwf1OCMKxGNs
         qBnbHdSDKlxACNOmvM94WhY+caPNv5a+VjbML3oeg2/xVNuvpdzcOD0f+HG9aWcAmCoi
         f/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556800; x=1689148800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXYm2hz4kTxElsLw4X9ny+JM0G1qOYMFtL4G8lKVhQM=;
        b=RSjiZWnQlSniturUXfwA+dKdvs1jmz9WsvwjPWEZMOQcFvJnT4w2c3kzE6zhhNwmN0
         hXH2LS+o85EbDRa03hA8+TXbMpnpm1NOyT3cOaOJatdiDGyPkXYl1kCxQ0wlB4loqbK+
         DXuBbdAxp9rui+ZPd22eWzPtLCcICiLXkZpucqSZIyPr9RvGgiwKjvgqbgAvMdYTVEWY
         R/MkN9MBdopeQOFD46Lr71OGYk1uI9sCIiHHnDpkRqVNoe0S+B8EsXOsW6nIXsKZ7LbQ
         AFldGh1QdSVnuq4kUUffAssMguYRi6chV2sVQG7iPjVzvShU4QNBHCPM6Qs1cy2jrI+Y
         cSiA==
X-Gm-Message-State: AC+VfDzFLER4D0P/UDZp18jyfcJG1w7KUuZoE8YIIiKcP11vRYGa3YSZ
        sXPzlbFTRYVue/4zC4TsLF4=
X-Google-Smtp-Source: ACHHUZ6W+NhXelu4c0LZFp0zNLt2oI3Q7Ebek7+5IhRWbZtZQWSFum6bcEQOeDKUD7OB7vxmL1bvaQ==
X-Received: by 2002:a7b:cd97:0:b0:3f7:678a:cf24 with SMTP id y23-20020a7bcd97000000b003f7678acf24mr5445926wmj.39.1686556799953;
        Mon, 12 Jun 2023 00:59:59 -0700 (PDT)
Received: from arinc9-Xeront.lan (178-147-169-233.haap.dm.cosmote.net. [178.147.169.233])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm10552195wmj.5.2023.06.12.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:59:59 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
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
Subject: [PATCH net v4 2/7] net: dsa: mt7530: fix trapping frames with multiple CPU ports on MT7530
Date:   Mon, 12 Jun 2023 10:59:40 +0300
Message-Id: <20230612075945.16330-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612075945.16330-1-arinc.unal@arinc9.com>
References: <20230612075945.16330-1-arinc.unal@arinc9.com>
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The CPU_PORT bits represent the CPU port to trap frames to for the MT7530
switch. This switch traps frames received from a user port to the CPU port
set on the CPU_PORT bits, regardless of the affinity of the user port from
which the frames are received.

When multiple CPU ports are being used, the trapped frames won't be
received when the DSA conduit interface, which the frames are supposed to
be trapped to, is down because it's not affine to any user port. This
requires the DSA conduit interface to be manually set up for the trapped
frames to be received.

To fix this, implement ds->ops->master_state_change() on this subdriver and
set the CPU_PORT bits to the CPU port which the DSA conduit interface its
affine to is up. Introduce the active_cpu_ports field to store the
information of the active CPU ports. Correct the macros, CPU_PORT is bits 4
through 6 of the register.

Add a comment to explain frame trapping for this switch.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 32 ++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h |  6 ++++--
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b1657679e69d..ef8879087932 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1006,10 +1006,6 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
 		   UNU_FFP(BIT(port)));
 
-	/* Set CPU port number */
-	if (priv->id == ID_MT7621)
-		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
-
 	/* Add the CPU port to the CPU port bitmap for MT7531 and the switch on
 	 * the MT7988 SoC. Frames received from a user port which are set for
 	 * trapping to CPU port will be trapped to the CPU port that is affine
@@ -3063,6 +3059,33 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void
+mt753x_master_state_change(struct dsa_switch *ds,
+			   const struct net_device *master,
+			   bool operational)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp = master->dsa_ptr;
+
+	/* Set the CPU port to trap frames to for MT7530. There can be only one
+	 * CPU port due to CPU_PORT having only 3 bits. Frames received from a
+	 * user port which are set for trapping to CPU port will be trapped to
+	 * the numerically smallest CPU port which is affine to the DSA conduit
+	 * interface that is up.
+	 */
+	if (priv->id != ID_MT7621)
+		return;
+
+	if (operational)
+		priv->active_cpu_ports |= BIT(cpu_dp->index);
+	else
+		priv->active_cpu_ports &= ~BIT(cpu_dp->index);
+
+	if (priv->active_cpu_ports)
+		mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, CPU_EN |
+			   CPU_PORT(__ffs(priv->active_cpu_ports)));
+}
+
 static int mt7988_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
 {
 	return 0;
@@ -3117,6 +3140,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.phylink_mac_link_up	= mt753x_phylink_mac_link_up,
 	.get_mac_eee		= mt753x_get_mac_eee,
 	.set_mac_eee		= mt753x_set_mac_eee,
+	.master_state_change	= mt753x_master_state_change,
 };
 EXPORT_SYMBOL_GPL(mt7530_switch_ops);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index e590cf43f3ae..28dbd131a535 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -41,8 +41,8 @@ enum mt753x_id {
 #define  UNU_FFP(x)			(((x) & 0xff) << 8)
 #define  UNU_FFP_MASK			UNU_FFP(~0)
 #define  CPU_EN				BIT(7)
-#define  CPU_PORT(x)			((x) << 4)
-#define  CPU_MASK			(0xf << 4)
+#define  CPU_PORT_MASK			GENMASK(6, 4)
+#define  CPU_PORT(x)			FIELD_PREP(CPU_PORT_MASK, x)
 #define  MIRROR_EN			BIT(3)
 #define  MIRROR_PORT(x)			((x) & 0x7)
 #define  MIRROR_MASK			0x7
@@ -753,6 +753,7 @@ struct mt753x_info {
  * @irq_domain:		IRQ domain of the switch irq_chip
  * @irq_enable:		IRQ enable bits, synced to SYS_INT_EN
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
+ * @active_cpu_ports:	Holding the active CPU ports
  */
 struct mt7530_priv {
 	struct device		*dev;
@@ -779,6 +780,7 @@ struct mt7530_priv {
 	struct irq_domain *irq_domain;
 	u32 irq_enable;
 	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
+	unsigned long active_cpu_ports;
 };
 
 struct mt7530_hw_vlan_entry {
-- 
2.39.2

