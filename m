Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216AB646ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLHLnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLHLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:43:04 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622907DA59;
        Thu,  8 Dec 2022 03:43:03 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id e1so322530qka.6;
        Thu, 08 Dec 2022 03:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpFfZJ+dd7Iy+0cWp0WVXsyVyo3bHauLh8AKOw7gOb4=;
        b=7AFEKjrqLiLgQAHhdHlvlYK7MYMntQVwLnYqFuKBSIYFtkNNE0RYOmfPiIRlBGstBr
         2zpgbR9bzayxz/cPJ7Qzl7qZ2wzMNzpOfztd8MrJNFlVMdyEekNZ65hrL+EJ/czxCSyP
         h+9YiMCvJ5AhvcfnSVQoy2/lTcfppYnLTMoSMzINSwgpsq2KckwJ+XRW6oQp0anHG6Ia
         yYT32k7xCwWZojHLRhBRqq0iokvur7NL6JIVmekmEzYK2nqbzrS67x5l+RBLK0SQyXWw
         wbQQwzqTNrKLeOFbOvtOhObXzMAcx2TzcGUp+BkfOe5C1cQg2XpzyNeGVrVr0/5Tmye0
         VvxQ==
X-Gm-Message-State: ANoB5pkZ19QhuN9+AdgYBtpWIZh1yiybpgR/ySc11Nr5ezcxVlzovtrr
        JmC6DRP/Shd6wcGaDt8DrxCyPN07d003R1+H19k=
X-Google-Smtp-Source: AA0mqf4haKcNfFAogIpEO2sYYyE5jix837iZNpaBdOAClE82bkCsJsM6+OCut9s8bSzIENPIHc/0hQII70weaGRblJ0=
X-Received: by 2002:a37:ad0c:0:b0:6ee:91b3:2484 with SMTP id
 f12-20020a37ad0c000000b006ee91b32484mr80159340qkm.648.1670499782570; Thu, 08
 Dec 2022 03:43:02 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <1670416895-50172-2-git-send-email-lirongqing@baidu.com> <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
 <17a6782c79a44aada31246ddefe02bfb@baidu.com>
In-Reply-To: <17a6782c79a44aada31246ddefe02bfb@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:42:51 +0100
Message-ID: <CAJZ5v0gXSUdFeHajUcjV-eh3eW1aRoJ8Yvp9J95czQg0cMetTA@mail.gmail.com>
Subject: Re: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 3:32 AM Li,Rongqing <lirongqing@baidu.com> wrote:
>
>
> > > Allow user to unload it in running
> >
> > Just like that?  And corrupt things left and right while at it?
> >
> > No way.
> >
> > And why do you need this?
>
> Cpuidle-haltpoll can not improve performance for all cases, like when guest has mwait, unixbench shows a small performance drop;
> So change it as module, user can insmod this drivers and rmmod this driver at run time

That is problematic, because in the mainline Linux kernel (which is
what we are talking about here) there is no support for modular
cpuidle governors.

Also, there is an interface for switching cpuidle governors at run
time already, so why can 't it be used to address this case?

> And some downstream os, centos and ubuntu build it module

Well, it's their problem.
