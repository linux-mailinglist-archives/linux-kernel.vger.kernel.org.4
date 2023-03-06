Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838046ACEFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCFUQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:16:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DFE2CC74;
        Mon,  6 Mar 2023 12:16:50 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g25so3660650qki.9;
        Mon, 06 Mar 2023 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678133809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAeoJvapRO4dVYQ2Gtaci6rfxzerkGQDplgvjzlK0uE=;
        b=bdZ9NbVgZarSVtJrX8qHEHSCRNAzt5xpgO0zTIZ3ZG581Q+G+RLKiCHERz34pYSu59
         szcpU+97hx40kJp91GxIHUKOmP0f5JxCZym/95UOfS8jCLWWdK0Bb6JdmBFaRvdf65BZ
         FpB6H+gIMSRwkHEQszd6okaf0a05XE40TTOaUCUfok12wpdbuXQexhQvPSmX7KK0g2qe
         qz+Jg/lY5VA+541ZLPOkQlcMy1y7h3WeUSlVPD1wA8al1hm0hIljUx+Nk8VANghpW7P7
         VAQ8ou7J4uzgI2hzVy0Ps8gxKyvleZgW5O7n+uLjytmvqkyYyOhmbv3uTVBRRAWvWvfE
         1ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAeoJvapRO4dVYQ2Gtaci6rfxzerkGQDplgvjzlK0uE=;
        b=a7k93+Np6ab0YfE5lVytfSrd+ILmFLi4rer4cEQ/5fOlJmPMIx0S7NkiiZfEbbuP8H
         WZlyb/hZ5a3MATtpHpUt4cB7wEsg2ecM80n210kfgbX+bFxFoYFbsRg/B9lmJhv+xow+
         juMEDV61D/DB/Zw2zlwI40MfyHYaOZuUAF0NTY3KYUB+KVpjvMuI6JMVGjaXnIcsUBQ4
         bCZBzNdYWpLt+JfOhUbAMgLkAOeDj5IuAT1cVQgGMsDWcC8/ZJfa5XOoniLE2LLolNjD
         DXqeByqaGFvNAG0MYjMVn+pNNrGO5oJ1M/iTtbq8/AhKdl2nuw7mYjqRlNYMIY6mkTJs
         nWTA==
X-Gm-Message-State: AO0yUKWmE21ofNIBFG6KgsAWtyZNwpPsIMAO+xa0VCAt+vWKr+lmRKD5
        dKkzM5ugl8/JPsrVfYyeP/RFp0G1Fscoy83RdbpPwdLWI5Y=
X-Google-Smtp-Source: AK7set9UB7bqPgylW/kuCPuna/JHfIKn1y9VfsE0+tUgqwucXEyBgXyPfMs49a9g4K3g1tFeQzKT/4LNPFcwCebBKG4=
X-Received: by 2002:a05:620a:5360:b0:742:69db:3bf1 with SMTP id
 op32-20020a05620a536000b0074269db3bf1mr3451654qkn.10.1678133809410; Mon, 06
 Mar 2023 12:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20230303215814.24783-1-asmaa@nvidia.com> <CAHp75VfpRVf3fzBf76mipu3dWDbwGCBFUOzyR-P=DLab3_y=Kw@mail.gmail.com>
 <CH2PR12MB3895B0A2360B02F0387F9FBBD7B69@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895B0A2360B02F0387F9FBBD7B69@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Mar 2023 22:16:13 +0200
Message-ID: <CAHp75Vcwcs_+1rdv6Day9U+i2CqbsPzsbFQ44Q-hwuwaW13VRg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Mar 6, 2023 at 8:47 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

...

> > > +       ret =3D gpiochip_get_ngpios(gc, dev);
> > > +       if (ret)
> > > +               gc->ngpio =3D gc->bgpio_bits;
> >
> > But this doesn't update bgpio_bits in the success case. Can you explain=
 why
> > it's not a problem (should be at least in the code as a comment).
>
> In the success rate, the bgpio_bits would also be equal to "sz * 8" anywa=
ys.
> The argument " unsigned long sz" passed in bgpio_init is specifically for=
 this purpose. That tells the gpio library the gpio register access size.
> if (!is_power_of_2(sz))
>                  return -EINVAL;
>  gc->bgpio_bits =3D sz * 8;
>
> If in the success case, we make it dependent on the ngpio value, we would=
 need to round it up anyways to the closest (power of 2 && multiple of 8) w=
hich is the same as "sz * 8"
> I will add a comment in the code in my next patch.

I believe we should use only a single source for what we need. If we
rely on ngpios, the bgpio_bits should be recalculated based on it. The
expression doing this is very simple. Something like round_up(ngpios,
8);

...

> > > +               ret =3D device_property_read_u32(dev, "ngpios", &ngpi=
os);
> > > +               if (ret) {
> > > +                       chip_err(gc, "Failed to get ngpios property\n=
");
> > > +                       return -EINVAL;
> > > +               }
> >
> > This is not an equivalent to what was in the GPIO library. Why is it so=
?
>
> Sure. I will keep it the same in my next patch.

No, you should take care about error codes properly. Now you are
shadowing anything to -EINVAL. With this you must keep the comment in
the code untouched (moved, but untouched).

> The reason I didn=E2=80=99t is because I noticed that the final result of=
 the logic is the same i.e. " goto err_free_dev_name"
> "if(ret =3D=3D -ENODATA)" is handled separately is to add an informative =
message: chip_err(gc, "tried to insert a GPIO chip with zero lines\n"); and=
 return ret =3D -EINVAL.

Yes, but you missed one out of three cases.

> > > +               gc->ngpio =3D ngpios;
> > > +       }

...

> > >                 pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\=
n", __func__,
> > > -                      base, base + (int)ngpios - 1,
> > > +                      base, base + (int)gc->ngpio - 1,
> > >                        gc->label ? : "generic", ret);
> >
> > AFAIU this will give a different result to what was previous in one of =
the error
> > cases.
>
> this one provides the "local" gpio pin id i.e. 0->31 for example.
> chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n", gc->ngpio=
, FASTPATH_NGPIO);
>
> while this one provides the "global" gpio pin id. when bgpio_init sets th=
e base : gc->base =3D -1; and gpiochip_add_data_with_key applies this logic=
:
> pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__, base, =
base + (int)gc->ngpio - 1,
> base =3D gc->base;
>          if (base < 0) {
>                  base =3D gpiochip_find_base(gc->ngpio);
> Then the base would be =3D GPIO_DYNAMIC_BASE
>
> Apologies if I misunderstood your question?

I'm talking about your change. It behaves differently in case of
different errors and contents of gc->ngpio and the ngpios local
variable.

...

Please, check again carefully all possible branches and cases (there
are few of them, not just a couple).

--=20
With Best Regards,
Andy Shevchenko
