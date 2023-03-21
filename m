Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDD6C291A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCUEXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCUEXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:23:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE212868;
        Mon, 20 Mar 2023 21:23:38 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso15084963fac.12;
        Mon, 20 Mar 2023 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679372617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26n9Fj0XRag4eT+rhFG7hdMB+QgQvTFFvrbS9ZfWqXQ=;
        b=o4IFSN0hUNN/FKoHtilOVOpaxTOjdvJW4Bw7OSMuT6bH8oSZqnwEcZ08Jwh/MU4RdV
         JuGUtBtSCRoU72qYFEWLaxu97JEpl7WA9a7FEmL2zEqKBkedOIbLC1DdGWyJplVYxbbk
         9qTfgTGqffuFUqE4whS2yXwdaC+9mAs+vQgoRm9f+o9ErbIVFIaJfSVhahp9f3YQK0ZA
         JmLNzS4pQwvcZaj+g7cxyLcAH0+y+WxVMSKSO6fr/H8wSwomac+lf2NhWRwHJX2wQ/f3
         NsrqiZ+3O+AchimaNyVMcjmKFuhHFx7UrBl0QvnfAb2OKmFBA34Dqf3MpRAIHs0hV/lc
         aSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26n9Fj0XRag4eT+rhFG7hdMB+QgQvTFFvrbS9ZfWqXQ=;
        b=6eb4KAK86Xy+7Qi6eTPeygcLQ3yDztTI6Z+pylmA4VPK5A8BRkgkQbfe40qwF9DbAE
         pmhurjPOtJW61ZJoX1ZTuHniHNKK9SX2daR7BfvIsHxQBKthZYs8IrvYBqbx2v9g8+nY
         h4C7oGTfgUmlkdjkxIYGAzeWYRpE869beLHHfajMGMONaGDOzUvLYLU0UuJksk/QsSZW
         dcY080nOkp0lwwoyklfyMwQOO7lqEJrfkwe8tCNYAijY0QLTQ4dy0hLDKXsb7rFfBZ2h
         Gz0Fb2JkIauGcdwJiqnqGvWNNBmTE8NG0H5xRjc3+DSD24WvkRKlr3t19uzaUqMeGCdR
         fdWQ==
X-Gm-Message-State: AO0yUKVpE8Rpan5n1Mn5fIJQ5i+YY01Id0HiPPC69DLcqyaUuuvO43t+
        wcjF/3U8R7hDs4hnpnpmpJz7pIo4nFv22Ej2MpI=
X-Google-Smtp-Source: AK7set9CA2uoTUKHKEfuByZqzqpS0iFxe74NVh1Fj/sg+c9HccsyC2LJNYepkVoZ5cifDgg50z4EUzcjybb25t+zvK4=
X-Received: by 2002:a05:6870:1314:b0:17a:c59b:8836 with SMTP id
 20-20020a056870131400b0017ac59b8836mr148672oab.0.1679372617394; Mon, 20 Mar
 2023 21:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-8-sergio.paracuellos@gmail.com> <966523bee1d28d546969a24eff60d315.sboyd@kernel.org>
 <CAMhs-H-y6TsSoKsJzM0gkFk6wx7xNigXKJb7wm8rBzrigtJANg@mail.gmail.com> <90dd1f841e7941d8b5931ef68cd6d14e.sboyd@kernel.org>
In-Reply-To: <90dd1f841e7941d8b5931ef68cd6d14e.sboyd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 05:23:26 +0100
Message-ID: <CAMhs-H8A-c0wo0vExRP_e9my6vzuOkoYwJ2WBTsnjh-X5iK08A@mail.gmail.com>
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

On Mon, Mar 20, 2023 at 10:21=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Quoting Sergio Paracuellos (2023-03-20 13:17:47)
> > Hi Stephen,
> >
> > On Mon, Mar 20, 2023 at 8:38=E2=80=AFPM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > Quoting Sergio Paracuellos (2023-03-20 09:18:20)
> > > > Clock related code has been removed from 'arch/mips/ralink' folder =
and put
> > > > into drivers space. Hence remove clock related prototypes which are=
 not
> > > > used anymore.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  arch/mips/ralink/common.h | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> > > > index 87fc16751281..fcdfc9dc6210 100644
> > > > --- a/arch/mips/ralink/common.h
> > > > +++ b/arch/mips/ralink/common.h
> > > > @@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
> > > >
> > > >  extern void ralink_of_remap(void);
> > > >
> > > > -extern void ralink_clk_init(void);
> > >
> > > Why isn't this removed in the patch that removes the function?
> >
> > Because the function exists for all the SoCs code and there are
> > several patches removing it; one per SoC, so I decided to remove this
> > at the end. Should I squash all patches together instead?
>
> No. But you should squash this with whatever patch removes the last one.

Ah, ok. I see your point. I will squash this with the last removal, then.

Thanks,
    Sergio Paracuellos
