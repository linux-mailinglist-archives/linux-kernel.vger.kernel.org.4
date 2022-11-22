Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C97634A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiKVWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiKVWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:47:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB81C901
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:47:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so241326pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OhM08xoktc6ZKNdEIG+FP/1L4abUAxOrd/YTmOzlE3I=;
        b=6HmnQaIAantqrLzDIs1GjTCygWym7grq9246f18l84sVPSkZfEkVFN+W2jIZ+PKiwV
         7NV62WeikSpliju9ikhNf0Y5nTCZcwZpG8MvcDxyOKPDWTzYp1I4MmYPc4TKasYJLHMW
         YHYfcAC63t/ADeojSlZVxmdz4TcX8+FQkvveHe7GRoSHHjcyzqpfcAq45xwfgMQekOGM
         6DNHDmEFfWIZi6oNNMsf4+ixjZLItHxN38ifIKwu6xGsLZ9plHyTZ6PLhqE2wLii7DhR
         z3dDzLgBzGz4Yh9tb7q7IAv9AbRsVruHZlo+vrMROW2GZz5qgB1cDCMzhpZd2lIEItoQ
         L9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhM08xoktc6ZKNdEIG+FP/1L4abUAxOrd/YTmOzlE3I=;
        b=fPwapCEnfFPEV+THDNg5WwIsZjic0VKp1q3kp9gxtMm/uQ8zA5vgJWKvibNr5HQl3q
         YKjyddJmTqyMCC0x0WmJxI38/Dv8eomikJe6CVakEaxps5UpAl4VEiXomMe3BSs4WBEk
         eolpQdvNd7PNmkncX4jaLDAZmMvdyuP3eslt0wdpT7myjSF1EpMhvEaxT5IFt2XU3eb8
         fUkSv9MSN+EV35U2WkgCa0/6aYli6MoWI9217NWxdlFfnoFhm2Yv2ontuQncDY5znAmy
         hjO3dC7BjeIPoeEC7w3Pgv6SSr8x71NQ2HQRLbuy2umnS/wc5D5oerbTKwAaf0CnEu16
         JjPw==
X-Gm-Message-State: ANoB5pm2x5dGBKnfgXoNDhArii0NAJ7JMytnVyvEjJLY2cDArQDCgV24
        g4EK3u0Lhk/fVm7gSBR+Gd8qR8jMjx65T6Ije+dP
X-Google-Smtp-Source: AA0mqf6QAA5jVBAQu3mvzw/vN4N59NNFL17QIHTfT23DcEiL+LSxGEIB4K/rIFCPXNdrfzZaZ0xZgOvxMOdrlkrEjJw=
X-Received: by 2002:a17:902:6505:b0:186:e568:3442 with SMTP id
 b5-20020a170902650500b00186e5683442mr18896465plk.56.1669157263144; Tue, 22
 Nov 2022 14:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-2-roberto.sassu@huaweicloud.com> <CAHC9VhQ9WftDrF1R--ZYJXOv-YbVU-Pr1Ob_deDwEWm8OcQ-TA@mail.gmail.com>
 <aa51b845dca6021282b5b2ae260020a3a5cfb5c6.camel@huaweicloud.com>
In-Reply-To: <aa51b845dca6021282b5b2ae260020a3a5cfb5c6.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Nov 2022 17:47:31 -0500
Message-ID: <CAHC9VhRBc_XeeCki3zqP40tpO-z2xja=yyMadr9_yLhGcgU3Vg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] reiserfs: Add missing calls to reiserfs_security_free()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 3:12 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2022-11-21 at 18:41 -0500, Paul Moore wrote:
> > On Thu, Nov 10, 2022 at 4:47 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Commit 57fe60df6241 ("reiserfs: add atomic addition of selinux attributes
> > > during inode creation") defined reiserfs_security_free() to free the name
> > > and value of a security xattr allocated by the active LSM through
> > > security_old_inode_init_security(). However, this function is not called
> > > in the reiserfs code.
> > >
> > > Thus, add a call to reiserfs_security_free() whenever
> > > reiserfs_security_init() is called, and initialize value to NULL, to avoid
> > > to call kfree() on an uninitialized pointer.
> > >
> > > Finally, remove the kfree() for the xattr name, as it is not allocated
> > > anymore.
> > >
> > > Fixes: 57fe60df6241 ("reiserfs: add atomic addition of selinux attributes during inode creation")
> > > Cc: stable@vger.kernel.org
> > > Cc: Jeff Mahoney <jeffm@suse.com>
> > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  fs/reiserfs/namei.c          | 4 ++++
> > >  fs/reiserfs/xattr_security.c | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > If I'm understanding this patch correctly, this is a standalone
> > bugfix, right?  Any reason this shouldn't be merged now, independent
> > of the rest of patches in this patchset?
>
> Yes. It would be fine for me to pick this sooner.

Okay, as it's been almost two weeks with no comments from the reiserfs
folks and this looks okay to me I'm going to go ahead and pull this
into the lsm/next branch as it's at least "LSM adjacent" :)  As it is
lsm/next and not lsm/stable-6.1, this should give the reiserfs folks
another couple of weeks to object if they find this to be problematic.

Thanks all.

-- 
paul-moore.com
