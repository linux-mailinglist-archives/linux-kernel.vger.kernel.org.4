Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A06B1C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCIHTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:19:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FE5C9FB;
        Wed,  8 Mar 2023 23:19:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c10so867754pfv.13;
        Wed, 08 Mar 2023 23:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678346339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfbJWUJGHH8nwSfPSekGj2SZwrexl9k35Jou//imJw0=;
        b=SRZq3YHPj7/9HEc5G/hdmOiAH/cKObd8ba0wfRV07PEPjCoUEUxJUHeBohmZbHAvv7
         r5ZigLdDFmjuKch3qWx86Y1QVVbigO95zw1uRzfUJ1AqGh0Sggu9a6HEkmLheAtE1/5N
         bUXhmMGToE1NeGe6GJwh7I0QkD/c1BynyUFvBY7+NDmKVUwyinHY37ZztWmfPg9tGb5D
         gDeBwBvBwv8mfMbe4aFtjdOR+V8cqdWKsGJJIyFYI80vz0/KM8PIAApY/sYAphhEbT4k
         9Ei7DTpGftHhyfolQ/08Akg1Ocbec7C8nuxPZnWAt/0v9o13EGlMu8Pg6WnSWsk5tqr/
         fIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678346339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfbJWUJGHH8nwSfPSekGj2SZwrexl9k35Jou//imJw0=;
        b=cy16nK8TjCHZENc/Fz6CsJgEmcMtwk0BFGlLRmpz6Jmwwzj+3BZe8Pelgi3wGWr/Uo
         Hd1lx2RK2rthndYsCuLoYeSA7pVem3k1YjJtqBWm1AZVS8GYXqKIgRsI1AuM8WfexUkj
         ZxwN6CvGXwhJfWSbdAxCZcA43GhoU7rloT9SkqPGkzgbLd+AWoqmYyRrOichM/UkvVHS
         aIIj2rFItDk5G9gtMwn4rShxoCXPlx4kLMJozEYvXPQl18ZcDH4p7FF3A1SY9b9jD1VH
         niE9uXdgJd5JXj86tbfRWEqXe5hqyDpdzhmRyCgR2mSTLoSsOdVlnyx5oePmp5vG+r+p
         3NtA==
X-Gm-Message-State: AO0yUKW8krAjTONFj4NOzUU5DmcM/Dvf7vi+6mkeu6/YXmn09XP2OB6i
        5HCAuv7VTg8f1M0wNleeeLJOCGyNW2CFBAvqn8o=
X-Google-Smtp-Source: AK7set/YWz7gZWkSMgyWc4wK6u9AzoqdFmwidNxJTC2APdBlFoKugVHoojpe26sybxvLybjN3eFc6dIyeU9+EBx9Q8w=
X-Received: by 2002:a62:824b:0:b0:61d:d277:e077 with SMTP id
 w72-20020a62824b000000b0061dd277e077mr1678177pfd.0.1678346339043; Wed, 08 Mar
 2023 23:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20230302093715.811758-1-zyytlz.wz@163.com> <d27127a1-2572-4ad4-b69c-8a6f53384009@roeck-us.net>
 <CAJedcCxYQYmORfnqcdudFKwy9hhU=mZh_d9MM7x+37ies2S-MA@mail.gmail.com> <e03134f9-9433-ab6b-170a-8ce752fccdeb@roeck-us.net>
In-Reply-To: <e03134f9-9433-ab6b-170a-8ce752fccdeb@roeck-us.net>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 9 Mar 2023 15:18:45 +0800
Message-ID: <CAJedcCy_cXh1jH4HT0hzG1NnQR5Gz9fTodAT_2trRRd=BWp57w@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to uncanceled work
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zheng Wang <zyytlz.wz@163.com>, mchehab@kernel.org,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E4=BA=8E2023=E5=B9=B43=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B 13:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/8/23 19:58, Zheng Hacker wrote:
> > Hi,
> >
> > Thanks for your reply. I think you're right. I don't know if there is
> > other method to stop new work from enqueing. Could you please give me
> > some advice about the fix?
> >
>
> Top-posting is discouraged.
>

Sorry I forgot that. Thanks for the kind reminder.

> Anyway -
> I don't know the code well enough to suggest a solution.
> It all depends on the driver architecture. The maintainers might
> have a better idea.
>

Yes, some related developers have reached out to me and discussed fixes wit=
h me.

> A worse problem appears to be that the worker is also canceled
> from mtk_jpeg_enc_irq() and mtk_jpeg_dec_irq(). Those are non-threaded
> interrupt handlers which, as far as I know, must not sleep and thus
> can not call cancel_delayed_work_sync(). I have no idea how to solve
> that problem either.
>

I'd be glad to pass along your thoughts and recommendations to the
relevant parties.

Best regards,
Zheng
