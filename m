Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BC6D9D80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbjDFQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjDFQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:25:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1803C22;
        Thu,  6 Apr 2023 09:25:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c12009c30so36436537b3.9;
        Thu, 06 Apr 2023 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680798319; x=1683390319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ABhLIEKILe7XTgIgQAZah/jshGbXdlYAiuCyxrHmZg=;
        b=pIRhLkgM5YW5LNV9EUvHam/4RiGnJ9NnJaq+dN9VZHwwY9WLanS0moz2Lz9gNKSmkk
         qNlSeKxduwRlsbBKRovd6QoArIIdSEpx0okoyDZjf/v+RaI7XfxeEFKTdPW06cfHhoSA
         8uVnOjxWFGYo0j/nibJx1AzRmxyUbCVVoh1XVul94lbN1eFK465h+JuOSDWPpohDSdNn
         yoZjT/bu/4V2HVzgU/tqpIOnudFvEvI5B74QpPi9M8jYF/VRiSZwC5yrfwIU8scvVJuI
         NuqCtNwKBxZNCaGUPe/myZJKbE+eAoMJIC5oLcZt8u84b2f1cCyHJrQF06tmysfGdOpD
         D1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680798319; x=1683390319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ABhLIEKILe7XTgIgQAZah/jshGbXdlYAiuCyxrHmZg=;
        b=RQDi6vwqsxAhw04zafgEdQFLknh3zK3Y4kNlkivdOWRuKqObyXEEh8Lv3CzA7vwIH5
         86k7Bcwqhr0kaZlQd9GUA6MU81yAGUFTadS7jY3mkisOHHVvDXnMNKEC0n6oxxPQ/tni
         IpKwdyrRMCHw9o2OL97y1K+tGEvCKNX25Q+wbyZ0N+YfuiHwENFFhcchakkIBg+Gksc/
         67GL1dxJNoftIK5BaIgHlheWSKkI878Hk+TOC0bMeep60yzBCSc1Tlh5lJkzmEcsh5MZ
         4vJ5cm4elvDjWdIpeO9YPFHDuQmPZzqP9bk7Y27Tv/Y7F05FncfoLxoBV0mGzKwFqCWj
         vp9g==
X-Gm-Message-State: AAQBX9f1w8ddG1J7Vqkv+3UlLXu3a5toGA4oXyxYDz5dW1yKkKdMebUW
        WBYhFYbHK7Bt0aad3HKjv6Q+HjN4q6JlQnfvvQY=
X-Google-Smtp-Source: AKy350avEOQwJl7ioQ83NrAtltKPSplgmEMbcsc0K/1cQFHGbGd45OXAD3JL1IkRRCwoDgtJ+w9iaZaSFLaQ83AyrVA=
X-Received: by 2002:a05:690c:714:b0:54c:88:64a1 with SMTP id
 bs20-20020a05690c071400b0054c008864a1mr2842085ywb.0.1680798318772; Thu, 06
 Apr 2023 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-3-wedsonaf@gmail.com>
 <2023040554-promoter-chevron-10b2@gregkh> <2023040509-tamer-clinic-c14c@gregkh>
 <20230405191826.GA365912@hirez.programming.kicks-ass.net> <ZC3YWLmIick4jSSv@wedsonaf-dev>
 <20230405202932.GG365912@hirez.programming.kicks-ass.net> <ZC3cxzpnrnXf/osU@wedsonaf-dev>
 <20230405204942.GH365912@hirez.programming.kicks-ass.net> <f9573e45c6a14644abc6fcd4d3c98897@AcuMS.aculab.com>
 <CANpmjNPrREVGC3Az0T7k_2yr1PJp+E4yURUGUnu9Jb_CShJNHw@mail.gmail.com>
In-Reply-To: <CANpmjNPrREVGC3Az0T7k_2yr1PJp+E4yURUGUnu9Jb_CShJNHw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 18:25:07 +0200
Message-ID: <CANiq72k0zkLO-zO=i_4Lu9P3tKo-dYDaJR--+KCP5jx=qL016Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] rust: lock: introduce `Mutex`
To:     Marco Elver <elver@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, Apr 6, 2023 at 1:22=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> For macro to inline function conversions, the most conservative option
> would be __always_inline. We've also seen things go wrong with
> "inline" only paired with various kinds of instrumentation.
>
> Can bindgen deal with "static __always_inline" functions?

If you mean the new feature where `bindgen` generates wrappers
automatically, it seems to handle them given `__always_inline` =3D>
`inline` which is what I imagine it looks for (I assume it does not
care about the actual attribute), though I haven't tried to use the
feature within the kernel yet.

Cheers,
Miguel
