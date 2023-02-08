Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1768EB8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBHJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBHJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:35:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F31BF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:35:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso961313wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5Tu8R0oupz/ghiHxU+IGFJ45u5bYP68xNxl3K3/IjE=;
        b=iqGdC41c/7Nav5uKJe7OFSVlN/w+wAHQedSiSAkvS2V0cWV1aa0Vz+pHyXM/Bhgw1t
         kQ+ZYwiGtNowD8cHal8ybws8mppYjq+jtUrl1+kgm2r6TSK2obKank2PdZnBZBOZ5oTn
         5SFe3xDzSSkr653gRrWicS3lePMHkFofroQSRg3NW4mizNyb1SWTxBozNHJuVB2WKl39
         pSOSO7ev/PlYUHMQ55bqc1VAek0gRkRln/clenas4STXF50e+WGhd4yVbLg/PCGaiR6m
         d6+VpLwlrYrPHGiSKfYTAU/0SyfXslc3w8xYu4ap7ns54COAm8pIh1lmLKsW2lkOHiWs
         QEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5Tu8R0oupz/ghiHxU+IGFJ45u5bYP68xNxl3K3/IjE=;
        b=JdGBwS/iSwGhq7lJZ6IbHplTBGyoIxhMrG3ma9T33c2NWxHqzEbk+kYSDSV68/7jhI
         l6zQEMKraLn4HNjPwSpeI9RTiKYGyAVwTY87IBSC36Og3EJIXYg4SFcQyI6PxQQmzO8w
         EswuE/UFqDSuwDrLZJ0dTzfbWr0DToW7HzI/+dmkS3vPOI9pjftHiEY8ucCNr03SeDMi
         /oDz1/6usSgWP0nIAzyg7Kw9+mP923J83y6Kj290XLIuDbdSXpi2o6QPi7+UQ7Z40MvH
         kYel5rkdP5EbrYtXfpltpkUy5aQlgt7nq+V2oVnAhzE+j22qw5O3Epq0ZX2SdQo3O8n0
         i+VA==
X-Gm-Message-State: AO0yUKUPQW7O3cTlJxf2Uv1bDvZCbqMEUjVySwrwslzu5mYh5e3ByJPG
        35plR+IX9L/jAFxsTFmXgQTXiA==
X-Google-Smtp-Source: AK7set/kCIIZcHoJ4TsvPawNaB7DdeTgLnyVQKSy16xqjOEFQfYshN3+RU6iL+FYD1oxwlLAWFVWqg==
X-Received: by 2002:a05:600c:1d8b:b0:3dc:198c:dde with SMTP id p11-20020a05600c1d8b00b003dc198c0ddemr5669502wms.41.1675848927019;
        Wed, 08 Feb 2023 01:35:27 -0800 (PST)
Received: from jackdaw.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j23-20020a05600c1c1700b003dc1a525f22sm1375051wms.25.2023.02.08.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:35:26 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] ASoC: dt-bindings: meson: covert axg audio to schema
Date:   Wed,  8 Feb 2023 10:35:18 +0100
Message-Id: <20230208093520.52843-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue conversion of AXG audio dt-binding documentation to schema

Changes since v2:
 * Drop 6 patches applied with v2
 * Drop Yaml block style indicator for multiline description

Changes since v1:
* Drop 2 patches applied with v1
* Drop node name patterns
* Fix examples indentation
* Yaml fixups requested by Krzysztof

Jerome Brunet (1):
  ASoC: dt-bindings: meson: convert axg sound card control to schema

 .../bindings/sound/amlogic,axg-sound-card.txt | 124 ------------
 .../sound/amlogic,axg-sound-card.yaml         | 183 ++++++++++++++++++
 2 files changed, 183 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml

-- 
2.39.1

