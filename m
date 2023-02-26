Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242C36A2CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 01:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBZACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 19:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 19:02:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E201421A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 16:02:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so6606305pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 16:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONKODUhKh5rG0iih3R+o2cH/8EVHLrhyLX6cTk7KJC8=;
        b=hyx7kRry5f+mP0ujoi8eqEnOePydkPnnsgYAsvezhDlm6rQlzVjSGA161gF3GHlnkR
         ksM82M7wv+1eQEWBoc0awZIUOd02TPmbwPxMlL4sUloFFh3TsL0z0b4iPBQEP7kDeJpm
         z31ZaCI+erAAiux6MZTSnQu3ceERvswLfIShWBNjxtviM0lPuXcl53X9ahbqZscRVrth
         kXuzI9sDu168qMBnbW1Bwc8oU2OkpRJpoJyi9EGM2YhUXLZ3SIfxtu7Vx6MBJ6nsTwgc
         kfHW1ss3JiwMardrdMUJy6DasY5qI6eOUGtsi8lwuUZs6lzJzJbxCNyUA6JJEfgKWd8r
         ZXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONKODUhKh5rG0iih3R+o2cH/8EVHLrhyLX6cTk7KJC8=;
        b=coqyfiGqzvkeBuiwXTKO+UkN2unzMgKUHwpq7H0eVqKd5HCqNdAkOhV0yb95XzoSs8
         0+v4Xw16x/UvOGT7tpLklCHQ00hCSxIM7541sGDgmu4456pgshTVMJxRc9xSA1UVk6HU
         diH7GN82U6e9QWaDx+40+KQLbQYvRPrRPtonQOGzng/E8ZrH5HQ2sW0OpS/Y3w2jgEZd
         v8FdKoRgQ9+IcwXW7rEmI4gfV/0UBmGoO7zTl9mu6s4BAWwbDmUnbE4d00xsFP9lB79A
         oiOAkZUcyf/ep9LOO0t/5yDWxmAo9rnyr5JlmgQ6JJ6Kn7sFXPTL0uJBhkLsw5di4qZ8
         yzrw==
X-Gm-Message-State: AO0yUKXfUIUIzck6YDbh4z+M80FYhmGfdDDDqd6qedvYWxCeWjs3G6dl
        d6rtEgppKe2D/BqwIN/Rw8C5zSA/GW+MrUO3W8gLsQ==
X-Google-Smtp-Source: AK7set/DdEbM2QWKycNJ/HOKPqBDaLJCUIqlskbbpEnhVxoGnAa406LpZPm5gaJohl3HzMr4fQvkZV4dbmBM47QqNYM=
X-Received: by 2002:a17:903:449:b0:199:4830:5cc9 with SMTP id
 iw9-20020a170903044900b0019948305cc9mr4404255plb.10.1677369724615; Sat, 25
 Feb 2023 16:02:04 -0800 (PST)
MIME-Version: 1.0
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
In-Reply-To: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 25 Feb 2023 16:01:28 -0800
Message-ID: <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
Subject: Re: Raspberry Pi 4B: Failed to create device link with soc:firmware:gpio
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Saravana,
>
> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the following
> for the "extended GPIO" provider:
>
> [    5.969855] uart-pl011 fe201000.serial: Failed to create device link
> with soc:firmware:gpio

Outside of this error, is it actually breaking anything? Also, can you
pull in this patch and tell me what it says? I want to know what the
flags are.
https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@google.com/

Can you also change every pr_debug and dev_dbg in drivers/base/core.c
to an info and then give me the logs as an attachment?

> The kernel configuration I am using can be found here:
>
> https://gist.github.com/ffainelli/4eb83740c25b10f75b54560f8c8febb1
>
> And the DTS is arch/arm*/boot/dts/bcm2711-rpi-4-b.dts

Ah, is this yet another case of a DTS that's not upstream? Don't
worry, I'll still look at it as it might point to some existing
upstream issue too.

Thanks,
Saravana
