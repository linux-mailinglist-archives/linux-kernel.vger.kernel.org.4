Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEED6D5154
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjDCT21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjDCT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:28:24 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EB1A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:28:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5463fa0c2bfso241506997b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680550102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9I3S15nqjmq/VpBKAht/PvKJEFQQLGuZ/bW1VqZbfs=;
        b=IyN7FxGoF35SVlsmVSkP+ewtImKekTWA1yEJClJ/qU1ZeHLLJe7j1a6XkZM+QwnitG
         iOI4L+AFo18QVXaJzP9yXKDip2x3G6pgxoWSZj6ZDtk9cuwxrYcNOmbIDSCtc0iuUuSG
         rR/fbS0p5MgU6TbaC0UcdVAQ58GnqXJHUqSSNiadbUE2j8nIvSArRYjKbAUyEkmRo2h2
         wnS7Yc4p7Y8Y4FrZ06tBKDMKRv9MqlJqDx0QjyEXEIeXZwQIfnQ67rb3XVWebvkvlBjr
         XxQGcXOp7u0LC8xRGR3+h6+ph/m59TUiD8xm8no45CPYK+MxKzWXLJoBmWDZTT6x9SZC
         oC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680550102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9I3S15nqjmq/VpBKAht/PvKJEFQQLGuZ/bW1VqZbfs=;
        b=EUBJfaw1YovSBcwsJBEl21uc7Ncq5r0ICFQ+1gCHjy8ty+AhaYR7ON6Qw8H+wByGvx
         abhfj7tdlxYlDUTN9MgL7HuMFj1Fiz8TlZuLez/kPC6PVzn9Y1WsPyNk8A0kWBqXVrUM
         tMCDp7DLliWPLHeRVPDaMGQXbGMgy0UK23RlRAZAv+SKBU5wEGzXYtxeqGcnq1jOajev
         bgNkNQBX6zZCanQSDyEFsb52ZTyuvoBcpNGOYG97efRniMKAW+gJCZlkgcPlwuSPBlIa
         k+7MVOfWums6alFEYRP4Jm5SpwsobfCJwP3+1MR1bxb/31foYDlYvcdvv8O3A5REVYRB
         mWhw==
X-Gm-Message-State: AAQBX9fm/97A45JEXxoXQ5V8bf0MtFhdC49o+CaWwh4U6NwfnxXAA6jH
        ZRfkzGR584vxkrZNrmyqzjpE0Oj5RLckIWUPt7Xx
X-Google-Smtp-Source: AKy350ZpuRBVczYWzU7b23b5YYokSEQwjmixNyc9iDT2GeF6yGMPV9McOXbrBeADGCew0tY98H4oDujnNQU83gb4STg=
X-Received: by 2002:a81:b389:0:b0:544:cd0e:2f80 with SMTP id
 r131-20020a81b389000000b00544cd0e2f80mr24438ywh.8.1680550102543; Mon, 03 Apr
 2023 12:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
 <CAHC9VhT6VXwybScqsnYHHtbHNPoWMVQJzQ7VAccm2MWZEz+5Dw@mail.gmail.com> <ZCnff6gUjU89zfAb@valentin-vidic.from.hr>
In-Reply-To: <ZCnff6gUjU89zfAb@valentin-vidic.from.hr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Apr 2023 15:28:11 -0400
Message-ID: <CAHC9VhTCafjmo7k=qGnOMDm4s4UHL9g=o5KgRfg9_xwWCzUhcw@mail.gmail.com>
Subject: Re: [PATCH] security, lsm: security_old_inode_init_security() Handle
 multi LSM registration
To:     =?UTF-8?Q?Valentin_Vidi=C4=87?= <vvidic@valentin-vidic.from.hr>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 2, 2023 at 4:03=E2=80=AFPM Valentin Vidi=C4=87
<vvidic@valentin-vidic.from.hr> wrote:
>
> On Sun, Apr 02, 2023 at 11:14:33AM -0400, Paul Moore wrote:
> > If you have the time, could you try a patch we have queued up in the
> > lsm/next branch?  We are in the process of removing
> > security_old_inode_init_security() and transitioning all the callers
> > over to security_inode_init_security(), and I believe the ocfs2 patch
> > for this should solve the problem you are seeing, can you test it on
> > your system and let us know?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/patch/?=
id=3Dde3004c874e740304cc4f4a83d6200acb511bbda
>
> Great, thanks for the pointer. This patch also works for me as I don't
> see the crash anymore. Can it also be included in the 6.1 LTS kernel
> since this is were I first noticed the problem?

I'm glad that solved your problem, thanks for taking the time to test it ou=
t.

I think backporting it to the stable kernels would be okay, but I'd
prefer to let it get some more testing in linux-next first if that's
okay with you.  Since we are currently at v6.3-rc5 and this patch is
scheduled to go up to Linus during the next merge window, it might
make the most sense to give this two more weeks in -next, let it land
in Linus' tree, and they ask the stable team for a backport ("Option
2" in the stable kernel docs):

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Thoughts?

In addition to the ocfs2 patch mentioned above, there is a similar
reiserfs patch which should probably also be backported:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/patch/?id=
=3D52ca4b6435a493e47aaa98e7345e19e1e8710b13

--=20
paul-moore.com
