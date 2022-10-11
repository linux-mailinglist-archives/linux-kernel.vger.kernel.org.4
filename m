Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542905FAD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJKHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:39:33 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3067D7B9;
        Tue, 11 Oct 2022 00:39:32 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id bb5so2439604qtb.11;
        Tue, 11 Oct 2022 00:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX79hRYrJFKUEMZlOxyb11gwPJYvnPLuU5eWyjSCPsM=;
        b=iUmEpr4cnrDOUmpD1MvHl1hzNd4cGo8gCqad96cHA0rvmPi9nMsFl2XOfXNT+t9E9R
         ijLHg1UQILfxC0V0mw4qrLiH687VBQrBok2FabgpmVnGCs9lK/uMtzheCnYGrs4jJhRQ
         8ODkEf7cguelCrYZv4bhmb7RCXrgBELAzNTh/ywGQ2Q7Pk92efdxmiUZ7/2wDV0oWVrH
         4HvP5kKwJDBHF0Ui89HDuDQYs+BBO09TDHcuRHAjY+6xh6Ng5HswWsbTC/izNtkv1y/a
         fwT6hksfCeq6X0eWZELVia7N2bAiDW7sNiMRpswXLGBKnG/lJB+tOB2qKbO020eQroeu
         erLA==
X-Gm-Message-State: ACrzQf0R+qxtjYmqS50oJ0p1N26pr8sgxL3matQN2WkTjE9EfELWGKOh
        uNhIv2N+vV1VvJBoRcfWFPZt6+rXJls+iA==
X-Google-Smtp-Source: AMsMyM5oM3GeSE8hQAS110nTE6Y0Et2EwFt5jCwZUwlFMLyxHCmhPFN1L6tsyktSS1nkJPJXvEktEA==
X-Received: by 2002:a05:622a:130a:b0:35b:b454:8644 with SMTP id v10-20020a05622a130a00b0035bb4548644mr18143695qtk.624.1665473971001;
        Tue, 11 Oct 2022 00:39:31 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u21-20020ac87515000000b00391d15f13f9sm10009487qtq.11.2022.10.11.00.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:39:28 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y205so15498733yby.13;
        Tue, 11 Oct 2022 00:39:25 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr21604885ybx.543.1665473965578;
 Tue, 11 Oct 2022 00:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0PBdDtFzcsmbtMv@shikoro> <CA+V-a8sOxyQj8J06kqnRN5G=L6KPdusJ-qLWntVa8kgFBh-MEQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sOxyQj8J06kqnRN5G=L6KPdusJ-qLWntVa8kgFBh-MEQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 09:39:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoDmwNnYNt6mVnHNYoNQY5fN207iyR_TopOsux6RKhnA@mail.gmail.com>
Message-ID: <CAMuHMdXoDmwNnYNt6mVnHNYoNQY5fN207iyR_TopOsux6RKhnA@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Oct 10, 2022 at 10:01 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Oct 10, 2022 at 7:53 AM Wolfram Sang <wsa@kernel.org> wrote:
> > On Mon, Oct 10, 2022 at 12:00:40AM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> > > used from CA55 CPU would result in an unexpected behaviour. Hence drop
> > > enabling WDT2.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > I'd squash patches 1+2, but that's minor.
> >
> OK, I'll wait for Geert before sending a v2.

I'd even squash the whole series into a single patch
"arm64: dts: renesas: rzg2l: Drop WDT2 node".

If that would be the only change for v2, I can take care of that while
applying.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
