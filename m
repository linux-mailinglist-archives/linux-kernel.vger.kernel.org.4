Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AD5F32B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJCPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJCPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:37:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059E2B240
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:37:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i3so6758349qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4TUdHFmO38US6568yTP0OqVuYA8SXcCUcaHPL5GJBFU=;
        b=PTlyWeS31NLqjaTlw+KY83qoDH3YyzTeDyWw8uQv+LwUMWpyvoN/3JNSV+RkGeGPNC
         7tObuMVupQk+MM0gvXycEHmn5lqCF54cptJo+DEC43rpFrzH2Lf3nv5OlFhqYEGVrOTY
         zHdzLcJaCuDQCuGuJsiSBgeFPFWzL55J1SrrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4TUdHFmO38US6568yTP0OqVuYA8SXcCUcaHPL5GJBFU=;
        b=7xP3iCxfuaD/8Mhbk/cIUgjYR9RcNvoIU32rd0Z4q58zR3EXONKemAy4tgTHuqtrag
         kaskCKX027w2BTLb1PkioHVoOwS1yuWTNotmDxrlFp1JwAysxMvW79nyu13FMNnrDjDN
         1Du3vrDuCfjcJgwoD+90JnqS+arVM+3HXLoSOvJl+DkzlCgUbvQjFV+TveD+7vMX7/76
         Cb83n066UoHkoxH7CAGFCpJgBtPdOJY17Z5V/V1jOODqe4vvH2K5PmZKXt8PiZYu32b1
         hXPkMD5yUa5eBC0U/xnK/3SLXn5ubikAKZ6o25cuA6Ts8seKRgIFNC7Xs5CDsg7RpyzI
         kOhg==
X-Gm-Message-State: ACrzQf1SvUh7fiosyCR1hHQSyFiFhgebn5JmpPLxVpkTDkyk66Ubxh6C
        clnrkL/7sL3AaxWOjmtx0FNLG/urQrKUMg==
X-Google-Smtp-Source: AMsMyM6xZRzH+5svctKxIwHBih0k2vYshlZ4CyvgElwEimd5Az8JwxIF+PfcfD4yvSCzvRFEVZCQTQ==
X-Received: by 2002:a05:620a:67b:b0:6cd:1bce:47e1 with SMTP id a27-20020a05620a067b00b006cd1bce47e1mr13904209qkh.666.1664811440556;
        Mon, 03 Oct 2022 08:37:20 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006ce60f5d8e4sm12058244qko.130.2022.10.03.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:37:20 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:37:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221003153718.o7fhrain5fnwwu3l@meerkat.local>
References: <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzqjfU66alRlGk5y@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:55:25AM +0300, Mike Rapoport wrote:
> If I'm not mistaken, bugzilla lets CC people explicitly. How the database
> of emails in bugzilla would help choosing the right people to CC better
> than MAINTAINERS?

It can't, actually, which is I think is the crux of misunderstanding here. I
think what Artem is proposing is to *auto-create bugzilla accounts* for anyone
who shows up in MAINTAINERS, so that they can be cc'd on a bug report.
However, everyone understood this as "add these people as default assignees,"
which is not the case.

If we auto-create accounts for MAINTAINERS, that would allow them to be cc'd
by an actual human being triaging bugs, but won't lead to any discernable
increase of bugzilla mail.

Artem, please correct me if I'm wrong.

-K
