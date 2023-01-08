Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE766198F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjAHUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjAHUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:52:25 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF110B48;
        Sun,  8 Jan 2023 12:52:24 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id i16so3466699ilq.9;
        Sun, 08 Jan 2023 12:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BirxzjgvGzirxW73jcrqqffk9nEsL9qkjV1hAIZX5Q=;
        b=sp3BzwcCfw1Lfr5v8LMDHGimGpA4iWmINkKk89Rk2KMQBgQbFkEQd5/iA1z+s+/gb0
         XBo2cwqRaOjt/wy1Brtfqsy1c+T945/cIQwRcHW5fEBMm3VNLa/D7mdQcOxh7CJxDv7u
         V3IIQk9H3HphmZwa5rH5x0eBwMpVplAlSEfPG9/aiRGSMN6g98RtIKpdc+cttNXv55J+
         YkkfVJySh+E8lDAn5Jkr4WKzsDvkK1zqpN1xtQb7lnt90N2CTAuxeU04U65Iqp1wIhLx
         aZfMx6dL2rJ+gKWlUpl2PdJdkpDxpsjKzuAj94Zu4nlNq34rtv2WYEU/tJ5FO8GkZREN
         JOhw==
X-Gm-Message-State: AFqh2kpvzAYnVxCe4kj6RBKcHNrZFeUPDdNBX1jGRN5bbtyOYTFZYTLe
        OHnfX/7u2VtPvpioHr9lcg==
X-Google-Smtp-Source: AMrXdXs7n9bgaFZ6xucDGoNyyLMSFYqhzi39KdrYn1a/78vXGaDWc0b2zp+58Pg+LBPFJrFlZQZ04w==
X-Received: by 2002:a92:ccc7:0:b0:304:aa32:a4c1 with SMTP id u7-20020a92ccc7000000b00304aa32a4c1mr54001612ilq.6.1673211143610;
        Sun, 08 Jan 2023 12:52:23 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id b19-20020a923413000000b003036d1ee5cbsm1858762ila.41.2023.01.08.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:52:23 -0800 (PST)
Received: (nullmailer pid 259074 invoked by uid 1000);
        Sun, 08 Jan 2023 20:52:20 -0000
Date:   Sun, 8 Jan 2023 14:52:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
Message-ID: <167321113265.258879.13467635620456746587.robh@kernel.org>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Jan 2023 22:18:10 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> is almost identical to one found on the RZ/G2L SoC the only difference
> being it can support BUS_ERR_INT for which it has additional registers.
> Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
> for RZ/G2UL SoC.
> 
> Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> interrupt-names property is added so that we can parse them based on
> names.
> 
> While at it updated the example node to four spaces and added
> interrupt-names property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Dropped RZ/G2UL specific string
> 
> v1- > v2
> * Dropped RB tags
> * Added generic compatible string for rzg2ul
> * Added interrupt-names
> * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
> * Updated example node with interrupt-names
> * Used 4 spaces for example node
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
>  1 file changed, 170 insertions(+), 55 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
