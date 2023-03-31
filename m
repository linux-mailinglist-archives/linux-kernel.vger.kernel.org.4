Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCA6D27F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjCaShD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjCaShA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:37:00 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77286236A3;
        Fri, 31 Mar 2023 11:36:58 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17683b570b8so24084644fac.13;
        Fri, 31 Mar 2023 11:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bjD1EcJNKzAi8wncOI0Nv9d4Dm2eSpivDuCUZ0uj+Q=;
        b=YSXAVDJxZlnP5rNK4AcZzldroEqDbpdAA0yuUytbn4ubDAyR2lWl7ovQDRiSXXspf/
         KEILaGN1MEqyDeDoOzdpI0wLjGPKwophEEkIPnz5hHQUxJSiugKAh9KsMukmc2yXwtc/
         6twOGxO6yJn2myXjPw4CtFQ7rlKX/xNyBMnwGUglNT29pGx14wY4kvm5og3Hbt0/sNSs
         BJFKAYS7pIQNnShCy2p9ayinx3Q2svq+UB3c6GWOxUD1GXEG9KKG7gzRl2LoLdLNQS+A
         PGtFHoKwk3PgenEPeZT4eQ0PJqWWisCnESQjiaJCHefa/6B85syhN5REp8HbM6HWuYhN
         48wQ==
X-Gm-Message-State: AAQBX9eFTegTJMPBW7AI2Va9LH7lT+bb32CKvzKXey4DIEO/PxLC6Svm
        0p62TcBRU02yxgYFelutTg==
X-Google-Smtp-Source: AKy350Y886xOZ+2ooL5E3zJvqqPPH1/c5nOufsJ+DfqnVrTuBrB0nKcCnpq/FFcxJ0fp42lzvWwBTg==
X-Received: by 2002:a05:6870:d191:b0:177:a92e:ee6 with SMTP id a17-20020a056870d19100b00177a92e0ee6mr17583742oac.54.1680287817716;
        Fri, 31 Mar 2023 11:36:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k24-20020a056830169800b0069f95707335sm1369913otr.69.2023.03.31.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:36:57 -0700 (PDT)
Received: (nullmailer pid 1920516 invoked by uid 1000);
        Fri, 31 Mar 2023 18:36:56 -0000
Date:   Fri, 31 Mar 2023 13:36:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
Message-ID: <168028781598.1920458.10411321215956149029.robh@kernel.org>
References: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Mar 2023 18:51:12 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-ostm" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,ostm" will be used as a fallback on RZ/Five SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

