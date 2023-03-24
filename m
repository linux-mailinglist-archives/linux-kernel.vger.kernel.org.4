Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35AC6C7D37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCXLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCXLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:31:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0411C7CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:31:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o32so963061wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679657468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3f6o0AI12RH51u4tiMa8ok8ddso/WpX9mlrkI0ZUu0w=;
        b=P7MGoAM/2B0An/hP4AHitapxcPDSq7vRUPNE7aa6gf7AlO5KgYVw+iE5cDl0nuxNSo
         bIuB51BQrVxtU2a4mNCgfg83mSVWjTaQ77YrAXbp0XAxUVYmw13/gTqJHrXjeLULyhMr
         VwkkvDVEuOIwU8zDdX3oArtR1Y2DbHZgol4F7jxOWDpZ7OPqVO1qoJendXyLuRuZWo7B
         c/tmZmE9sTFrpqbKUaHIFHI/mLLV9MrDxdKglqmSJ/rOXAzucYQ1hNN/PqsGiweulo9T
         DZcTdkjbBdLZHmRePmljMUiN9NBi3KjAKSx9YJr2TuQqFKCqhTK/ZZV30YBYJJDEj7DU
         /QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679657468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f6o0AI12RH51u4tiMa8ok8ddso/WpX9mlrkI0ZUu0w=;
        b=IESD/Xo90k3vk02ZcGUTRV+OXXHHxZYI6TrWAEqzMtMIjXADCaRVPm0yeX+1PMVtsM
         8Y0oQwAtpSOnUjZj3WXKpWTNv/ZDWuvp9C52oSILd3BIbKbLCTX6GT/JwU7l7wbwhwXk
         Lmm9c5Fp/H12iKT8BbJofuDAIl8wQ/zutAWyrE32UaOeXDZmpv8/7c5Yi66dspL6W6eF
         jdPNHHNo/vu+7HCZR8M7d0bg/tzBqKFjXQP2iAe5sMNaOaw7OwqJ92shGz43DtDh16uX
         sIPxZNAkcm4c7PWAr3H5J7Vi6XlD+E+q3TVGKDXPMa7VLi47aBY9n9C1KR9pm6M6muxX
         biXA==
X-Gm-Message-State: AO0yUKXrx5cPTs8/W74RWrx3erORNtC6cofnbfjc06FNf1XrVMEaDwNn
        Ui6FojPRjBqdSYS//s5qUGPWkw==
X-Google-Smtp-Source: AK7set90HHQGOSmYwIhfXbBeLYZ6w7qAmsMo8qC4WtVE1IN71eLboJgV4HF2Ym6aKBH6h674mWcsdg==
X-Received: by 2002:a7b:cb90:0:b0:3dc:4b87:a570 with SMTP id m16-20020a7bcb90000000b003dc4b87a570mr2381902wmi.35.1679657468483;
        Fri, 24 Mar 2023 04:31:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bc8d8000000b003eb596cbc54sm4724396wml.0.2023.03.24.04.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 04:31:08 -0700 (PDT)
Date:   Fri, 24 Mar 2023 12:31:07 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for
 riscv_has_extension[un]likely()'s alternative dependency
Message-ID: <20230324113107.djp4ejnlpzn3qzrb@orel>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:05:37AM +0000, Conor Dooley wrote:
> Here's my attempt at fixing both the use of an FPU on XIP kernels and
> the issue that Jason ran into where CONFIG_FPU, which needs the
> alternatives frame work for has_fpu() checks, could be enabled without
> the alternatives actually being present.
> 
> For the former, a "slow" fallback that does not use alternatives is
> added to riscv_has_extension_[un]likely() that can be used with XIP.
> Obviously, we want to make use of Jisheng's alternatives based approach
> where possible, so any users of riscv_has_extension_[un]likely() will
> want to make sure that they select RISCV_ALTERNATIVE.
> If they don't however, they'll hit the fallback path which (should,
> sparing a silly mistake from me!) behave in the same way, thus
> succeeding silently. Sounds like a
> 
> To prevent "depends on !XIP_KERNEL; select RISCV_ALTERNATIVE" spreading
> like the plague through the various places that want to check for the
> presence of extensions, and sidestep the potential silent "success"
> mentioned above, all users RISCV_ALTERNATIVE are converted from selects
> to dependencies, with the option being selected for all !XIP_KERNEL
> builds.
> 
> I know that the VDSO was a key place that Jisheng wanted to use the new
> helper rather than static branches, and I think the fallback path
> should not cause issues there.
> 
> See the thread at [1] for the prior discussion.
> 
> Cheers,
> Conor.
> 
> 1 - https://lore.kernel.org/linux-riscv/20230128172856.3814-1-jszhang@kernel.org/T/#m21390d570997145d31dd8bb95002fd61f99c6573
> 
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Heiko Stuebner <heiko.stuebner@vrull.eu>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Anup Patel <apatel@ventanamicro.com>
> CC: Jisheng Zhang <jszhang@kernel.org>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Jason A. Donenfeld <Jason@zx2c4.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> 
> Conor Dooley (2):
>   RISC-V: add non-alternative fallback for
>     riscv_has_extension_[un]likely()
>   RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
> 
>  arch/riscv/Kconfig             | 12 ++++----
>  arch/riscv/Kconfig.erratas     |  6 ++--
>  arch/riscv/include/asm/hwcap.h | 50 ++++++++++++++++++++--------------
>  3 files changed, 38 insertions(+), 30 deletions(-)
> 
> -- 
> 2.39.2
>

LGTM, but if it was based on for-next then it could also immediately be
applied to zicboz. For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
