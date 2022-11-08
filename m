Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E33620F20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKHLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiKHLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:31:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029344E416;
        Tue,  8 Nov 2022 03:30:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l11so21994834edb.4;
        Tue, 08 Nov 2022 03:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wL2n7EuR8P7CPo0/whRos0A/zGJ3McpJONiv/y4QNg0=;
        b=VtOnZxabcY1KU2EIYSidXphIP4a2KBXFBW9VWRN2obDePoy4eePXqw7w0J7Q1i1B4w
         36YTNcyp+a4QIZKnj6/Tx+aoQrQOwq/CsATs7f+cMqGr7Jy2yMmryF9ELgzS1pXLDBUQ
         828hePRKAWWigWt4Z8GMI7LqWVSQyfRs88qBDx4MRYytVsVE+5wFhGqtAebkI+pVfard
         LEP99eK1ntYfarG5h9uwcXkElJzvRhtd2dLQ3/u7NO5FuXG4M9zkgUXlhnth2KYvC9jM
         jCabGVOzJhvIbn4uPPOoSNn0+OtQGsSW/FTSjXWA0f+nSMydyvdpvWOsInxiZjDl0pH2
         3l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL2n7EuR8P7CPo0/whRos0A/zGJ3McpJONiv/y4QNg0=;
        b=MHlTFqls2t+VBJGLLn+5CD+Ug9qUfpg0U9r2K3WSsffsZ7IJLqsGjH3vH+OFHYRZZ2
         xbuWS4cWZTKanbIppotsawRODfxUAblK5LvM7GBgy/tEZoMN0rJQtCeFwsCDkCAEGZ8m
         sXEXkHrf/VU1wF0bgLyKjw6zvLqDE5hSD8R6T9ThZNF3P7lnYguIwTaJdvWTARHoF2ff
         mZaP/5WPBOi/3EOu7NjL5ySa7HJGNxR/KYR7tzQ5kpJwhJQGKa3sS+gxzqcvOnRRzuXM
         RD8KB059jLN/JGUfQ/l7ROJa44u78qs1jrO3+RtidwWyzCJGgjuhZgAgF+HJwszA6JK3
         tnoQ==
X-Gm-Message-State: ACrzQf1GNdISA+cTJEbi8AheTACylXlGM6b0AzzTgecvzMJ6T6LnE/TW
        DqwNlrt0m8hn6uKhzSRFoAWDPs1QyJxnUn1LIIg=
X-Google-Smtp-Source: AMsMyM4TBJguhG8wh+Yi9QFwi2sB7qSY83X5NZglly7UHCWA+t0R5H1JdMwglw8UX1bGl5CflUNXw5SYunnMYZL5UWg=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr33920546eda.109.1667907054452; Tue, 08
 Nov 2022 03:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107172953.63218-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWZyiRz0Qe2OgCZLeQe4L+ty7MR2AHQVVeC0upaM3X8OQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWZyiRz0Qe2OgCZLeQe4L+ty7MR2AHQVVeC0upaM3X8OQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Nov 2022 11:30:27 +0000
Message-ID: <CA+V-a8vNxyw_ivDSpFk5kJznSktYU=7KwqY3x3R9MNE-yXvKUA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g054: Drop #address-cells from
 pinctrl node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tue, Nov 8, 2022 at 11:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Nov 7, 2022 at 6:30 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This fixes the below dtbs_check warning:
> >
> > arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
> >     [[2]] is not of type 'object'
> >     From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> >
> > Drop #address-cells property from pinctrl node as it has no child nodes in it.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.2.
> If you don't mind, I'll squash both patches into a single commit.
>
Sure not a problem.

Cheers,
Prabhakar
