Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125227494E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjGFFMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFFMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:12:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D661BE4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:12:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so200891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688620359; x=1691212359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytLtdURE8ci1p8O07WRCYTemM1Z6XZ6vCUH5E5BlFNk=;
        b=wdriVbGjW43OPJ6t+uBLbF8yBP9zVmCjpkWDsp/8C07ojo5tvNbeU/8KpY2peE3R6o
         gBZEL4+YIWkd8t2MnPcVTjjG0AczP2KJJdTxb0zvlmq231NtE5mGgF4uk1EmmvQdpAIw
         Z+NTkULhjtgZqkS8m67oOdCNmHmQyyVHrqY9aArYaxqChB2kxgL8G86RBofUUIIbQLMx
         MoHvoFYv1p9GtPVVac0eCDahj/qrbdIgsrcUmyrLF6BPNNiyVn9MN2W2OaT7RKLVxNeM
         JKPdTl5gQXzEbQ59r4B2fjFl9akz8KR5IjfQZAMNPiSnN79XU3NpA9rQ8fvMXjonXet4
         dUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688620359; x=1691212359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytLtdURE8ci1p8O07WRCYTemM1Z6XZ6vCUH5E5BlFNk=;
        b=aUhE3pQ7cr02qyo5/9g8j587IIv9TmyfKOReND+NwKX6egSv8wpVcbbk+yYwptaVoi
         4uKKO6z5hNJeQ/SKpQJV254mqnAtQWD9W028PuGX48t/6RaNP4qdwDccaHLoS+e8Nm9X
         PaD6Wk91Vw2WbVG9Qi2x9ReqQLNkR/15Aj8/pF+dPbJfWSoKQLMaB3tlVcIzYWg7hkd4
         +KX3gFhsijCkCt840p+EifFKqC4tM91TnQT70vdbD/eN+qFdvylwD0a+/hzuSC+wZvTA
         VjJlgBlfxf5Pbagi3VQEkKqzIa8s+zJpYIdsWBrqYuSu6JypTb0vOnjq6u9mC6p4XyKc
         XgDQ==
X-Gm-Message-State: ABy/qLadvlam21g/NJCrRQU/ubIAqjaq6GS0QMg3JeHRbgTxAQUaln7p
        UT1vAXYmxWV1uR1nGL5gLV1wf+MKvC4vpmNy9DWW
X-Google-Smtp-Source: APBJJlFC39UupwXY44uw6HCPSzb8ZZHacNRKC5iAYB0XEXyIDerGoosbNVBvV/EMY0jseiKcB596jxl2p048/OWEhPs=
X-Received: by 2002:ac8:7d0a:0:b0:3ef:404a:b291 with SMTP id
 g10-20020ac87d0a000000b003ef404ab291mr41859qtb.7.1688620359494; Wed, 05 Jul
 2023 22:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230704052405.5089-1-rdunlap@infradead.org> <20230704052405.5089-3-rdunlap@infradead.org>
In-Reply-To: <20230704052405.5089-3-rdunlap@infradead.org>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 5 Jul 2023 22:12:28 -0700
Message-ID: <CANDhNCpVznR-6-cf6dLYF30MPK3ktj4=DjDjku3OWU6p2hyzaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] time: add kernel-doc in time.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 10:24=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Add kernel-doc for all APIs that do not already have it.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Acked-by: John Stultz <jstultz@google.com>

Thanks again!
-john
