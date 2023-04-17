Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845086E5213
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQUti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDQUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:49:37 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDBD1BE6;
        Mon, 17 Apr 2023 13:49:36 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1879502e2afso15918937fac.5;
        Mon, 17 Apr 2023 13:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764575; x=1684356575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY8Q/FqFzjCvpbP4Ev1BoT6wajo3oFfDjEgQprnsCXI=;
        b=WGngnCDmpZ/N3I/6k3ZE6ek+OBdN6jgy8fC5o9k/1kLpN5y3JzZizfVeWz2AUzC7Ni
         0wVQgH5w7CaFMvwpcpOlmRBgIgqrKOsbqE0IV8IgllrJKcsWFI2hqsL+bcXqLEs+vX7k
         lhXzRyxojEi5sfxQTqCQo1RyDl8MPZm5HTjq97ue98o4Yq3uHTzrp66GrzS6gw5pqTBE
         A/WSJh1Q7yCYfxgeIS3rUbutc88bDxfhf5JmRD39j+duZasbCHYO97iNS3ysGFZqloTT
         IOJaE6xYcieq4IGxv6C/WdGfsBIeCgHRHHJiXUVTfDY+m0kfUKS3G3L8fUwN+mUghuaq
         4e1g==
X-Gm-Message-State: AAQBX9cabLbwhd/Fbq2onY8mDMS33/wRS+SDNXmYue7L0sSjMC77YqPY
        lMeMtkOWpXgaJhYpykcI5XThFzrpcQ==
X-Google-Smtp-Source: AKy350bptZJ28F/mRowmcmjBLmAhG+V+R/uPrat2LNmcRe9FgBoLEhLI6hRi07G+k+mhkz5h8t/IMg==
X-Received: by 2002:a05:6870:631b:b0:187:83c8:5f0b with SMTP id s27-20020a056870631b00b0018783c85f0bmr9414949oao.58.1681764575423;
        Mon, 17 Apr 2023 13:49:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v124-20020a4a5a82000000b0051ffe0fe11bsm5149481ooa.6.2023.04.17.13.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:49:35 -0700 (PDT)
Received: (nullmailer pid 3344791 invoked by uid 1000);
        Mon, 17 Apr 2023 20:49:34 -0000
Date:   Mon, 17 Apr 2023 15:49:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
Message-ID: <20230417204934.GA3334964-robh@kernel.org>
References: <20230414181302.986271-1-mmyangfl@gmail.com>
 <20230414181302.986271-2-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414181302.986271-2-mmyangfl@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 02:12:59AM +0800, David Yang wrote:
> Add DT bindings documentation for reg-clock-controller, collection of
> basic clocks common to many platforms.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> new file mode 100644
> index 000000000000..a6a7e0b05821
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> @@ -0,0 +1,245 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple straight-forward register-based clocks

'simple' means extended one property at a time with little foresight. In 
the end, 'simple' bindings are never simple. s/simple/generic/ as well.

When we first started the clock binding, we had exactly this. There's 
still bindings for at least some of it. It turned out to be a bad 
idea because it was difficult to get correct and complete. So this 
binding is exactly what we don't want.

Rob
