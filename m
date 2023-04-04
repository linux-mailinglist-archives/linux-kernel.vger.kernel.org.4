Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB766D69DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjDDRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjDDRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:08:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1355B7;
        Tue,  4 Apr 2023 10:08:15 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so16386788otb.0;
        Tue, 04 Apr 2023 10:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kyfGfHQKgkYy16DyfpdvEbx6sQQJifapGZEB9kHD60=;
        b=129cSKXlK0ZO7L7KgdEnMdj5ciq3oWEU7dcIh1iYO5/IL0nO9uEEDhT5CiSt7ryTDA
         ub7jwE2qA0WJl1vk39Q+w9VPi66sfANApZjXN7O7tby9AYmnyK3LmrP7J9s7qFCNKBOy
         JuOB1PFacv34sSIQ11Tzjx/5HBIxzkpkFjAiocneiv/u0s/ctS8CMu0z8axJrTY4kjXh
         6evrleuTm11WRgjjF8oTqLYL6j4LHnmFo/R7IZw8Kb5GPUA4FTsCq1hfnJYuvvKwBsIB
         CsL9R5yiPwLKwidvOrgz3/y/ZB1nTy2S5fLZnIrYZtAdwHyb+Ji7izy+Wc8P/BIFHQyc
         IsNA==
X-Gm-Message-State: AAQBX9cDltQP/OB5Us1on5nhIff/B2FncJUzsvnNwBs5Rd+/6PNCyi5J
        YioQ4mDpQuUPY3XQNLFgjQ==
X-Google-Smtp-Source: AKy350bmJMrR1r7FrJGxefej2KGuvmYkx3SzlJzTOaJo3fly2J6n9OiGiUI/5C16CZmpe5LaLx5AEg==
X-Received: by 2002:a9d:7b4e:0:b0:69f:2774:b60 with SMTP id f14-20020a9d7b4e000000b0069f27740b60mr1694681oto.8.1680628095187;
        Tue, 04 Apr 2023 10:08:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x9-20020a05683000c900b006a30260ccfdsm4494944oto.11.2023.04.04.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:08:14 -0700 (PDT)
Received: (nullmailer pid 115563 invoked by uid 1000);
        Tue, 04 Apr 2023 17:08:14 -0000
Date:   Tue, 4 Apr 2023 12:08:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Qin Jian <qinjian@cqplus1.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: Drop unneeded quotes
Message-ID: <20230404170814.GC49361-robh@kernel.org>
References: <20230322173508.3971182-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322173508.3971182-1-robh@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:35:07PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/reset/amlogic,meson-axg-audio-arb.yaml         | 4 ++--
>  .../devicetree/bindings/reset/amlogic,meson-reset.yaml      | 4 ++--
>  .../devicetree/bindings/reset/bitmain,bm1880-reset.yaml     | 4 ++--
>  .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml       | 4 ++--
>  .../devicetree/bindings/reset/brcm,brcmstb-reset.yaml       | 4 ++--
>  .../devicetree/bindings/reset/marvell,berlin2-reset.yaml    | 4 ++--
>  Documentation/devicetree/bindings/reset/microchip,rst.yaml  | 6 +++---
>  .../devicetree/bindings/reset/qca,ar7100-reset.yaml         | 4 ++--
>  Documentation/devicetree/bindings/reset/renesas,rst.yaml    | 4 ++--
>  Documentation/devicetree/bindings/reset/sunplus,reset.yaml  | 4 ++--
>  10 files changed, 21 insertions(+), 21 deletions(-)

Applied, thanks.
