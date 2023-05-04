Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD46F772F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEDUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEDUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:38:45 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35DD203E0;
        Thu,  4 May 2023 13:32:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-763c34315c1so65129939f.3;
        Thu, 04 May 2023 13:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683232269; x=1685824269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA20TOSek5QN06wRXiWT/dSTTLiibBANa8l3zZw/ZW0=;
        b=RBGdrH4d/NDnYIUyp7acK3moOupX/ttUtwAogNqJVEeVi/VHVyqCKufi/NhiBdSI0t
         FyKkYuOtYjDsZGoVPd24oG678JUNc+ZVHmRs304d1iCWVZ4Wjsy37v7iJyPSr5GuNSj5
         VlxTVEoCcVk9AWPcWESQrucnD+SOFCTaSroqznHEDlZbzHZKy5ZSftylPsL8w1wxr7OY
         /1YndJDUxSTyO+94cuoLk8ZOzw9f8KUTqwvxfCBsEIMDwuy04cCFSD1dSRYbeQTozD8U
         qs3VJTidBu+3jUgZlr3TvUG9GObSb6lu5cAE/5ygU7ZtxCU6XK9TuHen6Z4BFq5kH7be
         opvw==
X-Gm-Message-State: AC+VfDzzjRHterbyc1BSbySPBPYva2H0CP+QV3sSn7RB343elLxYebDb
        MmCvQE3MQXbcwQ2u02RdJ0ooQe/siA==
X-Google-Smtp-Source: ACHHUZ5CG9NqSZrBLZgYDI1UBcc0h1gHIMntqoA1SnNdYU8ayNb3BfWME5yS8u0iFY/rBBuEK8CKFw==
X-Received: by 2002:a05:6808:2913:b0:389:21:9483 with SMTP id ev19-20020a056808291300b0038900219483mr2333168oib.59.1683231718082;
        Thu, 04 May 2023 13:21:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020acaf302000000b0038e086c764dsm2036478oih.43.2023.05.04.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:21:57 -0700 (PDT)
Received: (nullmailer pid 263633 invoked by uid 1000);
        Thu, 04 May 2023 20:21:56 -0000
Date:   Thu, 4 May 2023 15:21:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: perf: riscv,pmu: fix property
 dependencies
Message-ID: <20230504202156.GA260181-robh@kernel.org>
References: <20230404-tractor-confusing-8852e552539a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-tractor-confusing-8852e552539a@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 07:03:22PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Seemingly I mis-implemented the dependencies here. The OpenSBI docs only
> point out that the "riscv,event-to-mhpmcounters property is mandatory if
> riscv,event-to-mhpmevent is present". It never claims that
> riscv,event-to-mhpmcounters requires riscv,event-to-mhpmevent.
> 
> Drop the dependency of riscv,event-to-mhpmcounters on
> riscv,event-to-mhpmevent.
> 
> Fixes: 7e38085d9c59 ("dt-bindings: riscv: add SBI PMU event mappings")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Atish, I'm not 100% on this one but I noticed it while doing dt-validate
> on a dump of the qemu virt machine which doesn't use the
> event-to-mhpmevent property.

Waiting for comments before I apply this...

> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Atish Patra <atishp@rivosinc.com>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> index a55a4d047d3f..c8448de2f2a0 100644
> --- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> @@ -91,7 +91,6 @@ properties:
>  
>  dependencies:
>    "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
> -  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
>  
>  required:
>    - compatible
> -- 
> 2.39.2
> 
