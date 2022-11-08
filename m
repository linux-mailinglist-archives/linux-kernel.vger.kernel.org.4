Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B007620E4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiKHLK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiKHLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:10:55 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB61007;
        Tue,  8 Nov 2022 03:10:54 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id t5so13314886vsh.8;
        Tue, 08 Nov 2022 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ljbpqeUpzJfqMkrUw95JFard8abiZdbIIeeNMaJgi7o=;
        b=OWFcdkRkt3mUC7aZDXwMSmKSkIjAiC/88vBm15uJO7ZbayYo0iQb9qG0oOsOgqJnoe
         4OtiDpZ2YTl1z/sKporedNlzRdVfYHUZ+/GqghpAVz1jpoKhTpPoKSU/ZVHp/oFOb0dm
         QGdNMZF6PhWQppBWZHdS4AUZHk5ogRWzwvVg2pDh9TPYXUxbmJ9rFHZNngQQfdGDjH/Y
         oynQaiOSjjArHRiRXWDMgCzmNvgO2KjxR04x5sbrZwJQ8Olm655W8ict3prlu0UWhzci
         UNTkn5GsfTA+W8PqLWzk+5aXne2BqxpU2kZIzZmP9Axm1CB2zTVPzbYFT1XHtxNUALC8
         4j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljbpqeUpzJfqMkrUw95JFard8abiZdbIIeeNMaJgi7o=;
        b=udOQyu6GgyXgvgbiNGvmY/OepisV+wHfnfiBRS+azlz5rkYlabToCGjHUyWNxrH8zJ
         f0G4Rq4NWZ/2t0DO7+Z2JLsO/gShqgqE+/F50iAfbK/xjPhUDB1oMpZ/3zpMlJc7oMUg
         cdxiNx3yR5HpemdcO/XSCIOgpn/RLDuZE3KzzDkZQEyCVONb5+m2TdPuDKW7WJfgTfy6
         hRMk+l7Dvg6wIvudI2lSpbKZc2Q9syT2xc314wP6Nk+7FT4S7mAwKqRLH3a+oToSjB7F
         meryY8AW7Zr/KdquT6adRk4AT4elErIZ/io7mVpJeSI7kJEYFfUr/9uiEZTq2EYBpKYP
         Tjlg==
X-Gm-Message-State: ACrzQf2CzUvfyFMVzAr132k61tQdcW4k21ET3mc1NGLBAwHB4PdtqFAI
        SfHNCdzVv2UkgLwvCgTvUZbYz1ZfCEq3F04wfNZKXbw0UQY=
X-Google-Smtp-Source: AMsMyM7RhO/d4B9S+gGi4XVF9igYGk47lHmdXDW7IG0Fp/XQSmvna+p1iWfoskzqEf+UM6q3231bACuBCs9t8mZixJU=
X-Received: by 2002:a05:6102:571b:b0:3aa:5a1:bf59 with SMTP id
 dg27-20020a056102571b00b003aa05a1bf59mr30299215vsb.84.1667905853444; Tue, 08
 Nov 2022 03:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com> <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
In-Reply-To: <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 8 Nov 2022 20:10:36 +0900
Message-ID: <CAKFNMo=bbR+ZgJQosEoj=yfoY2y=PmYHVfz3CdLCvCWVK7igTQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 7:33 PM Ryusuke Konishi  wrote:
> On Tue, Nov 8, 2022 at 3:49 PM Liu Shixin wrote:
> > Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_nextnum directly,
> > and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc is not updated,
> > we will get sb_segnum again.
>
> nilfs_segctor_extend_segments() pre-allocates one or more segments
> large enough to store updated blocks of metadata files that need to be
> written in a series of logs at once, and sets up a chain of segbufs.
> (Sorry for the missing function comment).
>
> sb_segnum is set by prev->sb_nextnum to form a chain of buffers for
> segments.  This is expected behavior.
> And, the sb_nextnum (= next sb_segnum) will be given by
> nilfs_sufile_alloc().   This is also expected.
> It looks like the problem is that nilfs_sufile_alloc() here allocates
> the same segnum again.
>
> Because sb_segnum is set by prev->sb_nextnum which is allocated by the
> previous nilfs_sufile_alloc() call,
> this usually does not happen.
>
> A possible anomaly is if the segment pointed by the first nextnum (or
> segnum) was not marked dirty on sufile.
> This may happen if the sufile is corrupted on the test disk image that
> syzbot provided (mounted).
>
> Can you confirm if this is actually happening?

If we can mount the test disk image, the state of sufile can be
confirmed quickly with lssu command:

$ lssu
              SEGNUM        DATE     TIME STAT     NBLOCKS
                   3  2022-11-04 23:23:49  -d-        2048
                   4  2022-11-04 23:23:50  ad-         103
                   5  ---------- --:--:--  ad-           0

Here, the flag "d" in STAT means the segment is dirty (in-use) and the
segment of ns_segnum or ns_nextnum is indicated with the "a" flag.
This is an example of a normal disk image.
Or, if it's easy to insert debug code to check, that's fine too.

Regards,
Ryusuke Konishi
