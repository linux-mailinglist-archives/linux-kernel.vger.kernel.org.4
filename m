Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47489732491
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjFPBRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFPBRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:17:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC55296E;
        Thu, 15 Jun 2023 18:17:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc572dbef27so115289276.3;
        Thu, 15 Jun 2023 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686878266; x=1689470266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdIy7jSOg3ethacnumUBPvWejcfHFalmOPOBjrVdXdQ=;
        b=kBwZ05CBDLxjIrRYgqoIXWfL0UbeC7kwpuV8BFsmp7kcBqCA0tx46AUIxk1A1QXlxK
         v02tcUfSLHzLv1pDLIomzv0KtAgca/cFvTGHytvEVkHAlX5h8D9kbhkO8ktRdEQuPVjq
         HfwEsdIU1AMz8lBLQwJKJLZVQ7VVeU2vVP/JTo1zbOMJ4UpPjtvGOPvC2sQ9q/A2FnYh
         d4EmhgZm6b2UY0D4v13UO7jvdE0eoTE24czmWVmEpQzwNeT+o5qkuj7gpVrDXHR6T+ON
         nZ8plfxOibOeu0G5v972jINKgtMzd78Cs0rbUg1Zx4UdBl5hYMzcCxGK9fceUCktqfXb
         RZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686878266; x=1689470266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdIy7jSOg3ethacnumUBPvWejcfHFalmOPOBjrVdXdQ=;
        b=YKYzr4iX71FmcNze5gUbTmp4abTQuYluVudHzNH4owPcq/r0rMJao+rnUd6p9qgmLG
         PQ+bGAqE+4aP2/9bOKbRsSe41CkCds8k5539N1GuvgCTgScxLqK6z0XBLUP+ZTC+6ORM
         Y8KcZeMsQpS8YRnaYTbaTBZcrYURRHgXTkSN+KfTEyRNCZHNofh9hP/ueM/9gGeD36wp
         F1xGANCXkzBbv6SVx59KDLCkeuPVhGf2Ib0lXAXroJvShzX9pZvmfZZ9iG7OSvJPh24n
         C3ZONDyw44yThNPwuuf6EEh9yExJbyUalmbUgvEQhKwPzrjpFyzFJ/5BxLAI0xLmC+kq
         pPIw==
X-Gm-Message-State: AC+VfDwsSvyTcAeU7z2MpkqpEdd2r5MBExLbyGy3lITV+spo1n4DaTlu
        5F0FzdVVoX/qlOQcA2y/15gZvz1uJiwGuPxTQ5k=
X-Google-Smtp-Source: ACHHUZ5zSagMGyLza7Ji3+DO98qUCN5SyhfjlFbIS+MtpIjO9clCFc2uavdDu2fbokkcRYSOfIXXfN1/J2N/r2sEw14=
X-Received: by 2002:a25:dd8:0:b0:bab:e88b:1dac with SMTP id
 207-20020a250dd8000000b00babe88b1dacmr207511ybn.46.1686878265936; Thu, 15 Jun
 2023 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <PAXP190MB1631B7C90A99FCEBB1594AAE8B4DA@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <PAXP190MB1631B7C90A99FCEBB1594AAE8B4DA@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jun 2023 03:17:35 +0200
Message-ID: <CANiq72kf=VktsDS6ctLxVt70EGtkSwfx+Z2=qNMdyQf81pQ3dA@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
To:     timo.gr@hotmail.de
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 6:12=E2=80=AFPM <timo.gr@hotmail.de> wrote:
>
> From: Timgrau <timo.gr@hotmail.de>
>
> Just a grammar fix in lib/Kconfig.debug, under the config option RUST_BUI=
LD_ASSERT_ALLOW.
>
> Signed-off-by: Timgrau <timo.gr@hotmail.de>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1006#issue-169631840=
6
> Closes: https://github.com/Rust-for-Linux/linux/issues/1006#issue-1696318=
406

Thanks for the patch!

A few notes:

  - From a quick look, I think "Timgrau" is not a known identity to
the kernel, right? (e.g. I couldn't find any other commit on that
name). Assuming I am not mistaken, could you please instead your real
name?

  - When I wrote the report, I wrongly suggested `Suggested-by` +
`Link` because I didn't consider this a "bug". But you are probably
right that should be considered a fix anyway, so instead we should use
`Reported-by` and `Closes`. So could you please remove the `Link` and
change the `Suggested` to `Reported`?

  - Also, since this is now a fix, could you please also add the `Fixes:` t=
ag?

  - For the `Closes`, you can remove the URL fragment part, i.e.
`#issue-1696318406`, since it is anyway the first comment.

If you could change those bits and send a v2, that would be great. Thanks!

Cheers,
Miguel
