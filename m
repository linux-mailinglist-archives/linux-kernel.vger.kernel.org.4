Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4BA64708C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLHNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLHNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:11:16 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29F81DBD;
        Thu,  8 Dec 2022 05:11:12 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id m5so719005qkg.0;
        Thu, 08 Dec 2022 05:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzijxs6s3oM9V6vsOC7KVyJM8HxmDMIIR252FdDbeTk=;
        b=xiNeh4q8H7gBybznkpi+JFC4WEdDoh7MktROdcROZz4MVrhfkwtu6CXpqjps7uEw5d
         sCV+iGu83Kh7rD9sWqs8HZ2EaGu46KsTXpC/Tii3vl9KtfozFaEtji3RiYMzuFzh3EDL
         4knTttPjemKnV1Jj41MP3LzEjgTZT9r3b7lxd1FumqjzB+2uR/lsBou9FLqhEQ3sLG0A
         Srj/GcKR7r1hMp9ybtNieuVi9y9P7xxdA840Nl/kPz/heOXSlh+e5BSv/51mIjLXTWYP
         DtBpW+g7XB0p7DAbGT4gGnR11pG8OlPzy/5jVSA5ClCHMKdLxNqENj3Q4K85e74JpKYz
         jkdA==
X-Gm-Message-State: ANoB5pko23+qXD17HeycPhpWPQs4KTgmjIkRKczeyD3dlV8UNGvXh0tP
        B0LkG2ePrH/PeChLpvNR+eC3frppn8B7ji8IewA=
X-Google-Smtp-Source: AA0mqf7TqEl9KBCBj1oxKtpOMuDmbCfWvhIij9yIkAa3B9r9V34NWxafKCf1ZjA5M945KvetK6plSQ35Y0Gvi5IAlc4=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr64554591qkb.764.1670505071465; Thu, 08
 Dec 2022 05:11:11 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <1670416895-50172-2-git-send-email-lirongqing@baidu.com> <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
 <17a6782c79a44aada31246ddefe02bfb@baidu.com> <CAJZ5v0gXSUdFeHajUcjV-eh3eW1aRoJ8Yvp9J95czQg0cMetTA@mail.gmail.com>
 <f10ae18cb250456c8ad420b0a3e45571@baidu.com>
In-Reply-To: <f10ae18cb250456c8ad420b0a3e45571@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 14:11:00 +0100
Message-ID: <CAJZ5v0jjR0bP0rGfUaYDEU8_vawo-HFKZOjOdTqkd2-w_OoPzw@mail.gmail.com>
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

On Thu, Dec 8, 2022 at 1:45 PM Li,Rongqing <lirongqing@baidu.com> wrote:
>
> > Also, there is an interface for switching cpuidle governors at run time already, so
> > why can 't it be used to address this case?
>
>
> I will study this interface, thanks

Sorry, this patch series is about the haltpoll driver, not the
haltpoll governor (which is there too), so you are right, it can be
modular, but it is not modular by default.

I guess it would be fine to make it modular by default, unless there
are expectations regarding it being present on system startup in the
field and that part is unclear.  I think it would be better to defer
this change until it can be clarified.
