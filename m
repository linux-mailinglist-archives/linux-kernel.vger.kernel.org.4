Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A39724E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjFFVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjFFVNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:13:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D471720
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:13:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso7932925276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686086017; x=1688678017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39uw5j5XuTGu9DjyN0cv5Al3Po6ZxhAFPhk3sdMi2Fw=;
        b=DKJQTgOo05HezKqlZ9DS24TwMox0bUnFdDpVF3dgI7CN2ObBD3SaEYsbUktmTDW3nM
         cHhKGrXhZu1KqsaCP9jnv0Bp34rx+PYS100YfKOKjM4mxA02CdLOte/kP9xZfzXsU7Jr
         TVsk8/Y9qLEb8qdVpsBs1+1hJa/fIPVVsmVwSC5ndAVa7wzGueVULvzXn1GP/M9Y8MiN
         qDmSp76aEitGo90Zj5XHY850+R8ZbbjUNosIBlhmd+7ntSi4yOLtYtjUq1hxRFx85V8u
         f4aBwZg4fN7Z3DJuHteCJdtybkK6yfduBhNRkpMcRce73D+gy8uTl0/tRwQ7+GYiVlCC
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086017; x=1688678017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39uw5j5XuTGu9DjyN0cv5Al3Po6ZxhAFPhk3sdMi2Fw=;
        b=E82T6qoy/vdMGGA8rDEro85stFADra8ZaHpETh9hoil4dSYhpYEi3wWfNMD0iNZnFa
         7b8nHj50xkHSvMgU2ibW33G4q6nddTOjysvWM3deLDrD5jHm6yXOXpXvW4pV9np+cM4R
         tQIID0ItvHef2PqR4+GSN+2fzcVV3AcSlTPcqQmAY8JhgeoeiLx0EIFV51oGag7T3upz
         8yx6d9+ZYlBn+AZKIVy0LLM5hZeKbZtOdi0oRf4Dqan5CpYmSgsxEp9IQhyw6I12FayE
         JNUfpWLDWbCmH86DQQ1dAmfWRqJZkbYXOPjCXMdU31BKybeyGgdqsf1K+nJIu9Nvddn3
         V7ew==
X-Gm-Message-State: AC+VfDzqKsQha4bIU7bDa3IZKD1VnOgyXTzlOd4nAQYGWXmzYZqpt6+n
        dRLGglHThpRWUyAHyM/ed0M108imTbMCQfsFp5MzDuzTE+WBK+4=
X-Google-Smtp-Source: ACHHUZ7Qa99BZOB/MZdSXvp3X6lxNXMZNKUrs6bg5e4zcI6VWeiSNpPtkZjfFbJkTd4DlqH77r4OYNrsM6vZLPMRQeg=
X-Received: by 2002:a25:a007:0:b0:ba8:620b:38a7 with SMTP id
 x7-20020a25a007000000b00ba8620b38a7mr3428219ybh.53.1686086017436; Tue, 06 Jun
 2023 14:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com> <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
In-Reply-To: <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jun 2023 17:13:26 -0400
Message-ID: <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
> On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > pr_warn message clearly says that GID should be printed,
> > > but we have UID there. Let's fix that.
> > >
> > > Found accidentaly during the work on isolated user namespaces.
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > > v2: __kuid_val -> __kgid_val
> > > ---
> > >  security/safesetid/lsm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I'm assuming you're going to pick this up Micah?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Dear Paul!
>
> Thanks for your review!
>
> Gentle ping to Micah Morton :-)

Micah?

The right thing would be for Micah to merge this via the SafeSetID
tree, however, considering that it's been over a month with no
response, and this patch looks trivially correct, I can pick this up
via the LSM tree if we don't see anything from Micah this week.

--=20
paul-moore.com
