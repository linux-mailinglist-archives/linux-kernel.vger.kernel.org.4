Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C45F4DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJECwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJECwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:52:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9BC399D4;
        Tue,  4 Oct 2022 19:52:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lt21so7413078ejb.0;
        Tue, 04 Oct 2022 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJwG3frOWn9EMl53OrFRq9F3gFMhYSxA/Qh0S8QYeGk=;
        b=R1Jv5DleiacEd81pWFLhrNGh6FeGASjMYG4OMAPZ+NMJMqyZr0Th9+B+ILT7IJ/REK
         xUiE1eqRHThBIKTvmfPIgDQIQSeLxdOJW5gvtGWmYt+E18UdfH/kjEQMFIMFefMRkKtv
         Tb560rYyRSu9lUT85LbJm8nSNWBIPm2JB8MUTf8KQSQb3jvihkLLBwCciONH5wz5knKr
         rvsXp1NEbObl3IzjJT1Vujya8b4ep5UZfL+IVRp2ffg4WzGl6UZpHWkj4OX9tOpJuGUj
         mmjAz7rihELLx8FvCvr8Z4Jya6MTLTAQT26F8UwK27TChA1fx6nHmvpJxZgkADITl/3o
         OEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJwG3frOWn9EMl53OrFRq9F3gFMhYSxA/Qh0S8QYeGk=;
        b=3f0tdjGY8pwq4bVukYTfcBktUzhHY7m/ftRvdV6Sm+fEvptycE1JIKmMq2kPZDy8D+
         H+2nGNayos3LgbUlfcyCpwJd7sBEcEXCiKA+doQtDPUSiJbtROd4mol33dXHji/3avzr
         0W870jrmfx2zHSblU8CiM8w7tII1yzNJ77a5WVUgBoa/Yx2yL02icnf2jKY1lnIONIEc
         1M+63WwSty13HNI142CYukSYbzRA/HE2RcNn5w4W0Bc2Qk4IoJSiQPCajaWOYIntMZ95
         nMoU6eekfaOUYVTRifEjLYpQB0Hii9z8gqQAvRxGUWVRtg2MLxbDZsvgGn0PMoOUKFXH
         lNlQ==
X-Gm-Message-State: ACrzQf27VRoz0cFXdQcqEez7xROZ4sCxLgcYYAc9UDeQyu70ceW/A6dR
        6aKt6/mvumUl34uTuwqPNrreNE0tP8YUzhVgqrA=
X-Google-Smtp-Source: AMsMyM6ofTEPyaplhV3tgR63D05cCHG4Sto86JoJxRELTJI7Hpqan/bej3wemN8eW4Y3hSOqKdrr/ApkAo81Hz3CMwA=
X-Received: by 2002:a17:907:97d2:b0:787:a9ee:8ced with SMTP id
 js18-20020a17090797d200b00787a9ee8cedmr22006722ejc.335.1664938361318; Tue, 04
 Oct 2022 19:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221004072302.345bfd4a@canb.auug.org.au> <20221003222103.GM3600936@dread.disaster.area>
 <20221004225012.501e11ed@canb.auug.org.au> <YzxX7ks+YD7U1dcl@magnolia> <20221004210400.GO3600936@dread.disaster.area>
In-Reply-To: <20221004210400.GO3600936@dread.disaster.area>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 5 Oct 2022 10:52:05 +0800
Message-ID: <CANubcdV462CTQQsmkaPG-dP1Cgy6BqHKj-gXZzh=U=pH+i7dfg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-xfs@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Dave Chinner <david@fromorbit.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=B8=89 05:06=E5=86=99=E9=81=93=EF=BC=9A
> As it is, I use the convention of putting an explicit From: tag in
> the commit message that matches the SOB so tools pulling stuff from
> mailing lists do the right thing with them (same as any third-party
> provided patch in a series).
>
> > That said... I think we should get in the habit of asking patch authors
> > to make sure that at least one of the email or name strings match
> > between the From and SOB tags.  I can see how people who grok even less
> > about how Chinese names work than I do (read: lawyers) might get fussy
> > about this kind of thing.
>
> As per above, the normal solution is an explicit "From: <foo>" line
> that matches the SOB.  It's just annoying that our new-fangled tools
> haven't encoded this long-standing convention to warn us when we
> pull a patch with a from-tag that doesn't match a sob-tag.
>

Sorry, but I'm not sure whether what you mean is adding another "From: " li=
ne
right above the SOB tag like:
=3D=3D=3D=3D
From: name2 <email address2>
Date: Mon, 12 Sep 2022 xx:xx:xx +0800
Subject: [PATCH ] xfs: fix xxx and xxx

...
the commit  message
...

From: name <email address>             //added line
signed-off-by:  name <email address>
...
=3D=3D=3D=3D

Thanks,
Stephen.
