Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A09640BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiLBRSv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 12:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiLBRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:18:23 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671565BD74;
        Fri,  2 Dec 2022 09:18:21 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id n1so6125694ljg.3;
        Fri, 02 Dec 2022 09:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GdwYktE3SJ00+EzqM3Nkk4pKYtF1FV5Z9anlWL/Lco=;
        b=iUeI5HpurfpaM6B9dh/gPa5uKtSvwyHHOoe/0o68Sl7L+IEvXV3hWoyCRUA0KJ/JBb
         I/w5FH4gUd/eOAfeBXoxCQI1sQWBsCJTcP/Htdg7PfZm5mMY10rg+B5aoag0qav6x8lB
         ZuaP2PO9QBCbsAgdSyI5h91EApR+A9q/CN7m/L6qTAwg/n1mRwkuvR4VJ5AHgMbXw3oL
         CGa8FbjDsjPklTFac4ysAtT+4mzyvH6D/YcwoZhqU8AJvyQTYBJqqm2oZwGObp8DGYoC
         mQMD0O/I/nsBOtSzulkO7lJfGYy/TIex5Yna/+e1e7j7Pk34RyKOFSUy0QhUSvxNpC64
         zUbA==
X-Gm-Message-State: ANoB5pmULHehCTCJ4I4Q7w9H47Oov5FeYHEFrh+qJNVWwFpXbEfDAH96
        jCm8DpK8ps2LAx/HegUdihHgKoohv8JgxMT9bAE=
X-Google-Smtp-Source: AA0mqf6Ixf5KE4K3HzvCHs9+2md4zU+Ibf4J/03MJ7mAN0kNY9SU3CPWK3WOuRJjsR8P5ZNeHZcPkA==
X-Received: by 2002:a05:651c:c97:b0:277:13ef:53ab with SMTP id bz23-20020a05651c0c9700b0027713ef53abmr24476126ljb.328.1670001498587;
        Fri, 02 Dec 2022 09:18:18 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id g3-20020ac25383000000b00492dba3c85asm1074415lfh.220.2022.12.02.09.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:18:17 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id g7so8381811lfv.5;
        Fri, 02 Dec 2022 09:18:16 -0800 (PST)
X-Received: by 2002:a19:f010:0:b0:4a2:2e81:9be5 with SMTP id
 p16-20020a19f010000000b004a22e819be5mr25394338lfc.486.1670001495941; Fri, 02
 Dec 2022 09:18:15 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info> <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
In-Reply-To: <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Fri, 2 Dec 2022 11:18:03 -0600
X-Gmail-Original-Message-ID: <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
Message-ID: <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running
$ iw reg set US
or
$ iw reg set DE
do not result in the bands becoming enabled.  I should have included
that in the initial bug report.   Additionally shouldn't the country
code should be getting gathered through 802.11d from the broadcast APs
within region?

Also crda is now disabled in both debian and Ubuntu.
https://bugs.debian.org/1003903
https://bugs.launchpad.net/ubuntu/jammy/+source/crda/+bug/1958918

I'm specifically on 22.04, and the 6ghz band works on the 5.15 ubuntu
kernel and the 5.15.79 linux-stable kernel.
The 6ghz band becomes disabled as soon as I upgrade to the 5.16+
linux-stable kernels. So from a user perspective this really is a case
of a kernel upgrade breaking user-space.  This is what led me down
this rabbit hole here.

If there's something that needs to be done differently from a
userspace perspective I'm all ears, but this seems as if it's a hard
disable by the above mentioned commit.

Thanks,

On Fri, Dec 2, 2022 at 10:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Thorsten,
>
> >> The other possibility is that this is actually a bios bug, as the DSM
> >> is being read out of ACPI.  In which case that would be Dell's fault.
> >
> > Yes and no, but no:
> >
> > A kernel change exposed this problem, hence it doesn't matter if the
> > BIOS is faulty: it's makes it a kernel regression and those are not
> > allowed. For more on this see
> > https://docs.kernel.org/admin-guide/reporting-issues.html
> >
> > That at least would be the normal approach. But the thing is: the legal
> > implications when it comes to things like wifi make this somewhat
> > trickier. :-/
>
> so you need to set your country code first before any of the regulatory
> enabled channels on 6Ghz get used. Otherwise you are stuck in the world
> domain that doesn’t allow 6Ghz at all.
>
> Two choices, either you run iwd and just set Country=DE where this than
> would be persistent; see iwd.config(5). Or you do this via iw reg set DE
> manually. wpa_supplicant has a set_country wrapper, but I don’t see it
> being used anywhere, so I assume you have to do this manually when using
> wpa_supplicant.
>
> And of course tools like crda etc. need to be fully functional to load
> the appropriate regulatory information. Since any 6Ghz operation is
> blocked by default.
>
> Regards
>
> Marcel
>
