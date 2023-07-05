Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50D748765
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjGEPFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjGEPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:04:54 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275A8F;
        Wed,  5 Jul 2023 08:04:53 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5728df0a7d9so85062657b3.1;
        Wed, 05 Jul 2023 08:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569492; x=1691161492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJkpWmxC/JKgZ5aaFx50qi+mR1B+BzCJdGti+xFndAI=;
        b=P+IgW2bL5+NIE8A/nxPkHPiNKfIjiudratgt6PWHInQ4e0WTvOJHoQOhRoQ93yLYlB
         BxS2flRlguDSumOzRzvvqG06A7XS3wgGoRFRl9ypwGj+0AtX20S1jIFT3SSZ2O3FoMxM
         j1y1rG2/m8zhQNBAKeosNH5Rw+Ngo8N4oN2GfXJr2ObFyx9vheX8BTtlYD0YUGd8hd1H
         +2JR1jB/O09dd+GL00cHGkAkBEtKJC4qr9LSlDV6FREoAWq5aV1DP35TNXw5Ia//M2tl
         AS2GpVMOSR+9b+lcm/I2C4H9QLIcU6uw9nRtoqz7ZIhNvipIWrLNCUU6qQNOlY8SbWlT
         oUIg==
X-Gm-Message-State: ABy/qLYYA+bdXyCqbdUSiC89PUogJaGCcFHFtze6UdmRKtCurJ8dllzt
        KP7vLOLBC9SCc3tTwnWT32DaMW/IVpCK8Q==
X-Google-Smtp-Source: APBJJlH8nVm4QYnEWTWykcpXZtQ7HNh5dPekivLX5mz87XxX1WIU9aSDeINsXtxoNRR4Ya2/cE57Ag==
X-Received: by 2002:a0d:d545:0:b0:57a:fb9:73c2 with SMTP id x66-20020a0dd545000000b0057a0fb973c2mr6728758ywd.27.1688569492441;
        Wed, 05 Jul 2023 08:04:52 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id b18-20020a0dd912000000b00570589c5aedsm6211474ywe.7.2023.07.05.08.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:04:52 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5728df0a7d9so85062227b3.1;
        Wed, 05 Jul 2023 08:04:51 -0700 (PDT)
X-Received: by 2002:a25:ce13:0:b0:c4f:43d7:7daf with SMTP id
 x19-20020a25ce13000000b00c4f43d77dafmr9465081ybe.1.1688569491682; Wed, 05 Jul
 2023 08:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230705145912.293315-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705145912.293315-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 17:04:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoQvfdoLXD5X64RiXpjfjbzq7KTnQW_wH+X6CstrKAJg@mail.gmail.com>
Message-ID: <CAMuHMdVoQvfdoLXD5X64RiXpjfjbzq7KTnQW_wH+X6CstrKAJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: renesas: add missing space before {
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Add missing whitespace between node name/label and opening {.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
