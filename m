Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250DE6BC302
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCPA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPA44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:56:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5839CE7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:56:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l1so48960wry.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678928213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSS+F/Bcd2QhmEMKAbEPUNmDxd0R/g869+IJjWilPDE=;
        b=kl3P1XmqGm/PjnhrcemaaT1eDsQbDT7OaLMbx5PrNaAOzp3piTiWS1acowvnM4T1lq
         34dFYVU99ozRoktHFvDf3Cc29QPD+Xoo4LJwKooDWLA++dUfWRTCT+W8EJHD4ihJXv9+
         fTjSqFBTM+Zsx8RQf1CO6lzOB/HyKDpeJYIzQpIoudeExrPyNLf1OHYt4jynAyv9PFuK
         2zhttqolKCFLGw+secwV5lP/gyk7NG1tvuFv3s8g2F+yjap8mqVUhQJOLaGOmMvvGcAR
         ajsoOSXV05O2tYEZ6BmYDr7oyL0+psFPIzRtGgjVhnoxZ7dOlskc/V2Zi4sfn1h014y4
         qBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678928213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSS+F/Bcd2QhmEMKAbEPUNmDxd0R/g869+IJjWilPDE=;
        b=vIGjE5BeuRLlKrGJBuWVxwkXdyidXuk5vvFy5fSSlg4JQdyCrcWBPVQl5HGPfzKY9E
         +7jdbxUaBF5cHxV9ftB0GRJ1idlM1iArJV9vLaUUPnNuC/Tnj3Pbx/rBgzcY7V+n9Clj
         LV2YZW1/4cqSnswsGQRNvSvry9TD6zCdxqvDY9If0L5OSPltsyro8OEQbR0jG/0DF9VP
         HGDq3rwtFTxHB8u+M9PStsN6zzlUXd5KqaZXsUlclkd1ygy+Ubx3TeAIQH+MveoN1fd4
         90unIzyWAIzSotJXh0vbGawjs3GfurqwDErWcuzV+M/rYDVLQhW4hO/uNCRdNL3lx4mL
         TOYg==
X-Gm-Message-State: AO0yUKXSLLvJghM6mVKCSbDUp1AznyiDJNJykj14/5VUgnZpzKyyUVdN
        t3v9oDdmcPbCPZl/5CZgucwMGyHR9LYKLZpuAkg=
X-Google-Smtp-Source: AK7set/jPlgH2eVqfMD55DQ8G5zEr9rlx/qG6YULKO700aK4Rotie4fqPVvrHpTzfEHwkB1W9OJsjGaSdxUsEm08eeA=
X-Received: by 2002:a5d:4687:0:b0:2ce:a3a7:5d3f with SMTP id
 u7-20020a5d4687000000b002cea3a75d3fmr945658wrq.3.1678928213248; Wed, 15 Mar
 2023 17:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
 <c708bced26624078842ff7d83e8597d7@AcuMS.aculab.com>
In-Reply-To: <c708bced26624078842ff7d83e8597d7@AcuMS.aculab.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 16 Mar 2023 08:56:41 +0800
Message-ID: <CAJNi4rMB46z2hejoPCHyy+qDwE5U2D7H1OUwZ3+_pFAT9-cN3A@mail.gmail.com>
Subject: Re: Question about select and poll system call
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
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

On Wed, Mar 15, 2023 at 4:59=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> > 2. Can we unify the two different system calls? For example, using
> > poll(...) to implement the frontend select call(...), is there
> > something I'm missing for current implementation? The Cons and Pros,
> > etc
>
> The underlying code that implements them is common.
>
> Beware that the glibc select() wrappers have their own limit
> on the highest fd.
> Exceeding that limit (probably 1024) will cause buffer overruns
> in the application (One of the Android apps I uses crashes that way).

Ah, interesting. Seems glibc doesn't make that limit from my testing
code snippet in last email...

>
> select() also doesn't scale well for sparse lists of fds.
> So it really is best to use poll() and never select().
> (Although for very large fd lists epoll() may be a better choice.)
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
