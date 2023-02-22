Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD069F043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBVIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjBVIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:33:12 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300AB1CACA;
        Wed, 22 Feb 2023 00:33:07 -0800 (PST)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 69849100003;
        Wed, 22 Feb 2023 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677054785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MF6u4u7TyQxUtEY9u6Z4hqRexx2GVbwM5SSm0K6MZHk=;
        b=Ffw3tTvuxpya3uZtylJgoFJqWB9PgMfxIWSJdY8XvqSjFPxN0mchPvxK0bV7T3reBJAVTW
        EQL5C4kKWLz0kgPGwDf3I2YuO5WdK9vZBl9whqd2GBdDg+teJLp01bq4WoQyujNp+HvD+V
        9kdfre4inEcOKZ7cCSUwj++MeuUj2qZhT4xna8+sQy392E3zaLNvaH1sloNmIjVsVVJxqP
        tRXORlAeMS4WEIzU6OSQtuFb237XkTEiwH9ES00wzqIHuPerztoYSBL7RlMFsDQJKIC3U9
        K082kQrK5DnV1p/rAeRDmenfrFsyvldCIEB3SHJaPfy9m2NXmauxcHGjKFJvXA==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Crt Mori <cmo@melexis.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/2] Add support for the TAS5733
Date:   Wed, 22 Feb 2023 09:32:58 +0100
Message-Id: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series extends the tas571x driver to support the TAS5733
audio power amplifier.

Kamel Bouhara (2):
  ASoC: tas571x: add tas5733 compatible
  ASoC: tas571x: add support for TAS5733

 .../devicetree/bindings/sound/tas571x.txt     |  1 +
 sound/soc/codecs/tas571x.c                    | 59 +++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.35.1

