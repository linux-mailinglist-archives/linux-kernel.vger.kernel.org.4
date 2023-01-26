Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA37567C90D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbjAZKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjAZKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:49:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF84E530;
        Thu, 26 Jan 2023 02:48:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v13so1449040eda.11;
        Thu, 26 Jan 2023 02:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WYsz1Mr8ifwOI062LelFza9HOPU/3NoUl24qS/os2Y=;
        b=IbWgmx4svSIsjcBfTYlX5PCPhsnMrGqcxkZglxyGNtqLsh0O6Yv0WrXPORZg405Fta
         IC7jlgcb5lsRRuxk1byIm8OilWWRH1xw8bNwervTvQYj7IeLTVFciH3BN6b8F29IOOyp
         wNcijJZroffNwmgmE/+GaN3KgbU7Py2YOsSlgxKWWR+5iF/XqgI7j6sYmEMAw5Nxi/Sv
         CYagiGT9eVbqHiBk++MyP/7tJMDB+IYNzmGsR2lwZFELCP7U+MnZHMfaK0oRVpkoCuar
         nhEhv9Yx7LnJnV5FSfW6b3aBK9EkwwRDZcBKM731/KgEgZVFS7FsH4/z8z8fHWtbGQOx
         PsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WYsz1Mr8ifwOI062LelFza9HOPU/3NoUl24qS/os2Y=;
        b=sfb5e8Z12Irtlnfor5C8hd6+zB2S8zJkWXd+OaaS+EWRUvgi34ZmLyyLudS4VCT6hl
         6f1aBlFMwzWP9Zj4/LqalcqQMEH4UX3vXO6lMlZACja3csa+zu5LlcH/BLmdAsaCBYQ/
         lY5Smbfw6pImTbdv7IcqnzRQOVB7dOGYeZA9+BKGzsCpqadLden8BzGQme7JDvFaZiYp
         Ghnyp5/VWt10YwJ29WErDm4bdxbz1GgAfk5lWFd28x6xSLMiK2vUrKZSXcTrhjVmp4Sw
         tDZbQRe5yBahInNQ2t7I34RsaakyZ0Zkf66yq3s9NU/TXLiFXWeC3Up84fEecJoso91I
         1K4Q==
X-Gm-Message-State: AFqh2kpk4fOnds7nDOxuXCZHb3y/9bhT2AcBqX1cB3Lmi6AkuVkh9sRP
        tGIQW23s94qewYJbWBqGwU8=
X-Google-Smtp-Source: AMrXdXtsZm0llymWvk5kzx1A0etOkU+n4hSDz+ODaJhG1EpeuuBhGVlaWOL2CearA5TRKWYI55ZJzw==
X-Received: by 2002:a05:6402:5305:b0:499:8849:5fb6 with SMTP id eo5-20020a056402530500b0049988495fb6mr40132990edb.30.1674730119072;
        Thu, 26 Jan 2023 02:48:39 -0800 (PST)
Received: from gmail.com ([31.46.245.95])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm534694edr.28.2023.01.26.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:48:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 26 Jan 2023 11:48:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, linux-pm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] x86/ACPI/boot: use try_cmpxchg in
 __acpi_{acquire,release}_global_lock
Message-ID: <Y9Jagh6eOEkcudL4@gmail.com>
References: <20230116162522.4072-1-ubizjak@gmail.com>
 <CAJZ5v0j7i0FG_ivX1xhTPutJOXb8nZEv7kq+TTOCjynts9049w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7i0FG_ivX1xhTPutJOXb8nZEv7kq+TTOCjynts9049w@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Mon, Jan 16, 2023 at 5:25 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > __acpi_{acquire,release}_global_lock.  x86 CMPXCHG instruction returns
> > success in ZF flag, so this change saves a compare after cmpxchg
> > (and related move instruction in front of cmpxchg).
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> > fails. There is no need to re-read the value in the loop.
> >
> > Note that the value from *ptr should be read using READ_ONCE to prevent
> > the compiler from merging, refetching or reordering the read.
> >
> > No functional change intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> but please CC linux-acpi on all ACPI-related changes in the future.

Thanks Rafael - I'll take this patch through the locking tree, if that's 
fine with you.

Thanks,

	Ingo
