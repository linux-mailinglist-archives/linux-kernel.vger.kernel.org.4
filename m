Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56F62CCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKPVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiKPViP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:38:15 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F65D6BB;
        Wed, 16 Nov 2022 13:38:02 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13bd19c3b68so21692839fac.7;
        Wed, 16 Nov 2022 13:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ajJyywD/4DGN7+ib3OOlpxn9zCtQP+kRRJV3rgQd0=;
        b=p0W/LGzDkzmVqVc9g/mWPEAgxlNnadVHvNwuAGnWuWS+qT4pZFFhx+bKe9KOr5mEAl
         rYzZJzDetQvAwL3Wcy29vkN7cuLsrAtmNj1qDZ485lyQv7x7lj962j8uSYwz1hNYf/6/
         Vv8YBF0zD/4t2smIqLT7Y432q9uOzzhUbH4mvc7w9itMyJryxHKvRBIeFIBg/GB6dP6N
         fMa+ajEK7meYoe8CZAYk0AIvDXHXoSOhJoM0HHG5wjjr9w+sBUikqU2gtPx38kldoFaD
         vwGcIazRjryg7k/37SgpQzh7pdOYDqssAwbz3r/Pv52UbIc+RsrVafHF7T4bacmbzmgc
         7YZg==
X-Gm-Message-State: ANoB5pnsbqlfROnjHP2u29S0F0SBN6jU0SOXeruSk8ZfU+fkReVQE8Pa
        /mWYoW6Sp1F57yTRwQWO+Q==
X-Google-Smtp-Source: AA0mqf61GFUFznefT2AM9Xs0EbuM8eP+CfmSUS4C466SPnx22nhb6x9TE9+WNDPceqqxiBupty8BHQ==
X-Received: by 2002:a05:6870:42cd:b0:132:fd69:b244 with SMTP id z13-20020a05687042cd00b00132fd69b244mr2746255oah.275.1668634682120;
        Wed, 16 Nov 2022 13:38:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d11-20020a056830044b00b0066c15490a55sm7067428otc.19.2022.11.16.13.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:38:01 -0800 (PST)
Received: (nullmailer pid 1016743 invoked by uid 1000);
        Wed, 16 Nov 2022 21:38:03 -0000
Date:   Wed, 16 Nov 2022 15:38:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/Five SoC
Message-ID: <166863468321.1016692.3662033617872440170.robh@kernel.org>
References: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 12:41:28 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The ADC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-adc" compatible string will be used on the RZ/Five
> SoC so to make this clear, update the comment to include RZ/Five SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rzg2l-adc" will be used as a fallback on RZ/Five SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
