Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613F76DD029
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDKDYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKDYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:24:32 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B41172C;
        Mon, 10 Apr 2023 20:24:31 -0700 (PDT)
Received: from shark4.inbox.lv (shark4 [10.0.1.84])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 8A65E480AD2;
        Tue, 11 Apr 2023 06:24:29 +0300 (EEST)
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 7424CC007A;
        Tue, 11 Apr 2023 06:24:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681183469; x=1681185269;
        bh=kLlC5EhX7boxr8HaOFzHxw2ocBQaG2UFAvf0J/unxZ4=;
        h=Message-ID:Date:From:X-ESPOL:From:Date:To:Cc:Message-ID:Subject:
         Reply-To;
        b=LPjjJkwQcDqEA59h6yp1TB3DWzeYxn+y+dZH5ycWfFYdChmW59S6HNDcCNB/MiZnH
         HmFtSqaydbRn7JobX6oF55mFljhhodS+jtGSB3N4iRFvgl9ay+vG974SMgqLGsmcR3
         y5OZ6yXsEguFVblQO1A1UZyf5aiu6JagTEWlTb4k=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 657B5C0050;
        Tue, 11 Apr 2023 06:24:29 +0300 (EEST)
X-Spam-Score: 2.974
X-Spam-Status: No, score=2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id lVEZhU_MnWuK; Tue, 11 Apr 2023 06:24:29 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id E55B8C00A8;
        Sun,  9 Apr 2023 20:40:09 +0300 (EEST)
Message-ID: <95908887b8303470ae95da48080a6ff7.exkcmailist@inbox.lv>
Date:   Sun,  9 Apr 2023 20:40:06 +0300 (EEST)
From:   exkcmailist@inbox.lv
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38VmXBDusO5Kpgfme6kmZaySiNDsCb7x6My6nVHv7Dfu99pAxyYY//ze3G0c2PD
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 767d273664e434a6e6975f40d63d3489efd98abe Mon Sep 17 00:00:00 2001
From: "@exkc" <exkc@exkc.moe>
Date: Mon, 10 Apr 2023 01:26:45 +0800
Subject: [PATCH v3 0/2] arm64: dts: meson-gxl: add support for Xiaomi Mibox 3

The Xiaomi Mibox 3 is a TV box based on the Amlogic S905X chipset.
There are two variants:
- 2 GiB/8GIB
- 1 GiB/4GIB

Both variants come with:
- 802.11a/b/g/n/ac wifi (BCM4345)
- HDMI , AV (CVBS) and S/PDIF optical output
- 1x USB (utilizing both USB ports provided by the SoC)

Karl Chan (2):
  dt-bindings: arm: amlogic: add Xiaomi Mibox 3 binding
  arm64: dts: meson-gxl: add support for Xiaomi Mibox 3

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905x-xiaomi-mibox3.dts | 142 ++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts

-- 
2.40.0
