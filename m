Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800BC690A56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjBINe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBINeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:34:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1C6032E;
        Thu,  9 Feb 2023 05:34:25 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F61CFF802;
        Thu,  9 Feb 2023 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675949574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aFexrg/8FqX5RvHAviJAig0Iuv2rMm3THqKOoU3xUnY=;
        b=bikNynPnndBhFH8gebmkiQAIut3UWiFLf4HqUT8C0P0ulWftmJuCpjP6vu/Tg0a8rTlMIx
        WUX1bwxlX43gh8lewud709UqTzIwVvAbkx87D42n6vcZA7FodYzYx8De6WW91E8IeuLkdu
        xetb+XnYd6sHLazjLEYOAmSnvu2eHk5EfRnXj5nvcC0YiWg5ShE755nJxTMoFPA66wVsfO
        3vYxdJb/ZxKt2mp3yyMp/jtajqPoade12KQOP6zA0CVDykbwCgt2jvoehkrZaDzU2EuUkI
        pncn9FG6EHYlXFZtEIFsfryQD0lVL7WlJLqZShreFuQfENeJCO8aVC62Ua48ig==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: add device-tree and bindings for renesas,rzn1d400-eb
Date:   Thu,  9 Feb 2023 14:35:05 +0100
Message-Id: <20230209133507.150571-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series adds support for the RZ/N1 Expansion Board. This board
is a carrier board on which a daughter board (either RZ/N1D or RZ/N1S)
can be plugged. The device-tree that is added by this series enables the
use to the 2 external switch ports that are present on this board.

----------------
V2:
 - Add "renesas,rzn1d400-db" in list of compatibles for EB board
 - Replace '_' with '-' in eth pins node name
 - Split some long lines in dts

Clément Léger (2):
  dt-bindings: soc: renesas: renesas.yaml: add renesas,rzn1d400-eb
    compatible
  ARM: dts: r9a06g032: add r9a06g032-rzn1d400-eb board device-tree

 .../bindings/soc/renesas/renesas.yaml         |  7 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts   | 94 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts

-- 
2.39.0

