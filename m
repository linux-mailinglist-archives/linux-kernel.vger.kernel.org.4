Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1070A119
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjESU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjESU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:56:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3022E5E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:56:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so383498b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684529771; x=1687121771;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GugnDVq0c7vfl3wxW3DkEvz8ZP8hJrKb81NPd+MbEgo=;
        b=w4XaHbcaoTeHwMKK8tq7/hze9Atyb1f5/XPGa2VJSxjgf1JOybobmSZXftt8JH1faK
         y+U3o7pUzV3LMpt+OI0BaTFQ9swX3VL4Aw4kija5c8VZh2y9uUua0MkAjfqpOTc5OvVW
         UcfUtIv3k49fgxyUekiCsGwXnfKGGSJgXmeR8whqCUKLI1Isz6Fy4NywgnLzGHDENMfD
         8FopzMsSrt4qH2Z8xA9F4YpBe0D/YiKCCfMkz8L5o61ICZdCyum6o+hoIeZbq4UyIN3I
         sncMKcT6+g4f2BOhFzAQMXoZYzLjITJefkC2xQ8gJpmMz3ZXY75+zCss7YyO7JFDBOao
         dgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529771; x=1687121771;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GugnDVq0c7vfl3wxW3DkEvz8ZP8hJrKb81NPd+MbEgo=;
        b=eTv4N0bSxSRAg0WLpqB5dzBBCKt3sq3ikKyLw10gollxBC8tfZhb1gb2iHTHKn+96M
         kaXjs6VforkTHnDkbmP4Vw877eiliwTY0y1yW0OGkfmpW5FsWRHxMn5P42Yd0CLsuuOJ
         gXuPPdFqkrIyCjajP/fANtYoXrHdtQBfm72u0zxIpshbpyRHK+TGUu7xszQYqu4QEheI
         x18yR3dMhgP7iuFE8wcOQ7ahfHIWZsmm4iHDg4yx2MqYY4fTzV7nSxotpj/gqeuRdh2f
         beyjm8oXvTxf9B2VkJ44wMI9x2Bht7SZNLclf0dS30X3YrY0ExmQvR3jkww35xQ5Ny2y
         VNPA==
X-Gm-Message-State: AC+VfDzwY8LVGQE6mSe6viCSW9pW6eUXQlKP8WZNQTOunB//GvtNrMCq
        BM3D9GVK/bDZinPM9MSetc5AUA==
X-Google-Smtp-Source: ACHHUZ584jM3FqhNjul9su9bLGVwXpcyvsMFcD/0XYITdp4xBcWtq25UqUY3OaQPOuC57udHHaNAkA==
X-Received: by 2002:a05:6a00:2188:b0:64d:fd0:dd1a with SMTP id h8-20020a056a00218800b0064d0fd0dd1amr4522909pfi.16.1684529770982;
        Fri, 19 May 2023 13:56:10 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b0063b8f17768dsm103656pfn.129.2023.05.19.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:56:10 -0700 (PDT)
Date:   Fri, 19 May 2023 13:56:10 -0700 (PDT)
X-Google-Original-Date: Fri, 19 May 2023 13:55:47 PDT (-0700)
Subject:     Re: [PATCH v2 9/9] riscv: defconfig: enable T-HEAD SoC
In-Reply-To: <20230518184541.2627-10-jszhang@kernel.org>
CC:     tglx@linutronix.de, Marc Zyngier <maz@kernel.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, frank.li@vivo.com,
        wefu@redhat.com, uwu@icenowy.me
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-e1d500da-688e-49bf-a2d8-bef0e2df48f8@palmer-ri-x1c9a>
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

On Thu, 18 May 2023 11:45:41 PDT (-0700), jszhang@kernel.org wrote:
> Enable T-HEAD SoC config in defconfig to allow the default
> upstream kernel to boot on Sipeed Lichee Pi 4A board.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index d98d6e90b2b8..109e4b5b003c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -27,6 +27,7 @@ CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_ARCH_RENESAS=y
> +CONFIG_ARCH_THEAD=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_ARCH_SUNXI=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
