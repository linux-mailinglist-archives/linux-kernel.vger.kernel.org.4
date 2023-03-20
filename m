Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D96C14C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCTOcO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCTOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:32:11 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420231BF4;
        Mon, 20 Mar 2023 07:31:58 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-54184571389so227699557b3.4;
        Mon, 20 Mar 2023 07:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679322717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O54noMvqG3UegcIjTcDUZ+r5sq4m1GQijs9yejp9gRE=;
        b=2mmU2NzI7fPSM7igO/TV1SPNwoEBk7PYJAUoCClbejCfpCff1kVVJXvtw7N/rAw2I8
         G9Gwg8EJyFYsq58L0HIQ8zvctFEufPEjDLE94rFkQboy6Dfsf+KWzEhgRqt5v7uik6sI
         kGN9ux/71m4+l1g3l2QGC5t1c72v2LJFRlnf6UqRHIovRtf3CzHeTf/m6HI6GCG4kYcA
         ZlCRI/o0FdkN3iipImh18KQKoW85Tk4ZIYSkM3e4A/jGEshcXP107mbbqILwNlZszEbl
         LhqTBFAa0yjZr7f/majl9cGswHjQq94rj06hRXOE9aYanuFRAHSV48vBWXQWHJQ/REvm
         eBdw==
X-Gm-Message-State: AO0yUKW33/AoYFap8iCS48RG+/dBzbrfsIlaZ3PGRB6RZ+DAgLwS4aqF
        UbIbkCzXHmXyL2YdCnJmYF6mEARNjLrPQw==
X-Google-Smtp-Source: AK7set/G5h7Cx8EAy8UinGJ3E0ckUpcuGdpS3oMAVuuiY9HZk+6hOwmvuE4AYLltvyiDjy8MJvaUNA==
X-Received: by 2002:a81:4f90:0:b0:541:826c:210a with SMTP id d138-20020a814f90000000b00541826c210amr13493358ywb.13.1679322717330;
        Mon, 20 Mar 2023 07:31:57 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id j2-20020a378702000000b00746059d9c3fsm7446338qkd.35.2023.03.20.07.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:31:57 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p204so2171413ybc.12;
        Mon, 20 Mar 2023 07:31:56 -0700 (PDT)
X-Received: by 2002:a05:6902:120b:b0:b6e:b924:b96f with SMTP id
 s11-20020a056902120b00b00b6eb924b96fmr542059ybu.3.1679322716693; Mon, 20 Mar
 2023 07:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230320123202.14474-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230320123202.14474-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 15:31:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoPXjXSr=-CnQnNFBf2bd1Oyj++nFekAUnhaj69Rv7JA@mail.gmail.com>
Message-ID: <CAMuHMdXoPXjXSr=-CnQnNFBf2bd1Oyj++nFekAUnhaj69Rv7JA@mail.gmail.com>
Subject: Re: [PATCH] m68k: remove obsolete config NO_KERNEL_MSG
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Mon, Mar 20, 2023 at 1:32 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> The use of the config NO_KERNEL_MSG is long gone. Remove this config from
> m68k's debug kernel configuration setup.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for your patch!

The last user was removed 20 years ago...

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.4 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
