Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674C642CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiLEQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiLEQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:16:59 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F6273F;
        Mon,  5 Dec 2022 08:16:59 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id q186so13571376oia.9;
        Mon, 05 Dec 2022 08:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq8qop3jPkeA6VnrIjkfepKATgLQISCUs8QA0r6gq7E=;
        b=sLJkB/E68n6s7kjflGHjLMu4C/tPIXCgkT0NY7ZJAHX1WugdLJMHQDVNyQZdTYC1jr
         2dBgxq5JBBiWNaezTt15KwVYRvlMn3M2g4Tw3oF2AAsGf7sP+/byHewO0SI/J+MHlDeh
         oA5bUbEbnVnnKS4VPaejHzPzo0o3Obny1jKUfpTCxUYcylK4V0WyiLzUcCDRpeanIdsd
         iXd54o1y3Tknbr7lCaLQZobSf2cglSYZbZCWa61htQKRe0tTYyaaNh70OOdJ/Y0m08n9
         6vzOVRHnzMKEQMpbeO+jJRWVCd68NkpEkjX/uf2LvSIT97sDg+5m6SS/KNVZbsXGGr8J
         MAWA==
X-Gm-Message-State: ANoB5pnX7lhdm5KLeQ9rqwC3ZFJY/ySSN23bcT/RxN8Jwi0/tbVsXRES
        3eKGvmTgkr6+65h0mpwvrw==
X-Google-Smtp-Source: AA0mqf4uYnMAjuj0jxyIUx3V6HeMwLgXhtP4Zbbv1j1uRbFBkTgANaoMqamQQIiABgzwN2s+FH+o/w==
X-Received: by 2002:a05:6808:114:b0:35b:d0ba:1447 with SMTP id b20-20020a056808011400b0035bd0ba1447mr12049841oie.93.1670257018090;
        Mon, 05 Dec 2022 08:16:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q13-20020a056808200d00b0035b4b6d1bbfsm7309649oiw.28.2022.12.05.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:16:57 -0800 (PST)
Received: (nullmailer pid 1980008 invoked by uid 1000);
        Mon, 05 Dec 2022 16:16:56 -0000
Date:   Mon, 5 Dec 2022 10:16:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
Message-ID: <167025701595.1979605.16523500992587130634.robh@kernel.org>
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
 <20221201123954.1111603-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201123954.1111603-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 18:09:53 +0530, Anup Patel wrote:
> We add DT bindings for a separate RISC-V timer DT node which can
> be used to describe implementation specific behaviour (such as
> timer interrupt not triggered during non-retentive suspend).
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
