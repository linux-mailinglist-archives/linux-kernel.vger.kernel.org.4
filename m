Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179AB68DE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBGRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjBGRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:05:56 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C03D0A1;
        Tue,  7 Feb 2023 09:05:53 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso4389057otq.9;
        Tue, 07 Feb 2023 09:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjJO3OpBUSTO6OYkxL9DTxtzb7K3YxEOsZ3y6y3+V9w=;
        b=x9MV1mWWQD27z0+DR0UQPKEQ9+4VTBxapHtHMxSobwZUBRvgZmJrmBGHxVJNlVWJ2Z
         zwJz7sThGSyqMgs/h7W55ID240dafBxFPnFxqMKM1AKAh5o+nXvZdNPrXLHMgD+stFie
         fTzewlNpfgxAUTMG1J8P0UFCWJDjndCsw2K3VHu0GPOI/PxfF7qtuiB1ZlfbvWl5c4TK
         PAqy0VZELut6HzdkKGXtPKBziEQ82AwkHn+7e+xzJFqx472MZqklafkj7LR9Fd3OYKwo
         QMmUZhbs2/+vh6grmNMx69yYqBkAPAerBasqhIpm2j10l6gowQEnwO0mL/OSanDb1jYv
         VP0A==
X-Gm-Message-State: AO0yUKWafmiInX0wf1yGf8XdCc7XMwFXl2fkzOHBPGeXjaaNfaEo9/PM
        V4+nTAaG/FsDP5R+cH471w==
X-Google-Smtp-Source: AK7set9x87GYzl8leh2Lg0sAbmIgU0U3bLD8+yGCibPjPr1q8G1W6tSreTRbK881CDXdQ76Zxpq1zA==
X-Received: by 2002:a05:6830:690c:b0:68b:c8e1:4f44 with SMTP id cx12-20020a056830690c00b0068bc8e14f44mr2412395otb.1.1675789552218;
        Tue, 07 Feb 2023 09:05:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j74-20020a9d17d0000000b0068bd04b4292sm6696702otj.31.2023.02.07.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:05:51 -0800 (PST)
Received: (nullmailer pid 3750258 invoked by uid 1000);
        Tue, 07 Feb 2023 17:05:50 -0000
Date:   Tue, 7 Feb 2023 11:05:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Message-ID: <20230207170550.GA3719881-robh@kernel.org>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-5-evan@rivosinc.com>
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

On Mon, Feb 06, 2023 at 12:14:53PM -0800, Evan Green wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This key allows device trees to specify the performance of misaligned
> accesses to main memory regions from each CPU in the system.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index c6720764e765..2c09bd6f2927 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -85,6 +85,21 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/string"
>      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
>  
> +  riscv,misaligned-access-performance:
> +    description:
> +      Identifies the performance of misaligned memory accesses to main memory
> +      regions.  There are three flavors of unaligned access performance: "emulated"
> +      means that misaligned accesses are emulated via software and thus
> +      extremely slow, "slow" means that misaligned accesses are supported by
> +      hardware but still slower that aligned accesses sequences, and "fast"
> +      means that misaligned accesses are as fast or faster than the
> +      cooresponding aligned accesses sequences.
> +    $ref: "/schemas/types.yaml#/definitions/string"
> +    enum:
> +      - emulated
> +      - slow
> +      - fast

I don't think this belongs in DT. (I'm not sure about a userspace 
interface either.)

Can't this be tested and determined at runtime? Do misaligned accesses 
and compare the performance. We already do this for things like memcpy 
or crypto implementation selection.

Rob
