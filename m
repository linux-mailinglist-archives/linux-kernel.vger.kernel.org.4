Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF2656DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiL0SQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiL0SQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:16:10 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF32DDF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:16:07 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-45c11d1bfc8so193298967b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMSJEr54reUvLsyEt0g6Qxy3nLHgzy6qj5b2+DqI7ho=;
        b=X+6ZSBqj6+QbPQ/oVoNJxqSfA4TEC1NlbNWMHYbLX17sbXX7sjNwWUfLlzPU+qg7J7
         cyoxzCJSk4kMxzsbz7iwcMfhEDd1QGCzgwWeazP+/u4h99ML7Y094RoQJu+UzHkTl+rz
         QY718wii4f30Ct1DdK1ghFj6XNrj1FEbwsnMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMSJEr54reUvLsyEt0g6Qxy3nLHgzy6qj5b2+DqI7ho=;
        b=bE4ZlNONkJ6QCfOY0Lwn9eScNNHy7C2FeyZjY601Yz+2zjfteehp6pqy3Ej2mevR9x
         Yl/fwJMFMf6T6cS6+nEzE28e5TuJIuJYbXKtbwuuzhnXNEp3Qay7s1gRw5QF2NtjKkZs
         SNpc1Fo5DE2h/LGyoJ+6XLDf+pn+zWWr48eH5P7ubM0NXqm5paef6uhx8XkR1k3VEu9t
         9QV+5lX3eCrr4CiN3AhvXtt0ONxP2XOpMpRJwyR+Kto0IobXQuYVufoQT3MbNCDEMX8e
         lhbM431ehl+85/ar8LyCENgWuQjpzm9YU+HVn/HWeGwtLgTRqI0x4fsth4BGm/oVpaaV
         LmIg==
X-Gm-Message-State: AFqh2koCpUvI4sPHsce7TMTMI1qof4+4YF7qJstDa0bf0dM+RQCWM+8w
        0Do/CwPag8vS+uohnOdKbl1kKG1PI2YYP49Gky3IIw==
X-Google-Smtp-Source: AMrXdXs2qXVXbIeSOZPrUECD4HGZK+sdJA4II7CFyF3HP+ffttgcN305uaUmfBpTIQrHV0crlgYRUZzRx39vYS7ZhsM=
X-Received: by 2002:a0d:ff86:0:b0:47a:a05b:7d0d with SMTP id
 p128-20020a0dff86000000b0047aa05b7d0dmr839791ywf.230.1672164966844; Tue, 27
 Dec 2022 10:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20221227110335.2923359-1-javierm@redhat.com> <20221227110335.2923359-2-javierm@redhat.com>
In-Reply-To: <20221227110335.2923359-2-javierm@redhat.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Dec 2022 23:45:55 +0530
Message-ID: <CAMty3ZAaHKJ21D8mE=HU3D3KOGAiZ7vfmW_Hgc-E5JO5S+tMNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: Add Himax HX8394 panel controller
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Neal Gompa <ngompa13@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Martijn Braam <martijn@brixit.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 4:33 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Add device tree bindings for panels based on the Himax HX8394 controller,
> such as the HannStar HSD060BHW4 720x1440 TFT LCD panel that is connected
> through a MIPI-DSI video interface.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> Changes in v3:
> - Fix example snippet for `make dt_binding_check` to pass (Krzysztof Kozlowski).
>
> Changes in v2:
> - Drop redundant "bindings" in subject (Krzysztof Kozlowski).
> - Drop "device tree bindings" in title (Krzysztof Kozlowski).
> - Put port next to other "true" properties (Krzysztof Kozlowski).
> - Add Krzysztof Kozlowski's Reviewed-by tag.
>
>  .../bindings/display/panel/himax,hx8394.yaml  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> new file mode 100644
> index 000000000000..fb1981cacfc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/himax,hx8394.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax HX8394 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Javier Martinez Canillas <javierm@redhat.com>
> +
> +description:
> +  Device tree bindings for panels based on the Himax HX8394 controller,
> +  such as the HannStar HSD060BHW4 720x1440 TFT LCD panel connected with
> +  a MIPI-DSI video interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      # HannStar HSD060BHW4 5.99" 720x1440 TFT LCD panel
> +      - hannstar,hsd060bhw4

Parent controller can have a compatible where the associated panels
will be enum list.

Jagan.
