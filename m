Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC24B5F0FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiI3QXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3QXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:23:07 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DAA1280C3;
        Fri, 30 Sep 2022 09:23:06 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13207a86076so1768584fac.3;
        Fri, 30 Sep 2022 09:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w9hq7n2tD3rgg2F00+aPHrrD1/MYUDM391P4uFAE3cA=;
        b=hRWFXxhE6EdV3FNJjWlFbPbLTg7Ol47yTLdVtQ7vUv7/P2VFXpQu1r4DhwN2H3vOVt
         i2DThh4al6sX2XPEWUOw1swYNsvGDZXkZFyRoIgR0/z8otOjnJSjKfuguEbq06ZJTuNs
         1uLe8I/fTg7f9IHIWCIQ5ZRL2EqxFKRAXSalaUoFexZ2UR0Tsn+zKzz1F+cqY1hEFwxq
         XaumeiVdM32qykf6ujKPUIfB7R5jZnXKleX1wgmyTcCxiE/xMpTWbA3kCS4sZoTILgBz
         ynSJ/85dZF+dDrWpkMCIyPEgSpz31vYUwVNRNcNZAvDSP+3W1uLGC0cooqchh4/QuYbc
         wb1Q==
X-Gm-Message-State: ACrzQf03ve+3rAD6XrDSKQUP1g3j+SiTkXUVcTo+gZ/AG2CEcs3PIzDX
        Nzr+DKgDSA3QneVhnSQtrD3tg8/nmg==
X-Google-Smtp-Source: AMsMyM6zcZ/ttBO2lDoYpmgwIrE+97StZEQQO1eKeFPnWuxuP8tvPZklLFGjubqpUpxqP+hmtoZtKA==
X-Received: by 2002:a05:6870:41d2:b0:131:ea46:760f with SMTP id z18-20020a05687041d200b00131ea46760fmr3119034oac.44.1664554985954;
        Fri, 30 Sep 2022 09:23:05 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cp26-20020a056830661a00b006596cafaeabsm669609otb.47.2022.09.30.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:23:05 -0700 (PDT)
Received: (nullmailer pid 465977 invoked by uid 1000);
        Fri, 30 Sep 2022 16:23:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To:  <4fdb6ff47f62814aab3b06efd1d4c2d7de83b109.1664368373.git.geert+renesas@glider.be>
References:  <4fdb6ff47f62814aab3b06efd1d4c2d7de83b109.1664368373.git.geert+renesas@glider.be>
Message-Id: <166455498409.465975.1174917477193500313.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: irqchip: renesas,irqc: Add r8a779g0 support
Date:   Fri, 30 Sep 2022 11:23:04 -0500
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

On Wed, 28 Sep 2022 14:33:36 +0200, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INT-EX) in the Renesas R-Car V4H (R8A779G0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

