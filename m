Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D036AB528
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCFD61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFD6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:58:23 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72643D31E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:58:22 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FA435C00B7;
        Sun,  5 Mar 2023 22:58:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 05 Mar 2023 22:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678075100; x=1678161500; bh=pn
        FkC+vgiukAXvQZB2Xafq5RnPPqc7XatDUtnaIu0bM=; b=wAfpBuN9DcC+29wxaV
        /DlKN6CVi0qSvZLb6DXDmlt9SbKx5TEMcazj7xUTxv0/w/iRUJ99+rWTbMwM+o4i
        E1OgqWhRa2sPcI5MmNFc4MbBimHpwtkV2EATAIb39sqb/dLq6AEQAVOWnBuFb7F+
        PaINwtjVNAXqcd/60uL67Twomhcz4OegNn3OPh7qU87KLkwlSy4g8cl6E88W2Udt
        tDtE9mUmuWZyggtx2CB8xb6Uwz++p2Syv6rw6Lk/f59lrg72p50fseT/tLjpo+0Q
        jNv959Uai+IqkQt1tsV3TDSn5k1d9Uh6tCMlrAE+TzW/xzYKdvCgFYzsiVn0KShM
        LD+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678075100; x=1678161500; bh=pnFkC+vgiukAX
        vQZB2Xafq5RnPPqc7XatDUtnaIu0bM=; b=M8QSy6cvCjxwX/ehr9AZTKKZlx4j/
        2qGQ8A21zDexblRjCWHyw+K6C84sGPBoPdb/ZZUmv5ivGzIHDiI9gJgjfBaUZXFC
        j1qBa2IiaoUkNCUOC+6bj5E/1OyhbUbr2rTswWw98CNbir/2j/vt2BiiqtVZ02Jc
        WW+Y8IegfX9wdruQXrsDa4Ac2GW4vkiBlNfsx9Jn04jMKXrE/O/A6jNZvEPvvFh7
        Sh2bt88LD2MZv3pB0l4tMtNNLdqqK00xdJkwWXec1z9+cBi9XJ/R2CVvd/6Q4g2V
        YdTagofuIiu5VXBVRi9TxBgpcfulgICnyajxfCXtuPvYjpLr3Hf06bulg==
X-ME-Sender: <xms:22QFZFkAntOVfyq_W0t20ZcRzDojHiR0fbDdcL4Sqk1EmEV0peVKuQ>
    <xme:22QFZA04mNadzesFnyAxg1THeWYL2V6yhN-VQVYxkvLU8ACh6h-fT9BWuSsMT0XH_
    0vcpk91pdRGz2AyfPI>
X-ME-Received: <xmr:22QFZLrjhwrEkEPcflMOv8Z9eUbPY9nqKE38ExVYY1oTCJ7Vux-gTyQUUUFztaWlblK0phEBd1lNfVfqXBrC1X_RmJoY6rrK8dUkT7zvMUz6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddthedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:22QFZFl-0BLUH2NhP27sZAnYsLaZUVgoLCIxhSxZHKXCJHPWoN5Ixw>
    <xmx:22QFZD2GmTi0dEmSPxpkkFX9tnv-RRRJ8xeIIuNQRe8nnQhuSg_ckQ>
    <xmx:22QFZEuSGy-jv2dqrqu8awwXrex9rI_6eEVq4K67incKef21iYJzCg>
    <xmx:3GQFZEzW6dGj0a3Ttnyg_xE1y5GOL-26AoPeqPDBYp0-zbSn_frkmA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Mar 2023 22:58:18 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de
Cc:     tiwai@suse.de, broonie@kernel.org
Subject: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Date:   Mon,  6 Mar 2023 12:58:14 +0900
Message-Id: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the last few years, I have reviewed patches for FireWire subsystem and
requested sound subsystem maintainer to sent them to mainline, since
FireWire subsystem maintainer has been long absent. This situation is not
preferable since we have some user of sound hardware in IEEE 1394 bus.

I will stand for the maintainer, and work for FireWire core functions and
1394 OHCI driver, as well as sound drivers. This commit replaces the
corresponding entry.

As you know, IEEE 1394 is enough legacy. I would like to schedule the end
of my work in the subsystem. My effort will last next 6 years. In 2026, I
will start strong announcement for users to migrate their work load from
IEEE 1394 bus (e.g. by purchasing alternative devices in USB and hardening
system for them), then in 2029 let me resign the maintainer and close
Linux 1394 project.

My current work focuses on real time data (sampling data) transmission
protocol in packet-oriented communication, thus I would provide less help
to implementations for the other type of protocol; i.e. IPv4/IPv6 over
IEEE 1394 bus (firewire-net), SCSI transport protocol over IEEE 1394 bus
(firewire-sbp2) and iSCSI target (sbp-target).

If receiving few objections from developers, I will start my work to send
fixes for v6.3 prepatch, and PR for future v6.4 or later. I'm pleased if
getting any help until the end.

Reference: commit b32744751e75 ("firewire: add to MAINTAINERS")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f..e137c1b2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7954,10 +7954,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/lio-core-2.6.git master
 F:	drivers/target/sbp/
 
 FIREWIRE SUBSYSTEM
-M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
+M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
+M:	Takashi Sakamoto <takaswie@kernel.org>
 L:	linux1394-devel@lists.sourceforge.net
 S:	Maintained
-W:	http://ieee1394.wiki.kernel.org/
+W:	http://ieee1394.docs.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
 F:	drivers/firewire/
 F:	include/linux/firewire.h
-- 
2.37.2

