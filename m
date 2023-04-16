Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F36E3B88
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDPT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDPT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:28:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE432123
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:28:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso184865e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681673280; x=1684265280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gycHA7yj6cEyO67Eau7CxKEijbEYGga0ND6jZYOwtZg=;
        b=6S6DR2vTH+dFOkR6a8d71fDagEaq6IJk7sjV2HGM8i6O7MTtPWzOG9iQgN3hEjvnm8
         l+93MjO9qOgUeim+m3yfWNM+1RDM9BplZE693Ak9q1MI+qM+MprjhxNKCdYbadEwcqdU
         ZsqoEOjwVw42OAvPb+HMzjFFokh24oO32En017kDlEs0WZx/NcbaS9RRtexv9pDvA/+c
         pv/umlvE8r42uhLcnigByBKiJHzE1R68xDURC+2axOKRcMtzkXP3sbkD1SNjpOqHC6CD
         omeiKzS+wIz3Lb2bmPk9FYpLNmKk5KrnzfqtnftKTVneyLuh801XA8hsXGlh0mTQ7uch
         GOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681673280; x=1684265280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gycHA7yj6cEyO67Eau7CxKEijbEYGga0ND6jZYOwtZg=;
        b=jWXiNZ1mAPhLD8v85OfwkNOZzAnrAAW7Oqdeo63shmh77V7+BfPVN5oC5hbIQ147TM
         EJ74/Ra+1GMyJhlFqEeRomb/C7H9dCmYudLesgfP23SHFGcce/F620OMPA8zAz5DnSie
         tnKmoqOfgm4ES87C5LKHInxlIZRY+p5yC3+fyyj0se2EbMSJQgjPo20kdRaEoLrfcy/4
         N7sbgbWXxQSQCgf/mbIQeWe+wzv5oeI/PzHpFYWeJUedEzT4Ullh7OK1CIJC7RSnwxMc
         nW8FTyA1g4Z7Y+wNZ5+JPLxUsPhxkLGP4fPuJ9j9VkcUJO62604Pi93FuL/9OqMENXy6
         Ct0g==
X-Gm-Message-State: AAQBX9d7kiDcj3rXbuDNeRwCWgFkRRhdkjXHjGMuzpGUmqv7HutS8o1j
        U+mfDQhlXU/cGZUQBCaNK+q4FCdGYsbFleAOjUBJuG0i/0FU+sLRqbs=
X-Google-Smtp-Source: AKy350b/VL/+Q2o9jnSxvX2anT9FlHG65dUlkiaAS9inf614ndGS1epsRFhqLkGDkLIfII/9cJJ34uMBzUo7abuIxPI=
X-Received: by 2002:a05:600c:3d13:b0:3f1:7490:e5a4 with SMTP id
 bh19-20020a05600c3d1300b003f17490e5a4mr4545wmb.6.1681673280121; Sun, 16 Apr
 2023 12:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com> <20230416151853.GK25053@google.com>
In-Reply-To: <20230416151853.GK25053@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 16 Apr 2023 13:27:22 -0600
Message-ID: <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 9:19=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/16 01:20), Yu Zhao wrote:
> >
> > Seeing the following crashes from mm-unstable. Please take a look. Than=
ks.
> >
>
> Hi,
>
> Did you bisect it down to this series?

Not exactly -- since this series was the only suspect I had, I cherry
picked it to v6.3-rc6 and verified it is the culprit.
