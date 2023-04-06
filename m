Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A816D9DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbjDFQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbjDFQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:56 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13BAD3B;
        Thu,  6 Apr 2023 09:45:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5416698e889so750709047b3.2;
        Thu, 06 Apr 2023 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680799548; x=1683391548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmugR8UydKlN1EfOvXZm8xFLk3c1OYMqijmmbQYMjGs=;
        b=gZxB16wz4albJQFaXi82iiF+GwHSiYJWzf5MBgrcCKrceZXuK+JnXGmlmze4vvN4xT
         lbdIe8qB/kWGO33KhQEkF5zVEXuVIE4zDdnSZ5Q1/6UIOL4UTPHBJlkqvuCYpr4sPGn4
         JP9rUb64aLAmPdYnBcXOFgKQNzoDiJAlfXBCqvbmaqVPN8uqLwcpjvIwxwr7x0rdqmQs
         pmaXkavhxDD0bopegmRojh0UKCSV6r86dwsMkZup6d94XcDMbKWQ5nxU6bfRpG+O2cAV
         N3KE94r5tYFs7jMvLFDO2hJPaIp2mXwzr20TzsasO2TRah4xc6Pxp7NHftlGe1K4hUYI
         3Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799548; x=1683391548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmugR8UydKlN1EfOvXZm8xFLk3c1OYMqijmmbQYMjGs=;
        b=DU270dzntIiWrg4C0mfoeD2DgvBgPpAd5wuBNxFIephY56F5c8UjkIKrrpwtfNydJM
         O6VKhAuzF39Z8sqcu9FWZZOCDhVcL8tj+jMQghNGAMsqIjx1J7zt/yt3dFbvOTXR9IO0
         zzPSEYDUgzgqTgMTQjB4JU9h8EY68q9284HzG+4Fp07Z1iQ0liHbXgNPaREnYYF2FXwt
         CBgKwVMuM3ZNd95XDEdK7vEz/imqn5ld8/HWelLBToaJ/ujpL8m9p2q6fxOkEiYdaPb2
         4xz7W7b9enbvxWx51ZCnAMmEY15e2JLrw9Tb5sL+tubAYsjE/Fn6F1h2pxXDRNc2sF8l
         S6Lw==
X-Gm-Message-State: AAQBX9eXfX2ILVPird6wTpZid90i6mhTYav7xJKTYOGaUBcPh+JMs3Os
        50TtWf0KepdGqiZPGNW9+J7RLNxW9DP3+36rmSs=
X-Google-Smtp-Source: AKy350Z4ayQwbwbWw/AJF2y0mjBR7MS5epXewMLKnhMdSjRFM3ynjJ6ju7riOLSg/z7Thld2e7OWf1+gSTt3zonpoPA=
X-Received: by 2002:a81:b245:0:b0:533:8f19:4576 with SMTP id
 q66-20020a81b245000000b005338f194576mr6347514ywh.0.1680799547701; Thu, 06 Apr
 2023 09:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-3-wedsonaf@gmail.com>
 <2023040554-promoter-chevron-10b2@gregkh> <2023040509-tamer-clinic-c14c@gregkh>
 <20230405191826.GA365912@hirez.programming.kicks-ass.net> <ZC3YWLmIick4jSSv@wedsonaf-dev>
 <20230405202932.GG365912@hirez.programming.kicks-ass.net> <ZC3cxzpnrnXf/osU@wedsonaf-dev>
 <20230405204942.GH365912@hirez.programming.kicks-ass.net>
In-Reply-To: <20230405204942.GH365912@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 18:45:36 +0200
Message-ID: <CANiq72nhWy5V=bE+39jFvV20+2v-xp+4iYmG=qTt+=GgF6Z3hA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] rust: lock: introduce `Mutex`
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 10:49=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Oh man, that's sad, I was hoping it would write the equivalent inline
> function in rust.

Some of us hope Rust would directly handle importing C headers, so
avoiding the intermediate step, like a few languages support.

> But yeah, feel free to convert macros to inline functions where the
> difference is moot. There is indeed no real reason for mutex_lock() to
> not be an inline function in that case.

We initially minimized changes on the C side on purpose, but if
maintainers are OK with that (modulo exceptions), it would be great.

Cheers,
Miguel
