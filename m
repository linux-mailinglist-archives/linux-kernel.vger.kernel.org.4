Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8764442D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiLFNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiLFNI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:08:59 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A7A2CDDD;
        Tue,  6 Dec 2022 05:07:12 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1447c7aa004so9173927fac.11;
        Tue, 06 Dec 2022 05:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imUdSZL1p1VPSoRbaTGeAWYoJrWVTzc2KiZUbiVlSk0=;
        b=Q+onvu7um3cXTpZ3a0pgluNaZZAFK8Bw0KIIYPemlpvMj8N8rEQflunZuVAcOL6KSu
         rflnDDUuFZlRL4LW7jnTkmlDV146E+5LdjZ9k1Vglz3YJ1tfixbjxnbiyPQSDlUqGLv1
         iXlFqHxDNFT5MsVj0h2U9r2ZhLZK5PgC46L266jmJd6WZNnMvnPTzw12uOUyubR1wVWu
         4b5X2//zT8MqcuTj6hIREcmw7vXzsRIr6Ht/rH51eehxucF99hUajeAchE4nQ6kQSNc5
         YX8NlTd9CLjyMWTzjkRRNJf2HalDOPKwtnw1Q/yEBI2OgdpJ/BBFWzPnP2axU4i7shUK
         1NPg==
X-Gm-Message-State: ANoB5pkNV+1gqyXIn0RfNjDdV6Xbd2Vd/QgRLOJ7FPifestzuUSvA0uG
        STs/bUoShkAlzy8ONeEEYQ==
X-Google-Smtp-Source: AA0mqf5z9DjerkdA2yTFa+vGGSfpZNB+NnpP2vdElYLYU29uLcQ9+ZkV9VlhJCcZpEAQoIs77c/cIA==
X-Received: by 2002:a05:6870:828e:b0:144:9477:9f56 with SMTP id q14-20020a056870828e00b0014494779f56mr5147179oae.226.1670332031196;
        Tue, 06 Dec 2022 05:07:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s5-20020a05683004c500b0066d2fc495a4sm9098255otd.48.2022.12.06.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:07:10 -0800 (PST)
Received: (nullmailer pid 232720 invoked by uid 1000);
        Tue, 06 Dec 2022 13:07:10 -0000
Date:   Tue, 6 Dec 2022 07:07:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: riscv: fix single letter canonical
 order
Message-ID: <167033202949.232654.4467238719152703044.robh@kernel.org>
References: <20221205174459.60195-1-conor@kernel.org>
 <20221205174459.60195-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205174459.60195-3-conor@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 17:45:00 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> I used the wikipedia table for ordering extensions when updating the
> pattern here in commit 299824e68bd0 ("dt-bindings: riscv: add new
> riscv,isa strings for emulators").
> 
> Unfortunately that table did not match canonical order, as defined by
> the RISC-V ISA Manual, which defines extension ordering in (what is
> currently) Table 41, "Standard ISA extension names". Fix things up by
> re-sorting v (vector) and adding p (packed-simd) & j (dynamic
> languages). The e (reduced integer) and g (general) extensions are still
> intentionally left out.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
