Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD516DDBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDKNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjDKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:19:39 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A5A6;
        Tue, 11 Apr 2023 06:19:39 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id bv13-20020a0568201b0d00b0053e3ccf739cso620486oob.10;
        Tue, 11 Apr 2023 06:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219178; x=1683811178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+jN3iQ4qMCG/ywdugeaRUxhNRMzD4nw9Q/UyMWp10o=;
        b=AFNwABqh6uuhiQ2/ZukLf/re/kjWuZsxHBOJavlJ/yi3t2zm0vZYR22PGTcvFMgHTK
         hLpFeM1bgbqqMPdpuI6KsSsSTmw1uDQcIPWfwbjMCwBnHQa4uNixEKICyrFPsd5ogcq8
         QzOiIQEX9C+62grlD+IJKE1t5cTuoz2egcl9lmM0Z94aAfQx8gTALy0eZSbiPdw/8mAn
         O+ZOrvEt3/B0gqQM6EMtU8JRvI77icfkNpuBxa/zzxo+SsdD0Ss8Q9Kl2OhcHpdD8rwT
         f+uyn7DKPA0N9EsqD6HEOlyUklLGaYksHFxmyxD+B1XEPQESpqE/uLCNqONl/uyW/hkn
         7tkg==
X-Gm-Message-State: AAQBX9cKaodK9BoQQ0vq9Vqw+Kd1zKR6M3ykBAwunsilGx3rb9I7bGj+
        hvXXuy8cnuJ2KfmhNTrYL1nFvc6EpA==
X-Google-Smtp-Source: AKy350aRquGawM9m0tUy6X2T787LM0VeIiRSGkcYDM4RyURvi7iRkhm8luybACSkJuiwd/+cshOuvA==
X-Received: by 2002:a4a:41c8:0:b0:541:f301:674 with SMTP id x191-20020a4a41c8000000b00541f3010674mr42176ooa.4.1681219178180;
        Tue, 11 Apr 2023 06:19:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a4a96ca000000b0053479edbc17sm5700330ooi.33.2023.04.11.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:19:37 -0700 (PDT)
Received: (nullmailer pid 2917455 invoked by uid 1000);
        Tue, 11 Apr 2023 13:19:36 -0000
Date:   Tue, 11 Apr 2023 08:19:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] dt-bindings: irqchip: ti,sci-inta: Add optional
 power-domains property
Message-ID: <168121917314.2917348.12208143525633287251.robh@kernel.org>
References: <20230407045111.531107-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407045111.531107-1-vigneshr@ti.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 10:21:11 +0530, Vignesh Raghavendra wrote:
> On certain SoCs, Interrupt Aggregator may have a power-domain dependency
> to be on before accessing. Add DT binding for the same
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> RESEND:
> Rebase onto 6.3-rc5
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20230103042724.1100618-1-vigneshr@ti.com/
> 
>  .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!

