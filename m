Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59399686613
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBAMjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:39:18 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C2CC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:39:17 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-501c3a414acso244067927b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9SOySbmS0Qu5aNxxomWwuDHN5fw98pINHsIoz0E65M=;
        b=Xm8IDE6xGlICK6pCDLTH1BYezg2m3vHDH3GWEtjzilEf4S8g6nW7e4KHnwrGzExYvk
         r0HWltfzMTrq7xrOKXlr2o2nqf1uyZFoYpNwkWoozAk/AmIa2qIxExmvuokPvCrdPP51
         L31Qc7w7VKNt1+1cyeji2LyT6rHU7tsRHUgyXxiD9/aPZ0gcVPVEh4/fy8H5RmVH1iIE
         Bjs4EzADrdJ0YcHkUPy+6jfPA0+GdTem64kn5rMzLm7Wz40WCQMDy+L0T3YOzSki49qM
         Rsp4i3h7hidbebLppnLRWzCUMEiQfYddswZypm2eTf+iRzgC2m7iaBO0u+9i/GHv0UDo
         KXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9SOySbmS0Qu5aNxxomWwuDHN5fw98pINHsIoz0E65M=;
        b=bw9krz/GGg734+aCDzSLgaPCY6IF4e2/m3ygnE+lgOcRnopaqizs4cak3IDJondKVh
         DurSB9Qvf53O9rKoxwn5HMGnzKyQcKOkAg6qVYDYw6GVToYa61bmIv9A51KloHljVYIt
         0rp8nFrNsPg9fCrFBvwcoz/Xwb5S3M7TOq6YIcY0EoUqOf+9n2ibrR0nr8QR96ENyvLa
         erGTRDH6OH/uwJKiAVmCq93eWOJiMhaHVIB3hhLaSh+lGVR4mqySBX1KY2qDK6wp6D1w
         jo7UVnNYhcnuam3khv/wTzhs01ZGQnlwBLqndmn9eUzrTuxstxUDIjOnnPw+fyBwGEcU
         mfjQ==
X-Gm-Message-State: AO0yUKXpNbu8RCLkhTN6zZkS43aXyeWkQKtx2OJGMS70zYBICluzfFuD
        h09g4NYp/eOkKy0dtVvrfVcU49ZrHKXr3AV91nwXoA==
X-Google-Smtp-Source: AK7set8zxc4D3iz25SvqBAE+y1UUbHjrFQJ7RyKAPdba3B+Svi09uuC7dLhYMHj1INUaPy8cHUXAH+rP13dUdko52zA=
X-Received: by 2002:a81:fe02:0:b0:506:369c:69c1 with SMTP id
 j2-20020a81fe02000000b00506369c69c1mr283708ywn.192.1675255156688; Wed, 01 Feb
 2023 04:39:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
 <CAG_fn=WxZf_kfn8-G8hvoxvUT8-NKNkXuP5Tg2bZp=zzMXOByw@mail.gmail.com> <CA+fCnZdOFOUF6FEPkg2aU46rKYz8L9UAos4sRhcvfXKi26_MUw@mail.gmail.com>
In-Reply-To: <CA+fCnZdOFOUF6FEPkg2aU46rKYz8L9UAos4sRhcvfXKi26_MUw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Feb 2023 13:38:40 +0100
Message-ID: <CANpmjNNgoHdmZEmnOMzBTXZ_Px=fipg-iSk3Hv1fE7MO7+fovg@mail.gmail.com>
Subject: Re: [PATCH 11/18] lib/stackdepot: rename slab variables
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        andrey.konovalov@linux.dev, Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 20:06, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 12:59 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Give better names to slab-related global variables: change "depot_"
> > > prefix to "slab_" to point out that these variables are related to
> > > stack depot slabs.
> >
> > I started asking myself if the word "slab" is applicable here at all.
> > The concept of preallocating big chunks of memory to amortize the
> > costs belongs to the original slab allocator, but "slab" has a special
> > meaning in Linux, and we might be confusing people by using it in a
> > different sense.
> > What do you think?
>
> Yes, I agree that using this word is a bit confusing.
>
> Not sure what be a good alternative though. "Region", "block",
> "collection", and "chunk" come to mind, but they don't reflect the
> purpose/usage of these allocations as good as "slab". Although it's
> possible that my perception as affected by overly frequently looking
> at the slab allocator internals :)
>
> Do you have a suggestion of a better word?

I'd vote for "pool" and "chunk(s)" (within that pool).
