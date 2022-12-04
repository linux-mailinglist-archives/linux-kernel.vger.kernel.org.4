Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324B641A37
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLDBFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLDBFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:05:32 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D791B1EC;
        Sat,  3 Dec 2022 17:05:32 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3b56782b3f6so84779747b3.13;
        Sat, 03 Dec 2022 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PyzqHyFdLyWqEa3wq8Yy+PDfxLYF/6Em2FYwiORm33Q=;
        b=L4+M48l9rcWzyolaSijYXQFCbAi6hbhgfhLzhDqdjmpgHxyZYu5U9FFfPGEGE+oeZ1
         T2Tzh0ckkeHDo+nTOAxU27Qx8XlE7IfncZdanD7R/9fBeXNVU9qq63pN+aDxXUtPPdFY
         M+mpQiHfVgtf+bpfcSMmrUvE24/1ODgzq0e/PKe/KZI1Mn29758ftB04K7cP1XlD7N/m
         wnMQvI1QtDFBwGYwUlXlbRIXLetiDn3ZtG29HwnZSuS9CX6j5qTrWlS1As6OoaodcIA6
         MGlYzbQUkiPDOMpkQeGVQBKILPbb3i21KEVt7y12Lk48GtDS0boyAz2MrFGs//bMPEq8
         8Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyzqHyFdLyWqEa3wq8Yy+PDfxLYF/6Em2FYwiORm33Q=;
        b=FQKP1VR3JD8alD5RAcDTN/Uy8BPbtP5ZCub+eQfC7lND6MQm/jqNLtX/ug6EjxqpA5
         OqCtIijla7sLYxfC6DIzDjsR36mv4fwOLb6vOe7AXPDAEx6fPQPIKfaPSGU7U5rAR9OT
         UoVyI5g3cvVG1F+ZIuDvv3vyj75O2INckqRSNg0UtQRBcao5YEJSUWEKVIgj/qXtoba3
         UjW5/Gkm2PHeC3xC/+6VI1Afc2Xvf+dQOHaatLTekoPX4MdZefBkQlEPnjMZ24GiPcsS
         XEg3FtggCGvKkJwcuvWzRz7KzqGUa6N/aVcf1RoJTxGNY0/jusTWL+jQIKv7NMIZxyG6
         0HuQ==
X-Gm-Message-State: ANoB5pn6cBXhP7B2jYqVCJWip084omUomPBSaHHZ3S46UsxkLQ7c1+tJ
        EODvdgFBIyHzalHmR2A7azSbnOUnx+r+//RjpBA=
X-Google-Smtp-Source: AA0mqf73ytY7NEhaiUQ88o7BGRcthtw6HVGT2ImvUh2R+g91gcPoiv6IEmOajAAeWOKh63qXEf2Le+v5ObdG5e2oBJM=
X-Received: by 2002:a0d:e6c4:0:b0:3bc:7270:cb70 with SMTP id
 p187-20020a0de6c4000000b003bc7270cb70mr39280836ywe.83.1670115931392; Sat, 03
 Dec 2022 17:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20221202161502.385525-1-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 4 Dec 2022 02:05:20 +0100
Message-ID: <CANiq72mO5L+DppmMO0pnBC-XWivaOc98EQYe92FWtJ+iHc6ttg@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Rust core additions
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Fri, Dec 2, 2022 at 5:15 PM <ojeda@kernel.org> wrote:
>
> This is v2 of the first batch of changes to upstream the rest of
> the Rust support. v1 is at:
>
>     https://lore.kernel.org/rust-for-linux/20221110164152.26136-1-ojeda@kernel.org/
>
> I collected the tags and applied the agreed changes. The full diff
> follows (with respect to v1), since they are minor enough.
>
> I will be applying the patches tomorrow, since v1 has had more than
> three weeks of review time.

Queued.

Cheers,
Miguel
