Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19426182BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKCP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKCP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1D1B1FD;
        Thu,  3 Nov 2022 08:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1751361F3F;
        Thu,  3 Nov 2022 15:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E4BC433D6;
        Thu,  3 Nov 2022 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667489232;
        bh=9B6TUpcxiiK6nYvO+tZ9kBnE+5WGkzDACOo23ch8WCA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=tZ5WpOZ7axSdC5g+29cT7yfgHFK7yRD4IMa9dxMheFgkrT+RotkRJIfGpMbS8c2oB
         GLepVRcm47TWGrS8XxZEjPXQd/dhZ6MHaRdTgQE31CF/NUJyg5qIHfYpybQjsxv1Sz
         H2ohLNem3YsF5qko+37yaXfV8sIS4HQIKF6qKwpuokjcSPbDtfVxb/xymZ2rriGS6M
         ddt5ca0zSqtZofSKXTQ+7ZluG2cY4BnUqNrxvVVUcEo4//EFGYCwRch+2ymfS8cz/T
         BrzbhTK7MwpypzEP6XkeN5A91xn5vzWYaYa2FDwBHNazQQjScK29irhQTMFeGE2Bhn
         0tGxzRJKJruRQ==
Message-ID: <576c42c4-1256-304d-3513-7bf02cddb220@kernel.org>
Date:   Thu, 3 Nov 2022 11:27:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-2-billy_tsai@aspeedtech.com>
 <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
 <2508B515-E153-42C2-B013-2A64A110BCF2@aspeedtech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2508B515-E153-42C2-B013-2A64A110BCF2@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 06:36, Billy Tsai wrote:
> 
> On 2022/11/3, 5:20 AM, "Krzysztof Kozlowski" <krzk@kernel.org> wrote:
> 
>     On 31/10/2022 06:38, Billy Tsai wrote:
>     > > +patternProperties:
>     > > +  "^pwm(@[0-9a-f]+)?$":
>     > > +    $ref: ../pwm/aspeed,ast2600-pwm.yaml
> 
>     > Full path, so: /schemas/pwm/aspeed,ast2600-pwm.yaml
> 
>     > Why unit addresses are optional?
> 
>     > > +
>     > > +  "^tach(@[0-9a-f]+)?$":
>     > > +    $ref: ../hwmon/aspeed,ast2600-tach.yaml
> 
>     > Ditto
> 
>     > Why unit addresses are optional?
> 
> The pwm_tach is not the bus. I will use
> pwm:
>     type: object
>     $ref: "/schemas/pwm/aspeed,ast2600-pwm.yaml"
> 
> tach:
>     type: object
>     $ref: "/schemas/hwmon/aspeed,ast2600-tach.yaml"
> to replace it.
> 
>     > > +
>     > > +additionalProperties: false
>     > > +
>     > > +examples:
>     > > +  - |
>     > > +    #include <dt-bindings/clock/ast2600-clock.h>
>     > > +    pwm_tach: pwm_tach@1e610000 {
> 
>     > Node names should be generic.
>     > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> This is the mfd with pwm and tach, so they are combined as the node name.
> 
>     > No underscores in node names.
> 
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#table-1
> I see that the underscore is the valid characters for node names.
> Did I miss any information?

W=2 warnings.

Best regards,
Krzysztof

