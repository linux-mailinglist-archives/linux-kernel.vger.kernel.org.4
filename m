Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92E64097B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiLBPiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 10:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiLBPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:38:11 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53E8EE68;
        Fri,  2 Dec 2022 07:38:09 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id c1so7941385lfi.7;
        Fri, 02 Dec 2022 07:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhdW6X1bGFq1GUdOEe+pRgDK494GKVDs9c7r4mfiruQ=;
        b=LxxZ7FlWH8XL/kaWszGQrGzeF4XG459tvGqgl6Kvw8m3N17fUZIz2Q0oqoopaCVjpj
         V4EnP8zR6O39C27o4qS6tNx1LCSZmPJWy4UK7ggUgPReIpf6qOkaF37SNhRihWdJv8I1
         EQDri6tcxZEk13oe8XDikUw6cTp3R7TtDbxEzCc3wD1dfyO/Z2CUhJLZXaauOx5uiImt
         MxAx1j/ZIT4accfojEVgKx0NQaT/+1lDleX93KEwX/MB8KjspTrYyTDgb8UJ2qa3ROfS
         t/uq4yycFTHcWWMsvAYDm7pBeEgsxteg+WqUhWXs2G/u57fXc9+iPrkN3i+e+zj4Xqgz
         Nlfw==
X-Gm-Message-State: ANoB5pk1u+e69VhCGd26FtS5s9yJxxby186uscHNwShoVCKg93axVXJH
        rWnKUYnvDg5OiS0cHhgWRzLTJvaUr4x1oyNH
X-Google-Smtp-Source: AA0mqf6WtGjNW0sRh9DgNZgKPJR9GAncVUIOvYTF7gw1mwIYgjb8GDaohcd0uwrycY5073j2BrJa2g==
X-Received: by 2002:a05:6512:2983:b0:4b4:d338:4d8e with SMTP id du3-20020a056512298300b004b4d3384d8emr17761989lfb.512.1669995486840;
        Fri, 02 Dec 2022 07:38:06 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05651c232500b0027708c94c9bsm6705ljb.79.2022.12.02.07.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:38:05 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id a19so5862765ljk.0;
        Fri, 02 Dec 2022 07:38:04 -0800 (PST)
X-Received: by 2002:a05:651c:200c:b0:279:3d7a:c240 with SMTP id
 s12-20020a05651c200c00b002793d7ac240mr19420636ljo.289.1669995484289; Fri, 02
 Dec 2022 07:38:04 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info> <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
In-Reply-To: <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Fri, 2 Dec 2022 09:37:51 -0600
X-Gmail-Original-Message-ID: <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
Message-ID: <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other possibility is that this is actually a bios bug, as the DSM
is being read out of ACPI.  In which case that would be Dell's fault.
Either way I appreciate any guidance you can provide.

Thanks,
Dave.


On Thu, Dec 1, 2022 at 5:33 AM Coelho, Luciano <luciano.coelho@intel.com> wrote:
>
> On Thu, 2022-12-01 at 11:14 +0100, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > Luca, I noticed a regression report in bugzilla where I'd like your
> > advice on. To quote https://bugzilla.kernel.org/show_bug.cgi?id=216753
>
> Hi Thorsten wearing-the-regression-hat, 🙂
>
> I'm not the maintainer of iwlwifi anymore, so I'm adding the new
> maintainer here, Gregory Greenman.
>
> Gregory, can you take a look?
>
>
> > > It looks like the self-managed regulatory information is causing the 6ghz band to be disabled on my AX211 (in the US).
> > > iw reg get shows no 6ghz bands (output at the bottom).
> > >
> > > $ sudo iw phy0 channel
> > > ...
> > > Band 4:
> > >     * 5955 MHz [1] (disabled)
> > >     * 5975 MHz [5] (disabled)
> > >     * 5995 MHz [9] (disabled)
> > >         ....(continues with all disabled
> > >         * 7115 MHz [233] (disabled)
> > > ...
> > >
> > > I was able to narrow this down to having been introduced during the 5.16 development window, as 5.15.79 linux-stable kernel works and the 5.16.12 does
> > > not (earlier builds of 5.16 kernel fail to boot on my machine for some reason).
> > >
> > > I found https://community.frame.work/t/kernel-5-16-6ghz-disabled-ax210/15675/5
> > > and they imply that this regression was introduced by
> > > 698b166ed3464e1604a0e6a3e23cc1b529a5adc1
> > > I haven't independently verified this commit as the definitive issue.
> >
> > You authored 698b166ed346 ("iwlwifi: mvm: read 6E enablement flags from
> > DSM and pass to FW"). As it is a regressions is ideally should be dealt
> > with. But this area in tricky due to the legal implications. Hence I
> > wonder: is there anything we can do about this, or is this simply a case
> > where we have to bite the bullet and live with this regression?
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
