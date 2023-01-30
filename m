Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D3680CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjA3MAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjA3MAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:00:30 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F22701;
        Mon, 30 Jan 2023 04:00:19 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d8so11720895ybe.9;
        Mon, 30 Jan 2023 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1HbguGHpB5FjqpATPjgOHDIrWn/kBKd6drXFRcfzVNs=;
        b=B38If1QkuwWtrB4fFeIOZ0mF+gcyvYWCVzpQ+7uNh2WDW6E8cIParAuMk9w3aDI7dS
         re0rwuXk38QKY7cLUiqX8uy2GzVRkA0mcOnE5nN6RGWXJ84p8jmIcN+8zJ1NvgRkTLgC
         R4b0Cltat49eq4rl9aq1trm0dl99CqKk+fp8+die9j4ol5A9opeKkHxaLnfHIdwfJsbC
         ukD0lyyLI3PVFkOUS+3XpqTrsMks5Aa6rOPWKVCgPPB3uW5qzdHhlaDX+38icxdW+5dM
         k4GD7HkvDn0/bUHBJ3nc4jkqcwsoD2JCw3oJM93jnFw88N1nW1BPhu/jfjjBGUlS0fG2
         +ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HbguGHpB5FjqpATPjgOHDIrWn/kBKd6drXFRcfzVNs=;
        b=2w7m86FJZcscKt4qsHjjnnRpm0nw7HYoh5PQnC5x0r+i9R5o8ZbzNHSfjPeiCDP3Wp
         QTS4CMX6uu5S3TiSq2VcJE06vksjobPwzHIcXq/ph54GPMon2/VL/BsH+cPOZYg8s/TM
         nZl8E8jKNl//SNtiSHS/6ot9j2jv5qkikpIruaaB67dWG72IbmsAhHK7ySjHVJ8+we9J
         6uH0H6hWe0tXqjrKwWLJOJ1nyKL0AsIxN5P8MD7ziHTy1lnGBN4nxJpQN7rqa0cr9wTR
         xRn0wt/OpK3X1jdwQVIjMmJ9CltAlSWlqFlGFNuRdV3PU+0XVfpH7DvVgcLEjLJl28jL
         9S7g==
X-Gm-Message-State: AFqh2kqBH4rTYW2COo0ftN6mF+fXDedKGjNpcLZ7EDDUs/w8RC73rzRC
        DE3noBOLyOD/qckkAT+IBhi1xcX7UszJeIvGXKQ=
X-Google-Smtp-Source: AMrXdXtZMmt5G/oSVrrJr7dHDHlsu+PaGz9sWWvSC9nqJy48wlwExCnPYy3D7LATlmfiivbrUYiAU+/+8iAdRc00MNc=
X-Received: by 2002:a25:24c4:0:b0:803:197f:3f41 with SMTP id
 k187-20020a2524c4000000b00803197f3f41mr4140563ybk.489.1675080018737; Mon, 30
 Jan 2023 04:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20230129184602.3974058-1-masahiroy@kernel.org>
 <20230129184602.3974058-4-masahiroy@kernel.org> <CANiq72=BRW9TunjKQmeMthm7Esc_YKM++NmWh-Dqc9Av13SNow@mail.gmail.com>
 <CAK7LNAQttb=qc5vsZNudYwTxmn=y3HZzVqZwAzMvLfUJXa4OFQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQttb=qc5vsZNudYwTxmn=y3HZzVqZwAzMvLfUJXa4OFQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 30 Jan 2023 13:00:07 +0100
Message-ID: <CANiq72miWD_MtTrC0Ua7o4Tk5oDbQSFefwmYCsGx3Y=85ziJfQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kbuild: srcrpm-pkg: create source package without cleaning
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
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

On Mon, Jan 30, 2023 at 2:29 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I guess you are talking about kernel-devel-*.rpm
> (and linux-headers-.deb).
>
> They are not useful for building external modules
> written in Rust since they do not contain *.rmeta etc.
> I am not caring about that because Rust support is not
> mature enough yet.

Yeah, that is what I meant, i.e. since the Rust ML was Cc'd, I checked
and wanted to say removing `rust` from there was OK (an `Acked-by`
seemed too much for just that line :).

> I stopped hard-coding the top-level directories.
> The resulting source package still contains all check-in files
> under rust/, so it is good from the source package perspective.

Sounds good to me.

> 5/5 changed the behavior because rpm-pkg re-uses the
> *.src.rpm generated by srcrpm-pkg.

(3/5?)

> Having *.src.rpm in the kernel tree seems Redhat's preference.
> Commit 8818039f959b2efc0d6f2cb101f8061332f0c77e
> added --define='_srcrpmdir $(srctree)'.

Thanks for the details! I just noticed it, so I thought I would let
you know just in case.

(Perhaps it could be useful to mention this change in the output in
the commit message.)

> In contrast, binary rpm files are generated under rpmbuild/RPMS/.
> I want to fix this inconsistency, though.

That would be nice.

Cheers,
Miguel
