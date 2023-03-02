Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016206A7FED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCBK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:27:00 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257973D08F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:26:58 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ev13so11279238qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtmjHcZkI3zGShXGHZey08Yzvo+1616KPZSuz8p9lIA=;
        b=qywYp9vMKL4fcXPw0U06L9HLhJIlb0znoW+lrCJJmaH8g/+T+6v1t6sb6XglX6ivQj
         aWUw8YbAdwW+gVlAAJkqEJtvc1duBaPwRhGXxn3WK0miCMLylXwK9gul0PqHQDeZw4Fp
         sBJblA5XYugDN5ees8eDK9JqCk+6rcdcDhwNfI/s8G5uUb2olDKCRp5F/MEtvS2XyoGW
         NPZMOSjjkjOFbCP1GZm1RhnqceyaLc/zXN5A3+4npgLm7yj+ScI2SLWpGEUf0RjbmCCr
         ux5V7f8bjmYlYMhIzxFwdXV1jMDnSYY6EIDzUOflWdRkdbymTdZkT2Pj5uwr8xvYyxfF
         UegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtmjHcZkI3zGShXGHZey08Yzvo+1616KPZSuz8p9lIA=;
        b=4/MQoTlLDuqNZrsl7DII02cIf+DA6SnD1xzdJY85QOgraGeSX4UqWbS2zAqv8M79Qx
         kzD0tpEXdmNgf9NCDlhgkxpAaY8F8UobscC/AiyiYX0XreTI+Nrfa7hjupV8rYZJciec
         nzGIj90v1mUc8/WS1rc9kPUxyVVqrNSqck3M60WwtVBOJXm38/+xe+WtXN1eijOBDJsH
         t1vYCNodtbWtNka5PfbbkRHesXK8arAkNF6QH3MHwivuB9H99NmDRp1owfJxsSmgb+WX
         Tlen18wKad8sovfaQopydB79I5yX2FQg3xb1QHp+Xq58Rf14WoY+XG3qVttY/lvlWMq6
         K6kg==
X-Gm-Message-State: AO0yUKV+St+klfjmXyJE9XerFRqK/XdD2YdsmmPdJ28GklocKA5eyDlC
        HFUxXuxNGomNXAHyLfc06j0lUOiug/8gWT3BTCE47+hM69XZBg==
X-Google-Smtp-Source: AK7set8Ffa6WifsSCkQSgZyy+Aj+4eMjZgmW3eHvQ+JiAL2jx5xzl8OdWHWr29OBcIDaeDJ+R+Ct/IFUhD+qCBujHo4=
X-Received: by 2002:a05:6214:4a4d:b0:56f:18ed:316f with SMTP id
 ph13-20020a0562144a4d00b0056f18ed316fmr2575689qvb.1.1677752817075; Thu, 02
 Mar 2023 02:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20230302071934.254111-1-bjorn@kernel.org>
In-Reply-To: <20230302071934.254111-1-bjorn@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Mar 2023 12:26:21 +0200
Message-ID: <CAHp75Vej41uWK9hUOuU=p2D3BwgznhjBzSLbFgRcdY8_X=brpQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/test_string.c: Add strncmp() tests
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
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

On Thu, Mar 2, 2023 at 9:19=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V strncmp() fails on some inputs, see the linked thread for
> more details. It turns out there were no strncmp() calls in the self
> tests, this adds one.

Thank you, it's good enough.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Heiko St=C3=BCbner <heiko@sntech.de>
> Link: https://lore.kernel.org/all/2801162.88bMQJbFj6@diego/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> Change back to it's original form. Checkpatch still complains about
> __initconst, but there's a patch addressing that [1].
>
> [1] https://lore.kernel.org/all/20230301094320.15954-1-bjorn@kernel.org/
>
> v2->v3: Removed the "checkpatch fix" patch
>         Added one more test
>
> v1->v2: Added two more tests (pos/neg). (Andy)
>         Minor code style issues. (Andy)
>         Fixed checkpatch errors.
> ---
> lib/test_string.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/lib/test_string.c b/lib/test_string.c
> index c5cb92fb710e..f18a34578f1f 100644
> --- a/lib/test_string.c
> +++ b/lib/test_string.c
> @@ -207,6 +207,43 @@ static __init int strspn_selftest(void)
>         return 0;
>  }
>
> +static __init int strncmp_selftest(void)
> +{
> +       size_t i;
> +       static const struct strncmp_test {
> +               const char *str_a;
> +               const char *str_b;
> +               unsigned long count;
> +               unsigned long max_off;
> +               int retval;
> +       } tests[] __initconst =3D {
> +               { "/dev/vda", "/dev/", 5, 4, 0 },
> +               { "/dev/vda", "/dev/vdb", 5, 4, 0 },
> +               { "00000000---11111", "00000000---11112", 12, 4, 0 },
> +               { "/dev/vda", "/dev/vd\0", 8, 0, 97 },
> +               { "ABC", "AB", 3, 0, 67 },
> +               { "ABA", "ABZ", 3, 0, -25 },
> +               { "ABC", "ABC", 3, 0, 0 },
> +       };
> +
> +       for (i =3D 0; i < ARRAY_SIZE(tests); ++i) {
> +               const struct strncmp_test *s =3D tests + i;
> +               size_t off;
> +
> +               for (off =3D 0; off <=3D s->max_off; off++) {
> +                       int res =3D strncmp(s->str_a + off, s->str_b + of=
f, s->count - off);
> +
> +                       if (res =3D=3D 0 && s->retval !=3D 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x0;
> +                       if (res > 0 && s->retval <=3D 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x1;
> +                       if (res < 0 && s->retval >=3D 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x2;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static __exit void string_selftest_remove(void)
>  {
>  }
> @@ -245,6 +282,11 @@ static __init int string_selftest_init(void)
>         if (subtest)
>                 goto fail;
>
> +       test =3D 7;
> +       subtest =3D strncmp_selftest();
> +       if (subtest)
> +               goto fail;
> +
>         pr_info("String selftests succeeded\n");
>         return 0;
>  fail:
>
> base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> --
> 2.37.2
>


--=20
With Best Regards,
Andy Shevchenko
