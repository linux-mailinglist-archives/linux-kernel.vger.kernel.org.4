Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6832C60208F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJRBph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJRBpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:45:34 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB13267D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:45:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 81so15347528ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3iSsnst/L6NfYcFirJxNRFbBLqldZchqVKRw0L9/A=;
        b=H/plYs2MWaQCz1Qqw9VMwAz1iRItNX7SVB3TGcCPvBYrMnjlmtkSONdjaiHGm/pPbd
         jlzvDiU01I5WFPQXBUXd96ZRTu3w5UaLAFv65FzhMl507pp0bC6HGJDGNEb51u5cCIaz
         WW6jHLk7lcRrz29dOzsKhNPOqELmECXOALgjP+nhp5VsRvYZhh+8XKNzJaLNVU2LmZmg
         QtGVo8YH16hqSFb8QcCSo/BzlePQ91nM+tb/LcpU7MqKxUmkf8tPCg8X6g5b5gDeYE2H
         0ipUAhKtIwxjTR1CgoBKc7FSr4jNIyL6y6lieu4h8O6ApZTRZr8qg7W5NADitjXsv9eJ
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc3iSsnst/L6NfYcFirJxNRFbBLqldZchqVKRw0L9/A=;
        b=qvvM4R2e0ccQas68B0JOaUVV1cKFomCQCQ0A1o0c2JJZtrw9dbxUF5QH2nDQ7/GoN2
         Fk/1qvBkEmxwhtv5rUL+q228NJkf9piyXuXV/Tu7nb5dAlKB7rTuYgougcKkwWQ1oe4A
         HPV5NHaJ9EEr1TGtgU41Xtu1XNBFWIAvUsczVCiNpGJNfBU05gVmeJZKMEWWDG+Fkqjx
         soo1UnGqDWOEhgvgvz4WXdQ6F7M8Mw7yCvfX9UehJAs9ya2GBzw/QQYC4A6JPndypAr5
         w7tB2Hs+VKIHvz8gYXg3ZDJ/J8fe+fCNUe1HutXHYcbEfr24lNddd+ZjO9cRLSxpJfdC
         pyHg==
X-Gm-Message-State: ACrzQf3F1mZmi0WtvRwsFTt9nKov6e+TyvxNAd2wmxKi4kKB3jTIKmkY
        VUMd51h+XJy8IeXfJ2JBT9mM9+fCfK3KtuosOlCY
X-Google-Smtp-Source: AMsMyM5On7bmlgMjHo9aS9yblYhNGik82fUAxWDT98YVn+JNWN7U7X/bxVWBK9j42c5h+Puvi3EkuJP8nBCbwctcGEg=
X-Received: by 2002:a05:6902:124f:b0:6c0:770:1890 with SMTP id
 t15-20020a056902124f00b006c007701890mr491854ybu.186.1666057532860; Mon, 17
 Oct 2022 18:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210222150608.808146-1-mic@digikod.net> <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com> <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com> <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com> <202210171111.21E3983165@keescook>
In-Reply-To: <202210171111.21E3983165@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 21:45:21 -0400
Message-ID: <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 3:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> [*double thread necromancy*]

Yikes!  This is some pretty serious mail thread crime ...

> On Mon, Feb 22, 2021 at 02:46:24PM -0800, Casey Schaufler wrote:
> > It wouldn't. But compiling the new LSM mynewlsm doesn't add it to
> > the list, either. Today no one should expect a LSM to be active if
> > it hasn't been added to the CONFIG_LSM list. The proposed addition
> > of CONFIG_LSM_AUTO would change that. "make oldconfig" would add
> > security modules that are built to the list. This is unnecessary
> > since whoever changed CONFIG_SECURITY_MYNEWLSM to "y" could easily
> > have added it to CONFIG_LSM. In the right place.
>
> Having CONFIG_LSM/lsm= is to support the migration away from having a
> "default major LSM", but still provide a way to separate "built" vs
> "enabled". As such, it needs to provide ordering. (So we have three
> concepts here: "built" at all, "enabled" by default, and in a specific
> "order".) And not being listed in CONFIG_LSM/lsm= means an LSM is
> disabled.
>
> I don't disagree about "anyone who enables a new LSM config can add it to
> CONFIG_LSM", but really I think the question is why require an _ordering_
> choice. Most distros and builders don't care beyond having the current
> "default major LSM" come first, which leaves only the "enabled by
> default" choice.

The code sorta cares about ordering, at least to the extent that the
LSMs will behave differently depending on the ordering, e.g. a LSM
lower in the priority order might never "see" an operation if a higher
priority LSM rejects the operation.  Yes, it's an implementation
quirk, but I'm not sure I want to start messing with the
fail-on-first-error logic right now.  Maybe once we've got the LSM
layer fully stackable and we've gotten past the initial support
nightmare of that we can revisit this idea.

> I personally think it's reasonable that a "built" LSM be "enabled" by
> default, however, this is not universally held to be true. :)

I personally would like to preserve the existing concept where "built"
does *not* equate to "enabled" by default.

> I *still* think there should be a way to leave ordering alone and have
> separate enable/disable control.

My current opinion is that enabling a LSM and specifying its place in
an ordered list are one in the same.  The way LSM stacking is
currently done almost requires the ability to specify an order if an
admin is trying to meet an security relevant operation visibility
goal.

We can have defaults, like we do know, but I'm in no hurry to remove
the ability to allow admins to change the ordering at boot time.

-- 
paul-moore.com
