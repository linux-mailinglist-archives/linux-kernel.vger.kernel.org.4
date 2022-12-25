Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE16655E03
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLYShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 13:37:13 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD85587;
        Sun, 25 Dec 2022 10:37:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3e45d25de97so129869377b3.6;
        Sun, 25 Dec 2022 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mtbvWP5/RwTkeMACWqwXsjU2x/ELrCA9QCXhaK8aZzE=;
        b=mknD/3aW8RCuFA/7hvepqNBSGedeUIhEvE7IqNE0fTJSgCYTgtb7TvjPXn7mecg0od
         BnO7w8ynNJJivMRy6//InAVude1ky54h5UoSLckI0gzH4tcfGWYse4nVTfPj2zRfQ7eS
         hnAuvk2u1sXxnMiXQ/EYIVPl6MILnXfiL160KpQQVZw6KxXC5E3/23Tr+YTje/2dORC5
         CesEjznM1XlopN/x8L9uTlBGjYY2fQDmoBKc0xz6ChfQMIg/baijoOY7LSf8VQNOV5o9
         n4bye+zICEREwQFYRHbCHujz/SFUYAJbYIf5PZeE+wYvGHwLGsPA1662TsYhj0t5DQ9S
         7v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtbvWP5/RwTkeMACWqwXsjU2x/ELrCA9QCXhaK8aZzE=;
        b=8Du2FEs0cYweWiOnkFwVyHcsXv9Xep2v2hx0ZS7yVVdFHFzhk4lqrwkYmg7ggmeBVm
         WGuWjJJPUY44IVULjEa2S7xxCQUG/AJsht+Z1xy4uPinX6sYqa5cFiGNZ/jTHPA9L+/r
         uyfUJRw0QmXTRrd+JLJzA/dY4ElfGxpToAR96faRZ8F+7d7oSFfHBwiLkJ2DWetdgK8e
         xS57PnQBnA46o/2XeuCppksG1t4d5VQk7n9j9wmCrdk8f3NzZRtJspbr7BM0M3LxE+QA
         BB+EB0JzrhYb/GHzWHMzT76PlchAGjgfd47VbkYk0OvTrrielOrcNUvevNs/OJ+iOSRb
         XSFA==
X-Gm-Message-State: AFqh2kphXAMEEiJxYeD+wZP1Z5zUCVB1ntdcPIs5K4RHJvYderW2wiyH
        2qFpXIakluQiST213cRdKaCwAy7WiD+cDrYMziP0PKH9
X-Google-Smtp-Source: AMrXdXtLaplwFUfT2qf/bLBHWHbfqJaQvGY9WqfDigNF9lhU/bwOD17KZPjhokLGS9jLgV3vJyUb0iApKA9gsrpw3EE=
X-Received: by 2002:a81:4f95:0:b0:3f4:6e40:89c3 with SMTP id
 d143-20020a814f95000000b003f46e4089c3mr1956568ywb.266.1671993431771; Sun, 25
 Dec 2022 10:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20221224155138.447912-1-masahiroy@kernel.org>
In-Reply-To: <20221224155138.447912-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 25 Dec 2022 19:37:00 +0100
Message-ID: <CANiq72=jDGX+8XobCTFs1-ut38cxQd0m7kEMg7U1Vn+NxtMTwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] .gitinogre: update the command to check tracked
 files being ignored
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Sat, Dec 24, 2022 at 4:51 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -c was implied for older git versions, but we need to make it
> explicit now.

Perhaps add a `Link:` to Git's commit b338e9f66873 ("ls-files: error
out on -i unless -o or -c are specified")

    https://git.kernel.org/pub/scm/git/git.git/commit/?id=b338e9f668737e08201c990450b8c3d744f63162

> We never know what are locally added to $GIT_DIR/info/exclude or
> $XDG_CONFIG_HOME/git/ignore.

Perhaps we could say "global exclusion file" instead (since it could
be the one from `core.excludesFile` too).

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

By the way, in the commit title: "gitinogre" -> "gitignore"

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
