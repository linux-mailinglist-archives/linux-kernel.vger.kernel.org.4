Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD106D69D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjDDRIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjDDRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:08:05 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305974C32;
        Tue,  4 Apr 2023 10:07:56 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-177ca271cb8so35369203fac.2;
        Tue, 04 Apr 2023 10:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6gkago0IX2qDsFTPoqyaI/Smb2BtWMPqkzjbhBxBBY=;
        b=FkYsKIZev2ARCd+d8x7DGbTUXQE7ICeoR7LMIGZ+Dk6L22/T7NUcfCLLm47jUC+ilE
         Wy06gEJAIGJBAwe/sGWkQnv5V5yBv3vpcKEVxNR+IP1zYJ8cel+ehWIS+n6T9KTBR35q
         K0C51bkf6iXptaxo1ppfvz/gndiSWrhCLy5Khjx4IopLVkHf/wRX6dpd/dMBKP9QA3eJ
         8gL2Gwfdi/THnKzIQcslUX1XHr97XMNqJm1rsDnj6u98qa4NsNvGYeGo0qL57uHcz3gG
         IuA1SFERKR/1mBZISqzpaJQVMiFpd0YJ3MYLa6WHWONC6UJ6txVUiWQAqGY+GQHZ9I5M
         W7nQ==
X-Gm-Message-State: AAQBX9cpPKCGy0DuDXJMymdNTn9WGtOA4oG6/6nTJnk834Dd/zsrIcnl
        0vR3jHnYxT5cW9fY1Pwtng==
X-Google-Smtp-Source: AKy350boa65dpRdsMFN94tJSdJniDAXV5Su1VkGjuBPDPH1ry4H904Fa2qgHRI+R97gDaNx5b+aQyQ==
X-Received: by 2002:a05:6870:d599:b0:17f:d229:bc54 with SMTP id u25-20020a056870d59900b0017fd229bc54mr58236oao.12.1680628075017;
        Tue, 04 Apr 2023 10:07:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kw17-20020a056870ac1100b001802d3e181fsm4961509oab.14.2023.04.04.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:07:54 -0700 (PDT)
Received: (nullmailer pid 111440 invoked by uid 1000);
        Tue, 04 Apr 2023 17:07:53 -0000
Date:   Tue, 4 Apr 2023 12:07:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: Drop unneeded quotes
Message-ID: <20230404170753.GB49361-robh@kernel.org>
References: <20230320234718.2930154-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320234718.2930154-1-robh@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:47:18PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml     | 4 ++--
>  .../devicetree/bindings/input/google,cros-ec-keyb.yaml        | 2 +-
>  Documentation/devicetree/bindings/input/imx-keypad.yaml       | 2 +-
>  Documentation/devicetree/bindings/input/matrix-keymap.yaml    | 2 +-
>  .../devicetree/bindings/input/mediatek,mt6779-keypad.yaml     | 2 +-
>  .../devicetree/bindings/input/microchip,cap11xx.yaml          | 4 ++--
>  Documentation/devicetree/bindings/input/pwm-vibrator.yaml     | 4 ++--
>  Documentation/devicetree/bindings/input/regulator-haptic.yaml | 4 ++--
>  .../bindings/input/touchscreen/elan,elants_i2c.yaml           | 4 ++--
>  9 files changed, 14 insertions(+), 14 deletions(-)

Applied, thanks.

