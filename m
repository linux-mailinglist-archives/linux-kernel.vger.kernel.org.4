Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00426F9B38
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEGTxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 15:53:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65911562
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 12:53:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-559eae63801so56450387b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683489196; x=1686081196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyj2EiCvdTduHLqcmu7mXgIBGvXlvMB1pane2tqkF7E=;
        b=HovbGonvcX5N33ZjAIXpk4nBo33sAlxq1QGT9NpuhVKTsJ+IPtEw9Cp0pK3vMQqZCX
         yMERRh6IsK8ylRf73EWSXkyxzpndyvw9zupn3p6xHJtD6gh6YQnVVMmrhzQzNnp/3k82
         WvBn7PioMWALD9g+ebvbodFgl7/8Zdu91Kkz7apHZvluX0naIRyiebich3A8BibOJ5ud
         x4u598AtsP929aBszW6HtQkOJeQzHnv9lc7PiAdtQJiyGXVl7j2NvQew1QYm2We4ZngS
         cmO8wXENruc4TD8Z4g4R0Ngf5MD+xWtep2Y3ix0agt9ARcjjDYtovnqY7/J87qqW4DWg
         MMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683489196; x=1686081196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyj2EiCvdTduHLqcmu7mXgIBGvXlvMB1pane2tqkF7E=;
        b=FgZYdR7r37Y8GWbPinMFLQ1ripsIB3bli+dvnVxsd3hLT4harlS0W5sp9DVIn/hipT
         ESOT2usNjSit9vwij4vB6dWUdYBRytIrcw1+XTyCEC1rB56D2Le1xbzcPMmja58HZK8u
         LPWh7gSR+R2xQeJzLK4IfJxvvnZmYmZu2b3ng6DXARXN5CQYIAVr7u3zKyTiq8JlceyB
         pR6qP92Z125gj+lGJyVDmjacGB5Lc5iUnxUvOdGt8Iw1aBKDItDMpA4A3Xt8ZTITZLSv
         EfH+qE+DAwm19H8fY4oU93ELLKkBqdOv/NXxzbSXPvtqUJQ3coeyyNV5HWi75VosVEmt
         SAIw==
X-Gm-Message-State: AC+VfDwq/T62b/zMYeAXyTZSpQ7sScJFEOnBLkA3DthRGLysNoUyL98A
        u/D1bhFpa0XpavLndLmT34SieXV5fpyNUYMgbw+W
X-Google-Smtp-Source: ACHHUZ7pNs3NaZ4FLiSZ/VNIGrR4CzLJdGR6zgvUQNMJX+pul+3P3AfyeKE5TmTF6NGa13Y4VaviefX/KFQw2NkRUEs=
X-Received: by 2002:a0d:ea4b:0:b0:55a:20a1:4ba6 with SMTP id
 t72-20020a0dea4b000000b0055a20a14ba6mr8815170ywe.25.1683489196101; Sun, 07
 May 2023 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com> <87pm7f9q3q.fsf@gentoo.org>
 <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com> <CAHC9VhTX3ohxL0i3vT8sObQ+v+-TOK95+EH1DtJZdyMmrm3A2A@mail.gmail.com>
 <CAPDLWs-=C_UTKPTqwRbx70h=DaodF8LVV3-8n=J3u=L+kJ_1sg@mail.gmail.com>
In-Reply-To: <CAPDLWs-=C_UTKPTqwRbx70h=DaodF8LVV3-8n=J3u=L+kJ_1sg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 May 2023 15:53:05 -0400
Message-ID: <CAHC9VhSfrAUJaP-MbTXFyLgAz5P3McjD0eouj+-7QwOrrYt8MQ@mail.gmail.com>
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
To:     Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Cc:     David Hildenbrand <david@redhat.com>, Sam James <sam@gentoo.org>,
        Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
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

On Sat, May 6, 2023 at 3:05=E2=80=AFAM Kaiwan N Billimoria
<kaiwan@kaiwantech.com> wrote:
> On Fri, May 5, 2023 at 8:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Fri, May 5, 2023 at 11:15=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> > > On 05.05.23 09:46, Sam James wrote:
> > > > David Hildenbrand <david@redhat.com> writes:
> > > >> On 04.05.23 23:30, Michael McCracken wrote:
> > > >>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_=
space
> > > >>> sysctl to 0444 to disallow all runtime changes. This will prevent
> > > >>> accidental changing of this value by a root service.
> > > >>> The config is disabled by default to avoid surprises.
> >
> > ...
> >
> > > If we really care, not sure what's better: maybe we want to disallow
> > > disabling it only in a security lockdown kernel?
> >
> > If we're bringing up the idea of Lockdown, controlling access to
> > randomize_va_space is possible with the use of LSMs.  One could easily
> > remove write access to randomize_va_space, even for tasks running as
> > root.
>
> IMO, don't _move_ the sysctl to LSM(s).

There is nothing to move, the ability to restrict access to
randomize_va_space exists today, it is simply a matter of if the
security policy author or admin wants to enable it.

If you are like Michael and you want to block write access, even when
running as root, you can do so with an LSM.  You can also allow write
access.  With SELinux you can allow/disallow the privilege on a
task-by-task basis to meet individual usability and security
requirements.

--=20
paul-moore.com
