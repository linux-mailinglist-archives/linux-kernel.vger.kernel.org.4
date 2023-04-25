Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002076EE62E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjDYQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjDYQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:57:06 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB8313FA1;
        Tue, 25 Apr 2023 09:57:04 -0700 (PDT)
Received: from shark4.inbox.lv (shark4 [10.0.1.84])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 733CA48052F;
        Tue, 25 Apr 2023 19:57:01 +0300 (EEST)
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 5C0C8C018B;
        Tue, 25 Apr 2023 19:57:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1682441821; x=1682443621;
        bh=Qq9ls3B214o+xFbtaX+maHmcXec0gagOLT9ZANiZIxc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:From:Date:To:Cc:
         Message-ID:Subject:Reply-To;
        b=bERv3ZNQ5JBDYpoXs1JXI1oQ3+XsqTlceOeeOiSKTTDY3Tw3vLNVh1nQS8jyIzlsh
         8PTiiVwLcCyoT3l1y2hqRmDVd6qfdozIfbZYr1DQe5xUnd1d1tVZsQyPqJ0/pzo/HY
         G3FsQtnLxGRhks6zbIMFSfDQfzGJ79AmB7zOM5Mw=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 4EBD1C018A;
        Tue, 25 Apr 2023 19:57:01 +0300 (EEST)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id LtyJlcPy_xEg; Tue, 25 Apr 2023 19:57:01 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 05A32C016B;
        Tue, 25 Apr 2023 19:57:01 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Chan <exkcmailist@inbox.lv>
Subject: [PATCH v5 0/2] arm64: dts: meson-gxl: add support for Xiaomi Mibox 3
Date:   Wed, 26 Apr 2023 00:56:22 +0800
Message-Id: <20230425165624.11999-1-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdmGU/2M26KZpu+eHlxMi6UUZBzir7z6FSnX9YsLvButt3c2iUB/ecFHrCbg==
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

