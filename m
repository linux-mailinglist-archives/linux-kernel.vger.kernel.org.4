Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9066A430
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAMUi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAMUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:38:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFC872A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:38:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso13057092wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Fvw7CEXfWs4BNOotSNKzL7lfGrSU83NLzzvdSmfbnE=;
        b=CTnLqZ1fH+fEdsSdiJU0d5bNYSidoh9EXQRUISnCP3i+h+Vulx3s0mr6l1ZlhFsKwH
         od6dcYrHtQjTHu5Vvd/JPiksqoe4VnbskICvU9v9z7vEEDpZYS40fZVuGeFQVxjzZ3SY
         qLD/oxdNJ6L8U9HgB+rf2rIovfNe0ykyOMJ6cJUrn30nNRTJtm5tMA9oswbgVtdyc4Jv
         wnL2QokSPS7JL92czzeEbF1gr0VNHscLsF1RqVBq88h1wMCsYWEZJwPMj31DuyiuOKQp
         6xiFjDyNv652VaBk2v2jrJr61btVS8om0UlsS/xtE5NZajmF5L9vV1sbDLY3TiZQDrIP
         EeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Fvw7CEXfWs4BNOotSNKzL7lfGrSU83NLzzvdSmfbnE=;
        b=q0nPOMUMcAfKIu3VraFCau2pSx6oljjzmb2fQEfYz+GXXmQUaUpP1qVLovc/WOiDTS
         3PI+RD5FZQkwZIxVvdNsfDrZDIU5PQ1aZw//fMK2w4yk47kDKcAEYtfzNRJ6z9ikcpyj
         WglDojiPxCHj9c4KClbXZ8elB7o6elyaauwp5+WdLyFaxv//BErUsSVg5vG5ZsVhPguw
         qUhOYmVUroe4zY5eQ/FjmdUnO9Dq9/I3iFem2Fn3hePQHH8Tuh3s2Wmmt03xqlzXtmAP
         d7hyW0UhIbRObIHFaik73fu6iBW2g98Qd66n3Uct2UEtRGjoY9Sh8F1SYWkJIr9xYVVg
         vZlg==
X-Gm-Message-State: AFqh2koSMpj3EXz+KfmRGIlFf3JQ9QZkUDUkBqsbAwZgLIdKeum7XIST
        VwWH68Ots+eH+Bj4nRPPn/w=
X-Google-Smtp-Source: AMrXdXv7TdEq0cy1zsLE1S/ABC1Eq0MnjdS6DKmFYPeZSf+/pixQTnXsGukj9Bm5JDzMHVsayapk6Q==
X-Received: by 2002:a05:600c:4d23:b0:3da:270b:ba6b with SMTP id u35-20020a05600c4d2300b003da270bba6bmr1946443wmp.41.1673642332265;
        Fri, 13 Jan 2023 12:38:52 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002bbedd60a9asm14125306wrv.77.2023.01.13.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:38:51 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 8BAD2BE2DE0; Fri, 13 Jan 2023 21:38:50 +0100 (CET)
Date:   Fri, 13 Jan 2023 21:38:50 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression bisected: drm/display/dp_mst: Move all payload info
 into the atomic state #forregzbot
Message-ID: <Y8HBWgieidOo4S1c@eldamar.lan>
References: <ghwn827862.fsf@gouders.net>
 <45ca4839-fa2a-9511-fd47-2d75fa3766cd@leemhuis.info>
 <038cecb9-aab2-bcd7-f003-46ca637942d8@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038cecb9-aab2-bcd7-f003-46ca637942d8@leemhuis.info>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Thorsten,

On Wed, Nov 23, 2022 at 04:43:41PM +0100, Thorsten Leemhuis wrote:
> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]
> 
> On 13.11.22 10:28, Thorsten Leemhuis wrote:
> > On 10.11.22 23:32, Dirk Gouders wrote:
> >>
> >> I noticed a regression with Linus' current tree and bisected it to
> >> 4d07b0bc403403 (drm/display/dp_mst: Move all payload info into the atomic state):
> >>
> >> I have two monitors connected to my laptop's USB-C port and since this
> >> patch, one of the monitors remains dark.
> >>
> >> Please let me know if I can provide additional information that could help
> >> to investigate this problem.
> > 
> > Thanks for the report. To be sure below issue doesn't fall through the
> > cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> > tracking bot:
> > 
> > #regzbot introduced 4d07b0bc403403 ^
> > https://gitlab.freedesktop.org/drm/amd/-/issues/2171
> > #regzbot title drm: amdgpu: No payload for [MST PORT:0000000006da5d29]
> > found in mst state 00000000b0e556d6" on system resume with TBT dock
> > connected.
> > #regzbot ignore-activity
> 
> #regzbot fixed-by: d60b82aa

I have a question on this regression tracking, as I noticed the
https://gitlab.freedesktop.org/drm/amd/-/issues/2171 issue which is
still open, does not appear on
https://linux-regtracking.leemhuis.info/regzbot/mainline/ :

Is the fixed-by marking above correct? There is still ongoing
discussion and Mario Limoncello is proposing to revert commit
4d07b0bc403403438d9cf88450506240c5faf92f . Cf.
https://gitlab.freedesktop.org/drm/amd/-/issues/2171#note_1722420 and
https://patchwork.freedesktop.org/patch/518080/ .

So is it needed to to unmark it as fixed or do I miss something here?

Regards,
Salvatore
