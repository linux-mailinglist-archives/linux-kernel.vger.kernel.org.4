Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE873720D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjFTQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFTQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:48:55 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8518C;
        Tue, 20 Jun 2023 09:48:55 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-340b7da7e3aso19943305ab.3;
        Tue, 20 Jun 2023 09:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279734; x=1689871734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKtBf3FdQDl5x5uXgdHSfUH2YbLABmeDIyDo1DZ9iLo=;
        b=QvxEUDBdZQ85XKt3mlB1wO9GeHyGDTPZCKYhW5WKaIkfstkPMaeF1iS8waSexBZf3V
         cKRqI3sxyMSgbNyxtCBkk8H0HuASKwVM4KACVer2Y+SzA1cgNuUZWhZ9u5mk5lii9q/t
         Equ9SwFxQmacJjAZkQ1Z8Th+5TsZggV08/gFpLhWwvLuUm3MpQhVMvRZzV0GUIdSXLnw
         xJvyjhUcQNTSYpDXn3bq0qJzp2nJ8S8JKdYPXRnAjOz6IkWYy2mVBXybwraoKRfnpbfD
         4ErJl8lyWZjDxlsoxgyg6Poy+pIrJaJZmluWOFTgSIY14fFPIICB+Y3TrW43Xbt51Jpj
         6RjQ==
X-Gm-Message-State: AC+VfDxRUM+4J2pGAMMzLqz5JZ0XZiu3HMQ3xVQEFY72BrcT9Ciao3v0
        xQaUwbEd2cktLP2G8SFU4A==
X-Google-Smtp-Source: ACHHUZ7My2jXB+Dq8VAUIRgDY8jlDmbwnilxlULBF7tROA1iafJHmdLKZVOsJySULbyVs0PQNEkGoA==
X-Received: by 2002:a92:cb43:0:b0:342:3f23:c144 with SMTP id f3-20020a92cb43000000b003423f23c144mr8651793ilq.28.1687279734478;
        Tue, 20 Jun 2023 09:48:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a92d90b000000b00333b5ae4ab7sm693461iln.87.2023.06.20.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:48:53 -0700 (PDT)
Received: (nullmailer pid 3803830 invoked by uid 1000);
        Tue, 20 Jun 2023 16:48:52 -0000
Date:   Tue, 20 Jun 2023 10:48:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@dabbelt.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: cpus: add a ref the common
 cpu schema
Message-ID: <168727973145.3803765.17862726534015699285.robh@kernel.org>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
 <20230615-dubiously-parasail-79d34cefedce@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-dubiously-parasail-79d34cefedce@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 23:50:14 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> To permit validation of RISC-V cpu nodes, "additionalProperties: true"
> needs to be swapped for "unevaluatedProperties: false". To facilitate
> this in a way that passes dt_binding_check, a reference to the cpu
> schema is required.
> 
> Disallow the generic cache-op-block-size property that that drags in,
> since the RISC-V CBO extensions do not require a common size, and have
> individual properties.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

