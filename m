Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5906E679C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDRO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDRO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:56:09 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E04AC676;
        Tue, 18 Apr 2023 07:55:36 -0700 (PDT)
Received: from shark1.inbox.lv (shark1 [10.0.1.81])
        by new-shark9.inbox.lv (Postfix) with ESMTP id CC183480813;
        Tue, 18 Apr 2023 17:55:32 +0300 (EEST)
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id BB04E11181B7;
        Tue, 18 Apr 2023 17:55:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681829732; x=1681831532;
        bh=Qq9ls3B214o+xFbtaX+maHmcXec0gagOLT9ZANiZIxc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:From:Date:To:Cc:
         Message-ID:Subject:Reply-To;
        b=IEFzPkv8YbaQ4afZpB4lgM5UfwYpk3XxcJu5d/3TlbcihvfJYbm28FEfm5ojKZPGa
         vv4w5F4OgpMMrJEjSCKq55qg3GWgvDLZRuDYHuMrYVFLVleR5KOR5v6O1XfBS7U9PP
         Y23u45zDuFaMmR4yxUp8hoyCORwkyY5vxBid7LEk=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id B56DA11181AA;
        Tue, 18 Apr 2023 17:55:32 +0300 (EEST)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id GIJBX0qtq56Y; Tue, 18 Apr 2023 17:55:32 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 7C61B1118182;
        Tue, 18 Apr 2023 17:55:32 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Chan <exkcmailist@inbox.lv>
Subject: [PATCH v4 0/2] arm64: dts: meson-gxl: add support for Xiaomi Mibox 3
Date:   Tue, 18 Apr 2023 22:55:13 +0800
Message-Id: <20230418145515.19547-1-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3gB+w1Luca2K41p5eDjx8rAJVdbxjuDrrAx6HtHtLDGrdd2bmeUB/eRFELmMmLD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xiaomi Mibox 3 is a TV box based on the Amlogic S905X chipset.
There are two variants:
- 2 GiB/8GIB
- 1 GiB/4GIB

Both variants come with:
- 802.11a/b/g/n/ac wifi (BCM4345)
- HDMI , AV (CVBS) and S/PDIF optical output
- 1x USB

Karl Chan (2):
  dt-bindings: arm: amlogic: add Xiaomi Mi box 3 binding
  arm64: dts: meson-gxl: add support for Xiaomi Mi box 3

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905x-xiaomi-mibox3.dts | 138 ++++++++++++++++++
 list                                          |   1 +
 4 files changed, 141 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-xiaomi-mibox3.dts
 create mode 100644 list

-- 
2.40.0

