Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A356F810E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjEEKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:53:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822C18DEF;
        Fri,  5 May 2023 03:53:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so13274126276.0;
        Fri, 05 May 2023 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683284032; x=1685876032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgaBKeEIlxAuYAP7cdMu1VdHHIFJCXTzQ7O6ZwAYCqE=;
        b=s3pJv8phz4dcw/96mqO39Pu3tK+YbrwOtXJVou33ycR8vmYxCXLQC/YEJvQ9zA3kMt
         Ekg9Nut3sqVhf3wQLuaeewXuP8M5PXc6cOjYB77jqgS0K27wq70pD5Nss5Lf69SZmEd/
         HvHhjiU2TUv5M6r1dsUc/I08StmvCi74BoNwzxW1fQ8u5XvQ0vDBG21zfooscBMGU7au
         CfPCMsAUGAXuj3oX/cCCRTBzxMLg6TJwpr03asJ33tyRsVwCE4MdqS85wGZXc8fdh3MN
         vtQU5Eq8nh5YAq+wpHIk5TygGi/ep7R+y9Hm41l29oqNeLbtNA7ls41OYud0S+FmuCuz
         488w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683284032; x=1685876032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgaBKeEIlxAuYAP7cdMu1VdHHIFJCXTzQ7O6ZwAYCqE=;
        b=KmJtspgCotmlIahDryS4fjvHSKmA2nijQnf4E/PQZKQwaeycRBLGWvVJQaOBkgdSAJ
         4nnyQl067Y0+83AEQUQMz7abOU35iGhN62FVnI0JHY9NVkqekRpMq2ZE1mWUkCJHq2p1
         o0h5yewplBLU4J54n+tSIMqiqYCaDqqDVl+/aNYSdopYXj2maRkZnkPAbke2OvBL/UOK
         Ew3pLAr6VYyEJa6UpjUV9xlOFvYdAsXH76MprB86rtJunkHsXCBnE7qNEoG2h1JByb43
         JWNMiOhuwSmu4sD7l3HJ3nYNF754tI/PLL3mRrl0hfjJaelfaDFWaptDUa5mghjqr0tw
         Hq4w==
X-Gm-Message-State: AC+VfDxSgGfLD81Dmxpkdip/Sej0S6q8DKqXP6nMKFYYIY/sraSKRvFT
        P1ToBe539Ku1p37xqG7exS3cqpstxu8lytOg3v8=
X-Google-Smtp-Source: ACHHUZ7hJdO+nwsRv/rDJf2nGSyHPLvHPOluSAFe/tzWxJV9t4hvlk4iI83oot0NAp+ExTHfErnivZj0KMddbnmc/E0=
X-Received: by 2002:a05:6902:729:b0:b9e:6c09:2d96 with SMTP id
 l9-20020a056902072900b00b9e6c092d96mr1409374ybt.12.1683284032199; Fri, 05 May
 2023 03:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230503090708.2524310-1-nmi@metaspace.dk> <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk> <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com> <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com> <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
In-Reply-To: <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 May 2023 12:53:41 +0200
Message-ID: <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:22=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Right, but that doesn't really solve the problem when the rust bindings
> get in the way of changes that you are currently making. Or if you break
> them inadvertently. I do see benefits to that approach, but it's no
> panacea.
>
> This seems to assume that time is plentiful and we can just add more to
> our plate, which isn't always true. While I'd love to do more rust and
> get more familiar with it, the time still has to be there for that. I'm
> actually typing this on a laptop with a rust gpu driver :-)
>
> And this isn't just on me, there are other regular contributors and
> reviewers that would need to be onboard with this.

Indeed -- I didn't mean to imply it wouldn't be time consuming, only
that it might be an alternative approach compared to having existing
maintainers do it. Of course, it depends on the dynamics of the
subsystem, how busy the subsystem is, whether there is good rapport,
etc.

> Each case is different though, different people and different schedules
> and priorities. So while the above is promising, it's also just
> annecdotal and doesn't necessarily apply to our case.

Definitely, in the end subsystems know best if there is enough time
available (from everybody) to pull it off. I only meant to say that
the security angle is not the only benefit.

For instance, like you said, the error handling, plus a bunch more
that people usually enjoy: stricter typing, more information on
signatures, sum types, pattern matching, privacy, closures, generics,
etc.

Cheers,
Miguel
