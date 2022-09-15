Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386015B99C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIOLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIOLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:02 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D32C134
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663242001;
  x=1694778001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DYJJ4qQiFhJJxICE6A+XbC2JNWpWJvGPHCHazCi+ciA=;
  b=DYgOQmg7Clozgp4qOUWM79Yd5IpW0v4Qsp6Gd1vyFwBJ2rYRnBkvnyyE
   n4Z0cVHTGVex5iCeknUJagzxzq443aHLOTDUSU3X1Vb7/naadt2MHKhvC
   9crSsgfejAlaFmZAM8MISOnHfJNQEy9wimKKYs0Vt1qH38sNQNqYV18R/
   WUOX2ml6VBgpQarzQl5trS08J5rh2DL7q7u9j+OcROAFU8LgNLPgYDybV
   XbZe7U5uW9sqJ0nM3N/2JRSxGMf/zA+6XLx1x8KiX/au1B3rcEAPVrfGL
   TH/Au7LwmJJNDiETA7jaqUZQ8VdsDBhGaXvZJLKKhX85ILp3bnQdmJ1XO
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.c>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 0/3] ASoC: ts3a227e control debounce times
Date:   Thu, 15 Sep 2022 13:39:52 +0200
Message-ID: <20220915113955.22521-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Astrid Rost <astridr@axis.com>

PATCH 1 - convert ts3a227e bindings to yaml.
PATCH 2 - add ts3a227e bindings to support debounce times.
PATCH 3 - add ts3a227e driver to support debounce times.

v1 -> v2
- Converted the devicetree-bindings to YAML.
- The debounce-times are in ms. The closed match is used, if the
given times do not match the register values.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>.


Astrid Rost (3):
  dt-bindings: sound: ts3a227e: convert to yaml
  dt-bindings: sound: ts3a227e: add control of debounce times
  ASoC: ts3a227e: add parameters to control debounce times

 .../devicetree/bindings/sound/ts3a227e.txt    | 30 ------
 .../devicetree/bindings/sound/ts3a227e.yaml   | 98 +++++++++++++++++++
 sound/soc/codecs/ts3a227e.c                   | 58 +++++++++--
 3 files changed, 150 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.yaml

-- 
2.20.1

