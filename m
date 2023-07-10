Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00B774D9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGJPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGJPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:16:32 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DEE8;
        Mon, 10 Jul 2023 08:16:28 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-345f3e28082so16520625ab.1;
        Mon, 10 Jul 2023 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002187; x=1691594187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY0GxBN2xgwjo+bXMXBJ7K5xkLz0l0SkC1bgFRQbePc=;
        b=cN6cMSirBwhoQJd22ALwXCzhQ+lBzgR17BsfaIuv1l60jpsQorM6PGl62ATl+WcUEU
         hNhHuGWYVeRYSpIelEHiiPwKJ12TEVlaSvvpjp7m61xRTyvIGvM61B9ijTIVgoVfIeA8
         fhQKNJDaC45mwhJ0hSnG9kr9qmy7WKOCP78TMmXrvI2BBi9WLtUy7Ojp1d0duXF+fRy3
         YulJGAZg/TrdKaQHxYhb1SGzwQdU5i14egetwl/AWp5Tbt9ZuuWQcJ+6KJ+85rETSdWl
         tY0ImvDYVsZFYhqiPQKJUJ5NrGNKxSXObGFGySPi986VhDRHaIaywxwh/9hCwraS7FaR
         QqjA==
X-Gm-Message-State: ABy/qLaD2EBDl5Xj+6Jo0LUqIZuOyUTzPQVCU+IQGEeF0NjV4hnwVLGk
        PgGhhFNwmx45vVFCns4YYIRURFehRw==
X-Google-Smtp-Source: APBJJlHQ3fBw2fUWi1AJFW/AlBFt3ZRHqEH8HOO/lErk7nSvGOLZYzoYpqWfGTdLNdnO9DrDV6/6ig==
X-Received: by 2002:a92:c142:0:b0:345:775f:1a2f with SMTP id b2-20020a92c142000000b00345775f1a2fmr12648247ilh.14.1689002187559;
        Mon, 10 Jul 2023 08:16:27 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c12-20020a92d3cc000000b003460b697bc0sm3610370ilh.59.2023.07.10.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:16:26 -0700 (PDT)
Received: (nullmailer pid 1992483 invoked by uid 1000);
        Mon, 10 Jul 2023 15:16:24 -0000
Date:   Mon, 10 Jul 2023 09:16:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: riscv: Document the 1.0 scalar
 cryptography extensions
Message-ID: <20230710151624.GA1987602-robh@kernel.org>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-3-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709115549.2666557-3-sameo@rivosinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 01:55:44PM +0200, Samuel Ortiz wrote:
> The RISC-V cryptography extensions define a set of instructions, CSR
> definitions, architectural interfaces and also extension shorthands for
> running scalar and vector based cryptography operations on RISC-V
> systems.
> 
> This documents all the dt-bindings for the scalar cryptography
> extensions, including the Zk, Zkn and Zks shorthands.
> 
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..361756978da1 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -190,6 +190,24 @@ properties:
>              instructions as ratified at commit 6d33919 ("Merge pull request #158
>              from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>  
> +        - const: zbkb
> +          description: |

Don't need '|' if no formatting to preserve.

> +            The standard Zbkb cryptography extension for bit-manipulation
> +            instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zbkc
> +          description: |
> +            The standard Zbkc cryptography extension for carry-less multiply
> +            instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zbkx
> +          description: |
> +            The standard Zbkx cryptography extension for crossbar permutation
> +            instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
>          - const: zicbom
>            description:
>              The standard Zicbom extension for base cache management operations as
> @@ -240,6 +258,70 @@ properties:
>              ratified in the 20191213 version of the unprivileged ISA
>              specification.
>  
> +        - const: zk
> +          description: |
> +            The standard Zk cryptography extension is a shorthand for the
> +            union of the Zkn, Zkr and Zkt cryptography extensions, as ratified
> +            at commit 73de909 ("Zvk: Update AES instruction specs") of
> +            riscv-crypto.
> +
> +        - const: zkn
> +          description: |
> +            The standard Zkn cryptography extension covers the NIST algorithm
> +            suite that other cryptography extensions support. It is the union of
> +            the Zbkb, Zbkc, Zbkx, Zknd, Zkne and Zknh extensions, as ratified at
> +            commit 73de909 ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zknd
> +          description: |
> +            The standard Zknd cryptography extension for AES block cipher
> +            decryption acceleration instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zkne
> +          description: |
> +            The standard Zkne cryptography extension for AES block cipher
> +            encryption acceleration instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zknh
> +          description: |
> +            The standard Zknh cryptography extension for SHA2 hash algorithm
> +            functions acceleration instructions as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zkr
> +          description: |
> +            The standard Zkr cryptography extension for the entropy source CSR
> +            definitions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zks
> +          description: |
> +            The standard Zks cryptography extension covers the ShangMi algorithm
> +            suite that other cryptography extensions support. It is the union of
> +            the Zbkb, Zbkc, Zbkx, Zksed and Zksh extensions, as ratified at
> +            commit 73de909 ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zksed
> +          description: |
> +            The standard Zksed cryptography extension for SM4 block cipher
> +            acceleration instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zksh
> +          description: |
> +            The standard Zksh cryptography extension for SM3 hash algorithm
> +            funstions acceleration instructions, as ratified at commit 73de909
> +            ("Zvk: Update AES instruction specs") of riscv-crypto.
> +
> +        - const: zkt
> +          description: |
> +            The standard Zkt cryptography extension for data independent
> +            execution latency attestation, for a safe subset of instructions,
> +            as ratified at commit 73de909 ("Zvk: Update AES instruction specs")
> +            of riscv-crypto.
> +
>          - const: ztso
>            description:
>              The standard Ztso extension for total store ordering, as ratified
> -- 
> 2.41.0
> 
