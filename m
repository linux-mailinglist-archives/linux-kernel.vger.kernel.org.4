Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8E721541
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFDHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:03:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926ADB4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 00:03:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DD8185C0107;
        Sun,  4 Jun 2023 03:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 04 Jun 2023 03:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685862179; x=1685948579; bh=FQJ13Aq87t
        YV6JYGYfyduSzT1CwAmRLXUL1KgqmPHmk=; b=W8fqjJIkD11IW5l3MAr6h09/zY
        Cu/f06dNh7+20PCgVp/815GnvWEFY1ORUIYhRheeTGPzUopZvMnmd4KfskXsNs24
        lfnBdl089tV8b1pLfSOw2LUZmrWx+4Xr+a6Piw4RVDCj+qoS3xrxrGruScI8mA+1
        tf6e9l27Hvmn4JCU7G7Cjn24VmoszrHHfliACwGLguaP40Y+LnduYrwrqCVRxMzf
        AHpgIt1Du7vKBPOe9Y1gZEII9Pc3BoQ1tbHwNKEjhbAss4nCF7At3EcBTB10n3EM
        GfNiydiwpUThtjDBfjLOWGaLHBTeHKv6M3UDELM3uCxFfORWqYmiuVU3Lwgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685862179; x=1685948579; bh=FQJ13Aq87tYV6JYGYfyduSzT1CwA
        mRLXUL1KgqmPHmk=; b=uR4KDaQLvqDeWzWdcZO5/gmIzAY1Y4RES76/+999XOPo
        rJBhqZqt54/HkLhKTjm+Y3emySsiH1qs8RZ38Lw+K0sMre4Xp/hWRUEx54Mll+q3
        HIR7AaDuJ0LUFAZsaPwOa0DhoCz90fJR6znxVsF6qgaI6Uuo70U6Qpmevny2TgjE
        q4a+ZMxBfsDAlmvygo1/1bAqKak1mW3G8ZZRgTsGNy3EMwJchl5CFH2gVfeZF5E0
        19E/PewNldCuVKGUPkTt7EZInTmDrXOyezAaLKx6lN1rY6w35aYzLznHz8DDpz/u
        6mI8xhrU9EbrNm+IFc6egjeXegTiyR2uLHzHzzHbWw==
X-ME-Sender: <xms:Izd8ZJRgs7x8KQP_LsS3SvKHlbqr3j7gl1Nm8KzMybd4DEJLEl0LrQ>
    <xme:Izd8ZCwziynRUu1sy9iHs2DrxUSd3qaPiCgIp50_BYsxEiSC_vB7PN4W1ypxxP80g
    JzW8UgJyIm7Z4KlWpM>
X-ME-Received: <xmr:Izd8ZO2pLgx6S43cdIh6yPZsoX2wRuwQDcXgHsFHUeHxzGpvz3599eQLPPhmblfJgUb7ANiSMZ2C60IHFxJtxIY9JhgFayM4j_qYOp967WI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedujeetlefhtd
    dtkefgtdeuieelhffgteejjeehkeegveduvdevgeeiheeuueekjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Izd8ZBC06I3WaM4OYBrR1P_5BUlTHs0G-NEW8I2xhdn_gE9RI8NGOA>
    <xmx:Izd8ZCjP3pjmKmYSrlVJW-urXSOr3LhJrsP6O6X-bxWOpZ4ONxl84g>
    <xmx:Izd8ZFrAwm5YTIZhJjxhaoqxmCeZTO69yf8ctUv2VbK1M28t18nwWw>
    <xmx:Izd8ZKI3HHhZKlcFK-AHgpHGLrlDYp1zI3AiXiJ_miCNrnfDJCd5Vg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 03:02:58 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: obsolete usage of GFP_ATOMIC at building node tree
Date:   Sun,  4 Jun 2023 16:02:55 +0900
Message-Id: <20230604070255.172700-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag of GFP_ATOMIC is given to the call of kmalloc when building node
tree, but the call is not atomic context. The call of
fw_core_handle_bus_reset() and fw_core_remove_card() builds the tree,
while they are done in specific workqueue or pci remove callback.

This commit obsolete the usage of GFP_ATOMIC.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c   | 2 +-
 drivers/firewire/core-topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aa597cda0d88..a3104e35412c 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1211,7 +1211,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		 * without actually having a link.
 		 */
  create:
-		device = kzalloc(sizeof(*device), GFP_ATOMIC);
+		device = kzalloc(sizeof(*device), GFP_KERNEL);
 		if (device == NULL)
 			break;
 
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index f40c81534381..88466b663482 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -101,7 +101,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
 
-	node = kzalloc(struct_size(node, ports, port_count), GFP_ATOMIC);
+	node = kzalloc(struct_size(node, ports, port_count), GFP_KERNEL);
 	if (node == NULL)
 		return NULL;
 
-- 
2.39.2

