Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2F6D5C59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjDDJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjDDJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:51:56 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38E11BCD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:51:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n125so37903445ybg.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680601913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtGvheLFEQGeT+QVm8ZOPd3bzjNLsHpa4GqYKrAgw3A=;
        b=inklxK8PUBaed0NuvgCoTa8YYllcZofQmdvhAxfTcgTg5G+omwrj6JbnAkRr9/SDAG
         QLwvpBo8purtIn9w60Dqpp78FGMi/IgeFSWz0SWYd7oxazxZl7zfdok0b5nDsf0GO1kE
         cOh2RpT3dR39Pog6t7d1iGuxg9CHtDaPKmkipOdViB5mU4o0Jnp/5ssPOwoxY0BO6XtJ
         h0XPGSRCbTIDAWs3HdvFJ/kFZiC3T6BEr7uehdkZHNuN2s7fZ4UWEuUfCpd2cxpA5ZHa
         3U1tYrTN1shrAwvmYwkdCFwBh/AiR1o+pv6ACleb/nXwHwCouRHb45IE9/7zFmI0jfjr
         EOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtGvheLFEQGeT+QVm8ZOPd3bzjNLsHpa4GqYKrAgw3A=;
        b=7sL0N2X26p8b6SWnDq1dK50Ug49pdVseEMmleJw0t/0q9dOIaLGnzECvQvnGt5axYv
         hx1Rx+zlgf4q8xolmznJcJ47fV3ji0fCH9HP2ddPBCC16dohXyMvh3xTdp9LO7ah3Lbs
         y+XX/+UnNGwnwD6gm1ezA5NoQuSI8Em8ypVYlFgWVbHPVdyEdQo2XRplT0SHvARycqs8
         qk7inl4LfllLvTkUxS6/GIltZ9zL34nXG19mkP0ZhIziosNz0Ei7UnJZZ1LB8v/jAXCx
         zJK7NujTi5t7UK9pgf4NU62rxqjb+CERm1WkL/z5XCCebsikMHfDLsOLI987S5MMnaAe
         QK1w==
X-Gm-Message-State: AAQBX9c23R+WOyAIrmnmLkpLvKEaQxtcPO+Jt9KEDUmL+qmjmr6b/j2y
        w5ZN+z1bI9KIwR4abIL5y5J7rnqNqTGbyWXK3sViEt9vDZ0=
X-Google-Smtp-Source: AKy350Yiz0V8IcE8JMm/L9h8m17jKCF4Y5T1k7kMjgnC50zTh6lIKmSiifurIT38/0IW65atHrd/oj94JfsQMQqEnhY=
X-Received: by 2002:a25:d897:0:b0:b4c:9333:293 with SMTP id
 p145-20020a25d897000000b00b4c93330293mr1261703ybg.11.1680601912868; Tue, 04
 Apr 2023 02:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230404075540.14422-1-ihuguet@redhat.com>
In-Reply-To: <20230404075540.14422-1-ihuguet@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 4 Apr 2023 11:51:41 +0200
Message-ID: <CANiq72mkORtWGuCZBdTy8eEuf9jAtkvA63nnw47MUkREp+j6YA@mail.gmail.com>
Subject: Re: [PATCH v2] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        Danny Lin <danny@kdrag0n.dev>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>
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

Hi =C3=8D=C3=B1igo,

On Tue, Apr 4, 2023 at 9:55=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@redh=
at.com> wrote:
>
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.

Please see https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag=
0n.dev/
for a previous patch & discussion, as well as commit fa60ce2cb450
("treewide: remove editor modelines and cruft") for a related cleanup.
Cc'ing those that gave some feedback back then.

Danny's v2 patch has some extra extensions/languages it manages as
well as some docs, and yours handles things that one doesn't, like the
Rust files and `Makefile.*` cases. So it would be nice to get a
version that merges everything from both of you, likely as
co-developers.

It still remains important to see if somebody's workflow could break
due to this, especially for the catch-all section `[*]` and for
options like `trim_trailing_whitespace` which can actually break
things like patch files as you note in the changelog. Perhaps landing
it in linux-next for an extended period of time (e.g. a few kernel
cycles) is one way to find out, or we could start without the
"dangerous" options. What do others think?

By the way, for the next/merged version, in your side please keep
`!.editorconfig` sorted and in the other side please avoid the
duplicated `.tc` case (which I just noticed).

Cheers,
Miguel
