Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9096766326E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbjAIVLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjAIVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:11:36 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD741A76;
        Mon,  9 Jan 2023 13:05:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id l139so9767852ybl.12;
        Mon, 09 Jan 2023 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myEKGg+oMEzcSTRA/yCcbDAjuI7KfOMxWzLnkBmkC7Y=;
        b=KKh3FuuvOpr51yI0LDH/oIme2+Hs5Gwn0hqqM1Ytor7PzuInJ0En8ggSSspfJ30SaI
         kWVKD0FVS+Grls7waVZhg5695Mvi96LjJjrbcZai4x49BmdWU4H9kUraiAuvBCe/B6lC
         fQhAL2CxHFyXCrbxQVdG8bfiJR//TYsTQTIth+GWMygLeUigzr1CoUa+n1pN0r/j9rEi
         0W8czT3zajB6mmnbkM065wnrFZRbKZ1niJVlj9l3omMbz+FMbPftQR5xOcTssawRuVrn
         n7E+2d0zrcx3Gh4MS5tv62NBiv9hHdxxys1C+qekXlRWgOgdaC7n9CdU6eqLFigLJX8q
         VRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myEKGg+oMEzcSTRA/yCcbDAjuI7KfOMxWzLnkBmkC7Y=;
        b=l8cDMzaLyN32ruhHOysoulpFW60FeXqJ2M5s6rqoKYT6ogOazOGFILT+YBbXpSlfy+
         qUw7SuSRGNcmefXtEJ03/H0yy5x21rX++AKgeE0slS2uWHJ/tXApgPFSYdzHGKbsawzJ
         gPfkdmyisNrR6xsBjptmPsZRQ6MSrNrJL4Ot+ozRT4d9tygPM8ythmsD9fSlkzQGi4Dp
         Gznca2FiHaPGEGcFTYDz3V+cQcehaSHEwKd/Dt9JbNY6Jd7p5yFCurkfvQyHxB0uNZxr
         dpoUT35HeePQUyAfaF+uUhmEAMfD0SxJ8InUSmFhWazskjnIgaTZa/I7xwXs6wBkxF7m
         dLrw==
X-Gm-Message-State: AFqh2kpDh3LNU6jxPwn8eyoUMJsNOWvsPNLPsr06QKozqB43BfzQm3rw
        HYzil+GmMS7gOeLHNhmA9/EuFxtl6UZOUgj5TvU=
X-Google-Smtp-Source: AMrXdXtxeAq1fcrp0b42A4VMYRMUWp0hLyrkry0m7xghpdIY2iK2OeCAvX/A8wipnJx6npW9eQA3IsQmGU8rhapiN+I=
X-Received: by 2002:a25:1004:0:b0:712:faac:e6b2 with SMTP id
 4-20020a251004000000b00712faace6b2mr6955908ybq.632.1673298346610; Mon, 09 Jan
 2023 13:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <CAKwvOdkr6mAdNOkZqGdkosAN6JABHRU3bHg=K8ujjbw2GxEsKQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkr6mAdNOkZqGdkosAN6JABHRU3bHg=K8ujjbw2GxEsKQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Jan 2023 22:05:35 +0100
Message-ID: <CANiq72=RJ9NffqJOJLuN6B-DCQgjx1Yp7-sP58q2HchBNpYE=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Mon, Jan 9, 2023 at 9:54 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This is super helpful for me, since I build clang from source and
> would like to use my libclang.so! Thanks for this documentation
> Miguel!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the quick review Nick!

By the way, I didn't add your Reported-by here because apparently it
is only intended for bug fixes and not features.

Cheers,
Miguel
