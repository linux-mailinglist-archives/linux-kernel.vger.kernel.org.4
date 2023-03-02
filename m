Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A96A81A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCBL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:57:25 -0500
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [IPv6:2001:41d0:203:375::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB238EA0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:57:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677758239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qsZyZ7PXvZbQBk4eGYRvHjkNl0k+LhGMBIeZUd7Jv4A=;
        b=PEgtSEKvtKfASJar6LgW/Ka8GyNSWdi+f0JfSINgyXld74M/kqeAo4eu15KN9yTF+v2CwN
        7DOQEgUCeMKPeJLW4MkXzhjUGSMoV87mcu4H1doWnctIFD494OBGPHcjoo4S/hpyC9MP48
        lcQYq4XVdncPI6AzjUmXnH8fr7mQTvk=
From:   richard.leitner@linux.dev
Subject: [PATCH 0/3] Add "mclk" support for maxim,max9867
Date:   Thu, 02 Mar 2023 12:55:00 +0100
Message-Id: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSOAGQC/x3NQQ6CQAyF4auQri0OxSB4FeOiA1UadTRTMGMId
 3dw8RZ/8iVvAZOoYnAqFojyUdNXyFHtCuhHDjdBHXIDOapd7QifnLq2OeKhc22Vx8QesvZsgj5
 y6MfN210Hnnj/0DAnbEoqv5t6R7lq+v+dL+v6A6U1NbR/AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=K+F0zEoOni4QYu/KLFW2VjlpSBy/WKzy7blh66XCPzs=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIY+iVe7uS991BX5X3YK0eN5L+nOOZsVyh/+9/+/Y4WucyY
 nwcbO0pZGMS4GGTFFFnsjbna3XPL3lcq6uTCzGFlAhnCwMUpABO5c4ORYZf+msWB5h39zsc2RcRN/O
 SpmvaBlS3Wp9HhWUTsdImJ9YwMX6duTVERyP/7/orHK1n79TKxcxd6cm5lrl5qVm85i2ExMwA=
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clocks and clock-names properties in
the maxim,max9867 bindings. Furthermore the binding definitions are
converted from txt to yaml.

The mclk property is needed for one of our boards which uses the the
i.MX8MP SAI MCLK as clock for the maxim,max9867.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Benjamin Bara (1):
      ASoC: maxim,max9867: add "mclk" support

Richard Leitner (2):
      ASoC: dt-bindings: maxim,max9867: convert txt bindings to yaml
      ASoC: dt-bindings: maxim,max9867: add "mclk" property

 .../devicetree/bindings/sound/max9867.txt          | 17 ------
 .../devicetree/bindings/sound/maxim,max9867.yaml   | 61 ++++++++++++++++++++++
 sound/soc/codecs/max9867.c                         | 14 ++++-
 3 files changed, 74 insertions(+), 18 deletions(-)
---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230302-max9867-49081908a2ab

Best regards,
-- 
Richard Leitner <richard.leitner@skidata.com>

