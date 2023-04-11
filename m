Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672526DDDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDKOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDKOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:23:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D15257;
        Tue, 11 Apr 2023 07:23:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id ch3so9391967ybb.4;
        Tue, 11 Apr 2023 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222987; x=1683814987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGIJwNZALprFDU80qb7cLcULxCnkP798jciFwdeaCog=;
        b=joFbieJB4dNxX8sxkqhUhjHbar19aTEVvpvIdMu6Xk00cqzGFSxcpVPcE0ZhmcN/Ss
         MNZKksNaoIdjUEVIoXEBiGYAuvh8ElzpUzQLyRbp99EkzmRbw0YYJbrvk3emVQdj/QGN
         aUDE998eKd1Sr5OgmpsvH8WOjBqIXgEZ3Vn82t0SLZkvEtz8P5y/XaQuq7yGaaenIMMd
         HAoW6ijwOLjqEl/OsugTHXGO3vm06p5Btci7eF+TRiCablDjcM2amAwZwK2He9VBOXq+
         nXqXUWI6WZYJtL1mqDAuIJ2iwNla//Z8ShZVM3zMS1hAkOqUDcoiAASgXB/kRTVySd7o
         25yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222987; x=1683814987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGIJwNZALprFDU80qb7cLcULxCnkP798jciFwdeaCog=;
        b=FGg0Op61vy4a9O/sLlfB0FPDcpphT1o0MZg5k+EnwHYOEc5lN2LErlq0bs7cNWXikf
         qkkiV0V5rUL2ZikYNtUNKHW7sUwEnRfCInlx37k9O/5aVLL8RK7gjcKd21ichvEClgB4
         qN0f34QUvSnTG3d4c6pyg6x9Nx1jFP8K/iTOnWi6gDY3l5+288u+abNwbUTg28lcNSEF
         SSUZsPd0IHb1Qxt4U8M3xf1oopIfJeImZNqZQ7GEodeYyf5FM+JyN5JrTU9QYgmeDFGX
         +QVwuTDcwMdF0G8WF87tV962XS0VGW+qf/iiFUPnZlgDp4N5yaBf0LqEmq8IAt4SGatf
         ilEw==
X-Gm-Message-State: AAQBX9drukF1HAhtUO9wGhCv7umG7dW4GWxKwTI8dKmFDjK9J4R+jfjH
        u3jMsZAoQf+BmJMTk4wdADYpe9xqwpJWN5h0SLc=
X-Google-Smtp-Source: AKy350ZOx+VBe3+xkPnUYMJSj5Pt4g+xiGsIEOaxHOPkp2VcWmohs42AsVbpcpUA8/gYAOQHoB97haJtY8ngSMfB2iA=
X-Received: by 2002:a25:d650:0:b0:b8e:efd8:f2c with SMTP id
 n77-20020a25d650000000b00b8eefd80f2cmr4525679ybg.1.1681222987084; Tue, 11 Apr
 2023 07:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com> <ZDSRSWhWsN34MghQ@xps>
In-Reply-To: <ZDSRSWhWsN34MghQ@xps>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 16:22:56 +0200
Message-ID: <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Deborah Brouwer <deborah.brouwer@collabora.com>
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

On Tue, Apr 11, 2023 at 12:46=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Hi Daniel - I don't know if the 'rust branch' is common knowledge but
> it helped me to know it was this:
> https://github.com/Rust-for-Linux/linux
>
> For what it's worth, I was able to get the V4L2 Rust sample probed
> pretty easily following the quick start instructions
> https://docs.kernel.org/rust/quick-start.html

Thanks, it is great to hear that the guide helped! :)

On resources: nowadays we have a webpage, too. Still to be completed,
but you may find it useful already: https://rust-for-linux.com

Cheers,
Miguel
