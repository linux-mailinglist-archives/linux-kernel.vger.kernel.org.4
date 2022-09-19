Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018795BCCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiISNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiISNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:19:16 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1C2B258;
        Mon, 19 Sep 2022 06:19:13 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h3so25419732lja.1;
        Mon, 19 Sep 2022 06:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CIXTFCzxjkeVwrqu3MxeoXf6dgZFRbn9vUeaJo1l6Us=;
        b=vfj7qDNHUBa7qO7sFx93dLQ/q0h2IRmAOn9WStbzCTV4hGzOhKb9HkNBu6mMZwfmQw
         t0FlRzaU4hEtFKvRkrhTum2lxVlg4e3GGCrTHNIIPYQXJj2kkFgCiNWFOQ/vuOQ0anjW
         027w/MRzKsdHmPsVCYolpXd+Kg4sRMdq99ELFGUur937ZoGgLWhG314ABNozmB5NdsZ5
         u1Ooy1LZvZXAC3oFm9IcS14Y36svtJHsevOJ044u4qltZDq6dp8eb5q5qZshIjH4HPbw
         b5OcA3k7wDWyz3mBAaf9lYFJOKCRjUvgFr/WZaPotp47ZVwGB1xBz4ALa4qLixJzFTaq
         XwEQ==
X-Gm-Message-State: ACrzQf3LsW3BaQM1JW9N/9Fud9AhBjkniKX4/IWDNDWRUXQBXQUXsV3p
        b+OP2g8rHuZO1VeLutSjfLiWUIiJcyfO2A==
X-Google-Smtp-Source: AMsMyM7cAAGQsl8uVRWFFu3aaDbh6kXayYRKRyhHiNXGMM8GOJ4ojzPhB7p6Z0LPioupUgDlFDwMFg==
X-Received: by 2002:a2e:bf11:0:b0:261:9343:fb2 with SMTP id c17-20020a2ebf11000000b0026193430fb2mr5424827ljr.47.1663593551557;
        Mon, 19 Sep 2022 06:19:11 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 15-20020ac2568f000000b0048b0696d0b1sm5198273lfr.90.2022.09.19.06.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 06:19:11 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id u18so46878528lfo.8;
        Mon, 19 Sep 2022 06:19:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3b8a:b0:499:ac9a:425b with SMTP id
 g10-20020a0565123b8a00b00499ac9a425bmr5883584lfv.301.1663593550016; Mon, 19
 Sep 2022 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220918140829.443722-1-git@vladimir.panteleev.md>
 <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net> <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
 <736d150c-03fe-ce39-a42e-b9b62f40a937@roeck-us.net>
In-Reply-To: <736d150c-03fe-ce39-a42e-b9b62f40a937@roeck-us.net>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Mon, 19 Sep 2022 13:18:53 +0000
X-Gmail-Original-Message-ID: <CAHhfkvxf5P0KYQpzjAxBbEmYtK+YRs5P1QD+28=9FLZfn_awyA@mail.gmail.com>
Message-ID: <CAHhfkvxf5P0KYQpzjAxBbEmYtK+YRs5P1QD+28=9FLZfn_awyA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sp5100_tco: Add "action" module parameter
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Guenter,

On Mon, 19 Sept 2022 at 12:29, Guenter Roeck <linux@roeck-us.net> wrote:
> I am not getting into define name editing wars. The define is named as
> it is. There is never a good reason to rename it. If I'd accept your
> change, someone else might come tomorrow and want it renamed to
> "SP5100_WDT_ACTION_POWEROFF" because setting the bit to 1 causes
> the system to power off.

Ah, sorry - this is one of my first attempts at contributing to the
kernel, and as such I of course fully defer to you. In case I was
misunderstood, I was just trying to explain my line of reasoning at
the time, which is what I thought you asked for in your previous
message. Thank you for the explanation, I was not aware of the high
cost of renaming defines.

I will send a V2 if this is all?

Thank you for your time :)
Best regards,
- Vladimir
