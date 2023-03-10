Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58B76B3851
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCJIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCJIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:14:55 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE64C6F5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:14:51 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536af432ee5so84479967b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quyZEe5f9jO8KHwGwidAcKdKAq7OwgEj9SHFvyGmlZM=;
        b=Xz0I6e3/LJ+Lvtl+mKQOAS8yqInF8ZVaGOXpCLhNKcTzLKSlpWsOv0VEUV904Fu2Na
         +9A9pGlvxI7QVFYtmKKzM6zJvyU/OvN4b4AgPCCXGFTKagrmgS5ZX9VtQAHafqBxGC6m
         Eq+llrzRCUIwZLjEDh0TDX+4GFXgVT0pFUHmGANZJZ4RWQImFVpWbTBQIxQnCxbduSEp
         DOThgSu4tTiGbqDTZTrSz73IR46mvjGnqF8u8lCX2TyneUEkARXtWV0c4hQwYhagD2T6
         s1pARgBUkdpxocdhAEHK1Lt7iH0sQ+LLaf/zWu8DCwBqOqVIgx7QnMe532eqyhHcCUGD
         RZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quyZEe5f9jO8KHwGwidAcKdKAq7OwgEj9SHFvyGmlZM=;
        b=KHc3cjfZFiXQF3oY3ai8QG4HXkOTlEdyXmVISAqrPfEwgONY3iOzWHG9Z2raFr+Vo6
         ccp/nDa4Ltc0/i75H3sR44WMHs+EaQ5hxXMwalLCiYpjIpqFlUj2oMbDD8V4oERQ3yGP
         nFrIW6JHQkNeRTSK1J+vuWKL8mSpML93+B3pypHn3dgP3gAhpXyuoqJLj2mhp+ZpbdWJ
         P4joGFe0dkpFfSWmhEXSXQSYE/1x01lW441VZzvtl/Ao4uowoI5y+vYLIsJNkgNRf9t2
         Brd5VleGuyD+1pPEYvnpMOE7YPky2ZkKLI/gRR9TD5spdAOVErJjHqbvoWjeMjvY0uK3
         kTDA==
X-Gm-Message-State: AO0yUKXX1VkywMuYe+8SqUPynYYfWrdc2XQ/3Qsb6rZOcS0k5IKnsmGg
        Q5Q7IINJCcONS13mglAavYWsZr4VJFV6cl4ED8UKCw==
X-Google-Smtp-Source: AK7set//fuO9ytX567HKWcNCadQ41YDeuUs8D1KGFn4aNeWpTp2CgUPag3nEjA34y+PObgUwSM88FqO9+8UaF4aug+g=
X-Received: by 2002:a81:b61a:0:b0:52e:cea7:f6e3 with SMTP id
 u26-20020a81b61a000000b0052ecea7f6e3mr15413943ywh.10.1678436090623; Fri, 10
 Mar 2023 00:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-2-sre@kernel.org>
In-Reply-To: <20230309225041.477440-2-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:14:39 +0100
Message-ID: <CACRpkdYWP7Fc3yho5nDB3qU6rt5o4p2Zcz_RxOvOfsAwjXgqXw@mail.gmail.com>
Subject: Re: [PATCHv1 01/11] dt-bindings: power: supply: adc-battery: add binding
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

thanks for your patches!

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

This does look very useful.

> +title: ADC battery
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  Basic Battery, which only reports (in circuit) voltage and optionally
> +  current via an ADC channel.

I would over-specify: "voltage over the terminals" and
"current out of the battery" so this cannot be misunderstood.

+ this text:

It can also optionally indicate that the battery is full by pulling a GPIO
line.

> +  charged-gpios:
> +    description:
> +      GPIO which signals that the battery is fully charged.

It doesn't say how, I guess either this is an analog circuit (!) or
a charger IC? If it doesn't matter, no big deal, but if something is
implicit here, then spell it out please.

> +    fuel-gauge {

This techno-lingo/slang term is a bit unfortunate, but if there are
precedents then stick with it.

The correct term could be something like battery-capacity-meter
I suppose.

Yours,
Linus Walleij
