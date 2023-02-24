Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4B6A234B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXUwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBXUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:52:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08918628C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:52:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso502021pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55mt+kuo5dWkNyekw++UMrCQ9c2eDryyoLQGraQZpU8=;
        b=PQ3//o9BqF/cCeFQ3Q1Xv/rY74hCW/eRKF38tLjFgGOCR99BqrWq0Z1TmDTmssrMtw
         KRsVOpJ9a+/eAyMeQAoEOu751ZJEZA0gMoES3cjoTU7FtwEeDlLdH5ex99hv3OBGxZM/
         Ww+f/8B/pGoMda4TM+YyDvLNPyGEe1cY8hiLLpcvyFB30w3Oa4txe99onuCvANlX9zkp
         GhdR7L1rwM6PQ59DvdRHq3URtyV2+A+jf30pFRrpM98vbViML4r7tz54JNrViqzhQV6l
         o2wvooKm2S3ozFKY2MzzjS7CVFlm1ZKR7jXKqPop9Cx1PRni7UE3dnNcqGsmchSjvdOm
         acJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55mt+kuo5dWkNyekw++UMrCQ9c2eDryyoLQGraQZpU8=;
        b=L31kw2LEnJODUC/0lqGnGrZ7H9KgLzHFUfouX9gKcrHQIy0WSvsIBOzxDEBtvSDtCG
         EoCtljmEHBDClEv0GCz+wEOU1hGx3ixFwfR7pZr2h6MUrJo9s7fqbxiObmwwxpkJklgI
         kIVzgWCPu/c3kT2uVA4nH+l4xmBj3124pmtjmgqE76Lvf+eoj7fTrLQZ5hkgsdTSkvLv
         xJs31AGc5w9yrvyfDIOEp1hlyuHMW0neRQ48r3A9QfmHm8CGcn4N7jRfCr8gVioc0YKb
         ucpzEHN0cW8H+AOeNAWL0DPgYpinKQOgPiSJR3dcFnF7JueIIT+I4F+9e0XmlXxcYBbc
         SCeQ==
X-Gm-Message-State: AO0yUKWTTQZbvs0AKWzm2XKTA1TanMhanusSzLNEf4kamfTV2Eug7tAx
        3ancKmLsH9IaMBC5JirhUxq6zB1/g2vp+U80jsNchw==
X-Google-Smtp-Source: AK7set9jwyl5cVUNpA1/XKIW8Cs28uP4ayT0pKHGrhJEcpKF3dfiREuG6JLl2PYLQ5lISV33j6Q9QZmQVEAdjse1W7k=
X-Received: by 2002:a17:902:b410:b0:19c:b7da:d41f with SMTP id
 x16-20020a170902b41000b0019cb7dad41fmr2274382plr.11.1677271923389; Fri, 24
 Feb 2023 12:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiZ9vaM23eW2k4R-ovtcWLyL8PWvnCG=RyeY4XXgZ6BCg@mail.gmail.com>
 <03dac14b-ed62-3e2b-878f-b145383ea9f8@cs.ucla.edu>
In-Reply-To: <03dac14b-ed62-3e2b-878f-b145383ea9f8@cs.ucla.edu>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 24 Feb 2023 15:51:51 -0500
Message-ID: <CA+pv=HPfatoLpQj77HWkzsg+tHK6AVRoR7h-eSY4=EyAFuocrA@mail.gmail.com>
Subject: Re: diffutils file mode (was Re: [PATCH 5.15 00/37] 5.15.96-rc2 review)
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>, rwarsow@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Meyering <meyering@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 3:20 PM Paul Eggert <eggert@cs.ucla.edu> wrote:
>
> On 2023-02-24 11:16, Linus Torvalds wrote:
> >   GNU diffutils have never actually grown the
> > ability to generate those extensions
>
> Thanks for pointing this out. I added this to our list of things to do,
> by installing the attached patch to the GNU diffutils TODO file. If this
> patch's wording isn't right, please let me know, as I haven't read this
> whole email thread, just the three emails sent directly to me.

For what it's worth, this looks good to me.

Thank you,
-- Slade
