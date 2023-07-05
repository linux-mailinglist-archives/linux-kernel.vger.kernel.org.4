Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC8748881
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGEPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGEPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:54:00 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BAE12A;
        Wed,  5 Jul 2023 08:53:59 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7836164a08aso333897239f.1;
        Wed, 05 Jul 2023 08:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572438; x=1691164438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RLbkYBSMtZSZWsdqOipQPRF1AXaIm7IXw5H9F31xDg=;
        b=YOqBHMuBehhI/6uka/fZOxhJyax+4qIFzKd0buYsQuhqnnScQyhVdSkC7Ns2BzAsAX
         2fmBfR9utC9mjai0aTY3EkUE37XQriezfYOPQMpzYk1wn63E7oS0ICNvHGkT8cA9d57G
         AFpc1RKl+FSvTHDZnnK3ePskWfK0y/sac06IfVczJjk5Tm4DbC9MfjBCp1j2+t6uu9p3
         S8a5i6J+TlxwDXF5i2CohEOBhzseFE9847xH569wijaIninvh9VkapHsXLHD6gwQEKWS
         ZEc55j1BAEYyxJ9FdSVc1BXUVNTMMj2UepKO4KfIx9YO8sLtwQE6wn2UWs/gRmeB2Vpn
         vRkQ==
X-Gm-Message-State: AC+VfDx0wiFQ35lCD5kTnt/OdJ9vRUKVoS93ym466XbHpyA+iBbRj2zA
        21SOrvPeiRShKnXXatsB+w==
X-Google-Smtp-Source: ACHHUZ73QtYKyynoI9ylI1XEWC2lq+A/sJ6q02lzFpAinNpUOyDvzNhBset5FBiQu0bFE/MLWXDyOg==
X-Received: by 2002:a5e:8811:0:b0:785:ca70:46a2 with SMTP id l17-20020a5e8811000000b00785ca7046a2mr18137083ioj.4.1688572438444;
        Wed, 05 Jul 2023 08:53:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q15-20020a02c8cf000000b0042ad6abe0bbsm6425382jao.20.2023.07.05.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:53:57 -0700 (PDT)
Received: (nullmailer pid 691642 invoked by uid 1000);
        Wed, 05 Jul 2023 15:53:55 -0000
Date:   Wed, 5 Jul 2023 09:53:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mtd@lists.infradead.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        coresight@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: cleanup DTS example whitespaces
Message-ID: <168857243311.691536.13322875472425620659.robh@kernel.org>
References: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 02 Jul 2023 20:23:08 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects spaces around '=' sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rob,
> 
> Maybe this could go via your tree? Rebased on your for-next:
> v6.4-rc2-45-gf0ac35049606
> ---
>  .../bindings/arm/arm,coresight-cti.yaml        | 18 +++++++++---------
>  .../bindings/arm/keystone/ti,sci.yaml          |  8 ++++----
>  .../devicetree/bindings/display/msm/gmu.yaml   |  2 +-
>  .../display/panel/samsung,s6e8aa0.yaml         |  2 +-
>  .../display/rockchip/rockchip-vop.yaml         |  4 ++--
>  .../bindings/iio/adc/ti,adc108s102.yaml        |  2 +-
>  .../bindings/media/renesas,rzg2l-cru.yaml      |  4 ++--
>  .../devicetree/bindings/media/renesas,vin.yaml |  4 ++--
>  .../devicetree/bindings/mtd/mtd-physmap.yaml   |  2 +-
>  .../bindings/net/mediatek-dwmac.yaml           |  2 +-
>  .../bindings/perf/amlogic,g12-ddr-pmu.yaml     |  4 ++--
>  .../bindings/phy/mediatek,dsi-phy.yaml         |  2 +-
>  .../remoteproc/amlogic,meson-mx-ao-arc.yaml    |  2 +-
>  .../devicetree/bindings/usb/mediatek,mtu3.yaml |  2 +-
>  .../devicetree/bindings/usb/ti,am62-usb.yaml   |  2 +-
>  15 files changed, 30 insertions(+), 30 deletions(-)
> 

Applied, thanks!

