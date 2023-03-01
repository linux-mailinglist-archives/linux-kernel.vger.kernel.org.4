Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C246A64D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCABbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCABbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:31:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D77C166;
        Tue, 28 Feb 2023 17:31:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg37so47593835edb.12;
        Tue, 28 Feb 2023 17:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dybzwFbIjgT2tCtgfGWmH+b0sBN7xN33eq9JJI1azg4=;
        b=J/riPlxooPKy5grH00GRJCM5uKoB0fQ7BcgtmA31Ea8U9JI/gwZgjclb6Z3xaZT0Fo
         QXV9SSx5KLNPvbMceyjFlh9ND8zhaGPu+k9/cwYb0ZBmwjbPaJT+ELkB6UNuT3j58Y3Y
         Llee33BEF4XxFxmBMTU/tN3wHDJ5Y1UupTC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dybzwFbIjgT2tCtgfGWmH+b0sBN7xN33eq9JJI1azg4=;
        b=jqbZqqmWLFv8lKmpkKt2+Vhn62gxd6Ek09BCt9yJNPWLY99hWbsKqO66vaxbTKksdt
         eUOWURFu1qY8cBs1qwdIKvy7WcRcFUHzK7AE0EURXa4UfO0I2PSoPRLX9xzwa4E3z/TU
         vZaTrc4vBcmaa6ubnZff//nUtDu7Hm9KAopfJd41SeZHIUdS9GxQsXOT4w5MYZkYgPKg
         b907avn3FphtTq6xy60qSSJh+TjleyFXl7bO65J1WhytPmL29tTNmjH/3cBsZO+C/q7s
         IMQbdQtcNMnrfbhu7cCxqmxhBlP2PdJ3JOLFb/1IVgB/kZfBCbcGYMpSqqITJPs6bwhY
         h/hg==
X-Gm-Message-State: AO0yUKUSSUC50et4dWNEEDFwEOFc4GZFRo6bxdMsAKQr6W7j3jLzQKeX
        Rj6o3KQfHZySEPO1G5hOaBSiELKW8hC7gdra7nA=
X-Google-Smtp-Source: AK7set8Rn7FrLIlyvtyXdzxIzlBOnS8eTiidZS6gad+90wWt7ADj5drCop6N8jGvqo5xdx0JPax4+93ppbEOjC6kDXc=
X-Received: by 2002:a50:9f4b:0:b0:4bc:5e2e:592 with SMTP id
 b69-20020a509f4b000000b004bc5e2e0592mr61110edf.7.1677634263803; Tue, 28 Feb
 2023 17:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20230224000400.12226-1-zev@bewilderbeest.net>
In-Reply-To: <20230224000400.12226-1-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Mar 2023 01:30:51 +0000
Message-ID: <CACPK8Xe2MA+hv3FH=eQ0toy94hQbtFgLvKxvW5k1vahQpkO+RQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: ASRock BMC updates
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 at 00:04, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> This patch series contains a few small device-tree updates for ASRock
> BMCs: an LED polarity fix for romed8hm3, enabling the ast2500 PECI
> device on e3c246d4i, and a SPI flash clock frequency fix for both.

Thanks. I'll apply these once we have a -rc1.

Cheers,

Joel

>
> Thanks,
> Zev
>
> Changes since v1 [0]:
>  - Added patch 3 correcting SPI flash clocks
>
> [0] https://lore.kernel.org/linux-devicetree/20230203105405.21942-1-zev@bewilderbeest.net/
>
> Zev Weiss (3):
>   ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
>   ARM: dts: aspeed: e3c246d4i: Add PECI device
>   ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks
>
>  arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 6 +++++-
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.39.1.438.gdcb075ea9396.dirty
>
