Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE56DCABC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDJSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDJSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:25:15 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 11:25:14 PDT
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693A61FE5;
        Mon, 10 Apr 2023 11:25:14 -0700 (PDT)
Received: from shark1.inbox.lv (shark1 [10.0.1.81])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 8B2C3480813;
        Mon, 10 Apr 2023 21:07:38 +0300 (EEST)
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 7AD4B11180E5;
        Mon, 10 Apr 2023 21:07:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681150058; x=1681151858;
        bh=y1ChjUCMzQii6EhLRKMmO6a7digcuovwd1kw7u2N5go=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:From:Date:To:Cc:
         Message-ID:Subject:Reply-To;
        b=vb5mdnl4+jFXMtD2syWXhid9OerURW9+OTxEiG46GWdvu41h4BFJg/3wmxu52azlo
         fAJE4FNri0TYa2bD8MaE1TT6fgTI5FU2ZFWuYl3tc6HZ3djX/NlyWCEc3Z24B8H1Kf
         76ifSzUT4RgEL2pX961SJaJfYhSMEfkrnx9oPe5g=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 736F211180B3;
        Mon, 10 Apr 2023 21:07:38 +0300 (EEST)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id PONECAxGTz8l; Mon, 10 Apr 2023 21:07:38 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 3517B111809A;
        Mon, 10 Apr 2023 21:07:38 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Karl Chan" <exkcmailist@inbox.lv>
Subject: [PATCH v3 0/2] arm64: dts: meson-gxl: add support for Xiaomi Mibox 3
Date:   Tue, 11 Apr 2023 02:07:26 +0800
Message-Id: <20230410180728.30332-1-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3gB6gpLwLuiSfBh5uXsxt+2VFkkvDuJsLBwtjJYqsqhvt90eXGXGIPxEAGnemLD
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Karl Chan"  <exkcmailist@inbox.lv>

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
