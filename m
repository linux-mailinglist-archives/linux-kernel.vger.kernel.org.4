Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A873729F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFTRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFTRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:19:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320511C;
        Tue, 20 Jun 2023 10:19:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-394c7ba4cb5so3256667b6e.1;
        Tue, 20 Jun 2023 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281557; x=1689873557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmCprH+idanaTAuo2dvFzhcGXyTLAiyj5xkHxuQVXTU=;
        b=b9lHqrbagfr1RSGyhYN77p4kcA/eHb4NKgN16tHcbxlk8o72r0HdwtasyTOHARltWD
         C/E82gKtEmrd4NpGBjaRFuww/h40qL0AfXOHeEvlXReEGa/3ENiah0Gce1po/Hu5MBfH
         NHqy0OE1EXnomjjuY1iicVoEUf4vyoVYLymygmw2KKkeT8i+ZrPnKE96GdYrgTDyaRIB
         ZV9hvI/ilx024AGepjkwoOEVvWApcD9JvxTUX52ZVxsF0+6FGcbPM+c4i00rm1N1iv2h
         dOp4RnvtAyaI5f9WpFdroMUvIvKJd+mcut+phNZHdiuqhx2VDf9Usn7eDjWnp+i/62rX
         FL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281557; x=1689873557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmCprH+idanaTAuo2dvFzhcGXyTLAiyj5xkHxuQVXTU=;
        b=DJgzcBFcTbA3JmKKOWpmhLqZtFz3/KudB7HtcZ5MFNYwU7wP2bw/6ivA8RV5YsOJD3
         gMgH6jcd1jYyHN0LI4DaFFmVBu4YlNQGLptj1QevWwZWovCc8cjtweIaPe7siVhh/wms
         0C63yvZ0p/KrxXmxKBM8I++G1DpbeTO/29CQXeyMqxkt+ZZP8mjD4k0fkloBx8D6PqTT
         f4Sgdsq7BhtM8rL+q/B54585odxGpn7PjwA4AZrUdBItaVGv0n78p/X8F52bMqfMLZ9R
         1D6/F+mf/mDHJLgC6ZuC0zgeT/8uu00GACoQR4FRhBun9lwrdjlqCSKu8H0zOc3c1KkX
         fqEw==
X-Gm-Message-State: AC+VfDyRpe4WEBUA0OQfooq6JcQQPL6Ga+Fay4G/RYRvm+Y68OEot+t6
        jweqyt7Et9cCA3bJv3vnwBigH6NIMrpy70mKS6g=
X-Google-Smtp-Source: ACHHUZ48AUCk89CwU1xZqpN0N9tbmO9d1ar83T9TqB8/AUAW9KqhF6B8cLTq3zwM5FrnfvvltVLs7q41z0lnrCLjlyM=
X-Received: by 2002:a05:6808:1b0f:b0:39a:aafd:dda7 with SMTP id
 bx15-20020a0568081b0f00b0039aaafddda7mr15864716oib.35.1687281557150; Tue, 20
 Jun 2023 10:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com> <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
 <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
 <ZJGSqdDQPs0sRQTb@elver.google.com> <CA+fCnZdZ0=kKN6hE_OF7jV_r_FjTh3FZtkGHBD57ZfqCXStKHg@mail.gmail.com>
 <ZJG8WiamZvEJJKUc@elver.google.com> <CA+fCnZdStZDyTGJfiW1uZVhhb-DraZmHnam0cdrB83-nnoottA@mail.gmail.com>
 <ZJHfL6vavKUZ3Yd8@elver.google.com>
In-Reply-To: <ZJHfL6vavKUZ3Yd8@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 19:19:06 +0200
Message-ID: <CA+fCnZe4cetv53bGM0cOxLGB+ZDiNU7eeSb2LKNkO2j4xCPkYQ@mail.gmail.com>
Subject: Re: [PATCH] kasan, doc: note kasan.fault=panic_on_write behaviour for
 async modes
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 7:17=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> Note the behaviour of kasan.fault=3Dpanic_on_write for async modes, since
> all asynchronous faults will result in panic (even if they are reads).
>
> Fixes: 452c03fdbed0 ("kasan: add support for kasan.fault=3Dpanic_on_write=
")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 7f37a46af574..f4acf9c2e90f 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -110,7 +110,9 @@ parameter can be used to control panic and reporting =
behaviour:
>  - ``kasan.fault=3Dreport``, ``=3Dpanic``, or ``=3Dpanic_on_write`` contr=
ols whether
>    to only print a KASAN report, panic the kernel, or panic the kernel on
>    invalid writes only (default: ``report``). The panic happens even if
> -  ``kasan_multi_shot`` is enabled.
> +  ``kasan_multi_shot`` is enabled. Note that when using asynchronous mod=
e of
> +  Hardware Tag-Based KASAN, ``kasan.fault=3Dpanic_on_write`` always pani=
cs on
> +  asynchronously checked accesses (including reads).
>
>  Software and Hardware Tag-Based KASAN modes (see the section about vario=
us
>  modes below) support altering stack trace collection behavior:
> --
> 2.41.0.185.g7c58973941-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
