Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D2748CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjGETFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjGETEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169F1FEA;
        Wed,  5 Jul 2023 12:03:40 -0700 (PDT)
Received: from p200300ccff0adc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mh-0017Xc-MG; Wed, 05 Jul 2023 21:03:27 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mh-001UQf-09;
        Wed, 05 Jul 2023 21:03:27 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ARM: omap4: embt2ws: Add audio support
Date:   Wed,  5 Jul 2023 21:03:21 +0200
Message-Id: <20230705190324.355282-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio support for Epson Moverio BT-200.
In the vendor kernel, the MCBSP side is used as master,
so do it here also that way.

Andreas Kemnade (3):
  ASoC: ti: omap-mcbsp: Ignore errors for getting fck_src
  ASoC: tlv320aic3x: use BCLK instead of MCLK if not in master mode
  ARM: dts: omap4: embt2ws: Add audio support

 arch/arm/boot/dts/omap4-epson-embt2ws.dts | 21 +++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.c            |  4 ++++
 sound/soc/ti/omap-mcbsp.c                 |  4 ++--
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.39.2

