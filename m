Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A55FD41A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJMFKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJMFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:10:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B66F547
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:10:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sc25so1430044ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0+8Gcuqu1UfIIg3dEddVHWK5ITU4lYfUd1AQFuGSck=;
        b=PNlEEsHdwYVg58gMTF3ZhmKzEdrbX4fl9/AhTWGZQ3wfRNAwC7Wsw7fkNz2phgytzu
         e+315XZJOSxy2j3+clw13RR71xCsdYqaXQghL/M/eGefdJTVAvWHgIYsLLkUBKmLnG4R
         EKtKs/N7FV0Kw5xV7wtHTA+fEqglQQ7SdaoLrHlwXNwiaBAyhpbsDcKV/6kC+WflfL2u
         LcL+5sJd7N8pk1geCXWKK+I8b+dCkTiBhnTkrFeMc04YW+ApYOEV8S2WRG0TVsZRpQQT
         SZ9ZIx+9iH/bvqhjWboqe6QuAUPv32X0LhCUhZ7xDCJYjdactM0WUmKr/GsSkblFwsja
         9BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0+8Gcuqu1UfIIg3dEddVHWK5ITU4lYfUd1AQFuGSck=;
        b=TaB0Qf89Cvih2Zfjfh08LPoNoEADOJO2ShnG+c2PiDRKJOc4YrXd8c9gHzjcfWqzAX
         ZzwYe2gtNTlk9xKaSX4MXxY2csyeUQRwUdPnOonoTWjVPLrSltF0jZvHsQIwF1nvhAQX
         FwLWuOtJwTkERYa8Ud/OsRgKYVzfFyqIqCJ+hXJS+cTINXYHaBjyDbgClHUm8DSSJSP6
         wHUy2/mJVeX+1SeyfLhMdPuPF/cJ4CW18Ta6vOj3+j9Brmc9JWl8q0OnMQSurYLKxIjQ
         pQ9+Fv7dtLfgqeqVX3p5lr1Ox0GJaAnPQ8aL7u8vfoHjkXPbzFqghoFbVpdM1A/rPevE
         4Zfw==
X-Gm-Message-State: ACrzQf3PZ0NaMrQ91Eg1UkHR4SDYfrKy36zo7wGyeBKYgPiEFi9SMhxX
        ogxyVIhCIqjYqGAbViMo6jxG80FLlWIbYxWhSdkuVQ==
X-Google-Smtp-Source: AMsMyM40g7/fYyTpIkB5M0+vGUbqGmA/ZLanWaIjN6oMD37YP60Aj424A3hZfIdLXXMlNOEEi5oEBv93L2VaR5eF/io=
X-Received: by 2002:a17:907:96a6:b0:78d:b6f6:3886 with SMTP id
 hd38-20020a17090796a600b0078db6f63886mr15039218ejc.106.1665637829662; Wed, 12
 Oct 2022 22:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221013045619.18906-1-palmer@rivosinc.com> <20221013045619.18906-4-palmer@rivosinc.com>
In-Reply-To: <20221013045619.18906-4-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Oct 2022 10:40:17 +0530
Message-ID: <CAAhSdy3UdPr9EVdKakN3hkBG-eoeDa6uuO1=X3OfKGgdttQUAw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation: RISC-V: Mention the UEFI Standards
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:26 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The current patch acceptance policy requires that specifications are
> approved by the RISC-V foundation, but we rely on external
> specifications as well.  This explicitly calls out the UEFI
> specifications that we're starting to depend on.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me from a KVM RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  Documentation/riscv/patch-acceptance.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
> index 0a6199233ede..9fed6b318b49 100644
> --- a/Documentation/riscv/patch-acceptance.rst
> +++ b/Documentation/riscv/patch-acceptance.rst
> @@ -20,9 +20,11 @@ Submit Checklist Addendum
>  -------------------------
>  We'll only accept patches for new modules or extensions if the
>  specifications for those modules or extensions are listed as being
> -"Frozen" or "Ratified" by the RISC-V Foundation.  (Developers may, of
> -course, maintain their own Linux kernel trees that contain code for
> -any draft extensions that they wish.)
> +unlikely to be incompatibly changed in the future.  For
> +specifications from the RISC-V foundation this means "Frozen" or
> +"Ratified", for the UEFI forum specifications this means a published
> +ECR.  (Developers may, of course, maintain their own Linux kernel trees
> +that contain code for any draft extensions that they wish.)
>
>  Additionally, the RISC-V specification allows implementors to create
>  their own custom extensions.  These custom extensions aren't required
> --
> 2.38.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
