Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E26B3EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCJMM0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCJML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:11:57 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15724BEB;
        Fri, 10 Mar 2023 04:11:40 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id c18so5359472qte.5;
        Fri, 10 Mar 2023 04:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN9ADwNp0Kvo6TG9fwtArvPEhlN9J1P8hbAGaNC2UAg=;
        b=kOvtWID2bL6WjzU7UzsB79PH8j41Z00zvxOMsE2BGUeJgDDPUvpF6iRXKxMOmS3uUd
         gCEBc07zup1re4x2G6/X408T/ASnxBhhY/epEyhWQ6ye1Z+kNN6DD9bEFMYcc93E6MqZ
         nzanhs94XzBcDADxLhSoCi801d/LNe+IGsrkNFqUPZMvdOO+k7MfkXJBXXgQDzRfKj1+
         QJyVutkxUMN3c2g6mGrWaahh/cHOgbY2Md35txSRm0LIFsTTpKrY1JmwgriMN5BGnibG
         11O4aOsPJfmesplEzll8p1z8ei70MKDnNF/cE6JCWyhcoaWxm9nBkL5emZFyg8hVNHG3
         5WWw==
X-Gm-Message-State: AO0yUKUNH+u/mF6eOdd7vMK67gVcgPLawjdLMVGM7Ypepm6Bt9WcU8sh
        NcUDZg8ciIKxFURjWi5lMm3TrzwrWO4R5A==
X-Google-Smtp-Source: AK7set9j0PsXtpFxaf73+BiUm7XbJ7SMGPbgtk0UXaThOi0Bo/QazvSyptoAzE1NzMxN4oWX+Idk6g==
X-Received: by 2002:a05:622a:d1:b0:3bf:d1b3:2bbb with SMTP id p17-20020a05622a00d100b003bfd1b32bbbmr8484041qtw.13.1678450298995;
        Fri, 10 Mar 2023 04:11:38 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id q2-20020ac84502000000b003bfa66b7484sm1268650qtn.35.2023.03.10.04.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 04:11:38 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-536bf92b55cso93216777b3.12;
        Fri, 10 Mar 2023 04:11:38 -0800 (PST)
X-Received: by 2002:a81:ae4a:0:b0:52e:b7cf:4cd1 with SMTP id
 g10-20020a81ae4a000000b0052eb7cf4cd1mr16215414ywk.5.1678450298121; Fri, 10
 Mar 2023 04:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20230206001300.28937-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV+Az_yda0nTzn5teeQ2V7brQsmtZx6RUzBQsok3LxVKw@mail.gmail.com>
In-Reply-To: <CAMuHMdV+Az_yda0nTzn5teeQ2V7brQsmtZx6RUzBQsok3LxVKw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 13:11:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWw43xpmRgzGM8g2fEbpMrVp4exOCNG+4riFC9v_TU+ZA@mail.gmail.com>
Message-ID: <CAMuHMdWw43xpmRgzGM8g2fEbpMrVp4exOCNG+4riFC9v_TU+ZA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Feb 10, 2023 at 11:49 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Feb 6, 2023 at 1:13 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the performance monitor unit for the Cortex-A55 cores on the
> > RZ/G2L (r9a07g044) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Fixed interrupt type
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.4.

And cloning for RZ/V2L...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
