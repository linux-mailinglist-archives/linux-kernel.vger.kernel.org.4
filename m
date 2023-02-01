Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945B268713D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBAWvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBAWvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:51:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD62529D;
        Wed,  1 Feb 2023 14:51:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h24so83201qta.12;
        Wed, 01 Feb 2023 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZeAHibIDvY1od232Bzk1jjyY4S0jzZKd2wQ9KbzuIc=;
        b=V7Jo2C4CuPbUs8N7rLVkvQ3gHfTZ8Bn+0/wVt0owZv5aaTi/QIXZL3mItL41LUpA+r
         OA5IS+3etcTJ2rdLu+QPwaDrsPjvPRVY3w+dhxmB1NL4LbP8zK4QvOlF83FCeA1zdfap
         ANnCWChugEIhly+lhK8uhZTo7IWfJ5rxWSmLnzQxE/o7UqoUDdDuXuHdYdRATdQgAAvi
         1+soKHD+QGr1XF5xfde06z5T8DJBAc+RDO8vbdu2oifek+z9G3j/8UGuGueZUZIvs4jn
         gHGYGv3abZy1ZRLCJWtqQwERp3J5ydCa+Hz/5uL2oO1VlZlj3rhOKzKoWc5xF+TgqNW7
         4mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZeAHibIDvY1od232Bzk1jjyY4S0jzZKd2wQ9KbzuIc=;
        b=A5/1O1C5QfDiOR+LWokFo5Np445m96ax1V4ZsvImMvA8CY1zKm4F4HbihzGDu5vXpG
         DJxXnFL9Hb3P9p/AH/35o6/hlBryNtwKceuxgJoR5x/QaMHquL40BOJfFfV17eEwFrBG
         hSC/4xtZskthT3W/lytMu2Bjy/CnF6mDf0dr3g3TRTC+jtpYTtI/ijDKR8gFsal3Y+QP
         3ZIi3kJWgANAbsT31kilerNYPQEKuu44f1pWeepzGWpBuCwHAcvCOnsGPifC6eV7z/Ex
         lhFUW1G8YAXT+8g3GDxB+UUwW+jStLsnGBtXMjHucEEh4/sIFZYCgndLBBZSj5Z0ty1O
         BsfA==
X-Gm-Message-State: AO0yUKVWEHJo4R3SBcMhKev44tkgFY3P6VCaIlvVkYthuKWD0g6lYYVr
        tKvchRucJcmM2fK5LnmajZuwSXYCXqwak+bXRHg=
X-Google-Smtp-Source: AK7set9manxB/Bai1aVVNzPerzWJDsG6yzRPWN8Sn+NvU8MVoJZeAMaPw889g7ro76ypFNgK0KLdj9m/uQcGyyH2s9w=
X-Received: by 2002:a05:622a:134a:b0:3b6:3577:2fd2 with SMTP id
 w10-20020a05622a134a00b003b635772fd2mr452836qtk.252.1675291870777; Wed, 01
 Feb 2023 14:51:10 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72mGk72tvLx+uH-puXZ=MvAA9dzNVqTXYmPq2iadwYuyWA@mail.gmail.com>
 <20230201184525.272909-1-boqun.feng@gmail.com>
In-Reply-To: <20230201184525.272909-1-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Feb 2023 23:50:59 +0100
Message-ID: <CANiq72=j42cdDY9OqA9Z8TQ5kHjTd+9aqxWqbhCsW4+-TR2upg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: MAINTAINERS: Add the zulip link
To:     Boqun Feng <boqun.feng@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     rust-for-linux@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 1, 2023 at 7:46 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Zulip organization "rust-for-linux" was created 2 years ago[1] and has
> proven to be a great place for Rust related discussion, therefore
> add the information in MAINTAINERS file so that newcomers have more
> options to find guide and help.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=xVaMQkgCA9rspjV8bhWDGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/ [1]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to rust-next, thanks Boqun!

(Vincenzo: if you would like me to apply your tag to v3, please let me know.)

Cheers,
Miguel
