Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AF6A079D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjBWLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBWLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:44:19 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1949222E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:44:18 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d75so2188428qkg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMm67g4tYyW2iBIaThCDKSYiHsYD4eAy5nCYGL3UlNw=;
        b=S3ghGzI83TJkKnhKoOrANjJI1wT3WkbxMgYvWgXVyZJ7w3ZeFStkOcHiAnjcLD0zy3
         lhZ7I/zOB/wJMyzKZBktTWQglTPTiQriWsxcvW89kHvw0Jrqyp589EM56Mh/fBjrciHn
         awk4Um6W38Lb8acemHwLsP3Og24EZ4uRqK0ChBIKOdHVL6m3WzVL4O6La5C1vbe4+KDm
         k6hyZ/nx4RLM/AERf9auadY/PBFJ49Bj9dIULDh7x3q4AMR1HwbJLwFPggEHqCinLs8t
         n/7df/304zOg8MOHpc4qG3D9lH3c40GQHJxqPzUGlJgk0xwJNsxL1hrEOczsvohkGWFH
         UlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMm67g4tYyW2iBIaThCDKSYiHsYD4eAy5nCYGL3UlNw=;
        b=JVC5lrXaba0S76/Eu7Koafm4awQArGdsp3BRDtHOzo0PVxkCCLs568YXqqeVZAhJWE
         1Nx3ozxCwh9xZx+4OWtm3y67c67aFnFlbRrADgl4JQe9c5SrETmbtdwcZb3ldpfaoVpM
         QX1VZWvjq3pIVM0zrMZiBYxVxeUkaxNBw6bmNv+3ZXLdqngLT0TVOHkPWf5cHy4I8K29
         RyU+7yBTSLO3vS89PKADlAQYJ1V08F9ThbWS1TBvo9Xwm1Ql+IwlBMJhxwUlO7mqxodv
         p8eyU/WciDRI8nZMGnLefW2vxqhBhFXaIrUAdRK4Suvnx/3E24e5/rk0Ceqk3RT9uKaT
         cxaw==
X-Gm-Message-State: AO0yUKXHBvJr7rFkvLAYXWLkn8WSJD5VED6sDurtLQ1c71bcfE9O2WVT
        jdIVVN9lV+Se/MDrSsZ4OqmG6L7g3lJqVGALVE1riUlJIYI=
X-Google-Smtp-Source: AK7set+/sObsP9vUQZ5GSBsYohLK416kS3Gqd8U9KYL4qKR1uMkqklOuFHpB80MGrvkGZrpb26kgOwZhHNJ34ZBuEmg=
X-Received: by 2002:a05:620a:2812:b0:71f:b8f8:f3db with SMTP id
 f18-20020a05620a281200b0071fb8f8f3dbmr2304923qkp.1.1677152657883; Thu, 23 Feb
 2023 03:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20230222220435.10688-1-palmer@rivosinc.com>
In-Reply-To: <20230222220435.10688-1-palmer@rivosinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Feb 2023 13:43:41 +0200
Message-ID: <CAHp75Vd+TyxF87sdfaM=zwM_Jg_+qBJQP_BYK5t6u=bMd+EqYA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: Add strncmp() tests
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     andy@kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:10 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> The RISC-V strncmp() fails on some inputs, see the linked thread for
> more details.  It turns out there were no strncmp() calls in the self
> tests, this adds one.  It currently fails on RISC-V systems with Zbb
> enabled with
>
>     [    0.683479] String selftest failure 7.00001001

...

> This reports a checkpatch error for the __initconst, but I think it's
> spurious as I've just pattern matched the above test.

Does moving outside of function help?

...

> +               unsigned long count;
> +               unsigned long max_off;
> +               size_t retval;
> +       } tests[] __initconst = {
> +               { "/dev/vda", "/dev/",    5, 4, 0 },
> +               { "/dev/vda", "/dev/vdb", 5, 4, 0 },

In the current state the max_off is redundant.

> +               for (off = 0; off <= s->max_off; ++off) {

Why pre-increment?

...

> +                       if (res == 0 && s->retval != 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x0;
> +                       if (res > 0 && s->retval <= 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x1;
> +                       if (res < 0 && s->retval >= 0)
> +                               return 0x1000 + 0x100*off + 0x10*i + 0x2;

But you don't have cases for +1 -1 results (positive, negative), why
not add them?

-- 
With Best Regards,
Andy Shevchenko
