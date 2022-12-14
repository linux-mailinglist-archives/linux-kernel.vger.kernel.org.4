Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6E64CDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiLNQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiLNQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:22:48 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A6116E;
        Wed, 14 Dec 2022 08:22:48 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-144bd860fdbso17293540fac.0;
        Wed, 14 Dec 2022 08:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HJcoPvMh51cpJw2lnN3HB94+Ii/jqthzmJxA42LWPE=;
        b=cmwaamlBeMTGmIh2hv5ZkFPauIktSFcYP3Qib3WvcpxKFKwnFwLv3wyq175VRNZv5X
         YzAxqvL1Z3tZZfX1Nt/EFDR8e+AWXfXvgoZIHpxUp5yVKaOCbkSra75U46EW+n4ET/Pa
         YfeYv5tEMAw1dSrn9Z1mtaDujTEqCYoAC0rApIilRlQCgc8vjoOW/RhauhOtafvS9QyI
         +cFk/AU9oVaico39MBxGw+/ONpMpTtN50VGu2EWDbxY0/Q/HfXcNqaQAt/Xpb4SwpDlb
         Ts8/VbnP5QZLpAGGGjNzYHQIhJo62k3rJADnsz5bMSH9tI1K2tJLOPTuZiOQxRQp3i9T
         RnkQ==
X-Gm-Message-State: ANoB5pl9qU86C4SjgUJ2bK92BcblozgmwCPzKctYdSwow1FaKhj/7vJa
        nHE3lzsHI1zqHEXCoKO0tDR/oQudLQ==
X-Google-Smtp-Source: AA0mqf7Ugs8Vu1CTCsoLEJlhyuSDVzH8+fhWkzhPMeC+JpI5dlsoFN69hi8YxwA48BX5fapl1jYqLQ==
X-Received: by 2002:a05:6870:fd92:b0:144:fc5a:cd67 with SMTP id ma18-20020a056870fd9200b00144fc5acd67mr12798338oab.49.1671034967522;
        Wed, 14 Dec 2022 08:22:47 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id l11-20020a056870204b00b00143ae7d4ccesm2843078oad.45.2022.12.14.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:22:46 -0800 (PST)
Received: (nullmailer pid 1172470 invoked by uid 1000);
        Wed, 14 Dec 2022 16:22:45 -0000
Date:   Wed, 14 Dec 2022 10:22:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-clk@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 2/4] dt-bindings: mmc: renesas,sdhi: Document RZ/V2M
 support
Message-ID: <167103496519.1172409.5839047840007773423.robh@kernel.org>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
 <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 23:01:27 +0000, Fabrizio Castro wrote:
> Document support for the SD Card/MMC interface on the Renesas
> RZ/V2M (a.k.a. r9a09g011) SoC.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
