Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB96DCE3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDJXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:40:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11783211D;
        Mon, 10 Apr 2023 16:40:23 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id ch3so7394924ybb.4;
        Mon, 10 Apr 2023 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170022; x=1683762022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTQtPc1KR8cL03Cu4yvySUtsAqnCh9TcCbpIOpD082E=;
        b=LvCJtpdvUXGmM5tCLD26vrPYHaTbyVySqbpJLltLM6laOR5DGneYwNdHidQ/0KRQzo
         fAS5G/mV8BrIRT/7FJPmSRVPu4JmIyI2BIM7LU4APXhshOi0MRmTdq0EJX+ESRyt5Odv
         DT3aGKmmgweMnnvRcQ+qOHBoiJxHg9DbzjmucNInrCEQrndG/2kJabIALJ5GnVQzi6lF
         2iehIqncrVGa2AZ70aQbaQHcdWT1zx0wRJ+EW19+YB+HqSfmQ3cCnOyp/WY974BDKMBP
         uS8ifM14G92fEi8A++D1kZFIrQ0G7OMvvWbO6z8gEYqkFrF3RliA7fV20j/HfJjscxw4
         33EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170022; x=1683762022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTQtPc1KR8cL03Cu4yvySUtsAqnCh9TcCbpIOpD082E=;
        b=ynTDW6AAQpuOMsgqkxGCMuU8WtE/z3l2pwjmQmRSNkWEkCk0b+x93CYbV87KhyDP58
         pIINnhf1a3WudawLr8wBJZVx+MXmCw4K4vw+Ky7D1If5zs/72DMzVkMcpg8kxsuSPTiK
         7D+5BLGha5X+Zu4JkxQzyGxaQpUnItz0FYTbvlnjeOPPSRpjaunXYD0ZceJ4IAlppEaY
         lkCyxWPlP4UupDFJxj73X+X2wm3BWpb8GTn1MW2GXC9rKXn7ezZsFgKsIpNmM+N7n5AJ
         OgWPqQpbJRgizXG0QmDprglVTz8j9n//erBDGnExGQShMqaMGnMqy9HDv+PrM8+9J0F/
         FHOQ==
X-Gm-Message-State: AAQBX9dlupK5k9UnSVtt3gg8dTOuLbrGZBuz+o34nsvjkdaokr0iiCCB
        EzLeuyKCbl075akvIV/ONVDUmbiobhIQNSpMNhk=
X-Google-Smtp-Source: AKy350byC3UZ5q46Cg3jjcDOCZuOE/5kBZ8jGkWjtaZzjZe5hvjzf3F5KgEQU7es7Q5ChrZQ4u786jZiUPkl5fwvbpA=
X-Received: by 2002:a25:3157:0:b0:b8e:db4a:a366 with SMTP id
 x84-20020a253157000000b00b8edb4aa366mr4583298ybx.11.1681170022289; Mon, 10
 Apr 2023 16:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org> <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
In-Reply-To: <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 01:40:11 +0200
Message-ID: <CANiq72k018LHbL7qqYXuuorD2ayrnTik8WD6MXPZgo5wR6VA9g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     Hans Petter Selasky <hps@selasky.org>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
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

On Sun, Apr 9, 2023 at 4:10=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> and I don't
> think there
> are any plans to introduce Rust outside of drivers in the kernel at
> all, last I
> heard.

This was indeed our original proposal (actually, for "leaf" modules in
general, not only device drivers), but where the line is drawn is up
to the kernel maintainers. For instance, some of them have expressed
interest in potentially having Rust subsystems in the future.

Cheers,
Miguel
