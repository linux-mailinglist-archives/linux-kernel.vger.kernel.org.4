Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8373A33C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFVOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFVOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:39:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B39819BE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:39:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso4347966a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687444781; x=1690036781;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOcn681HzuehLEAAjtV7KZ0Sslre2UN3bE33auZZhYU=;
        b=2E6PG3Gybkyvaasw3DfHQMDc2CMEIPgkgnxI53wkqyQdg8t+9ab1uIwfDIn3nax9Gv
         2wKj7W50nZ39jmH/aSaUY8kggtyM225iIbRi6VIdk75mPnhwUzG51cfdk+SdEiTOufaQ
         lPJ419BbwB8/SA1xpyqTU/f44r79ypzXC3cvV526ZXCMSwRgfvMbsbllorOSMNxVnj9J
         OpyKhUAZiO2zimczatkAJgbhYlXHxnxpdck9Xzr12NaiV1R4MlrlxGnvzKiTrH8bG1Cm
         9Fxot5rBTO2dEiaJZkxGGx0K/FRJ3NTL2zZ8UlyGeQW16cV6J3OjHjXhGDCGl06H/lts
         7zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444781; x=1690036781;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOcn681HzuehLEAAjtV7KZ0Sslre2UN3bE33auZZhYU=;
        b=dXqjT/en0fAi/bWSZUnWrmkVqgk+M+E8PB8CORbUkNE0PsOTkz9l/R8v8ZL5Kusn4R
         FteL+EqxOed+ZiF2juRDZT4ttkx2FJXhsiNu3mJzqB+UdTlSUnkXMmu9x0T/khfm/pbV
         Ugg4RP8d49UZsagrjL18lfu0fMcMNJF5R+e1UZGuDGZO6V7/R05iYOMG0pSv5t0OMu7/
         7DBX7UZJSQKVmlZmG6YsIlLeOIlx/oC2IRQJ8KLtPgz2HnxdGMKKYRkXUb9Ej7+FFENQ
         R5VaBFL6qO5ToofRjJF/JQNuJJcKtCIjDq/jiQjDLEveoXuXH5by+6LILzrsewSltayS
         RiNA==
X-Gm-Message-State: AC+VfDzV9dgEDLxpLp0ZQlvI+IUFdzni/QxWd2NCneAmioDw1tF78X+U
        kKL4NbrLjRS3rlRTQUq/sxW7zp5ay3JI8UMNWfM=
X-Google-Smtp-Source: ACHHUZ7VYYurKNaFAN6NfGrwHNG4lDAaqFqfbrmteE85L/f6RjTCOMutLcLibCKThE2wD/2Mo074QA==
X-Received: by 2002:a05:6a21:6da7:b0:11f:2909:fe9c with SMTP id wl39-20020a056a216da700b0011f2909fe9cmr22073948pzb.20.1687444780767;
        Thu, 22 Jun 2023 07:39:40 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s26-20020aa7829a000000b0064fe06fe712sm1891802pfm.129.2023.06.22.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:39:40 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:39:40 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 07:36:50 PDT (-0700)
Subject:     Re: [PATCH v2 3/3] Documentation: riscv: Update boot image header since EFI stub is supported
In-Reply-To: <20230621072234.9900-3-alexghiti@rivosinc.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        sunilvl@ventanamicro.com, songshuaishuai@tinylab.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        Atish Patra <atishp@rivosinc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-8f0968bf-c6ed-42e4-8e4b-d353b6331d1d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 00:22:34 PDT (-0700), alexghiti@rivosinc.com wrote:
> The EFI stub is supported on RISC-V so update the documentation that
> explains how the boot image header was reused to support it.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> ---
>  Documentation/riscv/boot-image-header.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> index a4a45310c4c4..df2ffc173e80 100644
> --- a/Documentation/riscv/boot-image-header.rst
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -28,11 +28,11 @@ header in future.
>  Notes
>  =====
>
> -- This header can also be reused to support EFI stub for RISC-V in future. EFI
> -  specification needs PE/COFF image header in the beginning of the kernel image
> -  in order to load it as an EFI application. In order to support EFI stub,
> -  code0 should be replaced with "MZ" magic string and res3(at offset 0x3c) should
> -  point to the rest of the PE/COFF header.
> +- This header is also reused to support EFI stub for RISC-V. EFI specification
> +  needs PE/COFF image header in the beginning of the kernel image in order to
> +  load it as an EFI application. In order to support EFI stub, code0 is replaced
> +  with "MZ" magic string and res3(at offset 0x3c) points to the rest of the
> +  PE/COFF header.
>
>  - version field indicate header version number

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

In case someone wants to pick this up along with the others.
