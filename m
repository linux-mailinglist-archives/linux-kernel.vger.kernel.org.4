Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001D64D241
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLNWTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:18:58 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA02CC84;
        Wed, 14 Dec 2022 14:18:56 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id x38-20020a4a97e9000000b004a5d69cfc90so442181ooi.6;
        Wed, 14 Dec 2022 14:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fKwEYXKRlbCe5cbb/8awwIxIrypc26XlILxNrHM9Gw=;
        b=SY+TskAfxXF0OZ8AEIyhDjvOjtnVpiECqObFoMeB99zXI4QqKFh/43fqRGHsLtWo2J
         BR1yCFrgMyddhp/Ezp+pVWScc2EMuq/JRgyX1sSInqsu02cU2uc6RBS9cDspBQWmt84f
         tylNVOkNBCCs6/8j/ezTwOCTXtaf0jtyKsGhrkDYmYOeffrT2G5fLq8z0VmFiArCa52A
         TAK+OQdfq383/NLQ+kN95aDcrG+YtVx7EHfqdJf+IwygfX4IlKbSgrog/Zh4/XC05WgA
         CMILSCe+9shzxaCGhEUdsTCQfCcf/PDKB2vAO1m9w7wOuXltotvH0b0TcFaoN0sva5jq
         kDzQ==
X-Gm-Message-State: ANoB5pm7ysWgoZ0Hd9nV+IGTISfvxLOZRwlRHI5HTUDxe/6ckpZ6lZ5d
        ycm3YW8iuKWOaH0ceSeGlg==
X-Google-Smtp-Source: AA0mqf7HttOuSbgbvR3LOAKmSgdhIpPAL3rCgPbbswvtsLMzoZSAPewNb8F5s9juDilGd3WifVo9NQ==
X-Received: by 2002:a4a:92d4:0:b0:4a6:5afc:9a51 with SMTP id j20-20020a4a92d4000000b004a65afc9a51mr1117536ooh.8.1671056335956;
        Wed, 14 Dec 2022 14:18:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l4-20020a4a2704000000b004908a9542f8sm2726970oof.31.2022.12.14.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:18:55 -0800 (PST)
Received: (nullmailer pid 1735858 invoked by uid 1000);
        Wed, 14 Dec 2022 22:18:54 -0000
Date:   Wed, 14 Dec 2022 16:18:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: sort entries alphabetically
Message-ID: <167105626477.1734283.4192335575546485583.robh@kernel.org>
References: <20221202110536.22230-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202110536.22230-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 02 Dec 2022 12:05:36 +0100, Krzysztof Kozlowski wrote:
> Sort entries alphabetically.  This was a semi manual job with help of:
> 
>   cat Documentation/devicetree/bindings/vendor-prefixes.yaml | grep '":' > old
>   cat old | sort > new
>   diff -ubB old new
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Patch rebased on next-20221201 therefore might not apply cleanly to
> Rob's tree. Probably should be taken after the 6.2-rc1.
> ---
>  .../devicetree/bindings/vendor-prefixes.yaml  | 64 +++++++++----------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 

Applied, thanks!
