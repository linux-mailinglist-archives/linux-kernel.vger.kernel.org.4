Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52A6ADF03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCGMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCGMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:45:20 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BB4D28D;
        Tue,  7 Mar 2023 04:45:19 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e82so11208773ybh.9;
        Tue, 07 Mar 2023 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678193118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fe876EcuA+jdmCESHMii/7cG2YSZKquEdS/vIty4+A=;
        b=ODIJueFdMNGe95gTEbyF5NczLJmY23TtUj51PPOLopdCMmLFgcThOhcAVkvfDnoWal
         kGcukFh7EtTc0RW08h2lwJk9aOVAolceIRIuOJKABA+/zAdgaUpAp0J6WXyT61J/a/ft
         tMygDnofeR6ck4paPkOSPfFEJuAPyTXIDnzWEuv74MGISTIw5i3wp84FjjkivYkMTQNV
         FU0w7dBuB3gmGh574Vs6I2bg7ztdeRTZAVPhfzpAy8Wm7v0N0ZXCBkDy2WwAsC0hnMsQ
         Jq33qja3vVL9a+IU3LhBjW8TtcIMuTPXr7vEKx28eD2rp6bXV+a/1SMLI9FZ3Nb60QUo
         VT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fe876EcuA+jdmCESHMii/7cG2YSZKquEdS/vIty4+A=;
        b=6n44r0H4VAevPhKEl8J/JUIJduSE0hjVGB9hovq+oiJxmICYT1Qq7rxd3R079/FUve
         oYR87JL2Zdda0bf7I/Rz2rdRQjBI7m0UyTSji/Xc5s1GD/+gyNTbKT3cQnhL2/7c27ZA
         MFYiFrkMHS3jTYzcWX2+36y4NltP7XwG8Vj9/simPSHPZMu1rQNNaRc7lyDBVYsryB1n
         VavQrstQVsMrwGs42VPNvyLBkoprbcydbMibk7WIBajvWKwL2DMHBc89hZazox5XLafM
         xjrPO9up8hOI1QsTtWnCZX+c0N8v3RwG7plVcvZOxIvZ5AXWiVglD7t5tXiY8sd35O7z
         2Clg==
X-Gm-Message-State: AO0yUKW04GYUCBabe/yPe5pJFk/YLFp46tk7ejCrujdvsodPYX0wDqSn
        yqQfcMzpJdB2NERsn6xuBQK8tmOvdGJ7/JOOvjE=
X-Google-Smtp-Source: AK7set+4i6X4+McENdJYEtkgtVMIkW1tvDFHTItHQ5/EcD88Yp6L91Q8oXnhMttrnbcAi9OAVXl2NClL+dgdZd9VEek=
X-Received: by 2002:a25:656:0:b0:a27:3ecc:ffe7 with SMTP id
 83-20020a250656000000b00a273eccffe7mr11410509ybg.3.1678193118746; Tue, 07 Mar
 2023 04:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20230306220959.240235-1-ojeda@kernel.org> <87ilfcivzf.fsf@metaspace.dk>
In-Reply-To: <87ilfcivzf.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 13:45:07 +0100
Message-ID: <CANiq72m_y=eCsJLxRP+bFvhmR5yAVK7=W6Hijb_CozWnL__dQw@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: point directly to the standalone installers
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 1:31=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk> =
wrote:
>
> I guess we should remove "or install ``rustup``" from this sentence?

Good point -- the page contains installers for `rustup` itself too
above the URL fragment, but we are pointing directly to the fragment,
so it can be confusing.

I think I will split the sentence and add an extra link to the other
fragment, since there is one for that too (`#rustup`).

Cheers,
Miguel
