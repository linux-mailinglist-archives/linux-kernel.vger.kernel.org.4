Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6783E6FB85C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjEHUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:37:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBA5279;
        Mon,  8 May 2023 13:37:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a00da4e53so90072567b3.0;
        Mon, 08 May 2023 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683578262; x=1686170262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6Lg2VPPD2mSZhjoYg9Er/+OKaBta41mbPF9BPFt4GI=;
        b=goDtNCjnwplpmQKEVANMgBMTCZXR/i+jAtvoJV4i/o8S2WBRSzkWSsw5Aoyvzv1sj5
         dxsrJJh7iNrBDfXoj+HZ2D9Vv7Ou1gAYEHyMw3uRCJRd8YdVGTsjDWueR4JX6/A2WCIO
         NTRkCR3rjyQXrmVldAj3xgrc9VGlf4izHIwIyp81q526LkCkGS5GgrkczJphAbcbtCfi
         ffVpqEROrYhHD2YD1mxHyI0V7I9fh1CWW3K89+9o8ub52+zzNZhxjg/mzlXus/08766N
         pmelAOLJB2H/q84Os4Whiohzn5NZRiEOr2qtL9LCM13t8NJ4a427QXLDC4CKDYquC1+d
         8USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578262; x=1686170262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6Lg2VPPD2mSZhjoYg9Er/+OKaBta41mbPF9BPFt4GI=;
        b=WIvJlZTzd5KBznAeVALHeJl7ma3QnfwKhu79Vc3WLyk+bYUPGyRJqg8ribt8uNBzS1
         WE+is7nveAt0YfOqbCjWcG2XHb4u4HGABxxEyPOxk4TqKws8mUTEIBcq6uazEFWRm4GR
         12jsyHd7tTlj/VjQxhMv01Xg/j0zx6bh9Rzh0Jz11weuUkqJg3Hu6xkHb/obb9E1jd6H
         xzZKASzhZxU4XZT8Rd1QHHgFVw9TlH2cvmAuj/Gv2riVUo/wJY99MfTPd5DScCbf5pMc
         o/X+bft9RecmlBeN9aMqA8Nji7Uz7AMU4W+JrGuZocDdGLgc9pf0E+4OrSNuiwwgOfAH
         0TDw==
X-Gm-Message-State: AC+VfDxqNOHUvXB+hjb5oAtSLqHEPwRmLnZev1lyBDydtI+Zz2qMw+Lt
        WuJx5dZ3Fhul3/2z1vKbK7ZCVrjWHwz9+f36Uug=
X-Google-Smtp-Source: ACHHUZ5tNogejSSjGSUPPdkQ8/W5T8oN4OijJD51kbQ0j/MWUuFYWZc8WycNq504dPEnjAEPLR+fnbXW7m9wTu++GmU=
X-Received: by 2002:a25:4cd:0:b0:b8f:54a4:9a55 with SMTP id
 196-20020a2504cd000000b00b8f54a49a55mr10090313ybe.65.1683578262735; Mon, 08
 May 2023 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <7f464c01-d4ec-d632-fa40-0c3f18c2ffca@ryhl.io> <20230507162739.17392-1-ben.gooding.dev@gmail.com>
In-Reply-To: <20230507162739.17392-1-ben.gooding.dev@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 May 2023 22:37:31 +0200
Message-ID: <CANiq72=0bbXtRpfYp+CT5tfwcsDi_A6_WV-23Bw44nD+Bbk9uA@mail.gmail.com>
Subject: Re: [PATCH] rust: lock: Reflow long documentation line
To:     Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     alice@ryhl.io, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

Hi Ben,

On Sun, May 7, 2023 at 6:27=E2=80=AFPM Ben Gooding <ben.gooding.dev@gmail.c=
om> wrote:
>
> Suggested-by: Alice Ryhl <alice@ryhl.io>
> Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>

Thanks for the patch! Several notes:

  - Missing commit message -- in general, please check your patches
with `scripts/checkpatch.pl` and please read
https://docs.kernel.org/process/submitting-patches.html.

  - This patch goes on top of the previous one you sent but, in the
kernel workflow, what you are expected to do is send a v2 of your
patch series instead. You can use `-v2` in `git format-patch` for
that.

  - This patch is not just reflowing as the title implies, but it also
changes the style of the link -- is there a reason for that? If yes,
this should be explained.

Cheers,
Miguel
