Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83FD6D53D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjDCVp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjDCVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:45:57 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655AF49DD;
        Mon,  3 Apr 2023 14:45:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17997ccf711so32421427fac.0;
        Mon, 03 Apr 2023 14:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjyuESymcsR2VMINdm5Bfho26ybLnXPxoDubHNZ3lbA=;
        b=fWYoNaHuQqYuxXc4ACWEKBJycECBB/VQGiBer0s2l2QZGGr4191sPXzyBrHG7X4EVU
         ZRd5NjU5STjc8xj52TxN69No35q8T8di+N+nBkdjjmTee0p4Nrj8Vg9JG2tpqClpCLab
         Cipypn9koN71B5FFlwm5nZieYULyloTeHkvrAz7klSoAPniibaWtBKHr2Z8nL+KnpAdR
         1fU5R6E3p7Th2JgfQnLdcDzMdDxd/YwTozhQ1pkuc00qoV4oa35YEvpkc48goxTy0cfr
         TD8vWVqi/CO7jONRPrY14TLNd5yJ+d6o/2XbpmCiw10/WucJ9mh3NBTTyjkgyUUCM4lM
         CgRw==
X-Gm-Message-State: AAQBX9f3G1KMjPhpTT/mAlfy0jIqKA6njLIaxKohSqdAcA1bIlzA5w8Q
        b/BaDVKjgXRaIfydBKMUJA==
X-Google-Smtp-Source: AKy350aFlhW6NPkDPCD/nqbhHu6uFB2MQkICizhIFFbEPL5jfztjWv/9j8uFDgl83EMtCrKL01hYiQ==
X-Received: by 2002:a05:6870:b38a:b0:177:c013:9dac with SMTP id w10-20020a056870b38a00b00177c0139dacmr366185oap.48.1680558024171;
        Mon, 03 Apr 2023 14:40:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b006a3170fe3efsm2942956oti.27.2023.04.03.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:40:23 -0700 (PDT)
Received: (nullmailer pid 1920507 invoked by uid 1000);
        Mon, 03 Apr 2023 21:40:22 -0000
Date:   Mon, 3 Apr 2023 16:40:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Scott Wood <oss@buserror.net>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1] dt-bindings: move cache controller bindings to a
 cache directory
Message-ID: <168055794093.1918674.10704326537545829066.robh@kernel.org>
References: <20230330173255.109731-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330173255.109731-1-conor@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 18:32:56 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> There's a bunch of bindings for (mostly l2) cache controllers
> scattered to the four winds, move them to a common directory.
> I renamed the freescale l2cache.txt file, as while that might make sense
> when the parent dir is fsl, it's confusing after the move.
> The two Marvell bindings have had a "marvell," prefix added to match
> their compatibles.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../{memory-controllers => cache}/baikal,bt1-l2-ctl.yaml        | 2 +-
>  .../{powerpc/fsl/l2cache.txt => cache/freescale-l2cache.txt}    | 0
>  Documentation/devicetree/bindings/{arm => cache}/l2c2x0.yaml    | 2 +-
>  .../{arm/mrvl/feroceon.txt => cache/marvell,feroceon-cache.txt} | 0
>  .../{arm/mrvl/tauros2.txt => cache/marvell,tauros2-cache.txt}   | 0
>  .../devicetree/bindings/{arm/msm => cache}/qcom,llcc.yaml       | 2 +-
>  .../devicetree/bindings/{riscv => cache}/sifive,ccache0.yaml    | 2 +-
>  .../socionext => cache}/socionext,uniphier-system-cache.yaml    | 2 +-
>  MAINTAINERS                                                     | 2 ++
>  9 files changed, 7 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/{memory-controllers => cache}/baikal,bt1-l2-ctl.yaml (95%)
>  rename Documentation/devicetree/bindings/{powerpc/fsl/l2cache.txt => cache/freescale-l2cache.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm => cache}/l2c2x0.yaml (99%)
>  rename Documentation/devicetree/bindings/{arm/mrvl/feroceon.txt => cache/marvell,feroceon-cache.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/mrvl/tauros2.txt => cache/marvell,tauros2-cache.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/msm => cache}/qcom,llcc.yaml (96%)
>  rename Documentation/devicetree/bindings/{riscv => cache}/sifive,ccache0.yaml (98%)
>  rename Documentation/devicetree/bindings/{arm/socionext => cache}/socionext,uniphier-system-cache.yaml (96%)
> 

Applied, thanks!

