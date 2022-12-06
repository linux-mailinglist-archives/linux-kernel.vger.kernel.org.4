Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B464442B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiLFNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiLFNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:08:41 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BC21C;
        Tue,  6 Dec 2022 05:06:55 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so3652476otp.9;
        Tue, 06 Dec 2022 05:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0jTcgACAkSw7JNBb/WV7+vRs389mYQWnqLu0OxzR00=;
        b=Mizf3UutLtzKg+7xQxw00BHcPAUl+PoNGjlCy/Sm1g+3vllbzldbLWmInOEDM+VVYd
         dFblYs2FSf+nZA42yaN27rncmX34L5xZsnc6oVli0D1i5z0/tgGgkutX3XO1s1Qn+ZSW
         WfoIRLJ9muNbUuU0EuHPIxyWMTY9jfwhEQNzvp81EZRayEMiNpe1eUxGUMS7/Qjv/WyU
         K+ty/esEKq0FTsCV+gEMMjxgRepj6mB4cJ1IvBhMN4YnwvKtFz9Z7v0P3cHIreOm9OOD
         sdTWnGCZQ4zOM02sryi/s1uzCCue11pIxKHojdOInlg8M4bum6sNy+NwGR4lcDyuK+gg
         sZHA==
X-Gm-Message-State: ANoB5pkEu+6X+5ipAtcQ23NT14+/pumIIU0RomJ/r9rxd1f4+iYhJ+pZ
        7g96S60rZnJC06gMSJh1aXzIAul4Yw==
X-Google-Smtp-Source: AA0mqf4x7yNixRdj8JvkRnl4xZF7qAyjrvvZTbz2eXONt7y0lhjiBhardtNRqcZTdLE4v7XEXTfQsQ==
X-Received: by 2002:a05:6830:610e:b0:66e:34d1:2088 with SMTP id ca14-20020a056830610e00b0066e34d12088mr24615297otb.149.1670332014642;
        Tue, 06 Dec 2022 05:06:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a4a9442000000b0049f0671a23asm7796022ooi.9.2022.12.06.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:06:54 -0800 (PST)
Received: (nullmailer pid 232219 invoked by uid 1000);
        Tue, 06 Dec 2022 13:06:53 -0000
Date:   Tue, 6 Dec 2022 07:06:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: fix underscore requirement
 for multi-letter extensions
Message-ID: <167033201265.232161.10135246798960157053.robh@kernel.org>
References: <20221205174459.60195-1-conor@kernel.org>
 <20221205174459.60195-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205174459.60195-2-conor@kernel.org>
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


On Mon, 05 Dec 2022 17:44:59 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The RISC-V ISA Manual allows the first multi-letter extension to avoid
> a leading underscore. Underscores are only required between multi-letter
> extensions.
> 
> The dt-binding does not validate that a multi-letter extension is
> canonically ordered, as that'd need an even worse regex than is here,
> but it should not fail validation for valid ISA strings.
> 
> Allow the first multi-letter extension to appear immediately after
> the single-letter extensions.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
