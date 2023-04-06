Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477906DA46E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDFVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDFVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:08:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514237683;
        Thu,  6 Apr 2023 14:08:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p15so47509576ybl.9;
        Thu, 06 Apr 2023 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815311; x=1683407311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A27I5gfhEkK0uF1a/DZc/Ub8U8KdJ3sBMklO6Yei5GY=;
        b=Y4+Pm5BrfbIhyoa0QbZn6zWMfvzmsgF4s8F7wazmYg9Vwxf6m6nvwkwkU5r/SXZEwT
         RJxIeE7Kl8oNdSmTdKP7gg6wWfS6QaW5bg+gUm+FRJW1ebKkafm+WqBpt0LsduhwO7Rm
         0UMCs1GMeN3NvHYj3MYBZr1MVKDJ9eAXY04W29TPdf5DaR+8s5mZlKgDwznv2dWzIIm3
         BF+my4GLKHAFJtgEW5NUj4mXhU2d8j3XXGhOaVF5+KhruVGxwgJJ8jVDEqnJkAdoIVyX
         rzW5FcWpM83MVbbeTthpVA2pk8cvOOOrUGxd9ge+iEz3xyGKchp5TH6X4cWhFUlBYqeC
         7DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815311; x=1683407311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A27I5gfhEkK0uF1a/DZc/Ub8U8KdJ3sBMklO6Yei5GY=;
        b=2bqygUBRk2xDDivssTSKIBfjoIzP/rdt+fPh4j3Ixkj+eoGjJROmH2S5BQck/n9qD6
         oDUvXSyXWT57THNSTQx+HgQJ1+Nlbvx1DBb8YmAQZn423hSDf/zDFdKNv6I3+cdCkaMu
         i20ncdCiYlDWQfth9X7WjLpHYWwRK5sJWdDYxXXeSfSSZb0sQnFfFSQqDQ32FSGeVJLU
         Kr2QX5wOSf9ZaZ5fvnIvuOPSQWNGYLRs3n8o4Izi+ConwK4i2fC7zKHKMPzJOwd4tFw6
         VK3PCla+gxrNd/mpT8rlTCofkhVYksd3SFRwGY4rd2oeIuQzyyNgdSdAe8izT1J7t6WD
         uDBA==
X-Gm-Message-State: AAQBX9fYpeC8Pf20lwxiFan/pK+OP0ZYpMVuX+iiY1WRcr78XTMtRZUE
        HRB072d6CuEBjAk6HUHH48Q8D+VzUMiZdy4S8Yc=
X-Google-Smtp-Source: AKy350b+N+YIoz1HmCnWeyCnx3SNci9etLebizMhB1JQA4PpgM57TO1c4ohQtQhORjfgVIK2LoGmMingHXrZB8G9Pgw=
X-Received: by 2002:a25:d2ca:0:b0:b6e:7a7d:b95f with SMTP id
 j193-20020a25d2ca000000b00b6e7a7db95fmr304237ybg.11.1680815311532; Thu, 06
 Apr 2023 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230303-str-rs-typo-v1-1-d022b4a57591@mailbox.org>
In-Reply-To: <20230303-str-rs-typo-v1-1-d022b4a57591@mailbox.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 23:08:20 +0200
Message-ID: <CANiq72=p0n5F3UBqGERSHMM=d4v_zdqkXXPQCC1SJ4bWCaXXBA@mail.gmail.com>
Subject: Re: [PATCH] rust: str: fix requierments->requirements typo for rust str
To:     patrickblass@mailbox.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viktor Garske <viktor@v-gar.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:07=E2=80=AFPM Patrick Blass via B4 Relay
<devnull+patrickblass.mailbox.org@kernel.org> wrote:
>
> Fix a trivial spelling error in the rust str file.

Applied to `rust-fixes`, thanks!

Cheers,
Miguel
