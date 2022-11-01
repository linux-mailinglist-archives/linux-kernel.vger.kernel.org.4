Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862786151B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKASkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiKASkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:40:39 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B91DDE0;
        Tue,  1 Nov 2022 11:40:32 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r76so10308333oie.13;
        Tue, 01 Nov 2022 11:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9hzjd9ZHijyciHnKdGg6ad5FqSz4oFo9jluuiQAUYc=;
        b=xLsi/LIJ+Sa7HTVvuooL9c6CsXfEKUnNKCkP3YIlKNvywjoZumbQqsc+2pKmhFzcZw
         LEqdJgVluyzaA2mZ/PwM3tDci//KioQ1HLK20N1l3zIvKdGMET8ZxsIJzfJsrkd7GG77
         jmcZSgGDUaEsox7vVq0AmCUjyE53wJM7M5qyJmk3oJ5gTfhh2nHKFtswmgRncNpVWZGe
         znhx39E3cI+MHEIVlx6w/v1CXbV9N4OG1GO8V1Fx7hEBcxc0I5jd1oIt/i/6Caq0W76c
         TqJ35IlB5RXywlr4fSBL8sn8OxPzfeMgdhoAxlN7opuBM0ZOkM+1WmnjdUIYpftU27Z4
         cQ6Q==
X-Gm-Message-State: ACrzQf0PuVCNBsfEV3QQ0IybkAc8wc5F+TEvm1XXT+DgsUPr7aoAJh+B
        kWMBQPNORqi9fz7gtxKKKw==
X-Google-Smtp-Source: AMsMyM7OY/1BncaNebgnDhimX7u3Eh4GfMoUFZ38+wmSUfWGXZz7innDDugb8enD/+xkKsm+4iBR0Q==
X-Received: by 2002:a05:6808:1908:b0:35a:b52:7955 with SMTP id bf8-20020a056808190800b0035a0b527955mr6310195oib.177.1667328031904;
        Tue, 01 Nov 2022 11:40:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ad041000000b004956ee06cadsm3677487oor.43.2022.11.01.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:40:31 -0700 (PDT)
Received: (nullmailer pid 1883701 invoked by uid 1000);
        Tue, 01 Nov 2022 18:40:33 -0000
Date:   Tue, 1 Nov 2022 13:40:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
Subject: Re: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Message-ID: <20221101184033.GA1879756-robh@kernel.org>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101095156.30591-2-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:51:54PM +0800, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 48 ++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

I'm pretty sure I've said this before, but I'm not taking more fan 
controller bindings without comming up with a common binding. Please see 
this series[1] and help ensure it meets your needs.

Rob

[1] https://lore.kernel.org/all/20221013094838.1529153-2-Naresh.Solanki@9elements.com/
