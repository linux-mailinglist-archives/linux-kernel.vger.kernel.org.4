Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB273FA53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjF0KjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0KjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:39:04 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCCE5F;
        Tue, 27 Jun 2023 03:39:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a0423ea749so3545687b6e.0;
        Tue, 27 Jun 2023 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687862341; x=1690454341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCgvLgi3BLx22tE+6LcdRjHHTXAUCqzO3DhXE5/At3c=;
        b=j4V/TgPYZOOMjOgLDAi/Fq1Y8RqRGFE7b4qGJRTHhPIZyNGDGr5yqNQrewztFtf4+H
         ad9pajr2f7m4EQWCIIZ7UZtZio4GJYgTjDdtTPHRGE4J1sMKSakHqDbNf898iQmg84X0
         oZdd9dQqPDhhXjPDGdGXik6nfCbkAaHgghtffDg3ccxxkGJQf524luAiz9KkLkiLd579
         lMYpgQWhUnJhY6/kXmGgYvSBMyPZsdHMrkRhn0njqEixyf3AQPrdjzrW8+zSLjuVEOu1
         FIRpBegrkGSWtArlAliOUuhNUyJLd7Q/kZI1AwHQBoLKNwl9o8TL/uhfCE7FAt29AuY3
         GNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687862341; x=1690454341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCgvLgi3BLx22tE+6LcdRjHHTXAUCqzO3DhXE5/At3c=;
        b=T9JErj7YzEUXHieuFPmwfDGAPn8ndARjFsyv9aRwv+Dioxud26OV/dw12J+96r+ABc
         l06EWfB5TeldSJX6FH3OZ5KyBhJ3+3te9JSu7mA9bP/5GP3Sp1BnL2bHO9DUDI8N/Dni
         DAnMw6vFmjKcqJCVHMmQPiUtDIrid8jCS9fVB5Eyjp96zThZcg2zZYLwfdhq9+KuNgqC
         4olIgUK4fsAtKjeLn8mePAlYM2la8/zBOY07Vn3JmDavIN/Zuu7dsEx4R9n5m6AN7FIU
         uW7ls5n6z2F8UIDCeZIL/1yiTqUJJIsBnyGxM3ev++LXhmgMp/AOfHPwk/CXaNdjzpem
         tP4A==
X-Gm-Message-State: AC+VfDzLSnSmwYBxniSlMWtc+4p8XA6fJYUX5m9LgUBkEfsWwcD4q1xe
        WR1SB8MJkDRHTGuBHbW5MvFXnVf0uYz36xhSGuWStQNIQqQ=
X-Google-Smtp-Source: ACHHUZ5H3GRoBym0b9/SiurE+jEIsHMp41/GcQAaG06YOaSsX0tGI2WlPTg+w61l4Kgc2zfz1Xr4qbgyrRqgP6044mA=
X-Received: by 2002:a05:6808:424d:b0:38e:a824:27d3 with SMTP id
 dp13-20020a056808424d00b0038ea82427d3mr30392455oib.27.1687862341491; Tue, 27
 Jun 2023 03:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230531125535.676098-1-hch@lst.de> <20230531125535.676098-9-hch@lst.de>
 <c1391658-d785-4b2f-ba7e-01e4668685d7@roeck-us.net> <20230626075325.GA26851@lst.de>
 <7e708dfa-4019-fe28-afbd-91ad847fada0@roeck-us.net>
In-Reply-To: <7e708dfa-4019-fe28-afbd-91ad847fada0@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 27 Jun 2023 03:38:50 -0700
Message-ID: <CAMo8BfLtEw2jdRC-pK4kYuqmgEy-0QgXDodiF+gZEMygNQQBbA@mail.gmail.com>
Subject: Re: [PATCH 08/24] init: pass root_device_name explicitly
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 8:10=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 6/26/23 00:53, Christoph Hellwig wrote:
> > On Fri, Jun 23, 2023 at 05:08:59PM -0700, Guenter Roeck wrote:
> >> Hi,
> >>
> >> On Wed, May 31, 2023 at 02:55:19PM +0200, Christoph Hellwig wrote:
> >>> Instead of declaring root_device_name as a global variable pass it as=
 an
> >>> argument to the functions using it.
> >>>
> >>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>
> >> This patch results in the following build error when trying to build
> >> xtensa:tinyconfig.
> >>
> >> WARNING: modpost: vmlinux: section mismatch in reference: strcpy.isra.=
0+0x14 (section: .text.unlikely) -> initcall_level_names (section: .init.da=
ta)
> >> ERROR: modpost: Section mismatches detected.
> >
> > I can reproduce these with gcc 13.1 on xtensa, but the report makes
> > no sense to me.  If I disable CONFIG_CC_OPTIMIZE_FOR_SIZE it now report=
s
> > a similar warning for put_page intead of strcpy which seems just as
> > arcance.
> >
>
> I don't see that (I tried 11.3, 11.4, 12.3, and 13.1), but then I am not =
sure
> if this is worth tracking down. I just force CONFIG_SECTION_MISMATCH_WARN=
_ONLY=3Dy
> for xtensa builds instead.

I believe it's yet another manifestation of the following issue:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D92938

Hunting is still on my todo list, but it's quite low, so I guess
forcing CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy for xtensa
is the right thing to do for now.

--=20
Thanks.
-- Max
