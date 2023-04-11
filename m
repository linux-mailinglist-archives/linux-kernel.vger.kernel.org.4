Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AB6DDD96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDKOUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjDKOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:19:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286E5259;
        Tue, 11 Apr 2023 07:19:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54bfa5e698eso314220587b3.13;
        Tue, 11 Apr 2023 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222789; x=1683814789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJL8EDeskQ3buhuZ8RqVzrQqA4hbPhWzL08/j/4ZyRo=;
        b=QhwckLrCQrR2ez/4jbDIdPlk6XKAtiDAf0x2Rf6RYj6bv0GVysc5m0bZHv+b78otjn
         IUc1Ug3hhLMCIWxJC50l8ZW2p9HhR3/u0vjJSImCZlqByWpAwct4Ee3+d+O8Z4xzR5/M
         IW4nAjZEvxjZOIJt//ib72v99BTQi4fxtZEUDU+z5B1Zmtyd8+pN1KJaW3e/J/2H77Y/
         GOW9N31adcb230fW5nhZ9T3eWzc95CsJZs6+EaES9b6ei+E8oroKrVQnYxH1oY55K5QK
         qmGD4EOj0Z6MQh6goqHsbJBzencKm8HCBsdsTmLsMCNV+Zo1cMA985Mej7BCqxwMX5tu
         APeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222789; x=1683814789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJL8EDeskQ3buhuZ8RqVzrQqA4hbPhWzL08/j/4ZyRo=;
        b=TLn4AYTiwwH1Vr2S0f2Ju/xAq47rB0H238VI849z6F4HgUjUr0o9MClS7mQTiPkb2I
         S3Igh6xZzIl6HiOC0rrmrPh9IrapZeE/Bc96OSABGbgEtjnmFKcPoa6dlvxtJadclPH8
         GdANxrZKwzl5Wbn5DvJcELBVPedqwcnBkac9OdMjBgH4A9dukDr/oAxVs/CTHuuecOvd
         bhGvud+5db0rQXtt2Y9eePYPqEQSRolZZ/UAcNNgdSZiGi6mVdqfc/bqsgvCkAhwzkFH
         PnHzTq80CYUgXOG42W9VksJ0WE6qIlXqyw6jqtVyYW8rpTLQWxN3x6E9cZp1gkWjAeVw
         cBhg==
X-Gm-Message-State: AAQBX9d4yeyqrcSQX/c8/Xiu/TP/JiH8ZUwUiSj4/LNQq+fbuFp1I2jD
        E+Yr2gM7SyUSeIMwo7bhKArylMBfooWn+QeI1qg=
X-Google-Smtp-Source: AKy350Zds44P7TdR7/cQA7b8nkFOjg+S10X78uapMOOx7SnVXZupZRI/jvfa9Pk/gkd1MKqhSHdhVhTpID+W8UHs9gs=
X-Received: by 2002:a81:b184:0:b0:545:f7cc:f30 with SMTP id
 p126-20020a81b184000000b00545f7cc0f30mr6022073ywh.0.1681222789320; Tue, 11
 Apr 2023 07:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org> <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org> <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org> <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
In-Reply-To: <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 16:19:38 +0200
Message-ID: <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
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

On Tue, Apr 11, 2023 at 3:15=E2=80=AFPM Hans Petter Selasky <hps@selasky.or=
g> wrote:
>
> If you cannot build a new toolchain without a new kernel.

Why not?

> Then you are stuck forever to build a new toolchain and kernel? Do you
> agree?

No, I don't agree, because I don't understand why you cannot build the
new toolchain in the old kernel, or use a pre-built toolchain for that
matter (whether built by you or by somebody else).

> Or you can say, someone else needs to deal with it, but then you have a
> single point of failure.

No, you could build your own toolchain and save it somewhere, if you
don't want to rely on a build from somebody else.

Cheers,
Miguel
