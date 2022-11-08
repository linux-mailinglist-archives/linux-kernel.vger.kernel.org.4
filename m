Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAD620F08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKHL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKHL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:27:43 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8B1D0DE;
        Tue,  8 Nov 2022 03:27:42 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id x18so8868872qki.4;
        Tue, 08 Nov 2022 03:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBJ14flGz4qbu94DTpiasIKodwrjiggJ5qyDbPrXNj4=;
        b=Dhe15we2hTI/0JQR0j97gAEkUkFyO6iL1w829WeUj+ERtBK2OLLdR7pI49sqtiachj
         xnPsCFsXtUDGhvli94tHG6AzG3atfiZSeYhX1uCOjjjIJ1eDGIdfI43BnwPl86bsfyGA
         RhDO/pidAmZGBH5qUSLwxtpmNzhquNPzSC1+GNXhPtURFt+c75xRxWJUeUUaDBFwqXZk
         J4TuqUbqw5T/9rpPR+vE/j3SLEqRW9qa0yetfTpWlOTCXvFGCdeMoHA59Xv2fSH85FBD
         3fWyX6FT1x4K+FSmxpFD8stKNGmBA6eREscfaNyMww82cb1t4YLutwyfza9+nmxSNCnD
         z5LA==
X-Gm-Message-State: ANoB5pk3W+Otf9o8+uTbOwVDz4zhE/e2FhNJq0VbzRCX6zQZbFZAfuqT
        K5XydblYW9D9jGKeW/JQQKW9+1k9vCytnA==
X-Google-Smtp-Source: AA0mqf5mmNfxraIJ9iPkUaT49dAba0jIRAB40sEcTG7kNhR2nUTfavfxBtsZ3rUNY5LaAnYoHtaWsw==
X-Received: by 2002:a05:620a:4ec:b0:6fa:f76d:bb45 with SMTP id b12-20020a05620a04ec00b006faf76dbb45mr4047654qkh.680.1667906861428;
        Tue, 08 Nov 2022 03:27:41 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id r3-20020a05620a298300b006eecc4a0de9sm9445790qkp.62.2022.11.08.03.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:27:41 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-367b8adf788so130864207b3.2;
        Tue, 08 Nov 2022 03:27:40 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr6626131ywe.358.1667906860433; Tue, 08
 Nov 2022 03:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 12:27:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcn=r_hj3OOOCzqtcGQstvxyNzi5dahQMwDHgKnJAS+A@mail.gmail.com>
Message-ID: <CAMuHMdVcn=r_hj3OOOCzqtcGQstvxyNzi5dahQMwDHgKnJAS+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Drop #address-cells from
 pinctrl node
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:30 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This fixes the below dtbs_check warning:
>
> arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
>     [[2]] is not of type 'object'
>     From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
>     [[2]] is not of type 'object'
>     From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>
> Drop #address-cells property from pinctrl node as it has no child nodes in it.
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
