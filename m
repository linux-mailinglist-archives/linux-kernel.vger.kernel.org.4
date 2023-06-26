Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D673E36B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFZPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFZPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:34:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77EE73
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:34:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so8575871fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687793645; x=1690385645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOcE0YUWkUmrq+/gOrSOJce+pS6FVzX4REjlVMYSaG4=;
        b=M130AEjsr8m4ZygKaFa7Kq8JtikEYaSZoJ6OyZg0p4wCF7Kiww9ZtERLNS4uL6SSiE
         TtEgtEOQpwvMW0Z+UbMPP0Uf3GbBy7BLasS9qGJ0m+kQlPWsg7b7A7XzNJxg1vvCGdw2
         Z3InxowJ53ImdnxUDsrHzj6D4JXPUEuux9i6pgAP0QR+7I7JWmTXJqPoJV+HamwX+o4W
         EGRRmx/DjDR7UQohfJWxybydg7UPxWsj/PzQMJUTT0jW1lTXGntWXwex6LkYxPBx6k5E
         /tF0Ni7eZ/i6Mf/INswt/oyvWs4lcI+zPyxmgucsmFBeUsQE7M8vNEqhNZt28i5I3uKr
         hCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793645; x=1690385645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOcE0YUWkUmrq+/gOrSOJce+pS6FVzX4REjlVMYSaG4=;
        b=X33cOv8k1yca6X/fmPS5fRWro0dV8z3jtCVzxUv7eMikd4+kdOQOkP6SK4+blbu7Ke
         LrlV3j7sFe5N8YwIvsff6k4E/0sXMpL7D5orrEJxNRkapq5TKdUpnHtq1HZBKgAXtNVP
         AMIsEoTN0rfoAZNailzM1bBxbNpRKukDlnFMFkYaSyaV9j5Ugz/Pdo1P/8q/11FV8XW7
         W2/SKDPSPnqAaLsKduok+Elh0FlzNpxug+28RlwasjZLaWYIBX4GHMhSTB2WVMu91bOL
         wqIuJHxxfMnFkLK8MgW/QCmCGUDw5yEF9JPhQu+lD/qImo8W58bm2OeGe7Kloo3L1iMo
         +XRA==
X-Gm-Message-State: AC+VfDx2E9K96a7LKfy/S26XwvZ8Hp0VhWGwekwmKt9CCkWAr/h+PUyZ
        GEc4BUtnfrOuGEJfnH4I8rbNBw==
X-Google-Smtp-Source: ACHHUZ5e9WFlfbtA2OGlPIGauJXFT0rXT3O/YtYVBHy4uTdeZSa4mLoM4vGGOAZsSHpw1/K1jlUbNA==
X-Received: by 2002:a2e:3202:0:b0:2b5:9d78:213e with SMTP id y2-20020a2e3202000000b002b59d78213emr5596880ljy.22.1687793645097;
        Mon, 26 Jun 2023 08:34:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id hk8-20020a170906c9c800b00987316d1585sm3421374ejb.145.2023.06.26.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:34:04 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:34:03 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/9] RISC-V: add missing single letter extension
 definitions
Message-ID: <20230626-2943390be412d044fff507e0@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-possible-poet-ae4afce0a525@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-possible-poet-ae4afce0a525@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:19:43PM +0100, Conor Dooley wrote:
> To facilitate adding single letter extensions to riscv_isa_ext, add
> definitions for the extensions present in base_riscv_exts that do not
> already have them.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 36f46dfd2b87..a35bee219dd7 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -14,12 +14,17 @@
>  #include <uapi/asm/hwcap.h>
>  
>  #define RISCV_ISA_EXT_a		('a' - 'a')
> +#define RISCV_ISA_EXT_b		('b' - 'a')
>  #define RISCV_ISA_EXT_c		('c' - 'a')
>  #define RISCV_ISA_EXT_d		('d' - 'a')
>  #define RISCV_ISA_EXT_f		('f' - 'a')
>  #define RISCV_ISA_EXT_h		('h' - 'a')
>  #define RISCV_ISA_EXT_i		('i' - 'a')
> +#define RISCV_ISA_EXT_j		('j' - 'a')
> +#define RISCV_ISA_EXT_k		('k' - 'a')
>  #define RISCV_ISA_EXT_m		('m' - 'a')
> +#define RISCV_ISA_EXT_p		('p' - 'a')
> +#define RISCV_ISA_EXT_q		('q' - 'a')
>  #define RISCV_ISA_EXT_s		('s' - 'a')
>  #define RISCV_ISA_EXT_u		('u' - 'a')
>  #define RISCV_ISA_EXT_v		('v' - 'a')
> -- 
> 2.40.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
