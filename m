Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E8691792
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjBJE02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBJE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:26:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B7658D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:26:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m8so3768699edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 20:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pt8I2gDFGkJc89VFttBAWrczFbW6HxF9sU3Iiy4h4oU=;
        b=g+HDZLcbqkc9l7r/SLkHf3MTXGwy+3wwTPT71E8FfYc4mybXqO31ghDAQDsbZu2uHl
         FzPJVeyM/Dtz86hUSokx0iYG6ISvjb47q/T7V2C701u1Hm2gVdr206fksdEI16y0koOt
         VQ7t0ehgPcNQ5dLAx57Yx1V8VyT9QSMa9UI7ezuM6ISnrWVqPrpkRtoeZg7oXWVI+GzA
         CwR4o8SjPLqhBeBO6QXPgxcJDLwzgh/gSRnXu9VskUolt2xM1le5UQbOwd/0aXCstTKi
         ASCeUFtRHSqANPkim7ChOKtQa9+TLYf3/GN2G3TnMQbjwx/yDBHThSPlmwcLIOngov6m
         6Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt8I2gDFGkJc89VFttBAWrczFbW6HxF9sU3Iiy4h4oU=;
        b=ZlNb0w29EOu+VoLIUe1IOWsVrvfkdECv/w9KIrZ+gUOEt/nhsGtX6MLf3PkXRLEfYc
         t8vV6riBEstWU0cE6FNqv98JZo5GanvJzxS2hAYNK5eimvU+0FpwNVoQ/GhFtwZCkMic
         nsnarbsp3CNJ/EmfgjpuXnQ1Af/B5PAj8bIH4Huh1gBPN3o5cstnai3OdlJV2TI5l4Zt
         BjYEQk34ENRlU3qqsMo9pS71o6DoIoCUPBCuOFXK1b9elYqcSxZ1K5TtB+LQCnkIh7B+
         7UcSiPQizLiFditzd1UM4R/vEzFdpXc6pmuGtCZ4l8sH94HGMjKJDlKdijVY/9sRrsVl
         lVeA==
X-Gm-Message-State: AO0yUKVvrgxkwRr8rObfSSyoik2fnQ8ivIwEouljanGL4RtJEZ1cfKPL
        KyvcbRsR6QskrESWg2/CWrfz5fRyAgTojYhysbGjzQ==
X-Google-Smtp-Source: AK7set+5s1St957AtsOtZg/2SckKqwY/chLNneXVWybGFKOK6P3inMJFiq1XrtosXZruQD2pn4FVdVbIyB5/AHPCIzk=
X-Received: by 2002:a50:d542:0:b0:4ab:4d4d:73fc with SMTP id
 f2-20020a50d542000000b004ab4d4d73fcmr9449edj.5.1676003182975; Thu, 09 Feb
 2023 20:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org> <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com> <Y+XG4mWPi4X9/hHZ@google.com>
In-Reply-To: <Y+XG4mWPi4X9/hHZ@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Feb 2023 20:25:46 -0800
Message-ID: <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness grouping
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 8:24 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/02/07 10:47), Sergey Senozhatsky wrote:
> > > >  enum fullness_group {
> > > > -       ZS_EMPTY,
> > > > -       ZS_ALMOST_EMPTY,
> > > > -       ZS_ALMOST_FULL,
> > > > -       ZS_FULL,
> > > > +       ZS_USAGE_0,
> > > > +       ZS_USAGE_10,
> > > > +       ZS_USAGE_20,
> > > > +       ZS_USAGE_30,
> > > > +       ZS_USAGE_40,
> > > > +       ZS_USAGE_50,
> > > > +       ZS_USAGE_60,
> > > > +       ZS_USAGE_70,
> > > > +       ZS_USAGE_80,
> > > > +       ZS_USAGE_90,
> > > > +       ZS_USAGE_99,
> > > > +       ZS_USAGE_100,
> > > >         NR_ZS_FULLNESS,
> > > >  };
> > > >
> > >
> > > Is there a reason why this can't be done with something like #define
> > > FULLNESS_GROUPS 10? We can make sure during build that (100 %
> > > FULLNESS_GROUPS == 0) to make our lives easier. I feel like the code
> > > will be much more concise and easier to navigate, instead of multiple
> > > enums and static arrays.
> >
> > I wanted to keep things the way they are to make reviews simpler.
> > We probably can do something more "disruptive" in a separate patch.
>
> Forgot to mention, I was also thinking about extending zsmalloc stats
> file and providing values for each fullness group per class, as opposed
> to current ALMOST_EMPTY and ALMOST_FULL stats, which don't tell much.

Makes sense.

>
> I can get rid of static const arrays and pass "begin / end" group IDs to
> functions that iterate fullness lists and pick the first head page, but
> I think that enum values will stay.

Do they have to stay for a technical reason or just to make reviews simpler?
