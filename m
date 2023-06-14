Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E0730889
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjFNTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjFNTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:40:25 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB882707;
        Wed, 14 Jun 2023 12:39:55 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-777ac169033so1354939f.0;
        Wed, 14 Jun 2023 12:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771527; x=1689363527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZUt8cSegNUdA7Zx2DedDrTZnUq0g2bN1h7iBXuNxXg=;
        b=iswqczBvvnqEk3K1hxrzNzKLGoLM1q1QHnhqbej9AQna98FSIWroxzsCAfr7hPZF9i
         MAMbc+PKzh5QQdDm2E2hrsYpnkMq10fEebOk8dMnKnKrS5VUNzgt9CWUggFMtYx3aWex
         GVk940WJO6En3INCrDEe2yef0mT8KrXjdFhRsccjpYiGZrQawOQuEjatHzQIVSjF4kD7
         gOCAoMPmRTcVFuqnZkT3Ez6j7lOIlYXva33Euo57GBjzCgJghcaAW/ccY4vkv2HVeRFK
         Uqo2N7nXvQnvZlV/v0Ec7GtAty8zsT8+6S9Teiz3mHLorsAbOMh9kMmrjHLWDu9jLzYF
         ZlxA==
X-Gm-Message-State: AC+VfDz3n+vIWDT88sYVfShLroJleTW9CG40qw2oEW4AjdcalGdSUw08
        6OaYEQiRxvhokl05Ton+6D32ISVvow==
X-Google-Smtp-Source: ACHHUZ6LmT+We7gJOUmqOY3r/LnnAAtveC1TRMTtsJZ9d6YbdSZP5U1OMrEm9KIXE389IVjuxFu4Og==
X-Received: by 2002:a05:6e02:1945:b0:33c:5709:a142 with SMTP id x5-20020a056e02194500b0033c5709a142mr2291631ilu.3.1686771527562;
        Wed, 14 Jun 2023 12:38:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b26-20020a05663801ba00b004141e72be1asm5130675jaq.175.2023.06.14.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:38:46 -0700 (PDT)
Received: (nullmailer pid 2615070 invoked by uid 1000);
        Wed, 14 Jun 2023 19:38:44 -0000
Date:   Wed, 14 Jun 2023 13:38:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     pabeni@redhat.com, linux-usb@vger.kernel.org,
        manikandan.m@microchip.com, alexandre.belloni@bootlin.com,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, davem@davemloft.net, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, mihai.sain@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        dharma.b@microchip.com, gregkh@linuxfoundation.org,
        balakrishnan.s@microchip.com, gregory.clement@bootlin.com,
        edumazet@google.com, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, sre@kernel.org, maz@kernel.org, arnd@arndb.de,
        durai.manickamkr@microchip.com, nayabbasha.sayed@microchip.com,
        nicolas.ferre@microchip.com, mturquette@baylibre.com,
        kuba@kernel.org, Hari.PrasathGE@microchip.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        cristian.birsan@microchip.com, claudiu.beznea@microchip.com,
        tglx@linutronix.de, linux@armlinux.org.uk
Subject: Re: [PATCH 02/21] dt-bindings: usb: ehci: Add atmel at91sam9g45-ehci
 compatible
Message-ID: <168677152371.2615010.58720961392289090.robh@kernel.org>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-3-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603200243.243878-3-varshini.rajendran@microchip.com>
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


On Sun, 04 Jun 2023 01:32:24 +0530, Varshini Rajendran wrote:
> Document at91sam9g45-ehci compatible for usb-ehci
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

