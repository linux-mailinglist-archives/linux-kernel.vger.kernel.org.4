Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F96EE926
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjDYUiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjDYUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:38:09 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25051447E;
        Tue, 25 Apr 2023 13:38:08 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-552a6357d02so74736307b3.3;
        Tue, 25 Apr 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455088; x=1685047088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSMFraWDnuFxIY/5xKaBGC0hsSHLhpd6E/RRLTqgcXY=;
        b=LcWTSi2md/Jgl0vEgTlmq1D0O7x5GrEXezRFqMP/H6OX4ccxDAcihkPmEnIEotGSep
         SUP58Pbnle9L9PNptK/GjKmR7RC9xFnLlLHh6nNFivXsr2ILH5ldut+7TRpRmwNCwi7j
         EPqStuSqxHLRNn9SSfQzgmaWwxwr097UCTg0/vG1NDOyhzPKyfj1CgXZQ6JBCRydSpsG
         dVW1K+7v/fntNEgeftywaDp4/J64gVt0JgXqnMMeiiqRaqzxXujflQmW8tF3GFsnfPDB
         NTbhiOBA3M031TA+vGNwXkCy55OKPepT92i+9RjR4sKHLoK5ubtkDS6092MZiHwz1Y3V
         yazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455088; x=1685047088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSMFraWDnuFxIY/5xKaBGC0hsSHLhpd6E/RRLTqgcXY=;
        b=j16MJmrmP3MUaiUJOLb+fkj9YHHWZqkKJ0WKDnPICEPwxDQ9RXZ/UzxZwNUs8VLIWn
         ZQrSux0oHzkqZvy83sfs66bRlbOTOfZhXw8/7+HCELd3VfFlmCoYZHK/Hwj/Ck+HzWVV
         zJHp/vlQ04h7LrB17DNkTrktSXluzJENitzFJJOOVFiSUrmTIt322J4Ja3Gr546uv8Ct
         taG1NwGS31LrVB594fxyJmBBZvYj8qYEXEE5mI7UrVhAAEE+NDdBp636O7zXMy1Crepm
         nT639+6lUbg7AAV12WO3FD2kAZWXKonCtzhZTv8kYFjFPqjnO6MZczTJUJICuaEkky+q
         Tb/g==
X-Gm-Message-State: AAQBX9ceHThaAISGuDre0buAWBE51DYTBLsSJvaYqvnedHkRmmvuz52S
        u2pb0GWD+icxUxYfemOIH+QqHIaowZwRrkcpYe20RVEyh1M=
X-Google-Smtp-Source: AKy350ZBhwoxLWkqkcvqti/j91TBOklHYVdf2aJArf2lmXX31SYCKkZTeBmEhsgDhUhzm0zqXlNytRCjORZ4cU0Xzmg=
X-Received: by 2002:a81:4602:0:b0:54d:c121:6c88 with SMTP id
 t2-20020a814602000000b0054dc1216c88mr12361981ywa.20.1682455088009; Tue, 25
 Apr 2023 13:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230425202848.261139-1-amiculas@cisco.com>
In-Reply-To: <20230425202848.261139-1-amiculas@cisco.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Apr 2023 22:37:57 +0200
Message-ID: <CANiq72kXa-SgRiVhvjU7X4fa8XSJB4po9xf_V4L6Gn2o+t6T+Q@mail.gmail.com>
Subject: Re: [PATCH] rust: Sort rust/helpers.c's #include directives
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me, Ariel Miculas <amiculas@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

On Tue, Apr 25, 2023 at 10:28=E2=80=AFPM Ariel Miculas <ariel.miculas@gmail=
.com> wrote:
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

First of all, thanks for the patch!

These tags look OK, but if you want to attribute the patches to your
Cisco address, could you please send them from that address?

Also, the commit description is missing. In the kernel, we give the
rationale for a change and describe what the patch does for every
commit.

Please take a look at `Documentation/process/submitting-patches.rst`
and try `scripts/checkpatch.pl` -- it can point some issues like this.

> +/*
> + * Sorted alphabetically.
> + */

Please join this comment with the top one, i.e. please do not open a
new /* */ block, like it is done in the other file mentioned in the
linked issue.

Cheers,
Miguel
