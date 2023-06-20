Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F13736B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjFTLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjFTLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:45:45 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC56198B;
        Tue, 20 Jun 2023 04:45:36 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55b3a245359so3096313eaf.2;
        Tue, 20 Jun 2023 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687261536; x=1689853536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJCMKaRS9iIUjy75SMVgQ9VDcAREfFkBluEAU4z9ags=;
        b=JafGBlk8XfHKEBCbR5tqF5YOtAo+NrGzEussgveHGWOlu8GHvnJB64cbGERaeyJGO3
         m9yZ5SotMdegV+GuJJ89oQXjiQLb4KVJHDnoaskf4Cpsm4vW7HsDeFhgzZaL6ttHTaMK
         1DPNgnwedQN+wGECrc3w75vbDa37J4OmNHdwRclNP+ZTxYCY//GBZ8BUKse5bA9fhH7Y
         F3xjOPm2JdBCfgaoYhv1CMhTAEcGrA/zM25EIjnGGCSrqxyvkxOc3Rmw6UIewS+moM48
         D/lZWaQ7ulPMq3zBD6WbFN4k33uOlSyAH+Cyd3Y5YaZ395q6VVXIQ9TNeNiLt2IgjBqt
         BoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261536; x=1689853536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJCMKaRS9iIUjy75SMVgQ9VDcAREfFkBluEAU4z9ags=;
        b=aNafFtjnjJESOCl0xmA/c4L97Dne12gkCll6wwM/XfpnooksIfmsBPHMKkDGL3DmAM
         nDEukj4KNMhD7tteAwzGDMQlDPnU0mODdSfZd4V65UxXVhTgk7RnbAVeyPJ9i07wx28c
         F4qBGPYdbjwva26znaqNzYKBrE/+FkvV5/O8/jdnBqv+BDODEpqkfO7/5rT7VHnZATfU
         2pX7lLRtDadYUjz6SMechNjrea3S1KnkKPfQkbkIPWBJaEURvFPJXblfhG9LODVgrZqV
         JrWMW6IhzoBmQnFc5Hb6b/sbM1YU/P9alKNFoSAwgjSlu9/uZbc/vWhslEZuoSUm28Ms
         bytQ==
X-Gm-Message-State: AC+VfDxH4j52uFzd/3IYLidIVYpsq/udEm4hi2ZmkVkeJ1GbWhR4WQBe
        MpLk8HuRnLblyCR/4u1RzDKOZg3WUHdR3pf8nAQ=
X-Google-Smtp-Source: ACHHUZ54uF7mepaUweD5UBJo2z3ZyfBJ1SnIHZ/Wn3QYsgoqkmZdln9JMYd8qBzKPB6APDZFn1NEazVjfaI7UfPLMlY=
X-Received: by 2002:a05:6808:2110:b0:39e:ce9d:1a92 with SMTP id
 r16-20020a056808211000b0039ece9d1a92mr7992873oiw.4.1687261536152; Tue, 20 Jun
 2023 04:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com> <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
In-Reply-To: <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 13:45:25 +0200
Message-ID: <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
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

On Tue, Jun 20, 2023 at 1:33=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> > On a related note, it looks like we have a typo in KASAN
> > documentation: it states that asymm mode detects reads synchronously,
> > and writes - asynchronously. Should be the reverse.
>
> This says the documentation is correct, and it's actually called for
> writes: https://docs.kernel.org/arm64/memory-tagging-extension.html#tag-c=
heck-faults
>
> Who is right?

Ah, right. I did a quick google to check when I was writing the
response and found this: https://lwn.net/Articles/882963/. But looks
like that cover letter is wrong and the documentation is right. I
wonder what the point of the asymmetric mode is then.

So the current code that you have should work perfectly. The only
change I'd like to see is in the documentation.

Thanks!
