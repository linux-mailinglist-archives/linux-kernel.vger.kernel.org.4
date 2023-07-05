Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5B74876D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjGEPFs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjGEPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:05:46 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99562198B;
        Wed,  5 Jul 2023 08:05:35 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5728df0a7d9so85073617b3.1;
        Wed, 05 Jul 2023 08:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569534; x=1691161534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJkpWmxC/JKgZ5aaFx50qi+mR1B+BzCJdGti+xFndAI=;
        b=dI7weMKh7K2OSLtvKyn1HgE12VS8EXNScLhfrGdpOBaq9NFQz7TPYavQpGqWxBTKVf
         IoRrkIRNtT/1uxqolpbZhRGedWfzcaYVA6zkSTBITJq8tEYWpL3/0CBww+O0YjFAwvEr
         jFXr1gvzP4OA33OwVkwQur6EmIJ6LcU8wyLhXn6015Bf8gvp/J1G0cRdziM+D6697t0x
         Hir1k0UpVr5d+c/t8mUwVNr9hBmR0z94C1yqFZXScC8dcFBDKGtUGTlG/dvZH5KaIFGd
         fWBoJgjHLXESUb+Ep43IkQNHsNZeYqDFfXekaynhGji3VGzLDdsohxH867QDNPeb7xqV
         IhxA==
X-Gm-Message-State: ABy/qLaqhlG0208+jS6efI79WX8AAunoUfq+QN9+qeSgbIvybDDRlWBU
        qyVccNkPr7a9uPkPJJmjtigxCxbIBvNmPA==
X-Google-Smtp-Source: APBJJlEjgMhEfX8b3XZrZUELtw2emHPkRGZywkptt5Lpg+qnFHzWY20uyELZUCxj/Pb9Q7UIcQNALw==
X-Received: by 2002:a0d:d849:0:b0:576:916d:96b with SMTP id a70-20020a0dd849000000b00576916d096bmr16584093ywe.36.1688569534388;
        Wed, 05 Jul 2023 08:05:34 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id r190-20020a8181c7000000b00577409a2958sm3202546ywf.138.2023.07.05.08.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:05:33 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-570114e1feaso84999377b3.3;
        Wed, 05 Jul 2023 08:05:33 -0700 (PDT)
X-Received: by 2002:a25:a205:0:b0:bac:7aba:ae4d with SMTP id
 b5-20020a25a205000000b00bac7abaae4dmr14417102ybi.28.1688569533674; Wed, 05
 Jul 2023 08:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230705145912.293315-1-krzysztof.kozlowski@linaro.org> <20230705145912.293315-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705145912.293315-2-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 17:05:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHBoiRsVppe+eHPmnnkAcHN8HJGhuXFN27r=ONzkJsWA@mail.gmail.com>
Message-ID: <CAMuHMdVHBoiRsVppe+eHPmnnkAcHN8HJGhuXFN27r=ONzkJsWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: add missing space before {
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
