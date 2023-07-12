Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5675073D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGLLz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGLLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:55:03 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC619B9;
        Wed, 12 Jul 2023 04:54:15 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5774335bb2aso74196587b3.0;
        Wed, 12 Jul 2023 04:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162788; x=1691754788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDxy8quJChHYDJKMgpcxwBW6AImi6kdDaLIGoVLlxtE=;
        b=D7MQZY7f8DVrPtOrJEBHll4XacK3qYcyTqOKKMqmzjzzxQGe1h3JG5jwxKoY/jGAOu
         UPuDBqWCjGpOnM0nKfaMcdcLHrS80cD3DBEuI3kADBq+jrKuDJZKbcWmS7FbyJi3MipR
         3ve6Cykku4LwfpxIOUzG/jYyXjfXLRvsWReEYzkNNX7vKLFOyPR2UXkHkT70K52lFq4A
         erVihFg8zGP7l5yfx7z9VeMqYr4tzBnGK4/qpFRYDBmgTjFYHUPaAslkGLpoQOk9y4C3
         b6z0KQevVaGVLNQdt44XlwF++3/Q9BBkWgMeByUQrFUKRI5iJuE2qPnPMbaIByqi/V2y
         XDUg==
X-Gm-Message-State: ABy/qLb5iW1HYiB7v7iNQHi3PBr8Cux1ptdzs2nxfM+CNb9HTdtJkguT
        JZHKj6aXu5xapWwgt4rhw+Yf56SJP3g96w==
X-Google-Smtp-Source: APBJJlEM1YHHiqHXfpjovIIzH2ELbpLmM4znnfJ9W3ytz/Vf41UDcnyc5Y0/HI8uOgNC5u8ZMDPtoQ==
X-Received: by 2002:a0d:ea48:0:b0:577:60d4:a879 with SMTP id t69-20020a0dea48000000b0057760d4a879mr16772400ywe.33.1689162788538;
        Wed, 12 Jul 2023 04:53:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id q64-20020a0de743000000b0054bfc94a10dsm1116817ywe.47.2023.07.12.04.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:53:07 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso6058688276.0;
        Wed, 12 Jul 2023 04:53:07 -0700 (PDT)
X-Received: by 2002:a05:6902:145:b0:bcc:c347:81de with SMTP id
 p5-20020a056902014500b00bccc34781demr12762298ybh.36.1689162786946; Wed, 12
 Jul 2023 04:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com> <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 13:52:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0vZm3npL-8MiNMo7Zjznz2qmuPR=8a0O0uxZjfpV7uQ@mail.gmail.com>
Message-ID: <CAMuHMdX0vZm3npL-8MiNMo7Zjznz2qmuPR=8a0O0uxZjfpV7uQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Jul 12, 2023 at 1:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Needed to enable this chip on a Renesas KingFisher board. Description
> copied over from the Mediatek driver which already supports it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> +++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> @@ -41,6 +41,12 @@ properties:
>      description: >
>        Backup voltage regulator
>
> +  reset-gpios:
> +    maxItems: 1
> +    description: >
> +      An optional reset line, with names such as RESET or NRESET.
> +      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.

I think you can drop the description, as it describes only the obvious.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
