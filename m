Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761D16477C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLHVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:13:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9F6F0DB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:13:16 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3c090251d59so28999417b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soc6B9tEjBwoJB9lGsc2dEEhtgB2qWgmXeK3gpYqXsY=;
        b=q+PuMpZRFA+cdjBHh866YIQm0c38cAAl/UjxGeBl4OmlT+HR/AO+EDP8w4H3iDQOFI
         1bxoP7XR9Ix+xAhNsUpJ2ej06FGmLP5BcP0ggE/yH/flcVuMqLBU+925vO/g1sYzTdV9
         q1NSsNNa8is0K8ysC4+q66x2XisApu+g8UScZXUvdRSyVoCOmWHtUqwnrSHoHN8F68ul
         AzQdVMgjzmVb1eCPNpyfaSCZ+9ADJsQfncLoRQBjW9e+K7J87GeDFN18ez3MptEGiE8o
         YKKP2k2opNXGpT5UuXFwSolkjTLZWpO8KyDWptpK+Zua9RmvfVWWSisqnhvXwewo+7Cu
         JCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soc6B9tEjBwoJB9lGsc2dEEhtgB2qWgmXeK3gpYqXsY=;
        b=FKmfg+W7ABTTlWB6jN7PZTmlT4bnX8fjkn0RhTmC1LHfZkFYj+XxeTyxRnkBICzGsv
         SVq/9xEM2vPUkqqFymrSwrfLF7xkptqu405UpT/0pfSPn5+K1QCX8V+jnoS0W2uMsjO2
         IJDZP21se/YEFTSViSJ+LdV35h3u7JIXqWDEwHs0FKPq5PWMBZrpkiilYZp1hdM0O+s0
         DhDvIF5KBLxp/n9cZThOETmD9vrDcgG4hPqs9dyalhawFCHET3BcojDpfP39nrsEpjPo
         +PQB2KFIaDY9Bg9h8S8rL699VNlZoENK+rQlR88Q5Bhlbb4JcyAG4io6wzWlxL73JyRK
         Rw7Q==
X-Gm-Message-State: ANoB5pn4NxczN/swOyUzJ6ZihCUqEoF1anPw8H/SNoATTLXn3f31j+tT
        6rA+ZHkbNwKk63ryRxLgcT09yhSZXBdSEduPRJzs8w==
X-Google-Smtp-Source: AA0mqf5WRT4mHXfrsSBEeehzvRcsxHd7WGu3PF+0jUl9JAFmRJN5HORADxjGm1ZP1O59O1iaDIHHBzdX0L7xnrO4NGE=
X-Received: by 2002:a81:7853:0:b0:392:b19b:47e9 with SMTP id
 t80-20020a817853000000b00392b19b47e9mr9758426ywc.252.1670533995276; Thu, 08
 Dec 2022 13:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <20221207131731.1291517-2-william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-2-william.qiu@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:13:04 +0100
Message-ID: <CACRpkdY6364RtQMgGAFA024Pb-9v6+xcTUJdH+-MvzooBGYnhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

thanks for your patch!

On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:

> Add documentation to describe StarFive
> designware mobile storage host controller driver.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

(...)

> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      The desired number of times that the host execute tuning when needed.

This is not consistent with the use in the code of the attached driver.
There it is a phandle, and it has three cells, which I am critical of.
Also this description is hard to understand.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts

I don't think the syscon phandle is optional.

> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +    mmc@16010000 {
> +            compatible = "starfive,jh7110-sdio";
> +            reg = <0x16010000 0x10000>;

No syscon phandle in the example: this needs to be added.

Yours,
Linus Walleij
