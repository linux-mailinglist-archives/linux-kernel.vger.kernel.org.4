Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD46B733EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFQGSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQGSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:18:10 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7890C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:18:09 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57001c0baddso17124057b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686982689; x=1689574689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM1SbdFY48xnS90YPMKPt/WpbhAPZNcjijkfIfyg0oY=;
        b=M54PqSnHl7F5+elaNhaomKWQ0HF3/Jic7ectrTo5YE5JWEme1GfptibwBMa6YSXvf3
         h0/+BXM7yq9NCA1HjuuVMW3pcJEWmJRinfgH/Qlf8nC3jBiDZHrVEod12cAjE4VUUA1M
         ffdSEXqiI8uFLC0fsKVcmcDUSWNEqpKBC6Rqevzr65PieFQDrAQXNo2XaaYoL/rSuU5j
         /gW+/nA9sMlbca9XEYSlwBSPhtwKOUm9qnw4yffz7pZVVSYIMAtSGyfZCe4VrPT1WqJd
         SfJlSfTab+3aDDGueDhMTLHLI3cs+euBuKVynDHL41uzLmr1zecuWpPjEAnG88mmKLIe
         Kjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686982689; x=1689574689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM1SbdFY48xnS90YPMKPt/WpbhAPZNcjijkfIfyg0oY=;
        b=DoPg76jdgzYfwKfhWJ1Oo74ziOCPkXaaDaj1Zd+Chb5S8PGjkXtSR6IZdZHC2tpChC
         KX0Cl6F7Q7XE7vA/hJB+Qi+oc/TlDiLf7jCoMqilmFfoRwyD+pqX/qsvpxDnau9ocdkT
         C8EN0vQqCmAGCch+kyoCSHTg6v+neEQwSoczbaf8U2HB8cBIPU0XvDoUVuS3B3iHigQg
         OvFuqe1M7UZ/bFjRUg3EVd7GqWfd1EUwpCe5eLk0yiydhNZAKTWyf4PWRwT+cscpc+BU
         lxlVQK2exnp95JAQZ1J4LZFvbUuohzXrxc010jTT/M71b0c4+yXSLfWyfyyYLbAURO08
         QUkA==
X-Gm-Message-State: AC+VfDz6T3hOVH7ZlYKEGb7AoD1RotAIo9kHBGgiPMge6HcpkIIZSCZn
        E8nF9jLftXKnpLvm+sU2tgGxfxyAqijjyqKyiOonPLBQDVLJqHGB
X-Google-Smtp-Source: ACHHUZ6H1W8PtwRoeRn4XP/WYLl2feYevT08f+dWsxeSsdox78IDsr/nTdMcp2E97nFOTyBFZQmqlgIgz9Sna42IVHQ=
X-Received: by 2002:a25:2e0c:0:b0:bc3:843a:953a with SMTP id
 u12-20020a252e0c000000b00bc3843a953amr1110079ybu.18.1686982689027; Fri, 16
 Jun 2023 23:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230617044036.3985524-1-zhiguangni01@gmail.com> <20230616224407.863c74a3dc9d4f1427802f91@linux-foundation.org>
In-Reply-To: <20230616224407.863c74a3dc9d4f1427802f91@linux-foundation.org>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sat, 17 Jun 2023 14:17:58 +0800
Message-ID: <CACZJ9cXM9VkJ5=euHphwM5TtX3aZqZ_QynOq10FtrqCxZfZsQA@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse:avoid null pointer access in memory_present()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 at 13:44, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>
> On Sat, 17 Jun 2023 14:40:36 +1000 Liam Ni <zhiguangni01@gmail.com> wrote=
:
>
> > __nr_to_section() may return a null pointer,
> > before accessing the member variable section_mem_map,
> > we should first determine whether it is a null pointer.
> >
> > ...
> >
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -258,7 +258,7 @@ static void __init memory_present(int nid, unsigned=
 long start, unsigned long en
> >               set_section_nid(section, nid);
> >
> >               ms =3D __nr_to_section(section);
> > -             if (!ms->section_mem_map) {
> > +             if (ms && !ms->section_mem_map) {
> >                       ms->section_mem_map =3D sparse_encode_early_nid(n=
id) |
> >                                                       SECTION_IS_ONLINE=
;
> >                       __section_mark_present(ms, section);
>
> I'm suspecting that if __nr_to_section() returns NULL here, we should
> just panic.  But a null-deref gives the same information, so why change
> things?

Do you mean if ms is a null pointer=EF=BC=8Cms->section_mem_map will cause
system panic,so we needn't change?

>
