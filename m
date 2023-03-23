Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B036C620B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCWIkB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCWIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:39:34 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FE18B30;
        Thu, 23 Mar 2023 01:38:11 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id q88so7440049qvq.13;
        Thu, 23 Mar 2023 01:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts6l4q35PJyZVvbtUPUcE0vDkunILKSFRvvJ+IL6obs=;
        b=g8bpv/jsdh05yaEiapsXJJWClDSFO83bVAezP9P7XZ9vpaAaX7bMcbznm02VRa1332
         4HXloZRSUr16LN3Q9D3Z3fXYUPGR20IBSdhoKXDLyjwlPBt2H368j/R1c2enS3s5Fi/x
         U+El+e2+VLToKgu2qpp7ILhULLJYx2NwbY21MDwUgjDv/p5/zvYjOPEW71x6uJyy9Pcs
         3OiEoDYVPBXOmNPhf8dQA8XGo6UinXsfnc9DwnoYjJPEPncCzEwJiJnMzV6oVVBs/Gjv
         BtH90JcsBp/BOz4BzsDOIiT0+gP5cL7prbKnj+ejzg++3+IgOtNku+w+3GT5LrBtjUL7
         qGYA==
X-Gm-Message-State: AO0yUKW9zKmGBgUGEkrc8vaTvdyK9Bu8zChIrQPCiw7FaV1VzMooGL/3
        sU1ZUcjNePvlZFYs/4ypj9P8Paf8niKwFg==
X-Google-Smtp-Source: AK7set90nJyJOqYatqHO3HFdFDeNvleNWHaNnVTj7wLVKS/DheMGSAlW2icGSGPQickvF4b6fSgnwQ==
X-Received: by 2002:a05:6214:29e1:b0:5ab:3328:d6e7 with SMTP id jv1-20020a05621429e100b005ab3328d6e7mr9960177qvb.10.1679560690467;
        Thu, 23 Mar 2023 01:38:10 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id v127-20020a379385000000b007456c75edbbsm12854228qkd.129.2023.03.23.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:38:09 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-541a05e4124so383422227b3.1;
        Thu, 23 Mar 2023 01:38:09 -0700 (PDT)
X-Received: by 2002:a81:af02:0:b0:544:8bc1:a179 with SMTP id
 n2-20020a81af02000000b005448bc1a179mr1425037ywh.4.1679560688960; Thu, 23 Mar
 2023 01:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230322173549.3972106-1-robh@kernel.org>
In-Reply-To: <20230322173549.3972106-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 09:37:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUtnngE4Jk6P0iLF7MXnp+7jw9XXOZsbSutDtbO77d=Q@mail.gmail.com>
Message-ID: <CAMuHMdXUtnngE4Jk6P0iLF7MXnp+7jw9XXOZsbSutDtbO77d=Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 6:35 PM Rob Herring <robh@kernel.org> wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml | 4 ++--
>  .../bindings/clock/renesas,rcar-usb2-clock-sel.yaml           | 4 ++--
>  .../devicetree/bindings/clock/renesas,rzg2l-cpg.yaml          | 4 ++--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
