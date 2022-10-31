Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE6613D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJaSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJaSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:46:10 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A812610;
        Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id p127so13656558oih.9;
        Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO8H5QCa3hgSieHYwlmpZX3yqBydAVWKuwLGmWit0To=;
        b=zS3N9TvSG/p251IMREqz5ES9TgTRra3tZ+eXZV/6r2urczZwYocJu+UzsKqNoSLR00
         Klkfq4/z1LyDE9Beo9G1dhwza4d0lzSY18ykyQ0xWuff43FxujlQj1YtgbZPH5yBaJBI
         IgBwXI80ASnjix8CFIYcL/tzYf1lgZ2O3zKvP0qP8C/IjS2vpViFfg08xcp3D2c7dQDd
         LfCuP3lHVxCNFYavEDKg3H+DgCD48FPI7b9PiQ6yiP0xtl/3ddzCD8/qo/IIEHNWWlIr
         QAgNpMTDgqscjffFLQHzuYjwFiUZgyB8+A/Pp9Pm5oTv/TiWDFq8rY7g0yiLKppBhFgN
         iSOA==
X-Gm-Message-State: ACrzQf3FmtARJdkaa68vL3qAxGD6e6ETiCypgIa4Sb8cOt5PvkvgT7Z5
        etKYx/ifSRvDdg2wFm3T0A==
X-Google-Smtp-Source: AMsMyM4/HGxczmxjs3nTZ13LSdLRb4M+o0ANIbSNLMj9l7t2fMP1wLJjAEWQ6t6bZdK7j9LmlV6xDw==
X-Received: by 2002:a05:6808:254:b0:359:f10b:5469 with SMTP id m20-20020a056808025400b00359f10b5469mr5693509oie.248.1667241968993;
        Mon, 31 Oct 2022 11:46:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k12-20020a056820016c00b0049a96a62a3bsm1742279ood.48.2022.10.31.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:46:08 -0700 (PDT)
Received: (nullmailer pid 3242738 invoked by uid 1000);
        Mon, 31 Oct 2022 18:46:10 -0000
Date:   Mon, 31 Oct 2022 13:46:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        perex@perex.cz, paul@crapouillou.net, robh+dt@kernel.org,
        broonie@kernel.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: ingenic,aic: Remove unnecessary
 clocks from schema
Message-ID: <166724196894.3242676.3402578757445878857.robh@kernel.org>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
 <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Oct 2022 11:34:16 +0100, Aidan MacDonald wrote:
> The AIC needs only the first two clocks: "aic" is a gate that's used
> for gating the I2S controller when it's suspended, and "i2s" is the
> system clock, from which the bit and frame clocks are derived. Both
> clocks are therefore reasonably part of the AIC and should be passed
> to the OS.
> 
> But the "ext" and "pll half" clocks are a little more questionable.
> It appears these bindings were introduced when the schema was first
> converted to YAML, but weren't present in the original .txt binding.
> They are intended to be the possible parent clocks of "i2s".
> 
> The JZ4770 actually has three parents for its "i2s" clock, named
> "ext", "pll0", and "pll1" in the Linux driver. The JZ4780 has two
> parents but it doesn't have a "pll half" clock, instead it has an
> "i2s_pll" clock which behaves much differently to the actual
> "pll half" clock found on the JZ4740 & JZ4760. And there are other
> Ingenic SoCs that share the JZ4780's clock layout, eg, the X1000.
> 
> Therefore, the bindings aren't really adequate for the JZ4770 and
> a bit misleading for the JZ4780. Either we should fix the bindings,
> or remove them entirely.
> 
> This patch opts to remove the bindings. There is a good case to be
> made that "ext" and "pll half" don't belong here because they aren't
> directly used by the AIC. They are only used to set the parent of
> the "i2s" clock; they have no other effect on the AIC.
> 
> A good way to think of it is in terms of how the AIC constrains
> clocks. The AIC can only generate the bit & frame clocks from the
> system clock in certain ratios. Setting the sample rate effectively
> constrains the frame clock, which, because of the clock dividers
> controlled by the AIC, translates to constraints on the "i2s" clock.
> Nothing in the AIC imposes a direct constraint on the parents of
> the "i2s" clock, and the AIC does not need to enable or disable
> the parents directly, so in principle the AIC doesn't need to be
> aware of the parent clocks at all.
> 
> The choice of parent clock is still important, but the AIC doesn't
> have enough information to apply such constraints itself. The sound
> card does have that information because it knows how the AIC is
> connected to other components. We need to use other DT mechanisms
> to communicate those constraints at the sound card level, instead
> of passing the clocks through to the AIC, and inventing ad-hoc ways
> to plumb the constraints around behind the scenes.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../devicetree/bindings/sound/ingenic,aic.yaml         | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
