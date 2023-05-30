Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5E7170FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjE3Wt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjE3WtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D1C19C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6ED62E3D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B243FC43445;
        Tue, 30 May 2023 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685486945;
        bh=0IuCc4ZXrqDomHpXWfXNUBxYgu4rnYtwWDypsa5wpHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ToGdzQYh7c7TbK+h9+ubtH9qr/elwlZQG/3NYRfX082sGoMBsCwx23XrscWImkWox
         0H3+IA1U/mz/QipP+b7iDaz+bjF8tvdVSOtqy4gO1r6QLVQDpGrcV95+DyHGp8KCR+
         g7FE4W91vlKlO4n59v/McfXuWiG71ZnV4kqdB0bDVHX4RU0JMtRJe2oJIejvFszrcB
         ysymo8H4CDRWrYY0H4O7bbz0PYQaJDwjz0LYpTwXLZLzBTubECx0b1qd1Go65KPzOe
         QFBWt4tMZACr6TZXIvGAEM4DUkfhTnMtrPIpk8hpsFb216y3P4eKfrcKowMz1HSAOQ
         5jGbba+laAHOQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f3a873476bso5674739e87.1;
        Tue, 30 May 2023 15:49:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDwpoJGOdxTZ8XA8vlVzBQfijEJ9VNCptQXUCE6jrejVCzNpDoaQ
        h134rD0dAKXwn7A6qMP0dlOnBbBfKIh1jgzQeQQ=
X-Google-Smtp-Source: ACHHUZ4bS0pN0vhbRQKYMialN1rGp+sHGugH3oihIijRD7zIcsyEyoMPZ5BwCJlvbUjzUrKdEXQxN6fKuKVldz1ZhpA=
X-Received: by 2002:ac2:46d8:0:b0:4ea:fabb:4db1 with SMTP id
 p24-20020ac246d8000000b004eafabb4db1mr1442400lfo.1.1685486943732; Tue, 30 May
 2023 15:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com> <ZHTuBdlhSI0mmQGE@moria.home.lan>
In-Reply-To: <ZHTuBdlhSI0mmQGE@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 15:48:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
Message-ID: <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:25=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > I don't think we are exposing architecture specific options to users.
> > Some layer need to handle arch specifics. If the new allocator is
> > built on top of module_alloc, module_alloc is handling that. If the new
> > allocator is to replace module_alloc, it needs to handle arch specifics=
.
>
> Ok, I went back and read more thoroughly, I got this part wrong. The
> actual interface is the mod_mem_type enum, not mod_alloc_params or
> vmalloc_params.
>
> So this was my main complaint, but this actually looks ok now.
>
> It would be better to have those structs in a .c file, not the header
> file - it looks like those are the public interface the way you have it.

Thanks for this suggestion. It makes a lot of sense. But I am not quite
sure how we can avoid putting it in the header yet. I will take a closer
look. OTOH, if we plan to use Mike's new allocator to replace vmalloc,
we probably don't need this part.

>
> > > The memory protection interface also needs to go, we've got a better
> > > interface to model after (text_poke(), although that code needs work
> > > too!). And the instruction fill features need a thorough justificatio=
n
> > > if they're to be included.
> >
> > I guess the first step to use text_poke() is to make it available on al=
l
> > archs? That doesn't seem easy to me.
>
> We just need a helper that either calls text_poke() or does the page
> permission dance in a single place.

AFAICT, we don't have a global text_poke() API yet. I can take a look
into it (if it makes sense).

>
> If we do the same thing for other mod_mem_types, we could potentially
> allow them to be shared on hugepages too.

Yeah, that's part of the goal to extend the scope from executable to all
types.

Thanks,
Song
