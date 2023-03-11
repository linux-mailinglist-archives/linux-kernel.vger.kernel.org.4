Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64966B5CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCKORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCKORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:17:09 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30331F6930;
        Sat, 11 Mar 2023 06:17:07 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id t5-20020a4ac885000000b005251f70a740so1215051ooq.8;
        Sat, 11 Mar 2023 06:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WayWIOIzl168cFhbQy0mqxc8fj9xrbSB83RnDiz8R3k=;
        b=FRE0qmpp7X+oKIlLW/puCl+smWwNkG2s+tNNTjVk+TLGRg1j2AjjUeOEtwlCDRGCR+
         JtKGZiDzS4fRehDZ7PTG6TM19PTmCRd6UBw8UDxZeDe3+toMlDZigGBrWAEk36OYKixu
         6w87nWnwQub8C3GkydvGR7iL2pbk+I/4kugEtvbnyGQYs+HTM9cRYrxyCg68A6K4hoIh
         LqZj982CCn2N4zSHwtY0AXWN6mfgtNAmP2wCxMQut9RKJHn2ngzl2W5a3NMhWqZAw+XC
         opmiKmpY8PP5aO9GvDNUE3CzDUkTVs6p8TcOZ4guMsd3xpGYRQqKgw+FHN6+8sBkeHqL
         s0hg==
X-Gm-Message-State: AO0yUKXIyWMduxepm3oCIh0GoK80lR+T+j1AKnBoDKzkMxFUpZipgox9
        YfYDg2A/LFkidPGssImQOJSd2wZ9QQ==
X-Google-Smtp-Source: AK7set8LV5pVOhq7euQWBiixs6oYxgiJUM68yu7tkDFISj8ddHnNo6RWeJD/0CThLBLiaIEVnWXbDw==
X-Received: by 2002:a4a:d637:0:b0:525:4058:2fcd with SMTP id n23-20020a4ad637000000b0052540582fcdmr3201545oon.1.1678544226475;
        Sat, 11 Mar 2023 06:17:06 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f1:6fdb:8060:4df8:4037:6d6f])
        by smtp.gmail.com with ESMTPSA id a7-20020a4ab787000000b0051ffe0fe11bsm1090992oop.6.2023.03.11.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:17:05 -0800 (PST)
Received: (nullmailer pid 140902 invoked by uid 1000);
        Sat, 11 Mar 2023 14:17:00 -0000
Date:   Sat, 11 Mar 2023 08:17:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <167854282659.42837.5915012938593380363.robh@kernel.org>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-12-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-12-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Mar 2023 17:07:23 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
>  MAINTAINERS                                   |   8 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>  4 files changed, 454 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring <robh@kernel.org>



