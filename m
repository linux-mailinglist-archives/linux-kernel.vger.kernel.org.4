Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8451B712A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbjEZP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244228AbjEZP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:59:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9B13D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:59:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b0d38ce700so245001a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685116740; x=1687708740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSRKBuS/oKd5fjIjvvaHlAtUo48fy4uJTXs+lCoN1vw=;
        b=f2sBZne/vKtkK/lk4t0/gRtIMivIWl2baIqJVKH3a4vlR5gImoHRlGZ5G4JQYE3Dih
         7nRNGmGkc9D8WsRBS+VyytzQmcV29mlOW9BIqa99N9baI+L3MPQCFI82HqV82+7+I1hx
         yANj0IJ5arSptM8ldKylACvtHKX6OCVnrBmk27xyWyIhGnD5hIGk2/4WrIS4qXkvDKZ2
         nLN7uYlvWNX9KMzNFsR0r2fwh/dhYKY2LmzQQsMcShmpJRZRWn76SeC2nShazTA5ostL
         fzi3mb1bCqNjIMJXBizkLV8x+yuWpThkNRgOlKjAAd2TszLG3h+EkuW7yGOXHxxthQiG
         +atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116740; x=1687708740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSRKBuS/oKd5fjIjvvaHlAtUo48fy4uJTXs+lCoN1vw=;
        b=dFVLDxmqAh3Gjz/+qgDkt1Ros4LAGlTKtY1oQxlEJiU8AmMqQlWp1NM6cTufryAFTU
         +ELPJdvgcrbFgq1Mda3z9EHfA4PDieURbACJaba9S+7D8wPl+27AGSo2TRv627vIhIjL
         pXO6GivNKZOjjrZJeaEophCxlG1bqQ+qe4HqH+wDbRu6exPX4SNLpGwihq37C7zStm4z
         xrs3So/dZKhDQ7s7+4FD9brh5RhjnVRfnBxmS0kfzhUZ9p6C5Uyd6SHxvlOqBjRNYkig
         GVqSjGrJtjQyEeY2qSR7S83oykWDv3evLg/qu35rP2LSHhxQ1hXrdPA0XuXzPf0I+lXZ
         GvXQ==
X-Gm-Message-State: AC+VfDxAGC8wXRb8fl+Pw5kQXbHdYDJINxZRb6JUBRwkdmQAd4n+n2yz
        u8fT10VpOhwh7GXwOvC5VcnANvHE45tBrCwMc5R1UQ==
X-Google-Smtp-Source: ACHHUZ5ZTSmP0QrHf7hz66nAsxeVVUQ0SpUHxrFTO+uHZWy73GDXXQ0RXqMJqWZ2a7+cV4JqymiWaY6rdgRoL1w+sZo=
X-Received: by 2002:a05:6808:1405:b0:38d:fdf2:962e with SMTP id
 w5-20020a056808140500b0038dfdf2962emr1562135oiv.23.1685116740735; Fri, 26 May
 2023 08:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
 <20230526172959.5440b9dd@nowhere> <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
In-Reply-To: <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Fri, 26 May 2023 11:58:50 -0400
Message-ID: <CAO7JXPit6snFM2oW-uSs-mtbmKr9wpbX2exqAUF0iAiaAO6hOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

>
> On Fri, May 26, 2023 at 11:30=E2=80=AFAM luca abeni <luca.abeni@santannap=
isa.it> wrote:
> > [...]
> > > + * but as "dq =3D -(max{u, (1 - Uinact - Uextra)} / Umax) dt",
> >
> > ...But I think this is wrong (should be "Umax - ...", not "1 - ...").
> > I think patch 2/2 has the same issue.
> >
> Oops sorry, I missed this. Will send the fixed patch as a
> reply to the original v4.
>
On looking again, I think the description is correct. That line
mentions the actual m-GRUB equation from the paper. And then the
comment explains why we use Umax(because of limiting the bandwidth
to RT capacity).

Does it seem correct to you?

Thanks,
Vineeth
