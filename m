Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADA64A5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiLLR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiLLR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:28:28 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAAEE0F7;
        Mon, 12 Dec 2022 09:28:24 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso9252955fac.4;
        Mon, 12 Dec 2022 09:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIZU7lLd7LTeyCvnIo5M5LnCfVrp3nfTga9aSk80knY=;
        b=JCjtA+2HsvS0eGmIE1pw/t7OCCsOpxQLWQA5vm9fqATEhHmOb0vWFgr7evib+hxaAn
         wwZ3Kcx1YNlPNzA6IPDts9KiRTSI4Oqj98B1khIss66lKfGl8NCowY4/WIlCYW9q6MBE
         f605PwKLCnOFFZ7JaLNI2sJilF8H6hMj35BZ9ZUJpDhN91EKD355wD8zLfjROZFo20d2
         HASsk5SpxWtZHfXnzOpCl5l6qxILi7bEiBIKs8Mw1H6Bomj8g03aVxYNptBtZ57KcS7i
         VFyQWN5Lr9+I8VSPsXZCT6YXqp6equjkxBAhNaVliwDjMf1pj89iASTILQxbGdg8D8rZ
         6XOw==
X-Gm-Message-State: ANoB5pn/oL55cmo01n9zDopd5JaA8YSZ489FU0H8VDmMuIwXCKf4enlQ
        HdqA+T54Ifh+XSTe9qmrJg==
X-Google-Smtp-Source: AA0mqf5osDHOzY5qrYDmnlHr4QDPnXNRcjhNYUoh8aFQJ3z+OABKLxdD1DQ1N/bzxBYuK3TqgsdPug==
X-Received: by 2002:a05:6870:a79d:b0:13d:9fdd:dc0f with SMTP id x29-20020a056870a79d00b0013d9fdddc0fmr9495469oao.7.1670866104139;
        Mon, 12 Dec 2022 09:28:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870e8c700b0014435b51ef7sm163994oan.30.2022.12.12.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:28:23 -0800 (PST)
Received: (nullmailer pid 1167733 invoked by uid 1000);
        Mon, 12 Dec 2022 17:28:22 -0000
Date:   Mon, 12 Dec 2022 11:28:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Message-ID: <167086610192.1167675.3784027898209853936.robh@kernel.org>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212115505.36770-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 11:55:04 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> 
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> describes the L2 cache block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Dropped L2 cache configuration properties
> * Dropped PMA configuration properties
> * Ordered the required list to match the properties list
> 
> RFC v3 -> v4
> * Dropped l2 cache configuration parameters
> * s/larger/large
> * Added minItems/maxItems for andestech,pma-regions
> ---
>  .../cache/andestech,ax45mp-cache.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
