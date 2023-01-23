Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8416785C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjAWTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:06:30 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E530192
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:06:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:6083:1fd7:ba05:ea8d])
        by michel.telenet-ops.be with bizsmtp
        id CK6L2900E4604Ck06K6Lbv; Mon, 23 Jan 2023 20:06:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pK28y-0076NV-L1;
        Mon, 23 Jan 2023 20:06:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pK296-00Ekpr-Hh;
        Mon, 23 Jan 2023 20:06:20 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] arm64: dts: renesas: r8a779g0/white-hawk: Add CAN-FD support
Date:   Mon, 23 Jan 2023 20:06:17 +0100
Message-Id: <cover.1674500205.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series enables support for the CAN-FD interface on the Renesas
R-Car V4H (R8A779G0) SoC, and for the first two CAN-FD channels on the
Renesas White-Hawk development board.

While R-Car V4H supports 8 CAN-FD channels, and White-Hawk has
transceivers mounted for the first 4 channels, my test results are
similar to what Ulrich Hecht reported for R-Car V3U on the Falcon
development board before, i.e. only channels 0 and 1 work, and thus this
series enables support for these channels only.  Whether this is a
CAN-FD driver issue, a pin control issue, an IP core issue, or an SoC
integration issue is still to be seen...

For testing, this series and its dependencies can be found at [1].

Thanks for your comments!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/r8a779g0-canfd-v1

Geert Uytterhoeven (2):
  arm64: dts: renesas: r8a779g0: Add CAN-FD node
  arm64: dts: renesas: white-hawk: Add CAN-FD support

 .../boot/dts/renesas/r8a779g0-white-hawk.dts  | 44 ++++++++++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 57 +++++++++++++++++++
 2 files changed, 101 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
