Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4884705D18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjEQCW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjEQCW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:22:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E055A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33828a86ee2so44285ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684290118; x=1686882118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z64Nmm8ZHGuJuP2MvW1StM+AVoYaW6xT6Xus5TrlYVk=;
        b=PZR0hZsHzkBi3CoxSkPt74A7CGO/edZ4y0cnAb7WVsOL7+pfEDk3SS0q+cnlrnvU+9
         uKiVLaSIqbGstl1AGxVsHccUdpf/xSVql5HNM60g/2vwJCh7FIhVcmOfOlx8Jz8HF23S
         CiXwOrQSjBF//UIaLRBYynwBwp3YK2KPBTsEmBcUbxHu+WkMk7Z16W2B/BINIAoBvhlu
         XdaLsSRo88KP5yIe3VIm5Jhkj1qQwVsj2ok+g23ND/01PVF+5mgWhpzDQ4sxL+3UeCpL
         skabb4lN/S3DY21Xm5bdh3tkUeQcSTMpjKUoR0gZoRFVJwKjoKf5uvim2dlD5N4Am4xN
         0i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290118; x=1686882118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z64Nmm8ZHGuJuP2MvW1StM+AVoYaW6xT6Xus5TrlYVk=;
        b=JnfGefmy0YR1PZmz38oFNDiRy1NMlhRLGT9uUnrj7mq7btna721lwXOa+O+zYLoyaa
         KL+CC5gNGZbPNTsAWZofwwHyVadUEfBY0T7xsYVUlpG6aDtOuzEW3YYc0vnr3FIZRvAZ
         G7aJ+fXK+1/L2imUPaRhIuYWYU6gqe+zNi1YihbJ/c9PcmUS4BcaIGt4NA+w/kbbiZTw
         I8f5aBd8hnFfvXLmgKZfBeeTAHlnNuIB3q/9l8hnGKCkvn2DsnMXVdH21aSq8d/l6WCC
         u0h1a+GLdzXWxC6cQWecuGDNe6of5HzBHmSLT7IQS6JTQoVv06p6UiiDFM1KsFSmJPOW
         T+pA==
X-Gm-Message-State: AC+VfDxOvhkmvQmvRVYozJE4OlVFk6XAM4mPVN/IrXIFjguScZO3QypM
        gi8U0W2FhpnZjtxj7r8k3CzJ54TeS4feNxbp5rd+PQ==
X-Google-Smtp-Source: ACHHUZ6Uoh+94jIebPJhEOywS9dWVDJxg9T9vl9rKgwdHyKTCL9YouPA+xGYsdIVC1eilcQdTz6QrcYRIiVhAhVJ0Cg=
X-Received: by 2002:a05:6e02:2169:b0:32b:7232:dac6 with SMTP id
 s9-20020a056e02216900b0032b7232dac6mr182448ilv.18.1684290117851; Tue, 16 May
 2023 19:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230516023514.2643054-1-pcc@google.com> <20230516023514.2643054-2-pcc@google.com>
 <342d76b0-a94f-902a-c701-04a1e477b748@redhat.com>
In-Reply-To: <342d76b0-a94f-902a-c701-04a1e477b748@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 16 May 2023 19:21:46 -0700
Message-ID: <CAMn1gO7BZ0C6VfE39+_QT+oOWWZ86M0BGEQPu=6Y8+ij1jAUCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Call arch_swap_restore() from do_swap_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:49=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.05.23 04:35, Peter Collingbourne wrote:
> > Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") move=
d
> > the call to swap_free() before the call to set_pte_at(), which meant th=
at
> > the MTE tags could end up being freed before set_pte_at() had a chance
> > to restore them. Fix it by adding a call to the arch_swap_restore() hoo=
k
> > before the call to swap_free().
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b=
8c61020c510678965
> > Cc: <stable@vger.kernel.org> # 6.1
> > Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> > Reported-by: Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=B4=B4) <Qun-wei.Lin@med=
iatek.com>
> > Link: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d=
434.camel@mediatek.com/
> > ---
> > v2:
> > - Call arch_swap_restore() directly instead of via arch_do_swap_page()
> >
> >   mm/memory.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 01a23ad48a04..a2d9e6952d31 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3914,6 +3914,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               }
> >       }
> >
> > +     /*
> > +      * Some architectures may have to restore extra metadata to the p=
age
> > +      * when reading from swap. This metadata may be indexed by swap e=
ntry
> > +      * so this must be called before swap_free().
> > +      */
> > +     arch_swap_restore(entry, folio);
> > +
> >       /*
> >        * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >        * We're already holding a reference on the page but haven't mapp=
ed it
>
> Looks much better to me, thanks :)
>
> ... staring at unuse_pte(), I suspect it also doesn't take care of MTE
> tags and needs fixing?

Nice catch, I've fixed it in v3.

I don't think there are any other cases like this. I looked for code
that decrements the MM_SWAPENTS counter and we're already covering all
of them.

Peter
