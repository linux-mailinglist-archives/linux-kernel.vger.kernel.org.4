Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04743665CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjAKNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjAKNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:49:19 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345D5F5E;
        Wed, 11 Jan 2023 05:49:17 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AA53DFF805;
        Wed, 11 Jan 2023 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673444956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pdzxj+WuY057sZ95mrcpv8a0CMR2UrZnAp8NXQR+XeE=;
        b=olT+JqyaFSAi9vB+Q2ko+Lcm28jX1cujIriRuUsfGWXvg/hphmA0GbXFdr4Rs624Fn7Gti
        S9xyb0Q8MSmj18LbyyARyOF1zlp77g6PzXcTBU0gWa3Gedm4Cl/lNE1mIsaEzE+tYjHJLf
        H3MwTBmjtmtxomKDuZtdGkS/nitlisTy36BnVklm0fpLvpW6LPzyT5FWYE3m/DVhRjnrBk
        HZ4sIAtbQzwcqgG1ske4Ep+y6nv275xEpGdkDs7OHPKqX2q8OxUXaAltpPdSKfn0X6Q1yR
        6EglAH81B//R1gkUFJxe5hAZvvl/rmKch+7+iGqQdbxJdEtbO3vAoEZD1Uiiag==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Add the Renesas IDT821034 codec support
Date:   Wed, 11 Jan 2023 14:49:02 +0100
Message-Id: <20230111134905.248305-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas IDT821034 codec is four channel PCM codec with
on-chip filters and programmable gain setting.
It also provides SLIC (Subscriber Line Interface Circuit)
signals as GPIOs.

Best regards,
Herve Codina

Herve Codina (3):
  dt-bindings: sound: Add Renesas IDT821034 codec
  ASoC: codecs: Add support for the Renesas IDT821034 codec
  MAINTAINERS: add the Renesas IDT821034 codec entry

 .../bindings/sound/renesas,idt821034.yaml     |   97 ++
 MAINTAINERS                                   |    7 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/idt821034.c                  | 1234 +++++++++++++++++
 5 files changed, 1352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
 create mode 100644 sound/soc/codecs/idt821034.c

-- 
2.38.1

