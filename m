Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6167066892C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbjAMBak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjAMBag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:30:36 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EAA5DE58;
        Thu, 12 Jan 2023 17:30:35 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-15bb8ec196aso9109819fac.3;
        Thu, 12 Jan 2023 17:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHEg0Tu4T0FTdfDnr1uHsTuZiO21FEsCK3FYFxVcWdA=;
        b=wRYxH+oyrHEQ8iJvNvnAxdscEzH5SQBvgEUZ0Kn+Te7FijriZMe8XFsHFsTruBbUx+
         DujYXqfWZGgViyoV3+5yDxTiuZW6wBlnxRD5BGmgqJQv/pk0R4TaIEUSk45XCX4xa+T2
         z2AHQF/AaLfPsuki0mk3ttGGhbJm/uiwxQfELtfdgTpS8k+BXZBTBKXmCT9XCNAl4XNU
         tETuB5FKfgP2Lrch3X4RbJA55h5ewBiSJar5eUYYeZarBmUtPVECRyTQU2AL47ZtaGHC
         nWLMaP3qs4Hw+PvB4OaCksBonYke6aVLY1ZwOET4YMqnNkkAjZYVuUheXFl4Hw2hSKOi
         abWQ==
X-Gm-Message-State: AFqh2ko8xWvYFh0YUDHUYGyXc14BMrOshve8spESH01HCI7bD7jI+mgI
        EAd8Qyl84mRD6VRMTkNXGA==
X-Google-Smtp-Source: AMrXdXu/Y+DQPo4vCrgC2MrR0FQ8VB5gdtOfweqbYceUwefQolDBA2xCqxSt8+XnoA9uaACqeriVOw==
X-Received: by 2002:a05:6871:4408:b0:14f:9e41:7dbe with SMTP id nd8-20020a056871440800b0014f9e417dbemr4578946oab.10.1673573435159;
        Thu, 12 Jan 2023 17:30:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a4abc9a000000b004a0aac2d28fsm9025181oop.35.2023.01.12.17.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:30:34 -0800 (PST)
Received: (nullmailer pid 589937 invoked by uid 1000);
        Fri, 13 Jan 2023 01:30:34 -0000
Date:   Thu, 12 Jan 2023 19:30:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: crypto: Let STM32 define Ux500 HASH
Message-ID: <167357343355.589882.8533297538415386387.robh@kernel.org>
References: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
 <20221227-ux500-stm32-hash-v2-1-bc443bc44ca4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227-ux500-stm32-hash-v2-1-bc443bc44ca4@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 20:19:12 +0100, Linus Walleij wrote:
> This adds device tree bindings for the Ux500 HASH block
> as a compatible in the STM32 HASH bindings.
> 
> The Ux500 HASH binding has been used for ages in the kernel
> device tree for Ux500 but was never documented, so fill in
> the gap by making it a sibling of the STM32 HASH block,
> which is what it is.
> 
> The relationship to the existing STM32 HASH block is pretty
> obvious when looking at the register map, and I have written
> patches to reuse the STM32 HASH driver on the Ux500.
> 
> The main difference from the outside is that the Ux500 HASH
> lacks the interrupt line, so some special if-clauses are
> needed to accomodate this in the binding.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use an else construction instead of if/if not.
> ---
>  .../devicetree/bindings/crypto/st,stm32-hash.yaml  | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
