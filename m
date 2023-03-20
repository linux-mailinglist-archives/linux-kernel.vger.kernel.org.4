Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53A6C2269
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCTUSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCTUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:18:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA52659C;
        Mon, 20 Mar 2023 13:17:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r36so9658205oiw.7;
        Mon, 20 Mar 2023 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679343479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvCcR37fJLrlgMelR2q/aS1U42JwkCalYOsRuH6mTh8=;
        b=IKID8tLkc4Izl4DY8COzbDpVHlzwLNw9WA2rcFJqv14tjXVobe7QhMBCp8bZ4v9cnO
         /Satm3TrEt+LK98otDTP6100A93uBQYCVVreUQ205taqSq+fP34SNCRN5NfxBgWT+ObM
         GNdEYb0CrhVk0fz9yydwfg3DL94vUQdLDG+jUlzE3aMemPx9E09UqgwT5nb5YlyKdeHS
         OWPsag8iVs9tL64UPZ5R20tPIUnHDQfZ+gRHrNQwSio4E5Y0AiAJfmncH9HNu/7TJdie
         aZNNNA2e+rLjOa5TeMTQKr4CLT8NtOkTvu1PVkTQmJ3AU7KbCeMqZtz0kA07hs7pERD5
         Orag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvCcR37fJLrlgMelR2q/aS1U42JwkCalYOsRuH6mTh8=;
        b=yBK+lj/q7m/1VtseVIWN6tQKJ6cxEOY/a/RJx5BtFc6SktiOLdJDXFsn7e0wbcm+f6
         itCeentwJWYHYJqIcrexjYmak6wPxVisM4wPpZiGanG5jwx7YFsoiF9SqvpaaA/yMqbC
         uJDc22B0nHQ3/n8drWCWxMN8BZDwfEeVCTYn50Vt4PKDC51VjTfG5nhI9vGUCMOjmkUo
         8HNE6djeyPfKzbIv1I4hHYVBS0fPDUp46YFOIA30nbgUHoiglBf38MGjuXYoKMBO6wsO
         f2oJSEoZBLMgJgCfb3aEyK/MDRtoG+y4HrLa32OF55ooK+sZxvOb0PRINQxOcTeQiKiY
         tCyQ==
X-Gm-Message-State: AO0yUKXeFwhz+Nr7pOKL4StYhAoXyAMAp2KiWBnSDDk3lrqnMIWGfC4d
        Z1rUBHqjNqxpuxSrBGGckb0NZOC3TVIB4c6OR0c1ZjMM
X-Google-Smtp-Source: AK7set807dpDFqIgr0TVWjB5UgDKtLRi91cnUNLVUYnXxWSDoNT/vCt3knhIXpePGsDmGr/HTl+GDDsJ6PHeO0k/eb8=
X-Received: by 2002:a05:6808:18f:b0:387:1107:1d63 with SMTP id
 w15-20020a056808018f00b0038711071d63mr387087oic.0.1679343478819; Mon, 20 Mar
 2023 13:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-8-sergio.paracuellos@gmail.com> <966523bee1d28d546969a24eff60d315.sboyd@kernel.org>
In-Reply-To: <966523bee1d28d546969a24eff60d315.sboyd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 20 Mar 2023 21:17:47 +0100
Message-ID: <CAMhs-H-y6TsSoKsJzM0gkFk6wx7xNigXKJb7wm8rBzrigtJANg@mail.gmail.com>
Subject: Re: [PATCH 07/10] mips: ralink: remove clock related function prototypes
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Mar 20, 2023 at 8:38=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Sergio Paracuellos (2023-03-20 09:18:20)
> > Clock related code has been removed from 'arch/mips/ralink' folder and =
put
> > into drivers space. Hence remove clock related prototypes which are not
> > used anymore.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  arch/mips/ralink/common.h | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> > index 87fc16751281..fcdfc9dc6210 100644
> > --- a/arch/mips/ralink/common.h
> > +++ b/arch/mips/ralink/common.h
> > @@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
> >
> >  extern void ralink_of_remap(void);
> >
> > -extern void ralink_clk_init(void);
>
> Why isn't this removed in the patch that removes the function?

Because the function exists for all the SoCs code and there are
several patches removing it; one per SoC, so I decided to remove this
at the end. Should I squash all patches together instead?

>
> > -extern void ralink_clk_add(const char *dev, unsigned long rate);
> > -
>
> Same comment.
>
> >  extern void ralink_rst_init(void);
> >

Best regards,
    Sergio Paracuellos
