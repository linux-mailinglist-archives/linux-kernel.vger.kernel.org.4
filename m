Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF2616B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiKBRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKBRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:43:29 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA0F12ACD;
        Wed,  2 Nov 2022 10:43:28 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r76so13405517oie.13;
        Wed, 02 Nov 2022 10:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9poywl78m8VbboeaIxh9XvxslO7HuQV0K41BEoNBnI=;
        b=felTKJEgHVapdSpH4bGAX4hNzGKlBczogOH3cE+gW+Wk2JMK57bzox/VmlbDLXtQ1I
         FJA/Zv35IU/2qC6P53ptibfutppvyj5h99bL5dUTTv4HQzBjSFSKHQjXGajykfmUpMzz
         Fxo+AQtHa4k+MZgTaMNJgguVr8LvhAIbaYzSvIx4UtiM+AbhTeLhpgXXE/mVMqxF3myj
         kBmlWWWc/GLsZqOTLbXAb067B+jm8aTxpJ6X+NxeNWEznOgukwe3I0LyhfF4HzzIKogP
         LmwDcBcLp8NI7F33zvMUm8lR18dvZVK6dQrIa0/BGcYisgoey+t9D3ki8tvU1bOukd+Y
         0Wbw==
X-Gm-Message-State: ACrzQf05wnx2lrVQCqovwPKZhrpe1DWzv8j6frtMLLT5oK2kH3em17Gi
        TdyIodENrdsKsCX6sHG5hg==
X-Google-Smtp-Source: AMsMyM7C49lmmZ/gTiysk0FOySnpKStlXVbXhGF6IF/PgxlF1xZeShB8CXViCLEOlLjjMfpHKM0rdg==
X-Received: by 2002:a05:6808:2203:b0:355:1584:77ca with SMTP id bd3-20020a056808220300b00355158477camr22300871oib.64.1667411007639;
        Wed, 02 Nov 2022 10:43:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b5-20020a056870d1c500b0013ae5246449sm6282686oac.22.2022.11.02.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:43:27 -0700 (PDT)
Received: (nullmailer pid 14800 invoked by uid 1000);
        Wed, 02 Nov 2022 17:43:28 -0000
Date:   Wed, 2 Nov 2022 12:43:28 -0500
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
Subject: Re: [v3 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Message-ID: <20221102174328.GA11490-robh@kernel.org>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102083601.10456-2-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:35:59PM +0800, Billy Tsai wrote:
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

Same comment from last version applies. Please don't send new versions 
so quickly before folks have a chance to review or discussions to 
conclude. 1-2 weeks is typical.

Rob
