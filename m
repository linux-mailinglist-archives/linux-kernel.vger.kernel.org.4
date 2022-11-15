Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186962901F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiKOCyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiKOCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035D913F29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so32921628ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhLFlyx+HwJ1ZM4Lgtghsv3nWTmtK87TqidUEKXNRv0=;
        b=mwiE5YmA64m7c9RqpS46cGxcmWS3abT7KJjEHko54IFdBQzl2rDTmvWMNjmpZYQPMx
         +e7PSOkqjf3gsQ/OYibbL7V3OHS3HVIdBXxkZxY12kpV2gyMHIsU5YYAwQwWbth/EBmo
         k9/V5mOgogsH5yeo2SizHPHCID58H5PD+jTQ1sopX2I3iCupyDUUsU04QKb4LDLj9pDJ
         atK77+jCvg/GeeLNFHAb/5GLnr9wTVBd539NB61eMhOHArYpGYeNE/Wuz4MhKv06gimQ
         xXo1M8la1v4Xynsd4snlm5cHjKQZFmSIdBRJz8bDkaCL+8bnBhWGKvK1qBYIEJXHweji
         V5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhLFlyx+HwJ1ZM4Lgtghsv3nWTmtK87TqidUEKXNRv0=;
        b=STZEmL5j+Y5n4lZnzJzYzO7qVIPsz3THXjayYONUY7sJ6UpZUQ9+U0ggwvcocfinfd
         +meywH9u4/zwcxBNgg9KsbKmyVLWXtD3w82X3tsHTCRuLccoMtE8TjtbkJCl0oOZnhkD
         rVhq/erHjAuWGhqOApIT3plZAVYGeDe7GfP/ER09k3no63lcwriMoJQV5k8atXlgjnug
         R9X8YIMJrh1o7UNIcJ0aBWeHzWbuy6kgzot8WOugII2WtfY8riBV+vM1z8yl/UOdlID1
         AYTVn5A7wlmaN5vUTfsezjpjytsmkXXdn9q1qsr0VMOTqYDiBkwXGNpfpJmwt4OJlBzh
         18UA==
X-Gm-Message-State: ANoB5pnJzp5bqLPv2Qa1DZMZ3IrUQhKKydMOmgyodH5A2bFA1K3t4QTI
        Hy2l/wCy928U601/7kSoaWX5Gw==
X-Google-Smtp-Source: AA0mqf5JivAi2ZF9ol363qK+7ytfa4atR05s5ByGG1JukcRFiWfAhIL4BTILOtnHOK4xhIOEg7JA5Q==
X-Received: by 2002:a17:906:814:b0:78e:ebd:bf96 with SMTP id e20-20020a170906081400b0078e0ebdbf96mr12315635ejd.625.1668480871620;
        Mon, 14 Nov 2022 18:54:31 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:31 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 03/15] dt-bindings: iio: adc: mediatek: add MT8365 SoC bindings
Date:   Tue, 15 Nov 2022 03:54:09 +0100
Message-Id: <20221115025421.59847-4-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding for the ADC present in MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index 7f79a06e76f59..ed582c6e7ea9c 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt8188-auxadc
               - mediatek,mt8195-auxadc
               - mediatek,mt8516-auxadc
+              - mediatek,mt8365-auxadc
           - const: mediatek,mt8173-auxadc
 
   reg:
-- 
2.38.1

