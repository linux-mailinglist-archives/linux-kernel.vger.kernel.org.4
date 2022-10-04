Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48C35F45E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJDOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJDOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:48:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115924BF3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:48:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g2so8483484qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ihftkltNveJbQdV47ucYZdqJk9biYFJbbWec+UAUaqI=;
        b=bCOclblMw4zaokxU052XVeIH9IFOsnNvnBLTBNQQxDiYphNQW14xmYUVoJa7/SvzOX
         qBTxFSblw8bPY01muWGwvsgRYJUDWeQa+OXchhb8JbbPQAZKzWdKQdmR67BRmmhvbBKJ
         uk1jbSJv+lkQ8beE7uQosuUrHRinvgB6Z4fHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ihftkltNveJbQdV47ucYZdqJk9biYFJbbWec+UAUaqI=;
        b=eBSfzAf3JO2Dp912J9IeSDpN49Rlp3mlUCdCLtibD/ZyVFBwktMEiIJjX3+UOdwdyV
         pspiyULq5372ek5/So+nWE+SaNBykyd+hmGve98HetlYEOTcqanFno/2bw36oH2r29xd
         pFRPa4bYgDdm2kDP/I1MQFfTQRemU+QJxpQGD4EExy9kjo/+OZA5qMhtRayESrWH7e9P
         SApBZ4iLN9DEMX2TjqTv1OCWYJs3w6PLYRAZc5K0ruJdWmCyctHmvbBwMz2HPltHBlS4
         WNPVcRALJMfwpJyRwZ2g6NoFveRUAk8Qg6yZrSzbKcPyYb3hPK57gQe8NP5hdoSjRPAq
         euiQ==
X-Gm-Message-State: ACrzQf1jPD7U8Vgf3DBLWtFCMmfsUnZ2FROdy84wBFMzVaQuQCVup7zv
        ypPcV8sTHjSqgywvs75LfTBsOQ==
X-Google-Smtp-Source: AMsMyM6+Bc9ggdImprFSEV1hRtemUxuVGWvA6/LDu4e+5bM+Ys3Rxli+THNpHa5WG/LMSjfwREz93g==
X-Received: by 2002:a05:620a:158d:b0:6cd:efb1:8eb6 with SMTP id d13-20020a05620a158d00b006cdefb18eb6mr16903244qkk.185.1664894891065;
        Tue, 04 Oct 2022 07:48:11 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id y3-20020a05620a44c300b006ce60296f97sm57780qkp.68.2022.10.04.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:48:10 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:48:08 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20221004144808.q6jq77quysduw5wt@meerkat.local>
References: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
 <20221003153718.o7fhrain5fnwwu3l@meerkat.local>
 <b23586ae-3082-08dc-7bc7-94c3fecffbf9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b23586ae-3082-08dc-7bc7-94c3fecffbf9@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:24:23PM +0000, Artem S. Tashkinov wrote:
> > It can't, actually, which is I think is the crux of misunderstanding here. I
> > think what Artem is proposing is to *auto-create bugzilla accounts* for anyone
> > who shows up in MAINTAINERS, so that they can be cc'd on a bug report.
> > However, everyone understood this as "add these people as default assignees,"
> > which is not the case.
> > 
> > If we auto-create accounts for MAINTAINERS, that would allow them to be cc'd
> > by an actual human being triaging bugs, but won't lead to any discernable
> > increase of bugzilla mail.
> > 
> > Artem, please correct me if I'm wrong.
> 
> Exactly. Only maintainers and mailing lists will be assigned
> automatically as it is _now_. Other developers need to be CC'ed _manually_.
> 
> There's no SPAM issue or never has been about what I proposed. Absolute
> most people will never CC anyone 'cause bug reporters are normally quite
> lazy or not experienced enough to grep git logs.

It's still not a perfect plan, because this is what tends to happen:

1. someone is cc'd via the bugzilla interface
2. the maintainer responds via replying to the email and cc's someone else
3. bugzilla doesn't automatically synchronize the email Cc: fields and the
   bug's cc list, so any responses posted via the web interface don't go to
   people who were cc'd via email

Let me ponder what can be done about that.

If you're interested in helping to get the bugzilla product list into a sane
format, I can suggest that you work on creating a mapping file between
bugzilla product/component and MAINTAINERS entry, maybe just for the
"S: Maintained" and "S: Supported" ones?

E.g., starting from the top:

    3CR990 NETWORK DRIVER -> Drivers/3CR990
    3WARE SAS/SATA-RAID SCSI DRIVERS (3W-XXXX, 3W-9XXX, 3W-SAS) -> Drivers/3WARE
    53C700 AND 53C700-66 SCSI DRIVER -> Drivers/53C700
    ... etc ...

That would allow me to automate the creation of components *and* work on a
better email bridge than what bugzilla can currently do.

-K
