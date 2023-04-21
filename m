Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831A6EB14F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjDUSAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:00:34 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B291BF8;
        Fri, 21 Apr 2023 11:00:27 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1879fc89e67so1475933fac.0;
        Fri, 21 Apr 2023 11:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100027; x=1684692027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD45LRJYwcwGuhNgZXOZfLUe3Rp7o6tEE2EZGvtQuzY=;
        b=kS4lqwjBftAU4U0BzTvWHS9UFiQqzXvZl26ZiLlD469REj3HRoYX7gyWk7sFlbmdnZ
         dPU7H96S5HAHJp9fEpMcffY5jEh0MD+3wBfWNTqqAOKYfFaA9E2pwYFJMndg+/Lf0kE2
         9YYpR4n52Jjq5gpuAP9/N/9imT+zdNtJWXjQyHKgNyB3ffM18Rvqu0XUsgIGwJx3ZaBP
         JShOd0JZBDZuInYURsfTuq+V+G/+LbPYW9kB9EhckV0PtQR94kwYO8paP+aYlRXHz74J
         azFwL1a6u+68kvlcmw9hD2+N6PPJt7csTLv9Kxt2SWl/ZqQGQML/prPNsOPJBg545ptR
         BG9A==
X-Gm-Message-State: AAQBX9eAO4FRmftCdzso1tAUBTjHHvU2/AymEic+0Zln2FEHGpsZMPpY
        xvHTJCv9512tTLLgNIBQtw==
X-Google-Smtp-Source: AKy350b2fQzu9H8xXTbqN6A1n9NlXJPvwjLvHLyVvV33r549va/iRuLiPVlgV1jQrex1VTdY1CSdRg==
X-Received: by 2002:a05:6870:8186:b0:17a:b378:8e1d with SMTP id k6-20020a056870818600b0017ab3788e1dmr4628318oae.0.1682100026777;
        Fri, 21 Apr 2023 11:00:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n124-20020a4a4082000000b00541854ce607sm1956261ooa.28.2023.04.21.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:00:26 -0700 (PDT)
Received: (nullmailer pid 1549286 invoked by uid 1000);
        Fri, 21 Apr 2023 18:00:25 -0000
Date:   Fri, 21 Apr 2023 13:00:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     sboyd@kernel.org, arinc.unal@arinc9.com, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-clk@vger.kernel.org, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 1/9] dt-bindings: clock: add mtmips SoCs system
 controller
Message-ID: <168210002512.1549232.11622395955569841871.robh@kernel.org>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
 <20230418090312.2818879-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418090312.2818879-2-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Apr 2023 11:03:04 +0200, Sergio Paracuellos wrote:
> Adds device tree binding documentation for system controller node present
> in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
> for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

