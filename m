Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228B965C7B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjACTsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjACTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:48:36 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4DDDEF9;
        Tue,  3 Jan 2023 11:48:35 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id c11so25359217qtn.11;
        Tue, 03 Jan 2023 11:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb6vaN7S0LgbMT0omK02MiFSOGzB3hZFddL85UgbNtc=;
        b=5gGMiebNnjdSOGSXNC/hwz88TaSJTyv06SlvAnYD+rxSLMITcfjXPL+I1DJkhki94G
         kuQX+3ZbOHkcn2VTQILfpyL5Z/emPgGQZl6ZEYF1p8iy3f2Hl+w/mGo/wW9lKTzbWW9p
         voY7CsUFB1nK8Gcbkeyieq8wkc/iwCXRjZM054hjMwc35bHgVz5IveMf7fxkbpevS12r
         zKRnEWoT1cU4sH93qcK3Ldx3aSnUX+yEg3HgmU6OlSpfXZ8NT4KvAt2KJIGuHPnvW5Oj
         1fRB1JaUPpWdYHAT1TArQJBCVl4Po5Ns8YktMIbC4dQyONIDHMGRDXsC/tfOoEG+dEZv
         pFCQ==
X-Gm-Message-State: AFqh2kpGeBKBhDgwLbBRWJQHeFIcMFIUbbY9k1O7jcZJDXdjmNyvtDro
        JjoZBeREOwJ90D4DdGR8hIoun8bKZ5Bzrw==
X-Google-Smtp-Source: AMrXdXu2ev5bho473L2HDta+wTzcYSGfSel3BOqWowATHB5KSr8hau3HBMlsVb/k6jsoGJGAbnOP6w==
X-Received: by 2002:ac8:6705:0:b0:39c:da20:65f with SMTP id e5-20020ac86705000000b0039cda20065fmr64334534qtp.2.1672775314672;
        Tue, 03 Jan 2023 11:48:34 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id m14-20020ac866ce000000b003a7ee9613a6sm19062464qtp.25.2023.01.03.11.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:48:34 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id e141so34308009ybh.3;
        Tue, 03 Jan 2023 11:48:34 -0800 (PST)
X-Received: by 2002:a05:6902:908:b0:787:948b:d5f1 with SMTP id
 bu8-20020a056902090800b00787948bd5f1mr2143969ybb.523.1672775313884; Tue, 03
 Jan 2023 11:48:33 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info> <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
 <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
 <19ea39c87df3c54cbc487466f806bc157d0bf563.camel@freebox.fr> <0611323c-2088-e6f3-1c38-7cf742dfb60d@leemhuis.info>
In-Reply-To: <0611323c-2088-e6f3-1c38-7cf742dfb60d@leemhuis.info>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Tue, 3 Jan 2023 13:48:23 -0600
X-Gmail-Original-Message-ID: <CAMfi-DTyhv=Pga+ds5REtxngwoXeufMYr_dOh93X75Pm9bbU0w@mail.gmail.com>
Message-ID: <CAMfi-DTyhv=Pga+ds5REtxngwoXeufMYr_dOh93X75Pm9bbU0w@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     mbizon@freebox.fr, Marcel Holtmann <marcel@holtmann.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 4, 2022 at 3:37 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Does it work in Windows?

That's an interesting question.  I did some searching and apparently a
number of other OEMs are all having issues with this even under
windows.
https://www.dell.com/community/XPS/Does-the-XPS-9520-support-Wi-Fi6E-6GHz/td-p/8229808
https://www.reddit.com/r/framework/comments/t0ghsc/fix_for_6_ghz_wifi_on_the_intel_ax210/
If I had to guess, I'd suspect that Intel has pushed similar checking
of ACPI into the windows driver.

Can we just get this terrible code ripped out until the OEMs get their
act together?  This is really bad user experience.
