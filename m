Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2362B59C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiKPIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiKPIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:51:26 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18C19C17;
        Wed, 16 Nov 2022 00:51:25 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id x21so11219429qkj.0;
        Wed, 16 Nov 2022 00:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQu4Kk2VsAJA/MwzBFNdfwCCKiskjqEECAV5YXUKBl0=;
        b=3+SdDdWVIdgHg+BPtj0En8ex0aZMy0RY/vOFu35sOKrh/n9NOTngM87XsiVq/11cIf
         myAQoz7gL8gydwPjj1s1LD9CrSlPyZJCwlzrDoU2cPZZXSU1ZJRf7b0PJO3/iFlVK+J5
         27TUyBzpJFPtLEYMiaJsztNRVuUmDiAuoLAwiv471dbF+ztDs/8t9uuwvGDxZ9EELUIz
         9+ciYFMRAlHqz1Vs9shyF1OFmftD5r2bJYSPCykECOa5kPYsyktHscXWGLOL6MYWdqeM
         BXNCE08TueczSxcrm58lCamlLwNd03xfxMURFIgUjvTdkqKJxvK1gYuq1RE1oa0YbeIV
         BnuQ==
X-Gm-Message-State: ANoB5pm1LusAugHc//IVHMzczl+2bxDAUxMDp2kcz4MKZ36vzzFmluJJ
        xH2TpXzRSIzsZ+G2TJWEWkvUtldHjkwKSA==
X-Google-Smtp-Source: AA0mqf7xKyaPimgenMIqplwMStWHpyoWD+X4MgPtzcG2aaUVND4AHhhfv37J5ZPzn/Gb0nkCRZxQ6Q==
X-Received: by 2002:a05:620a:15ae:b0:6ea:3fa0:bbfb with SMTP id f14-20020a05620a15ae00b006ea3fa0bbfbmr18218551qkk.473.1668588684352;
        Wed, 16 Nov 2022 00:51:24 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b006fbaf9c1b70sm376197qkb.133.2022.11.16.00.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:51:24 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-382f0906929so69848417b3.10;
        Wed, 16 Nov 2022 00:51:23 -0800 (PST)
X-Received: by 2002:a81:4ed2:0:b0:370:202b:f085 with SMTP id
 c201-20020a814ed2000000b00370202bf085mr20953147ywb.502.1668588683661; Wed, 16
 Nov 2022 00:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com> <20221114111513.1436165-7-herve.codina@bootlin.com>
In-Reply-To: <20221114111513.1436165-7-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 09:51:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzRqaAYZou5y6GivUcTfSAOx=ETDZXHhdK=iTGohUZNQ@mail.gmail.com>
Message-ID: <CAMuHMdUzRqaAYZou5y6GivUcTfSAOx=ETDZXHhdK=iTGohUZNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller node
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:15 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the USBF controller available in the r9a06g032 SoC.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
