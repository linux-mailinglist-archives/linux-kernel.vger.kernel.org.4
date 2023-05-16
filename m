Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3BC705AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEPWgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjEPWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:36:19 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9F6A5E;
        Tue, 16 May 2023 15:36:09 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4360bef3213so3441677137.2;
        Tue, 16 May 2023 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684276569; x=1686868569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO6goYlwL4iToGOjsZHzqUARbwpLkTb6qhA2YqxeeVE=;
        b=hHu4z1Gzj57Y9XSFHW/ju30BU2KLMb+YSpi8TuZHrkg1bqrNjM+STsh81jCq26DBrX
         3BQ+vYSJzyQh3G16m5/QRa+KcRgF2aXnu+npeWsJzJda+vECoDNreDI4q0V8KTnKK4bX
         OrM9LKR5zrxY6TzZixoNRGdddtHCXf3CAKsXZ5cSUXlkbn1FlgyavZ+L7xFkIjAlUeG3
         KSTbrT06+jf0pwl0qOG3axtRG8F7eEkx1y6Ik4idJUO5DhB2Drm8j8m0Cwg1LTBxrMu4
         fkJdWxN1xnznd49FPjjGZEe9ovB/HzRTTtsimzJ/Vl3Go8dQKiabSbAQI3nKFZpKFdVH
         8rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276569; x=1686868569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO6goYlwL4iToGOjsZHzqUARbwpLkTb6qhA2YqxeeVE=;
        b=d5JLOOU7fn4nfDPPmllELArkACNnbQVAn0g1XoMazYJtukYpsoZPLpiSW5Pgs797Ds
         HPto6Q1atoHJQrLVHft6tBC8g4cZkb3VgCSbgWtGDdA5AsXTxkVQk78DhoqTwPkz1ayj
         x4aZxRUap+FKruDzDBPgyCRHdvxj9oQGLnsho+3R20m56KlTPmmDIhV+HR4nByesKDgn
         iF/ZU3OkD7lb9NmAaIMf8fXH+hMxWCjBR0yebPJJgb+JqklkbdeCyb3LBZQoa3sXv3lh
         /gQKlSHNj1OM16NQWqi8MVlV3MyP8JZTJ9uTeAa5wVIcVtGLPGALn3RrPbDHBn9kjtGZ
         6tEQ==
X-Gm-Message-State: AC+VfDzV1XNuiEbap94PlsIJWnqizPIqvIUac5ZhMXrYa93gjyzKO51B
        QW0Is5nQqjr6iocBxwk0NDz1npx53ZRdrKhjz+M=
X-Google-Smtp-Source: ACHHUZ73RHEjDMwdKY0r76kxqXj9fZ3K2nw7Oc6gTCkuau/VaSGKaDGTs2MjpBab2/r5uvF6Zc3sahF0FENGRwGUKhE=
X-Received: by 2002:a67:f30d:0:b0:436:3238:bd1 with SMTP id
 p13-20020a67f30d000000b0043632380bd1mr7960550vsf.34.1684276568666; Tue, 16
 May 2023 15:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com> <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
In-Reply-To: <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 17 May 2023 07:35:57 +0900
Message-ID: <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
To:     Gong Ruiqi <gongruiqi1@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending this email after noticing I did not reply-to-all]

On Fri, May 12, 2023 at 7:11=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.com> =
wrote:
>
>
>
> On 2023/05/11 2:43, Hyeonggon Yoo wrote:
> > I dont think adding a hardening feature by sacrificing one digit
> > percent performance
> > (and additional complexity) is worth. Heap spraying can only occur
> > when the kernel contains
> > security vulnerabilities, and if there is no known ways of performing
> > such an attack,
> > then we would simply be paying a consistent cost.
> >
> > Any opinions from hardening folks?
>
> I did a more throughout performance test on the same machine in the same
> way, and here are the results:
>
>               sched/  sched/  syscall/       mem/         mem/
>            messaging    pipe     basic     memcpy       memset
> control1       0.019   5.459     0.733  15.258789    51.398026
> control2       0.019   5.439     0.730  16.009221    48.828125
> control3       0.019   5.282     0.735  16.009221    48.828125
> control_avg    0.019   5.393     0.733  15.759077    49.684759
>
> exp1           0.019   5.374     0.741  15.500992    46.502976
> exp2           0.019   5.440     0.746  16.276042    51.398026
> exp3           0.019   5.242     0.752  15.258789    51.398026
> exp_avg        0.019   5.352     0.746  15.678608    49.766343
>
> I believe the results show only minor differences and normal
> fluctuation, and no substantial performance degradation.
>
> As Pedro points out in his reply, unfortunately there are always
> security vulnerabilities in the kernel, which is a fact that we have to
> admit. Having a useful mitigation mechanism at the expense of a little
> performance loss would be, in my opinion, quite a good deal in many
> circumstances. And people can still choose not to have it by setting the
> config to n.

Okay, now I don't think I need to tackle it from a performance
perspective anymore, at least it looks like a good tradeoff.

I had few design level concerns (i.e. in ARM64 instructions are 4-byte
aligned) before switching to hash_64(^ random sequence), but looks
good to me now.

> >> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> >> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
> >> +#else
> >> +# define SLAB_RANDOMSLAB       0
> >> +#endif

There is already the SLAB_KMALLOC flag that indicates if a cache is a
kmalloc cache. I think that would be enough for preventing merging
kmalloc caches?
