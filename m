Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12007668BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjAMFup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjAMFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:49:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D31E0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:49:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so4416541pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zWKc0l2Qw6F73of28DYGFo+S2kOIG+V6VrgUC1o/HMs=;
        b=T+yj+vJ9gC2N8z8WJPIVJ5o6PEhbHCKEHTFja2VN9wsOXbY46za7wqxN6feGNp/PDw
         r1Xpb0nf9xWKTWmiOf8NrMYL67ZhgDOzkbPAenRustMQh5BNRuoR6zEY0Zpt/91cC8R/
         6HhrXDkI5PsFxRHx71z37pIjvd91tIRZ80pD4lI9Iop12Z2wnFoiDlSvNagK/d6ZgOsY
         2P4fQ/wSKI6a9f+I7/rtGxHLAcZ5I5tnn+w/yaWKRY0vK5B6q2fagUnbR81JYJSaG6Vk
         NsKZW8K9ScihJbj2o18OJPK11Lu5lv4RoSS/I4M2JhNEcw5ilnYtG3bs+xwGK92eNBkP
         tXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWKc0l2Qw6F73of28DYGFo+S2kOIG+V6VrgUC1o/HMs=;
        b=FfUffa5G6snBbO8i/Ks15PDpGoJTOPGjjEO9NXfD66dr9cM6YejcjXcYkZboHMraHO
         RwO6hm5sb/dCKK9kkckWZTnVmqFAUCt/LZOMP7N5647UghzsncauiNjG8AzNPPYZE8jm
         KYnSzHRAA/FB7FSRfbyQ9JK6qJ3+zFXnEdOnWTR8dH1g628qrKUZFojC8mSyjcxbMg3j
         j8ZZuappBnnRC+8ANmJLKg9n8FhRCFQ5fKw+DvAUWBiFSwBuPB/QafjoIFLi/GBmrZOO
         Nx+Ht3BJJwMnX50yayKZPvF1P1+GUPWVGBpc7fIRu9+xi5PL6gTkM+31jiKgxuisTf0M
         VrnQ==
X-Gm-Message-State: AFqh2kpBemPOYDix5CDcCMipCCkHBleUJMmv6gONg8GwZI17cPBBQqsE
        TKkT2RptlkVJ8KPRqVzd304=
X-Google-Smtp-Source: AMrXdXsr1P6+PRiw6tbAoEgIVBCqonVVF/n+YkwfBn7QRsqFIukitOB0HXgpeumRtAcRESRcaIh9rA==
X-Received: by 2002:a17:902:e48d:b0:194:4484:8e61 with SMTP id i13-20020a170902e48d00b0019444848e61mr10140052ple.69.1673588994272;
        Thu, 12 Jan 2023 21:49:54 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0017f57787a4asm13164690plg.229.2023.01.12.21.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:49:53 -0800 (PST)
References: <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org> <m2o7s55gan.fsf@gmail.com>
 <m2ili43s2v.fsf@gmail.com> <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
 <m235983p58.fsf@gmail.com> <m2bknv3b1a.fsf@gmail.com>
 <m21qor3afi.fsf@gmail.com> <Y6XC3Du9pFKQFNkt@bombadil.infradead.org>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Date:   Fri, 13 Jan 2023 13:42:05 +0800
In-reply-to: <Y6XC3Du9pFKQFNkt@bombadil.infradead.org>
Message-ID: <m2cz7j7zm2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luis Chamberlain <mcgrof@kernel.org> writes:

> On Thu, Dec 22, 2022 at 08:09:38PM +0800, Schspa Shi wrote:
>> 
>> Attaching the full test program in case anyone wants to add some
>> comments.
>
> Good stuff.
>
> That looks like a kernel sefltest. So you can just add it as an
> initial selftest for completion so lib/test_completion.c and extend
> lib/Kconfig.debug for a new kconfig symbol for it, and then just add
> a script on tools/testing/selftets/completion/ with a simple makefile
> which references a script which just calls modprobe. You can look at
> tools/testing/selftests/kmod/ for an example.

OK, but I want to know, is it enough to add only positive examples for
the test items here? Do we need a reverse example to prove that the
previous writing is wrong?

>
> But I still think you may want an SmPL Coccinelle grammer patch to hunt
> down other users with this pattern. The beneefit is that then you can
> use the same Coccinelle patch to also then *fix* the issue in other
> places.
>

Yes, I'm learning about SmPL, and I'll add this syntax patch later to
find more problems.

> The current uaf on umh is not something I'm terribly concerned to be
> exploited in the wild. I don't think other use cases would be easier,
> but, all this work would close the gap completely.
>
> Thanks for doing this.
>
>   Luis


-- 
BRs
Schspa Shi
