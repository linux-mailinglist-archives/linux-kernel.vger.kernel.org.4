Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00774744E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGDOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGDOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:42:44 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B110CB;
        Tue,  4 Jul 2023 07:42:42 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440b9d60606so1920733137.1;
        Tue, 04 Jul 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688481762; x=1691073762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxhjD7KY5JD674i+41mIILyrwvbeMopv+PbB7rT3+IE=;
        b=qXoDuKf7tijC6nBenqA4HmNXCVz12f5ddVrWo/iBC08Xy5X/GCcU43sZ0mtpwstHzz
         GGG4rED1L0Z3jHx0ObuuPnqTWgOV3lvgb0UgCTp0CeJLzQJEGAmTwNjVcNLWi2mplii/
         gTzcErjfLOJvdkMr/rbh3rwy+y80EnZd7ymGi3sD7e4+hc0QpRfU1gEicpQvVZGtzAVf
         6EUu76BBqp0jaLUX1ZJLF1j0K7hxvYq5PwkFk8Ccvmvlcutquq7I+RgTWyWu/YG1H3fa
         w3VIu5zXhiZjEGvEfADAqF0uBRfL7T9poR368enlmGkLswEIk/idT17/IjIAC8boz7sh
         McZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688481762; x=1691073762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxhjD7KY5JD674i+41mIILyrwvbeMopv+PbB7rT3+IE=;
        b=NVqUSAuRHHcB89RqYVobleynYC2hVcXKjZa8hF9UHv20t+JZuHBw4KMzAVhfMiLve+
         9AoHRnQrrkwS0z2Rn9mnK2p5g7xA9+xvVMtfRZSrJU+LJC1RqHCjcQc6miGc7rXAsG0l
         B6tZDB7ywdvo6TNJbwjUyntJEaFKVocVNK0gxKPUZruwfi9IypU0EPa7Cjy8xeVpV4bD
         SylalahU12wYgHPNFPGtUv5QWXjnoGcz6qsCN3+hfwDjgNbcl/bFK2z4bI4fyKdIhQw6
         qQJFXyohRZb2nHLmOFf6+fh9m3m8O/nvglgaLJGSaSfC6Mnm89iIVXjVjZe7S/O0zdRV
         fXmg==
X-Gm-Message-State: ABy/qLZ2Ae9Aizb2N12lDTaYnR9kFA75bm+s+CSMZYT/BXOIeN+jxK9L
        r+OhSYS7talt7d1xA3zKSxtA4Kw9647eKCy3ibY=
X-Google-Smtp-Source: APBJJlEzBfrRFFxw3waM7f1ipL7WWKBgZ8jQmyUjVtnbM0TCNsn4+zGfKdFXtaZmMtcuMEXY1XjZXuAM/dQift4uNtI=
X-Received: by 2002:a67:f3d5:0:b0:443:7170:b048 with SMTP id
 j21-20020a67f3d5000000b004437170b048mr6639880vsn.27.1688481761915; Tue, 04
 Jul 2023 07:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 4 Jul 2023 16:42:30 +0200
Message-ID: <CAOiHx=kreUEnqssO7y_+UqAxsnXaLPbwBz8h3JRkdEq+pkdW2A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: cleanup DTS example whitespaces
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 at 20:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
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
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> index 0c5b875cb654..d6c84b6e7fe6 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -287,7 +287,7 @@ examples:
>              arm,trig-in-sigs = <0 1>;
>              arm,trig-in-types = <PE_DBGTRIGGER
>                                   PE_PMUIRQ>;
> -            arm,trig-out-sigs=<0 1 2 >;
> +            arm,trig-out-sigs = <0 1 2 >;

There's a space before the closing > you could drop as well.

Best Regards,
Jonas
