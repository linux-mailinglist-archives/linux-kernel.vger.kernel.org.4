Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA31263310B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiKUX40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiKUX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:56:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD74B98A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:56:11 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b29so12763600pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sFqoA3xlAXzNwNaJLAB412Ok7P7Z69MnqdPRYsS/dcY=;
        b=UGMGIxl4MlQMRNDDoJWW1JeWd1Saa+VY7wYO0h5+ALzBmXWpD2TS+rloS5mLWItbTu
         dmLO6NI0/V1oHyb1t8W3cmApDUm4Tye2vUImDyToVFtk3M6GOw5Inchh/UMvHT2e/+Mq
         TZ0Zu/FXa04YRFFPQkZkOCpTQLS0EdUOIT0pN4L3oxkVk6sF6dYFnXSdIODc7wwURPgb
         9uoLDRbPa4Hxw+5ALlkY5tWI5ZiDCeNk3+/eGSw7eJ37LD7LmjdzmNfuwXTxMuQBy69L
         SQx4AJf0J8sU68MUvZMsMSHdQOZmK/LoNgQ2SeuUcyj1Hy7Nep6MNCRwXKjnXY74GtT0
         A1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFqoA3xlAXzNwNaJLAB412Ok7P7Z69MnqdPRYsS/dcY=;
        b=GCAjgSs4YWEoRq5VZGIPfYtHMyWa5AcG58zeT9XTUmWNJLH0bB+8dZqviFvQ1y1SMH
         aStatMhe3SOgfg40Amqn6jN8Bl+aDbp993gS3PGhiGtnxwXCUHLDwAFHip763Repqe/k
         FTYmZ12jbVKIoiOKQjBuFz4rVjQNRy60ZHY1hDT1S1tL9WVW8jUzkXjtNClNwlKWR86M
         HpfFMrWCS/t71avhSQXDTSwCWxTrrXhT7SYtJeJqQvftgsoOtyyRGkWOTlSx2dgFk2mF
         m3kK6Xkl1S45t47aJ6JfJ4dzN2gaD6gaRcRV8HYWl1q/kvRu73Yo2lFBR0jkA0H936dN
         4M1A==
X-Gm-Message-State: ANoB5plQ4mTvXhK/7CsXTSsb+bdsOh1bXQbf/ggl9pGMpaW4VT4+xJwr
        uPiAqrB8gniNnuaLcBCLR9iMcvoPFIegx9GICqu9
X-Google-Smtp-Source: AA0mqf7G6c3Nvud9YG/dWkDyX6JZDp8dvZSG4MT1APz5NyskblXGRN/R4W65HJ2mSLW6V+5KIth5yCSQDFWO6JKT7SI=
X-Received: by 2002:a62:2941:0:b0:573:6a8d:dd15 with SMTP id
 p62-20020a622941000000b005736a8ddd15mr11936805pfp.2.1669074971136; Mon, 21
 Nov 2022 15:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-3-roberto.sassu@huaweicloud.com> <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
 <aa5fa8c5f231115c58012352124df57d16a01e41.camel@huaweicloud.com> <7812899531b2bd936b25fde8fc2f1c2a6080b2bd.camel@linux.ibm.com>
In-Reply-To: <7812899531b2bd936b25fde8fc2f1c2a6080b2bd.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Nov 2022 18:55:59 -0500
Message-ID: <CAHC9VhTvcgOjXAH51Vnk66kEjXfjUS2aJjXjJmU-rwLT53vWPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] security: Rewrite security_old_inode_init_security()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 3:54 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2022-11-21 at 10:45 +0100, Roberto Sassu wrote:
> > > As ocfs2 already defines initxattrs, that leaves only reiserfs missing
> > > initxattrs().  A better, cleaner solution would be to define one.
> >
> > If I understood why security_old_inode_init_security() is called
> > instead of security_inode_init_security(), the reason seems that the
> > filesystem code uses the length of the obtained xattr to make some
> > calculations (e.g. reserve space). The xattr is written at a later
> > time.
> >
> > Since for reiserfs there is a plan to deprecate it, it probably
> > wouldn't be worth to support the creation of multiple xattrs. I would
> > define a callback to take the first xattr and make a copy, so that
> > calling security_inode_init_security() + reiserfs_initxattrs() is
> > equivalent to calling security_old_inode_init_security().

FWIW, reiserfs isn't going to be removed until 2025, I'm hopeful we
can remove the IMA/EVM special cases before then :)

> > But then, this is what anyway I was doing with the
> > security_initxattrs() callback, for all callers of security_old_inode_i
> > nit_security().
> >
> > Also, security_old_inode_init_security() is exported to kernel modules.
> > Maybe, it is used somewhere. So, unless we plan to remove it
> > completely, it should be probably be fixed to avoid multiple LSMs
> > successfully setting an xattr, and losing the memory of all except the
> > last (which this patch fixes by calling security_inode_init_security()).

I would much rather remove security_old_inode_init_security() then
worry about what out-of-tree modules might be using it.  Hopefully we
can resolve the ocfs2 usage and get ocfs2 exclusively on the new hook
without too much trouble, which means all we have left is reiserfs ...
how difficult would you expect the conversion to be for reiserfs?

> > If there is still the preference, I will implement the reiserfs
> > callback and make a fix for security_old_inode_init_security().
>
> There's no sense in doing both, as the purpose of defining a reiserfs
> initxattrs function was to clean up this code making it more readable.
>
> Mimi

-- 
paul-moore.com
