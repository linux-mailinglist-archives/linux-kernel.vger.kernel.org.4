Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBC5EB13E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIZTZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIZTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:25:32 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403AC3ED4F;
        Mon, 26 Sep 2022 12:25:31 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278624b7c4so10568433fac.5;
        Mon, 26 Sep 2022 12:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wSlAs3Ov0qyrjU7F22uJf4Ts4qpxiIbcNCqQGXu5To8=;
        b=h9cX9F+5wp6BHzjjsMW8qepMVmZZVk3cEaORfwHwnhictYdENd6IEtChVXe0ltTJ3d
         3qG8YeE+lCH9vvnoM+1JoSNRqXvA5bX/X3dImUGGX8nSrNkfsRclaiu9CrFffqUpZ71a
         N8A7ZGi0CmZRAoPruUorHPc2t0BPZJeaC2wTaWXB7sLYLTLt6m2/2/9UIeItWUpy6X1b
         bLk7ChzcqZ2zle4UcpS2R6OxYDiXzO6Fw7lC/lorNLd4sE2ffon8NvqWPUKYVWOiTNHg
         di2KCKpefB+VwxGpPHgfO7k21n2W79ncCZNjFG5y6hQUda1y6zGXnuYOeqcIbRJ17peq
         Q87g==
X-Gm-Message-State: ACrzQf01zgwHu8U/J2OaBHVoKySQR3RkJndIElJ28ciAFo5vku6Cz2mL
        EQo0L5UG15ZXuSnTNxym3w==
X-Google-Smtp-Source: AMsMyM7OEMrkEHBKBFwh58ANG9uZxsIgNS8g+IPXs3SnAsM46IvViigJ6s5H8yfe8cKpWha/Klnrpg==
X-Received: by 2002:a05:6870:f216:b0:12c:2f14:b4a with SMTP id t22-20020a056870f21600b0012c2f140b4amr171512oao.186.1664220330418;
        Mon, 26 Sep 2022 12:25:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q21-20020a4a8355000000b00475db5c28f9sm6948860oog.10.2022.09.26.12.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:25:29 -0700 (PDT)
Received: (nullmailer pid 2638834 invoked by uid 1000);
        Mon, 26 Sep 2022 19:25:28 -0000
Date:   Mon, 26 Sep 2022 14:25:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
Message-ID: <20220926192528.GA2638774-robh@kernel.org>
References: <cover.1663617425.git.sander@svanheule.net>
 <ba3ae8e521ef82dd94f18a602ef53078f4a0d8d5.1663617425.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3ae8e521ef82dd94f18a602ef53078f4a0d8d5.1663617425.git.sander@svanheule.net>
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

On Mon, 19 Sep 2022 22:24:42 +0200, Sander Vanheule wrote:
> The interrupt router has 32 inputs, and up to 15 outputs connected to
> the MIPS CPU's interrupts. The way these are mapped to each other is
> runtime configurable. This controller can also mask individual interrupt
> sources, and has a status register to indicate pending interrupts. This
> means the controller is not transparent, and the use of "interrupt-map"
> inappropriate. Instead, a list of parent interrupts should be specified.
> 
> Two-part compatibles are introduced to be able to require "interrupts"
> for new devicetrees. For backward compatibility "interrupt-map" is still
> allowed on these new compatibles, but deprecated. The old compatible,
> with required "interrupt-map" and "#address-cells", is also deprecated.
> The relevant descriptions are added or extended to more clearly describe
> the functionality of this controller.
> 
> To prevent spurious changes to the binding when more SoCs are added,
> "allOf" is used with one "if", and the compatible enum only has one
> item.
> 
> The example is updated to provide a correct example for RTL8380 SoCs.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> Changes in v6:
> - Allow interrupt-map for backwards compatibility, but mark as
>   deprecated.
> - Update commit message to explain forward/backward compatibility
> - Drop Rob's Reviewed-by because of above changes
> 
> Changes in v5:
> - Add Rob's Reviewed-by
> 
> Changes in v4:
> - Indicate more clearly that the controller is not transparent.
> ---
>  .../realtek,rtl-intc.yaml                     | 60 ++++++++++++++-----
>  1 file changed, 45 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
