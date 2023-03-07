Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC56AF649
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjCGT7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCGT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:59:02 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B824493;
        Tue,  7 Mar 2023 11:55:39 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k23so12555885ybk.13;
        Tue, 07 Mar 2023 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678218938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0IZLqmZy0tkE3D6dehIaOZJMQhJ6wIO1l7RgkyXBKU=;
        b=P1sOOl+jOSGV2KvhWDTm43KAlEkQoK1UU4EX0jCulOuurJF0V1C7CQ02KMaGUqTw9X
         QZKqqhQXAIeC9WFvTnpXfeJVdEDypFi1ohEtENR9FUFx1uQLLf6fmHpydoUTAfAY4ho+
         Kri4JCyuykgvVY0sp3gqvrf1lKz/Vlp16qkwU2/n9IDp0gqun48Bsir6i6iW3xa+nRUo
         EfpjSr7lZlWuyRRp1tvBgpfyoGfBFgYKhA1HCd4eDaZBUtR0H+U/DTkQpmSikp35L3i1
         KTLziDNysQ6CLpKJHuAfc1hVcxXQIuUodvQ6BuDM3pxJ35VK0gIAUAbhWn+9OPqwmABW
         TyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0IZLqmZy0tkE3D6dehIaOZJMQhJ6wIO1l7RgkyXBKU=;
        b=XbLh1k92vvcYqn2EEN71PPVfsySCpUmZ3v3HrAlHrJh/nE9ETktZ5HbpMIHZbAvZU8
         lpD1vaTuDERUfyOSZZ0iDhOqjlcj05KED46de2V05Fn/zGvN+eLwYAFpmLtw1uixsYpO
         zsX2kkZARV5LmpOT79zT06XRrcfuwlkdgo3eW6zgn5XEuJBRsWQSG4qcl3tpkobAkb+b
         +IvSpbuE6IRb6/vQXkOat/Ao40zV+bEvm2qNupTYrqasauf8BxX7cfZPHIPqIuGmlGtA
         +BHuW0MkoYLgaiykJRSW7Akp+QIU1JPocWDUu6T9oLdoEe951BKVeIJhwkZ6Kddnq4ot
         C5Dw==
X-Gm-Message-State: AO0yUKWgtP9Q5rEx5KPjw0Dhk9ce2udNiu7XMi4FFntui2ksF22m6mty
        FkC9mi8PwWnaxposekb4ct8sVxMX47HNPZEutow=
X-Google-Smtp-Source: AK7set9q7Fr5lAcQ+rUn/aXjIXW/u94G5SLO1K/+kqdRhPEJFxECPOa51JwvvrUobgAJvlH9+sSBCHaRLK4iCfY53Yg=
X-Received: by 2002:a05:6902:4c2:b0:a36:3875:564a with SMTP id
 v2-20020a05690204c200b00a363875564amr9258448ybs.2.1678218938404; Tue, 07 Mar
 2023 11:55:38 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
 <20230121052507.885734-1-varmavinaym@gmail.com> <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
 <ZAdYIMYAwsOwErIl@nvrarch>
In-Reply-To: <ZAdYIMYAwsOwErIl@nvrarch>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 20:55:27 +0100
Message-ID: <CANiq72=mg3LEdqaiy+4VDn67-C++Fyz21gefns_EvgUwGfPCTQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, alicef@alicef.me,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Tue, Mar 7, 2023 at 4:28=E2=80=AFPM Vinay Varma <varmavinaym@gmail.com> =
wrote:
>
> Sorry, got caught up with another project and lost track of this thread.
> I have updated the patch and replied to some of the threads inline.

No problem -- thanks!

Note that we may need a rebase after
https://lore.kernel.org/rust-for-linux/20230307120736.75492-1-nmi@metaspace=
.dk/
(or equivalent) lands in `rust-fixes`. So perhaps wait for that, then
rebase (especially if we go with the EAFP style), and then others may
want to give it a spin for a re-test.

When you rebase, please consider putting `f"{name}.o"` inside the
function to avoid repetition, and perhaps consider inverting the
condition to avoid indenting the file further (and reducing the diff).
It makes the "Skip ..." comment more understandable (otherwise, you
may want to change the comment to "Only process ..." or similar
instead of using "Skip ...").

Cheers,
Miguel
