Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355B567AF83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjAYKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjAYKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:20:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59E3A5AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so16514491wrw.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CocmKqOl46F4l4g+acF+P3temDKBy6NTuyF++EyDG7k=;
        b=ABIvAwL7oLVLsS6IP5eQd9RiAnQ6dMfhQC3OdxtoyE1HhMCNS+pquX/ljQMoq7bILZ
         kleQMQy7uaIfcEtPgSTTKF0JXzpjvCaH/wH2AT46DHq47GLtvNqi7/Nd/YgMTF6l3sPJ
         Itns+/uXLjA4DGfR4MfkFF+V+WnaldJZXhYwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CocmKqOl46F4l4g+acF+P3temDKBy6NTuyF++EyDG7k=;
        b=x7XiQNIVyJixnly92xHIeQCMocoxgCv7ctCGIkhy1AINTmELZN7FRwlMnafpEnhSlB
         076S58fBRtscXxEG5+HAtrKH/OfC0qC0QfSbtmzNolSKVN0XUuXnAnZKnRwv0S6A5KNA
         FdQOBJQw7ExQAet5KNqA26gRL2I0I0tx0GC7yCrfbuBO9YAEjrn2BiahmKKVTf0rBxkh
         I9hg4Z6pNOmTCBEX52NCWUuvP8ubN4z4APa4a7R2gxGWW1TQA897UNuh9tlPQsgB8Bnm
         hhEw9+4bTOh3yS/+V7XJ9mkdEnWT641UJqNtvQ35klwQNRqsSgnCV5+TL+2SpJy2ZgpN
         CIAg==
X-Gm-Message-State: AO0yUKXRtRadoAndxGkvLhR6yLIM/RZm6QPGr3oqF60RV2yqkBgQMfay
        9/P1ZA19ob5zAPIKClsrqSWoIj6AbrJvV16biIZYow==
X-Google-Smtp-Source: AK7set9xuQLQxGd4V9X5pRRQliJNhvniM28fljwVjOIj/yKJcakQvNE8RP3bXULZL56B4NBvE99Ob/ydLJNe5SM1hig=
X-Received: by 2002:adf:fe50:0:b0:2bf:ae3f:5371 with SMTP id
 m16-20020adffe50000000b002bfae3f5371mr156634wrs.704.1674642015770; Wed, 25
 Jan 2023 02:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Palmer <daniel@thingy.jp>
Date:   Wed, 25 Jan 2023 19:20:04 +0900
Message-ID: <CAFr9PXn+XMzz8uZzNwDNdCpYeN4Nf6rc6nXWvuf_TCRe2B_PXw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: mstar: align UART node name with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Jan 2023 at 00:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bindings expect UART/serial node names to be "serial".

snip

> -                       pm_uart: uart@221000 {
> +                       pm_uart: serial@221000 {
>                                 compatible = "ns16550a";
>                                 reg = <0x221000 0x100>;
>                                 reg-shift = <3>;
> --
> 2.34.1
>

I have this change in my changes to use the proper uart driver that I
need to fix up and resend but it doesn't hurt to fix it now.

Reviewed-by: Daniel Palmer <daniel@thingy.jp>

But we don't have anything queued up in our tree to send a PR for so
maybe this should be merged via soc.
