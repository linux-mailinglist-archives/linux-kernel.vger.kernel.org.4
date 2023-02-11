Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F3693393
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBKUNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:13:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F218B22;
        Sat, 11 Feb 2023 12:13:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so23398988ejc.4;
        Sat, 11 Feb 2023 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9e5tNbxrcBqEtClBWjdGwDiemkYMqsKA+UfmHWi9+Y=;
        b=peycM+ujMjmntXoGI352UOHmuAfZD/7B8Z2kvOo6YTCh/KJgu4kYXEBBuJ9pF6eOni
         n/jkAn2nzhAbTV4i161WMDkjtnc7jgH6wPfW7dTfm6LZTzvHFz+0b1tBY6pHhezeVhC1
         wAUwDsP/tZsr0cvP7ENO4JD8TULOY6hnOuipeT8blB0aYiR/MqF2ycAkRMGv0ChVqUZy
         VRdPfk5vN6lbG8pyVkZcT1tIMr72sRFO6AbBbckRAIs4ZmVOg5r9Jw1PmpQsOeeXhTrf
         H9LT9SRgFrQTJ55BeTGy9aUCDUJFSlMPYeeKk5Npgc1gfYsiMy/iwC/OcluVY3HEeAfa
         8GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9e5tNbxrcBqEtClBWjdGwDiemkYMqsKA+UfmHWi9+Y=;
        b=4JRs46CgPAso5PTfhrXYRAege1Qu4FwQEG2dNy/t+9Onxo2yy5HkQhXXTFvM9fik9q
         uwDO3Qhvdsh+xNuPeWGd5TyNPDG5vzHfxIrXEyEEt0ha66w7nj82Iqn2XcdT+L5yb58U
         uEsNl94hF2dS4QZr/NEwfJl+DwuEnc8PxxwBDBPjhE6auxPRwHe3gH2gasIgAXCGZ/5L
         X2oZ6C/L8CrXR8XxZ6dDyZ431uBDyDl13zzMj6U/LgwnBDFz1AfrO+1uiVqME0lnuBJH
         WChjSP9FQel9xoyiIyNNhBdg+XF265hkA0J62CYdrzUnQSdATFUJ2dT9LODnQZRU1qfM
         KdVQ==
X-Gm-Message-State: AO0yUKXd+Qmma1FC9bO3EFqzKBR0Q+1t5j0UrZ33YltgdT2yhrqiqP0F
        dmVHZLtI1ZvBJk6rA2tl7OuiLRIBmQDqSKkcTKt67GY2pMA=
X-Google-Smtp-Source: AK7set+CLHA+r6hk9yDAzRpOY5AME8RdEBbntcSFFOqlzGdnQUpD1d7oJaCWx8p2BMFIbib4Qh1NGfRfm+it7DyoINU=
X-Received: by 2002:a17:906:149b:b0:88a:5bed:62f2 with SMTP id
 x27-20020a170906149b00b0088a5bed62f2mr2644188ejc.4.1676146428121; Sat, 11 Feb
 2023 12:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-2-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-2-c4fe9049def9@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:13:37 +0100
Message-ID: <CAFBinCDEtwVYUB5KTJCQ+1KL5+bqeCNeF4gPe1jzx3SPeftqGQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: soc: amlogic: convert clk-measure.txt to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Feb 9, 2023 at 2:41 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Convert the Amlogic Internal Clock Measurer bindings to dt-schema.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  | 40 ++++++++++++++++++++++
>  .../bindings/soc/amlogic/clk-measure.txt           | 21 ------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> new file mode 100644
> index 000000000000..77c281153010
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-clk-measure.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Internal Clock Measurer
> +
> +description:
> +  The Amlogic SoCs contains an IP to measure the internal clocks.
s/contains/contain/
It's been there in the old bindings as well but it would be great to
have it fixed.

[...]
> +properties:
do we need something like the following?
  $nodename:
    pattern: "^clock-measurer(@.*|-[0-9a-f])*$"


Best regards,
Martin
