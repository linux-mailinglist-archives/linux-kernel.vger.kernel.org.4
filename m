Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D706C7306
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCWWWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCWWWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:22:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13612A9A3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:22:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hf2so24601045qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679610141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMsUA1oydzTRboxQIpYrDLUbNVlpVOoAHdk0YZIU4iA=;
        b=mO7QDhv3G++xArQnQGuymA/vNePYJOzDXA0KcafH9fVwRLbnb43WaoMuTBLOif4aCq
         8FVPwESSrol3rUDWJp1YwKi5F4bK0ncxdiF9pq2I+kZ59RYWCl99sLUNnFsajYSuMuJu
         iMg+0d/6FEkK0N4cKbh0rnO7+rE5GLB5bY7j/nKcg6IutqMvbjdILn4Orw1ibfIgrKJ7
         InC7HgdqmmMRWPlkF7JOtlgOLtKDgYH+/y9cnlg5/9/5I5VekjG405JbZdKOB4kJtx3O
         w0ogt3hkfdpc5uwk/FF7BlGFA9tKQCYU1hVyZRzgt1cFQ3oOwuwDcTlXvGeUMBV5vzRA
         Hsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMsUA1oydzTRboxQIpYrDLUbNVlpVOoAHdk0YZIU4iA=;
        b=D31PhAGK0EigcuIy1VtUY7buKxtSwCB5QtARfykq+vcLU2zYR/iwnXx6V9ZB+s15Ik
         PsZ7qIQ4xh/Y69+pHdE14Cs2JZKomSAbdMTIvUf0VJKYt+IcJu4P6p2PK8MaiDpRwJLc
         RZVK9XHlWFGpt+f1YmGGuYuZ/CRErnNdUv5/UCgh6Rmp05hj+NA7Rms6VvRARCO23IgR
         SIBghtuElFnRsYWE4FwpVs27rbMgPj69+HiUVb+k75A9A6KuDE4hrIu9CU45L5IIz7h+
         aYIO2Rf0onJ0N6tx9EgLTXBSMbV5InVr/wy7QEx1g8NAypHGTYgF6SdTf2/kfuOsCWIp
         C6yg==
X-Gm-Message-State: AO0yUKUDH7+Bg/7+yFfqD/RyHYpkJHGxgQNURAK5VrPIeGKh0m4iYSBH
        el6Vagr/MhHSq3dhF997QtWCBUepgfGLScwCFSc=
X-Google-Smtp-Source: AKy350aa0KWzSeHgdqqXQ5iqfK6nxAouutaHE/1/UEDsP9satJOhqrY5hmFgU/AeFHi0JOKTOiu+susu7/MDo5VUoqg=
X-Received: by 2002:a05:622a:1a8c:b0:3de:65db:2127 with SMTP id
 s12-20020a05622a1a8c00b003de65db2127mr357059qtc.1.1679610140817; Thu, 23 Mar
 2023 15:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230323184537.749868-1-agruenba@redhat.com> <CAHk-=whms=0Cvmk946a0Pebv1YLWiuYCjyVy6yNeBp55+R8sMw@mail.gmail.com>
In-Reply-To: <CAHk-=whms=0Cvmk946a0Pebv1YLWiuYCjyVy6yNeBp55+R8sMw@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 23 Mar 2023 23:22:10 +0100
Message-ID: <CAHpGcMKO-C=+wPprBGnOLeA+6_PJhHatO3fANizXNAtG2kYRcA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix for v6.3-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
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

Am Do., 23. M=C3=A4rz 2023 um 22:54 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> On Thu, Mar 23, 2023 at 11:45=E2=80=AFAM Andreas Gruenbacher <agruenba@re=
dhat.com> wrote:
> >
> > From: Linus Torvalds <torvalds@linux-foundation.org>
>
> Wat?

Hmm, that's weird, you ended up in the From: header by accident. Sorry for =
that.

> >   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs=
2-v6.3-rc3-fix
>
> -ENOSUCHTAG
>
> > for you to fetch changes up to 260595b439776c473cc248f0de63fe78d964d849=
:
>
> .. and no such commit available in any other tag or branch either.
>
> Did you forget to push out?

Yes, I did forget to push the tag out and I've missed the warning "git
request-pull" has spit out. Sorry again.

I've pushed the tag out now; should I resend the pull request?

Thanks,
Andreas
