Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127745EA7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiIZNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiIZNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:49:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7B1F34BA;
        Mon, 26 Sep 2022 05:06:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f26so3869209qto.11;
        Mon, 26 Sep 2022 05:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zwqQg/EA9NE7hz0+et8lHT66JUNAuO2pFuOCuX6k/yw=;
        b=GCIfIQGiXmu/6cfWujCAOqJ/QLyH4WfVnAdCseU2ByKuvQFM6L43TyYWULJtbJ1qnD
         eqWDO+g/0H5KaeRRfNHDMsRdUNgcQEN2Xs9cVCbAv53NID5UHteaJbW+wplS/KQ/MKLw
         IBliSNcohxL0yFijJ1gYgVBJay7bctF7OeSiArVhEf8qqPZ7CB/A8T5h/CNy+Vrd052y
         f2Ft1oN3X/XvS/aRLtG7i7BGIQxjY0+lzSkh4rE/3FIagzfLe3GoNusAY4AqatBb30RA
         /YdCick7/ziJ3ddPpIPVPJF84eRmXMFkAjKe1nbAqkuVcRaQF0SdMr1AK6pBYACHxO0t
         0DlA==
X-Gm-Message-State: ACrzQf1MqQcLiL6/1iEj+tHFXPMWQ90K6UICG7jtNi7Md6VLQdbuRnTm
        Rn77gVBlrFBFYnr+oGlFj0hTC0NEKtbxRw==
X-Google-Smtp-Source: AMsMyM4f2USErY5Wp2DisWPjWgm1QD0z6baomR7VfxgKHkXKSd34kSylqlz42uKKNc9kkJ2bNl0i+Q==
X-Received: by 2002:ac8:7d14:0:b0:35c:bdbe:5b97 with SMTP id g20-20020ac87d14000000b0035cbdbe5b97mr17568542qtb.272.1664193536555;
        Mon, 26 Sep 2022 04:58:56 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id fv19-20020a05622a4a1300b0035d474fd797sm349916qtb.23.2022.09.26.04.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 04:58:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 126so7951281ybw.3;
        Mon, 26 Sep 2022 04:58:55 -0700 (PDT)
X-Received: by 2002:a05:6902:2c1:b0:6b2:8bb0:79a0 with SMTP id
 w1-20020a05690202c100b006b28bb079a0mr20847868ybh.202.1664193535675; Mon, 26
 Sep 2022 04:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220921082221.10599-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220921082221.10599-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 13:58:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgwNMr-KgXTancXGJUqLEb92S0MR9rLM8fzn+Bc51U1w@mail.gmail.com>
Message-ID: <CAMuHMdVgwNMr-KgXTancXGJUqLEb92S0MR9rLM8fzn+Bc51U1w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to
 carrier board DTSI
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:22 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> spi1 is available on the RZ/G2UL SMARC EVK carrier board (PMOD0), hence
> moving the spi1 pinmux from SoM to carrier board. This is to keep
> consistency with the other SMARC EVKs.
>
> Also while moving the pinmux rename rspi1 to spi1 to be consistent with
> other SMARC EVK DTSIs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
