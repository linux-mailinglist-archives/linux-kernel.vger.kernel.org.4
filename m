Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4260E7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiJZSsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiJZSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:48:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7FD2CDD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:48:13 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-333a4a5d495so157513977b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRxOFS7Sx6dO2GW/75w/W4oHmcqu5DxQl23Fxpg/q7I=;
        b=fWzNFxQWoucrvGjeZscdqU5IC0s2gnxGTWwFejGE42H9pZdUXKlziM6VzhqtbMXJBA
         whJZMrjXQN0he53DZi5LQe/xXx/iA5t49rt3rkhVYKYWjJ5I9Di2Wq2HF+WtRUCQcETs
         GNalEnPV8c5gm6DB0cdcVd5P7gRIzcbKC7x7/Wuz5H/aNS2hQjZPwNAyJRSkqdYw3cxO
         ODGZKYX3m8uZtXQAglIXFjzQeOm7l6529dNKNEJ5dedaDeDqgGG6QTDJWX+qf8dD9Mou
         yfPEA1+DxM4k43IvD9xkb5HE/0vaFE3KFGucqQdyq7BDqmdXfg3XMV/jHriOy4kMzl97
         ycJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRxOFS7Sx6dO2GW/75w/W4oHmcqu5DxQl23Fxpg/q7I=;
        b=cQ2V7DDQVHEuJPYSvkk6HDlEzjLT4UlHq/bDV/Cy27tynVCykCQOj5dHzddKDJMczb
         LLJQKTBXOkl6KrnUnhMzd2+ut0ZsCij7pA9495rKZUlIXCa2kQgH0zRm6jygd93l3RMV
         IO+HCaX3M9TDcNhsU1wjtjMQ9xtYo3nmBwAf5haaES/Lpqgfx2Ef/x52Snem4ZrPOEbK
         L6T468XUzKsqjxippapS76V4JtmI7zHBzemcvmDv+Be9nB0+K6tU98Rr0t+j3cr2n9AZ
         1ndNqEuonTan5Z6fkBLfY7HN/GxkElnTcFLSN/0XdobhB4LYdS2JPgx1vxAMjopAADsC
         Azsg==
X-Gm-Message-State: ACrzQf3y1bGFtYR3EtgA0exrdlAy/3mnqk+1aXQ0EISFEhLIZ0fG437B
        F39foZONqWh6oIrzuJ8O7M8wBaQ5Kh2v3h7NTFIF+Q==
X-Google-Smtp-Source: AMsMyM7Ed2SK/ZMNN4r3tWJCyA/X3+ZX2V0tKtk9C+U0X8euFL9UhAofye9uM4qX7ENX9bgL9i6Sfqb1c+6fnK7OIzo=
X-Received: by 2002:a0d:ff01:0:b0:353:380e:ca03 with SMTP id
 p1-20020a0dff01000000b00353380eca03mr40924242ywf.466.1666810092171; Wed, 26
 Oct 2022 11:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220823080117.738248512@linuxfoundation.org> <20221026160051.5340-1-mdecandia@gmail.com>
 <Y1ljluiq8Ojp4vdL@kroah.com> <CAAPDZK9Oz2Hs9wofW9820gM=SeWgycCEWN=Xsjmy-YY_iFBcfQ@mail.gmail.com>
In-Reply-To: <CAAPDZK9Oz2Hs9wofW9820gM=SeWgycCEWN=Xsjmy-YY_iFBcfQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Oct 2022 11:48:01 -0700
Message-ID: <CALvZod5My-JaXBSm1iuVSFMiarB2YuE=O0AxD=6ZG0BfmJZ1AQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 051/389] epoll: autoremove wakers even more aggressively
To:     Michele Jr De Candia <mdecandia@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
        bsegall@google.com, edumazet@google.com, jbaron@akamai.com,
        khazhy@google.com, linux-kernel@vger.kernel.org, r@hev.cc,
        rpenyaev@suse.de, stable@kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:44 AM Michele Jr De Candia
<mdecandia@gmail.com> wrote:
>
> Hi Greg,
> sorry for the confusion.
>
> I'm running a container-based app on top of Ubuntu Linux 20.04 and linux kernel 5.4 always updated with latest patches.
>
> Updating from 5.4.210 to 5.4.211 we faced the hang up issue and searching for the cause we have tested that
> hangup occurs only with this patch
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=cf2db24ec4b8e9d399005ececd6f6336916ab6fc
>
> While understanding root cause, wt the moment we reverted it and hang up does not occurs (actually we are running 5.4.219 without that patch).
>
> Michele
>

Hi Michele, can you try the latest upstream kernel and see if the
issue repro ther? Also is it possible to provide a simplified repro of
the issue?

Shakeel
