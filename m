Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D720736DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjFTN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFTN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:56:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB510A;
        Tue, 20 Jun 2023 06:56:23 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39ec45b22f6so2146699b6e.0;
        Tue, 20 Jun 2023 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687269383; x=1689861383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu/aiaH31TZLMVI9Tp+a0lmhaF9umbZZEeQm47dZ8JI=;
        b=CnJeqkL3ZzkSmcdCSOkUt4xDGbdWTfBD9wl0ylaMOlqI2xPnNVZzwO2QZ3QfjpuKBT
         CbhB2sgp2Fie6iY/IYbZOyYOaY4LO9ZxAT4dCb2CiF0dRB9s6cmP/LId/jxJNi5VQDrd
         NjVUiWyNZHhQgUIH3ncvvgMHijgrvc1qBHwqf+I8IQip4dQnqUAuY6CP8qLAO8AbZCIx
         MZ6I5IkWFqLOLxpt1rsGPeqZBQGquBA8eyTl2gzTQoeNHA5iYHCRkyugMwCjSfkSybFB
         RssckhgYXhNcvjeqi4wQz6OGu1pabVgySO1l3Q4K3L1vAfVkbNSTHe89T/OdwlTkvaOu
         5B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269383; x=1689861383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu/aiaH31TZLMVI9Tp+a0lmhaF9umbZZEeQm47dZ8JI=;
        b=JB9dQCRXDFTOlg7lA5ZR/AUZ92MozrnygrrTLA7RWQJNhaqDK5t41r0PyYVt7rwedl
         Utj4Dm4izwJ35KL+SjGf7JaOgTe9CDvEEZ6itA6hfqVLsEhXeIDylsvcsA/dboPDNVk0
         FSPbirJFsoHuPpQzcn6g2g5BXDd6FQuVH/kKykr0jUTjEUfD5NWnFbIdD+P1Q1xje/tu
         QEyyrJDU7yLDyYc5a7pTfeCv3BlTMHVNONKuCeirGbx/T9A1FmS0Q/eaiifYk8o1UZMq
         Z8t8kFhS1Bog/dzbExgovQ5AYBwy09u+c0gRcx2XiaIdq5OI3v3lYdvyhe+2+o/NxeC6
         rTXw==
X-Gm-Message-State: AC+VfDyIduL82FbY/RLkDfWdxDVBAIDTIW3beIyUSdBUxD+TH+upUYHa
        VmqCXGkphc3G/U6tLqgd7fhKa2wLFQifcL+ZQ6Q=
X-Google-Smtp-Source: ACHHUZ76Quqktp3zHudolMcMsRYtqnxo/hI1u1UexkjnqkDAG0iaKT+k6idf61xtF/ADg/Dr9l3UsFl/R6wztd8sVOI=
X-Received: by 2002:a05:6808:6397:b0:39c:767e:bfc6 with SMTP id
 ec23-20020a056808639700b0039c767ebfc6mr11697031oib.10.1687269382925; Tue, 20
 Jun 2023 06:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com> <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
 <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com> <ZJGSqdDQPs0sRQTb@elver.google.com>
In-Reply-To: <ZJGSqdDQPs0sRQTb@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 15:56:10 +0200
Message-ID: <CA+fCnZdZ0=kKN6hE_OF7jV_r_FjTh3FZtkGHBD57ZfqCXStKHg@mail.gmail.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 1:51=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> > Ah, right. I did a quick google to check when I was writing the
> > response and found this: https://lwn.net/Articles/882963/. But looks
> > like that cover letter is wrong and the documentation is right. I
> > wonder what the point of the asymmetric mode is then.
>
> Maybe not as strong, but asymm mode makes sense from a microarch point
> of view, where writes are always committed into a store buffer, but
> reads can only commit when the data (incl. tag) is available.

Yeah, I get that it can be a bit better than async with a similar
slowdown, but there's little value in catching only reads from the
security standpoint.

> > So the current code that you have should work perfectly. The only
> > change I'd like to see is in the documentation.
>
> Something like this (or more?)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 7f37a46af574..3c58392d931e 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -135,6 +135,8 @@ disabling KASAN altogether or controlling its feature=
s:
>    fault occurs, the information is stored in hardware (in the TFSR_EL1
>    register for arm64). The kernel periodically checks the hardware and
>    only reports tag faults during these checks.
> +  Note that ``kasan.fault=3Dpanic_on_write`` results in panic for all
> +  asynchronously checked accesses.
>    Asymmetric mode: a bad access is detected synchronously on reads and
>    asynchronously on writes.

Could you move this to the section that describes the kasan.fault
flag? This seems more consistent.

Thanks!
