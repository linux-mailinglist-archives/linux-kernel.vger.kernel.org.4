Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B54661A54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjAHWHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjAHWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:07:15 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C036FAD1;
        Sun,  8 Jan 2023 14:07:14 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id bp44so6701491qtb.0;
        Sun, 08 Jan 2023 14:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSyezriUL/lNJCBbCnrFB5rH1MXCIbx1ORje4SC5K9Q=;
        b=ydqolkvVvu9YoYP7/TWRgRzpaqA+Yks9k/ynlRXN+iH6Lrksvq3gglfMAWOAs1bCZW
         mEAJDmgpNYW06d/OftAQdnPiwxmJrROrrmyoooHbC9XTZXiD8kLU25KfFUKQBO7ltJCU
         QO8tEk0U+1OsAPKgmuSqrmC+U6eyQCFfQoHtiKt7m5SL297W0gfv+hbVy6fPxlBOYGDx
         drY32nUNlHOCGcKXnjDb+OVD7CmLoAT3FvHuTxZWnZrVrgms7J6f5l9v3vHibpNM8nau
         pi6Si7B9XZhGpfqx4smxRff/C9CT42Q726itZMpoj204buNx4repOrv+fXxstyQDaYXE
         MBRw==
X-Gm-Message-State: AFqh2kpuhUi390dC6jRHBne4GkGNPTkqkroA9/Fa0Zg47LQPxh0Fpjng
        Ghcoyed7F91ZBqlpRLDt3Q==
X-Google-Smtp-Source: AMrXdXtiEZ+bMuMU+KeikknktjQhAuTk6bddM96Sps6T8MQGto5OfixHJF2B/USv9hnPuMQKfyfn5g==
X-Received: by 2002:ac8:4e04:0:b0:3ab:5dc7:6bf0 with SMTP id c4-20020ac84e04000000b003ab5dc76bf0mr85234496qtw.36.1673215633610;
        Sun, 08 Jan 2023 14:07:13 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b00705b4001fbasm1425450qkb.128.2023.01.08.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 14:07:13 -0800 (PST)
Received: (nullmailer pid 345158 invoked by uid 1000);
        Sun, 08 Jan 2023 22:07:07 -0000
Date:   Sun, 8 Jan 2023 16:07:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Fabien Parent <parent.f@gmail.com>,
        linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/8] dt-bindings: power: Add MT8365 power domains
Message-ID: <167321562678.345108.18031842904012970078.robh@kernel.org>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-2-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105170735.1637416-2-msp@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Jan 2023 18:07:28 +0100, Markus Schneider-Pargmann wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add power domains dt-bindings for MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>     Changes in v4:
>     - Add infracfg_nao as it is used by mt8365
> 
>     Changes in v3:
>     - Renamed mt8365-power.h to mediatek,mt8365-power.h
> 
>     Changes in v2:
>     - Made include/dt-bindings/power/mt8365-power.h dual-license.
> 
>  .../power/mediatek,power-controller.yaml      |  6 ++++++
>  .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
