Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C97394EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFVBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFVBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:53:05 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD751BF9;
        Wed, 21 Jun 2023 18:53:00 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-341d62e78d3so30480765ab.3;
        Wed, 21 Jun 2023 18:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398779; x=1689990779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPyXNWV+5Rq0jnNZMv1kqGws0ng4nexiCuZNtuQKCfc=;
        b=aQwymo28h/4vUt1FbTvLbNnvgptiEvwxgkvqaqnd6OklROHmTyWlLxxJ0MmB8CqT7r
         nRnSpMEg5gKj+L8W7E7C0khPikKSqU1XYavNdzL7wTcOz5FeH2y5fQTyXADjr0tZ4MDx
         0tGWCexujtgFT1/UzDEsP6hl/Jd5oGhmJr0p2cTC2qoENPIIClV8w1Twq3kpWS0w6F33
         D4lDCU5D8tl98PPCkAJy0yoWTFKgAJRj0z+4tNCTDImunqALyX9tYizN6h+jz9kEU/Bi
         jxeuRiBflzlw/CRHE8yiaYWfiFGl9qfRZYufZkDifDmJ0MgTVJKnjG/wBoansnzwYyNg
         3/0w==
X-Gm-Message-State: AC+VfDxpwX7AaXEZYgDV4SL4J7FfwZCg6cW7ifU2GGSuaDGxOrrVdie4
        +y0NFpcHRtSphnlOs/5RYw==
X-Google-Smtp-Source: ACHHUZ5bXaNVYRvyVfg2gIqLORoZrPaNazGxcaU4nmHT1DBtkRs7fLnJxGeZccaoiFIquwjsd5yHWQ==
X-Received: by 2002:a92:d486:0:b0:340:d836:1f64 with SMTP id p6-20020a92d486000000b00340d8361f64mr16631899ilg.29.1687398779402;
        Wed, 21 Jun 2023 18:52:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d18-20020a92d5d2000000b0033e23a5c730sm1672193ilq.88.2023.06.21.18.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:52:58 -0700 (PDT)
Received: (nullmailer pid 43975 invoked by uid 1000);
        Thu, 22 Jun 2023 01:52:56 -0000
Date:   Wed, 21 Jun 2023 19:52:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, pnguyen@baylibre.com,
        linux-arm-kernel@lists.infradead.org, fsylvestre@baylibre.com,
        Philipp Zabel <p.zabel@pengutronix.de>, louis.kuo@mediatek.com,
        Andy Hsieh <andy.hsieh@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: add mediatek MIPI CD-PHY module
 v0.5
Message-ID: <168739877539.43891.4753109019939618528.robh@kernel.org>
References: <20230620121928.1231745-1-jstephan@baylibre.com>
 <20230620121928.1231745-2-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620121928.1231745-2-jstephan@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 14:18:46 +0200, Julien Stephan wrote:
> From: Florian Sylvestre <fsylvestre@baylibre.com>
> 
> This adds the bindings, for the MIPI CD-PHY module v0.5 embedded in
> some Mediatek soc, such as the mt8365
> 
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

