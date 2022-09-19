Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CD5BCA76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiISLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:13:05 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590115806
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663585984;
  x=1695121984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UmCsk+shjy5qu5dw1fM/f6/rDCelAQiyZQXXy+VkQbs=;
  b=DesRJont64po/n1Q6mZ2ml/NOIdq/Nfq+ovg8vV3TMec8fdTyhwXvVee
   HRXEvhUQEiIksgRkEKhUhd6PZUEVirL28srfFVr4SA4LvJdACXUFkGDRJ
   fWIPUCF5gaTfSdnb4Wa1nXP15cnln2YXUcjZ2lj7xElBsy7QIQ1c3h9do
   +G2LBbNkB1L8Y/U3MmCtyg7yteVFUSpCLcUwFsty5n8GOYAzHzB1WRwAP
   s3kgUqQaOMhen3A28dfeFBI07Tz/gBO3dBLYd3eXq+LXPhoRpki+H5086
   Md9Zd79+gDqSf3ZapEYgXlNpn4TbejBR0h3Fm4awGKJ3IdEXDe2SAB3jw
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 0/3] ASoC: ts3a227e control debounce times
Date:   Mon, 19 Sep 2022 13:12:55 +0200
Message-ID: <20220919111258.3774-1-astrid.rost@axis.com>
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

v2 -> v3
 Changes in the yaml file:
 - Renamed ts3a227e.yaml  to ti,ts3a227e.yaml.
 - Changed "ti,micbias" default value to the reset register value.
 - Skipped some obvious descriptions.
 - Removed unused include.
 - Node name is "audio-controller".
 - Removed register value from the description.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>


Astrid Rost (3):
  dt-bindings: sound: ti,ts3a227e: convert to yaml
  dt-bindings: sound: ti,s3a227e: add control of debounce
  ASoC: ts3a227e: add parameters to control debounce times

 .../bindings/sound/ti,ts3a227e.yaml           | 94 +++++++++++++++++++
 .../devicetree/bindings/sound/ts3a227e.txt    | 30 ------
 sound/soc/codecs/ts3a227e.c                   | 58 ++++++++++--
 3 files changed, 146 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt

-- 
2.20.1

