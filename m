Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C566E6F03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDRWBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjDRWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:01:08 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB19109;
        Tue, 18 Apr 2023 15:01:07 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-38e04d1b2b4so566309b6e.3;
        Tue, 18 Apr 2023 15:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681855266; x=1684447266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUZCWdrMpmE98XPzyUWaFXep+TFtMG1Cry/8zBfjR0s=;
        b=XpTHaG9vlO4Ryps/X4s1au6kw3UUX7cg3pRiMMGWDBFtGcaKnALIrc4K7gKhBUPAgp
         GkdvIJeWUvb+2OookwT0eO2QYM0LlDsM9liHRElX2GFtp15ZEKOP5183RPRGE94Ws/uH
         WU1avi8t9UOlwNOW2K0dVzNMaR7OTsrHUtyQlL9xLP/BXc5LY0mH/CoB7pXmJIMCNfSz
         YJ/t18goriSeq0n2UkFi6VXTjXu4moGLuvvY/JcBz8+84Xzg7BnyOqp10EC4kXD5GTs3
         Sx6bVx5WLdVt8YdvpzlcBQt20g7TzOYpM4EvVUKxKIXuY1vgdH6s2n1ZB+LosBd/GNo2
         VRKw==
X-Gm-Message-State: AAQBX9d/EMnqqYJBFrwVjxLfUVxE5t26MPGFqHB8ec+XaQYonxZxd1/l
        g3i09vJcJp1bUJq+id4B1w==
X-Google-Smtp-Source: AKy350bRDGYoUZLL6UJSFAz/QGM86RSeA9S9WXw1mapesHioxAxgjrNaBWUK+XbvQYlQk51Aa60Nmg==
X-Received: by 2002:a54:4f12:0:b0:389:1fcb:f327 with SMTP id e18-20020a544f12000000b003891fcbf327mr2042229oiy.26.1681855266449;
        Tue, 18 Apr 2023 15:01:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l83-20020acabb56000000b00383ef58c15bsm6344895oif.28.2023.04.18.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:01:05 -0700 (PDT)
Received: (nullmailer pid 2401434 invoked by uid 1000);
        Tue, 18 Apr 2023 22:01:04 -0000
Date:   Tue, 18 Apr 2023 17:01:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
Message-ID: <20230418220104.GA2387740-robh@kernel.org>
References: <20230416131632.31673-1-aweber.kernel@gmail.com>
 <20230416131632.31673-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416131632.31673-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 03:16:30PM +0200, Artur Weber wrote:
> Add bindings for the S6D7AA0 LCD panel controller, including the
> S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
> of tablets.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changed in v2:
>  - Updated commit message
>  - Applied suggestions from Krzysztof Kozlowski
> Changed in v3:
>  - Correctly applied suggestions
> ---
>  .../display/panel/samsung,s6d7aa0.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> new file mode 100644
> index 000000000000..079e2b3a9eaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6d7aa0-lsl080al02
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  enable-supply:
> +    description: Enable supply

Comments on v1 apply here.

Rob
