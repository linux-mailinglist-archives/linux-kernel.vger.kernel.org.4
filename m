Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0565DE1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjADVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:13:38 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80541B9CB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:13:37 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-466c5fb1c39so481088877b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm/j0z462mdM8G/UYzJ5Uazs2w9/g+VBxs3TnQCWPbc=;
        b=FOhn/gMU6U3jv24+NuZ1TYiqoPJmc8rFD0nwOSD/TV6yICBfuwk7ApX28XT6c3UX6U
         Boq6xVaC8XWn2+Eeej8pEGEv/jdBsoRD/jPMyg/BemURBBn6BiImgjv6+oXdjr9h8T9C
         LaQg/omj0fFdX5wlX6negdcjIfgD8WteEcyJiJwmLdx24hTgA+13/S1NWBdNGxmbxDg2
         dtO9ZRuQ8+s4zW4E5HW68dWIab8NLQpL+avDRUkGX5nhoO0wg+cciuU9a0H38n/ghPNM
         r0AJd58dYmYn4zlGD8Rxt1OXQMU1G6PnOMW3InGJNhSZYUyzeIYA7i8iyxQ3Pwmb3QWM
         3A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm/j0z462mdM8G/UYzJ5Uazs2w9/g+VBxs3TnQCWPbc=;
        b=A+XKwvTfrnLKRyWg5002RZRUVN0u5aMnJMwkR6xpKZQK4S8XzL5UVWqxIScQe9FXbr
         CMHTM/fA4C/hbdD3n+1OkCCkPBu7VYGnqwYKt7dWThN4TAfRbid/UBYMq7f090rUcd1D
         7baz3Z1rlJxgr6jJfdyFwaXpzOsih2h9CFNrX0M2FZ6UyLA2m9CeMK1mwxkEqcxAIVw2
         TE3qmC25Qf+hRhLWxwzMxUpY59G2d3cKKKk1YUVrJVdwv9R3VSWxLy3x4S7RG5kX2Wfs
         RxV5tdbfPCxgjkJqu3UWtNRVhqH0NVAgUxZLnNohCzkjZoN2HfIpbw3keaRfiZbKGrc1
         BLkQ==
X-Gm-Message-State: AFqh2koDBs7vEgqzW+KZ2kVw+wXpi17rzXQDeSzZbUgQZRGvRvYEssTk
        EnxBYA4fUEEo/vWMZt57Flkc+2+PMS9aPzB/9sl2VDkQzq4=
X-Google-Smtp-Source: AMrXdXuzUscg3toIJ/GWjXTw3UiHmASA3k4gv23QHRgPogVR9QFJJtq9XL8I8RHf+Y1hzh3UDMk98Jw3P52HzkCkTCs=
X-Received: by 2002:a81:4817:0:b0:42c:cb4d:187 with SMTP id
 v23-20020a814817000000b0042ccb4d0187mr5534691ywa.78.1672866816816; Wed, 04
 Jan 2023 13:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20230104095049.59043-1-ppbuk5246@gmail.com> <Y7VT4gvLCQK7B1Ak@kernel.org>
 <CAM7-yPQakk1bwON8abPm6CpYGNy=MxAjoYXfWYQExY08hFkC9g@mail.gmail.com> <Y7VY66+BNvCF26dG@kernel.org>
In-Reply-To: <Y7VY66+BNvCF26dG@kernel.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 5 Jan 2023 06:13:26 +0900
Message-ID: <CAM7-yPSjzP3_w=wXiRB-zDbeqxAZD+0x1jKkwiKeXgdNbgZshA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] memblock: Fix return sizeless candidate on __memblock_find_range_top_down.
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've got possessed by something... Sorry to make noise again :) Thanks!

On Wed, Jan 4, 2023 at 7:46 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 07:33:25PM +0900, Yun Levi wrote:
> > > Did you see an actual issue or it's solely based on code inspection?
> >
> > Based on code inspection. I haven't seen the actual issue yet :)
>
> I don't see a problem there. Do you have an example how this could happen?
>
> > Thanks.
> >
> > --
> > Sincerely,
> > Levi.
>
> --
> Sincerely yours,
> Mike.
