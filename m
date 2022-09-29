Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A555EFFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiI2WPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiI2WPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:15:38 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618AF50AF;
        Thu, 29 Sep 2022 15:15:37 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id s125so3032069oie.4;
        Thu, 29 Sep 2022 15:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4BfKtAN74BiuLXzY75ghMuhJ1sBHsY4RPott4OBX9j8=;
        b=Mm19t192ciYXmvGNJr/bx1kAXjYqPK65s9InjF2an94OQls3osMlRU2eB6BZQzUO5y
         HAyBxQizcSxNntKAkGS3Sv8C8tyomDpp5z6PQGgCJHYN0wwYGeF0JQuXqvIYpiv20Y26
         TOylEbQujFiCBvcxtxFTSWB0+bw33FyhfuSKpAdZKhPo/TqyJu60qA+wb/vg6gqCPGnf
         P+mVh7o4/mcZULeG2/BLLeNxg86J5OiHQtbdfckDXsaQ9quUKsrX/SvNrz+fSNHW/dXC
         cGIbAur4MooE47HR0Hy6J3TmJEfkWNcP/auZNiJ5qU9hCgXtgnDmlq+WazPOVq36Wyep
         1EXQ==
X-Gm-Message-State: ACrzQf2XeDr9nQq4cw7O3AYbtJYueP9RklhamU8zVIfI38PDmdt7fSjP
        9HqtJrq0M38GEnLqrxQArA==
X-Google-Smtp-Source: AMsMyM793Cd8u3q+sjWrpJjjLQ0fbvmUagt931/u0RIvCAWtOjG21n+skk3xFBtXE3Ry/fZOtKPL0Q==
X-Received: by 2002:a05:6808:d46:b0:350:cba9:1981 with SMTP id w6-20020a0568080d4600b00350cba91981mr7922656oik.130.1664489736371;
        Thu, 29 Sep 2022 15:15:36 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x65-20020a9d37c7000000b0065bf42c967fsm210418otb.19.2022.09.29.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:15:35 -0700 (PDT)
Received: (nullmailer pid 2863698 invoked by uid 1000);
        Thu, 29 Sep 2022 22:15:35 -0000
Date:   Thu, 29 Sep 2022 17:15:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFT 2/5] dt-bindings: crypto: add support for
 rockchip,crypto-rk3588
Message-ID: <166448973449.2863631.5987990052207072258.robh@kernel.org>
References: <20220927080048.3151911-1-clabbe@baylibre.com>
 <20220927080048.3151911-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927080048.3151911-3-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 08:00:45 +0000, Corentin Labbe wrote:
> Add device tree binding documentation for the Rockchip cryptographic
> offloader V2.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3588-crypto.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
