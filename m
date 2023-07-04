Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBC74731B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGDNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGDNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:45:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAD10A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:45:52 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c5c03379a76so1016966276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688478351; x=1691070351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4AMLUs9zdYkz13PYZ3sZgfaLBUzB3BRb9jZF/zG6Gy4=;
        b=f//c71F+CiiJ0nQYLNnQXUSbAHrEMuUk0nw1wwalcqczyC4cibu2CBc5Bqq1RtJtEK
         FXsYoEaQ7ltPESn8l7IvqYRBWfzWOkclLdWaPGFVrKHk+5accVNfp1ogMQeHL57mySgK
         7REX07YJruKKEqpeJ1dFpEAhuIMJL793hsMehXu3dJIkAXpGsq2VMuqxiKntG4+N+dhi
         m1YwWB8Dp0tYJs5Z1Epaw+dcPiE1gnPCw1dfO9E/U1X/Fe4jvfwhFUGRUdFPE5QKYlk+
         j3l5fF84hhm/UUWt+erN34P6+c7IDsRD/GAzIQeE+5mP6ziVCt7nHB6EakqfCgM6laVa
         8abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478351; x=1691070351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AMLUs9zdYkz13PYZ3sZgfaLBUzB3BRb9jZF/zG6Gy4=;
        b=JWIshdZMDllTxxydCFkkz+9D9nd8Iv41WR+8PGFSeRzVJ4OdN3dtsMpNDkZSnsYyHj
         TuZ/KLKyDFuQV6CGbcEYpOVYZXN4jodt/I1U0jd72KEvvNqAqMHvWh4X6DsT8+S/1fA8
         oxzm0F8rpYAGiJOqzeyNWmauAESN4pue1dJ+XG7UNEO2qs7MP6FmelNW8sARXoY+LUw/
         ra32E9xRzAEbL6Bo279PCDD8qGKbQ5cBPqRO5K4xpwm+t2JJSVpES5NT0RmuX+INwRfR
         Q+9akbONFMNqtSzpJwU7TZVpEFfPXoQ+nGGOuoyfke9DwHBjQW2bbODKQ2ljC9oXwGf8
         vASw==
X-Gm-Message-State: ABy/qLaO0P2ckR3rku/jnai9eFgQ9yCGRyEmxou1uxlS87H0mmNrghIQ
        nbqyWtKTE/ssGiFy6CnuYrJx1TOdhiR/+qaFcONkMg==
X-Google-Smtp-Source: APBJJlEleHWeClZf2D74mZ0WM0CjCPjrraHn2hhQsLjcjs+MPeKaQJowGKx5dWhdHhQ6pcRJZwraIGBorgd0saV7QNw=
X-Received: by 2002:a25:c5c3:0:b0:bc1:dfa5:83a4 with SMTP id
 v186-20020a25c5c3000000b00bc1dfa583a4mr11215700ybe.13.1688478351717; Tue, 04
 Jul 2023 06:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702182308.7583-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Jul 2023 16:45:40 +0300
Message-ID: <CAA8EJppVOc0_e_o3CX_U9BvDWFKaz2-0FSZsXt11kDg5SXBn5A@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 at 21:23, Krzysztof Kozlowski
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

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #display/msm

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


-- 
With best wishes
Dmitry
