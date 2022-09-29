Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386F05EFFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiI2WPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiI2WPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:15:00 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29654D4D7;
        Thu, 29 Sep 2022 15:14:59 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so1064329ool.3;
        Thu, 29 Sep 2022 15:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G3ixGfgN7BtiMl2GIJrXgjiRG+Ja3k65KHc2UeJTU2Y=;
        b=3Jy9NYvuo6n5zW/SIcC7pJw4ycEoWa/XAmrcfGAa8BZ3Q+FBQzh7oN30mHLnVxKOz5
         GY440sl+r72Vi0oJ3R+Q1GmirwEjgRVIfBClc50+2N1hMNzqakTHrwj/aAgapFjYTm2G
         iYRyBKMCeRzX5xFuAHid1QO4LJJhe7scjHGVEwhwc83bJQ9124qcFWPrRiQShcIwNDE1
         P51TVtEr0AZ6p1xak5bexumL6IBmOL0ExKzuQZ87avfRD879MP6Il+F5kuwnjDNPvvyf
         6bL52CdB1iTGgjuQRwsyaCZxl9Y/jpUDJhwdCuX5VJmjpI3CI62iZ/mf4y2p0oRuWL9E
         2qNQ==
X-Gm-Message-State: ACrzQf1YWJKbAQYHJqfT1R27bq3aI0MpQ2OZAxaduJYMF9Klp2haPYxm
        hME6e/aZve5lHFI3wUrKaQ==
X-Google-Smtp-Source: AMsMyM6X8fuxncInKY1HHajfMs3xBeGsJpxqmoGci0kg/caJyZtFTBc6uzl+qdSsE6tynspmpVwZHw==
X-Received: by 2002:a9d:666:0:b0:655:d979:8a6 with SMTP id 93-20020a9d0666000000b00655d97908a6mr2406280otn.200.1664489699187;
        Thu, 29 Sep 2022 15:14:59 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c6-20020a9d7846000000b0065892f42157sm199147otm.75.2022.09.29.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:14:58 -0700 (PDT)
Received: (nullmailer pid 2862895 invoked by uid 1000);
        Thu, 29 Sep 2022 22:14:57 -0000
Date:   Thu, 29 Sep 2022 17:14:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-rockchip@lists.infradead.org, davem@davemloft.net,
        linux-clk@vger.kernel.org, ardb@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-crypto@vger.kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v10 25/33] dt-bindings: crypto: rockchip: add new
 compatible
Message-ID: <166448969734.2862850.15734713971995985090.robh@kernel.org>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
 <20220927075511.3147847-26-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927075511.3147847-26-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 07:55:03 +0000, Corentin Labbe wrote:
> Since driver support new compatible, we need to update the driver bindings.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 79 +++++++++++++++++--
>  1 file changed, 71 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
