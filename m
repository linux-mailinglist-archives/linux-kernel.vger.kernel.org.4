Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D936BC342
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCPBWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPBWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:22:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2E7303D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:22:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so1587426edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678929749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk5MnEj+9VdMq2koFjsXyLeZ+RHukG9plsb5KVbpDTg=;
        b=e+7tQkAQ2uUODrnzOrY6Ips2/7+bIYTNXPx6aMCM1eR1GeiKx/tKzSh8Bj6I/MP34k
         Wz+8TJHIWu6R7JemAB2R7ittFu5xBMal/raUmVrxB8V40iec+dAftGd4BiapoOM3cNqY
         sj7Vtek0LI/yMFB25r27MSF95TKaooXqBfATR8GA6piJKchdGM4iUPDzNmO/gtfVHkYs
         TLb5/5fyNFuEyBkJ8NsUOoBvAly/fmbPFDy1rx1jwNcmKj/JJ9nA/ZRdB5YJe//ifn8b
         50W3XrmHTzRIzDBswedqRHtP+tTb0NnE+sDpGD/hIf43HLKvZrEwLJDn8enB/mgzNArw
         aueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk5MnEj+9VdMq2koFjsXyLeZ+RHukG9plsb5KVbpDTg=;
        b=IuNbCz+bD9i1GRIToTUhoeHVabM+L0W+coZ2jP1xybr2LLzHdKkug9QB5x8GS1a1uP
         8weIfTAQvh8UGAMy8ttrJh3dMdDwLVVrrCkF4EOnGklmPukU/fTLdRZxLYQc+AQLOpne
         TJVe3NsVBIvpavmoSGvYnWUGMNjQEf85nBPR7vUS5NomulwQaOznXmW5gSLrVgQnNOMk
         whAik79kaJs9Jo5a6qnHb7uFyIEeJeZJXzxyUmIQCTe/g3u7tp9aXVVIdl/nwhDG/rMi
         Qw7GRHbVwzBtpVvGEjc7hclRtM/f+MHTrUPyGvLfPDvCnCpOBvg/ayfHEL+7QyNbjirj
         FGjw==
X-Gm-Message-State: AO0yUKXZ96qR06vUBuaFIJ1UGfRhTr2p296rYXj29dpAeKLECtrru5GQ
        OAu9sXbqQR0pfa1j5d/8t5yXNqNP0tBZAYZkedInTA==
X-Google-Smtp-Source: AK7set9vUQWlnYib29M7GxGUMKP+4/l9rWjXcSKXwSBOGUAVjRwK82k8x0u1IBJKP1XHqNoKznFC4u6JpgMJWUT0U4U=
X-Received: by 2002:a50:8a9a:0:b0:4fa:3c0b:741 with SMTP id
 j26-20020a508a9a000000b004fa3c0b0741mr2496372edj.4.1678929749501; Wed, 15 Mar
 2023 18:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190600.324573-1-joe@isovalent.com> <ZBB8vZ8EJRv2d7mD@mail.gmail.com>
In-Reply-To: <ZBB8vZ8EJRv2d7mD@mail.gmail.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Wed, 15 Mar 2023 18:22:18 -0700
Message-ID: <CADa=RywQPwBib1MKs3+TFK4K6yh8sd2UkERkU5bzHZ9VS77hyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 6:55=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> On Sun, Mar 12, 2023 at 12:05:59PM -0700, Joe Stringer wrote:

<snip>

> I believe there are some inaccuracies, though. As far as I see it,
> local_freelist_check corresponds to __local_list_pop_free in the common
> LRU case, specifically, to checking its return value; use_local_node
> corresponds to returning that value; and common_lru_check corresponds
> to bpf_lru_pop_free (for both common and percpu LRU, that's where the
> distinction is made).

Ah yes, thanks for the pointers, will fix up. I started with reviewing
the shared case since I was primarily interested in the behaviour
there, then I added the other cases later. Adding the function names
was one of the later ideas but it's difficult to get accurate.

> > +  local_freelist_check [shape=3Ddiamond,fillcolor=3D1,
> > +    label=3D"Local freelist\nnode available?"];
> > +  // The following corresponds to __local_list_pop_free() for common L=
RU case.
> > +  use_local_node [shape=3Drectangle,
> > +    label=3D"Use node owned\nby this CPU"]
> > +
> > +  common_lru_check [shape=3Ddiamond,
> > +    label=3D"Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];
>
> Nit: the exact flag name is BPF_F_NO_COMMON_LRU.

Will fix.

> Thanks again for this patch, this piece of documentation really helped
> me understand internals of the LRU hashmap.

Glad to hear, thanks for the feedback on the patch!
