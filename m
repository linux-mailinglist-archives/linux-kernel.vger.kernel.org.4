Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3D661016
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjAGPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjAGPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:47:56 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBAD4566F;
        Sat,  7 Jan 2023 07:47:55 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b718cab0e4so59602577b3.9;
        Sat, 07 Jan 2023 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeL07sk6Ni/kjyb9/YN9ylMOaOu9Hftn27xq249q7DY=;
        b=GUwTK5LN2GHW6KoakJ7sKpfHe3RaYflWnMq2XPUJpwpYf+62s5GMT+8d4n8z+WpRSD
         Vz4Sy4OipDJTbY74VOzvbujCzLgek9lC/fVSfRxR6ip5Mp4b2gQhSCQMfGAqJbXQNknR
         rUDzDTIZQbkQmDH5T866VelDyraOmYfLrXvJqCHfnEFNUCnZZharNT4Pe/WcOSyx4GTx
         ZIjeyIYw27obW62ZV/8UcY9UA8R/DjSSrma/ZD0f4ipOanwfWzJd2huLOyhDEsUg7l1z
         CeU4Y6btDU3vyEkepEJHLRl7uBYp0xz0RD9n6rf/0uhVJAvQZK1Qh+LAJ+ij2/TNOZO9
         YBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeL07sk6Ni/kjyb9/YN9ylMOaOu9Hftn27xq249q7DY=;
        b=r43zqCKE2/fguRvd5fSQlKXVxYsETjFqUj0+5lu8oD8UuTmrr9Drv8yuQ2laJOFhuJ
         Ll0TgiANNS/zOFNUpRCFBXLGl1TSQl5fsZ0j8jPMHJs/vkU8nMcV7cTrLhpORMgMjvew
         cFyfR+fijEuKpqmhXVete73t5iCRItfrt8YsPmwemW/aKPgZ5s7zUWYNX/DMMBtLBAeW
         Cw60dhjRhVUUerZMHLcn2MZEhPdU1CNOhWgwbnEb26FCeN3D51XOMWt+d7gu+N9o4mnB
         18vQVD5zl/hvnMvwnimyT5uHACxTjAhXorPhte3qKcrLkgVI2fzuWTnBkpH7+GV4L6Y3
         sqLg==
X-Gm-Message-State: AFqh2ko9zsLzG3Z5lHv3g/UZ8k7BWtLAHmzSuFCnRVQDZGmJnBdOvbMj
        hUsk6th+f0jDc3oyfL27qxQnZHlfUmyVlsd15YE=
X-Google-Smtp-Source: AMrXdXt+eQRO+yIDr5h+PzRPiS0SeQ92AL0zYuc1njsZ7XB+O7uxuvAslFzh4ZDrOfsJBVboJrd1wvwadLmQTPRGICk=
X-Received: by 2002:a0d:f601:0:b0:3d8:8c0e:6d48 with SMTP id
 g1-20020a0df601000000b003d88c0e6d48mr570125ywf.462.1673106474960; Sat, 07 Jan
 2023 07:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20230107094545.3384745-1-masahiroy@kernel.org>
In-Reply-To: <20230107094545.3384745-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 16:47:43 +0100
Message-ID: <CANiq72=q9pk2ZB2K9Zjn-COY1KD3MFAGthx7VJ_2YmtH61tdng@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: move rust/target.json to scripts/
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 10:46 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> +hostprogs += generate_rust_target

I see that with the cleanup now we can also rely on Kbuild triggering
it from the `target.json` prerequisite. Nice!

Do you want to take it through kbuild or rust?

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
