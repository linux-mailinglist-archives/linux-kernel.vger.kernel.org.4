Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33856387A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKYKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:36:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DC46657;
        Fri, 25 Nov 2022 02:36:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so9312113ejb.13;
        Fri, 25 Nov 2022 02:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAA5+MTosfMlNvoe36JT1THP0OI7Tftg0ZLwKpzdNig=;
        b=deDNxf2lRCheq9V0vXDBA6reUMtumtqZcNEppvF215oH5eHmU2HzYSolGZUK/Pnipp
         ndLiI4v8j3Y7U1lrHi3O1y+0YOpYb+J11Lcr4O81WqM9mpYE7HAz1kWBNjHI8302hwe9
         2XBID3Dr0tUxMINLtQNaBey/kaAxgD8sYeI5JcqUJ7YuVHyBUiIfWe1YOIZgSngSCqjG
         zAgIa1VDH6JwZQCV9+r/JcZuv4lCaqCL097tAWQe2mJHBRJdNb6MryVOVIn/Edv6xyiG
         Hej2YtTIjQiAljHr6dpaQDLRrLMQzQIJIO9/O0d9zgVBibhtRQKFdU28bMjmeoGw9DRb
         vYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAA5+MTosfMlNvoe36JT1THP0OI7Tftg0ZLwKpzdNig=;
        b=MjHdH0nSv1H67A3mA9sVa5o5YHZcj03oM+e04ztnP+CfkqS3+PkEeuw406tanreMwc
         5FYmIq6geka2vGnnMPEL//lFUXfTvhhEzScv5A+ro5btNlnz9cGFNaFyhht/01n5Y1+i
         jFPK/7wAl0aXTGJWO7Va3AuGYu2q9Iqe7njCmF6n3j+afCfeIfNlJWesoqCawvwgO4Kp
         bEC712D3j3ucJ8T0cE9l9+G9h2s3G1osKIyPLRD7tmxORVzE68Ufbelz99zuMOwkbnd+
         VD1SvQq6o5n47stVFzFgajjU/Nryc0iyyjEZvhKFZmZgqqByd27Y4HeWUBgtFJqlIk8S
         ATzg==
X-Gm-Message-State: ANoB5pnbQ+SIbmM7xKAyoVoSgvp6apxYHzy1yJtp6VXQpq3BFQxb2FK3
        GkG9v2Cd1ZJtpONmZoWZBQITPwLC18APvBj47U1kG1ekMNk=
X-Google-Smtp-Source: AA0mqf5v4s+UiXApNhf+ddpsOWAtYV+uHFxYvnI+gH7ytNyYHKGnV6H8idKdOR9FnvEhkFCHFEi45im9VjNaU3DDanQ=
X-Received: by 2002:a17:907:7650:b0:781:e568:294f with SMTP id
 kj16-20020a170907765000b00781e568294fmr17396469ejc.447.1669372607905; Fri, 25
 Nov 2022 02:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4801607.MHq7AAxBmi@diego> <CA+V-a8sT8VxpeM=eBgmDeojOka-LDmvP4JkhVfEDKi3D3VOsmw@mail.gmail.com>
 <3217756.bB369e8A3T@diego>
In-Reply-To: <3217756.bB369e8A3T@diego>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:36:21 +0000
Message-ID: <CA+V-a8uXxCupvW9eQGs4=XnertvZUfi_KVAF5SUcmqmPHT_+xA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Heiko,

On Fri, Nov 25, 2022 at 10:20 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Am Freitag, 25. November 2022, 11:02:21 CET schrieb Lad, Prabhakar:
> > Hi Heiko,
> >
> > On Thu, Nov 24, 2022 at 7:58 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> > > > On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Introduce ALTERNATIVE_3() macro.
> > > >
> > > > Bit perfunctory I think! There's a lovely comment down below that w=
ould
> > > > make for a better commit message if you were to yoink it.
> > > > Content looks about what I'd expect to see though.
> > >
> > > Also both the comment on the original ALTERNATIVE_2 and the new ALTER=
NATIVE_3
> > > should probably be merged into a single comment explaining this once =
for all
> > > ALTERNATIVE_x variants.
> > >
> > > Especially with the dma stuff, I'm pretty sure we'll get at least an =
ALTERNATIVE_4
> > > if not even more ;-) . So we defnitly don't want to repeat this multi=
ple times.
> > >
> > Do agree. How about the below?
> >
> > /*
> >  * Similar to what ALTERNATIVE_2() macro does but with an additional
> >  * vendor content.
> >  */
> >
> > So the other ALTERNATIVE_2+() macros will keep on building on it.
>
> My idea was more like having _one_ comment block of something like
>
> -----
> /*
>  * ALTERNATIVE_x macros allow providing multiple replacement options
>  * for an ALTERNATIVE code section. This is helpful if multiple
>  * implementation variants for the same functionality exist for
>  * different cpu cores.
>  *
>  * Usage:
>  *   ALTERNATIVE_x(old_content,
>  *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
>  *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
>  *      ...
>  *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
>  */
>
> #define ALTERNATIVE_2(...)
> #define ALTERNATIVE_3(...)
> etc
> -----
>
LGTM, I'll include the above in the next version.

> So this would include dropping the old comment over ALTERNATIVE2
>
Agreed, I'll drop it in the same patch.

Cheers,
Prabhakar
