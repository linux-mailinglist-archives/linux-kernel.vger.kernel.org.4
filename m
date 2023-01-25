Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9A67B8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjAYRsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjAYRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:48:08 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5110262;
        Wed, 25 Jan 2023 09:48:05 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id i28so10232729qkl.6;
        Wed, 25 Jan 2023 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B5h79gATJdLg+JCRb4XZmPChOYH13ROvGXfoO8M0bQQ=;
        b=RAHAUQee6eROdwcbsdIlBOXDKZQaY+SVNQnSBwmdn7Eez5kDbg93pdImce77l+Hl4L
         doMypibEmgpu9/Yuu2Co1877r8gZfwgPhSoW6F4POvkBinZqYBnBDtL+2WPfSRT0qtPT
         lGZ9ZFDVB4l3ULAnYmXlMFIqshGytWEjI7InaR+xC6rJ1de/mOi5giGhpAeSwUPEkFnu
         9uN3kEJOO7XI/0bz3/oxzufIJWzvWUrcjocI9SXu+vMPEgbhEPYn2G+mwqUxxz7thTOe
         M1+lNb2N8Z0D2Zh3MRBm/zM4wwCWseazyRKDpLYPTWVicwtDA9m/KEfUvdPUACrKkdg8
         Hv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5h79gATJdLg+JCRb4XZmPChOYH13ROvGXfoO8M0bQQ=;
        b=cnLEgqZnbEru01dXi2Fe3lG3TxH8Sq0VEEow4Zw3CSmUCY4uy/PIKRUsRQ0N5eZyOS
         2PBHfNZY3Y68VI562IpiFB/E2PA9mo1LukLTEnqT3+hHoocUm2Fs1NwWHkHbQ7iWNhMA
         iRsbNqVXQvhI3RIS7oVUeTwysIpmh8SfXMBxhOJ6eczDYQj0WqpNe3rvMlz0TJwYhDpB
         CVs8pSD8stX4ZznUuwpBZWURnqubxtPAhoJ0uTFIHPGj6bfIgpznPfap7WnpFUJj+FO6
         I0CSx9cnywCM6u9yi3NUHFQrrOAJY+NqFWPsCMJVK/tf2/+R002eBay1F/ALDvNgiUKA
         hKxQ==
X-Gm-Message-State: AFqh2koXeQbDGbqLYQPcLHwJ96SlVblzzp7vnd10NQgDpRPKGdvw0mC6
        gmOzTGrHH452q0TSuqEMe3mqP/Q0gYMU39bljNs=
X-Google-Smtp-Source: AMrXdXu5kH3gpMc7G6+s8He9uRofw2xxVTn/XHDtgcGtNm3IZAo1g9JnV+eZ7pS482euusPK90O0op4mFLblVKWJW2w=
X-Received: by 2002:a05:620a:56d:b0:706:5fba:6192 with SMTP id
 p13-20020a05620a056d00b007065fba6192mr1835139qkp.383.1674668884558; Wed, 25
 Jan 2023 09:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y8mv8PzL1UsP9gNh@google.com> <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
 <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
 <20230124143514.1abf933f@md1za8fc.ad001.siemens.net> <CAHp75Vf5MAsiYKdmF2oQ2rNDjKUVW9nk5FjPhUcD3b-4r_u6yg@mail.gmail.com>
 <20230125183659.7dd9e0f5@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230125183659.7dd9e0f5@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Jan 2023 19:47:28 +0200
Message-ID: <CAHp75Vez1LarRnRDKm+pn52-hwh6dWCnkoHntw9pOqyZ_5C6wg@mail.gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jan 25, 2023 at 7:37 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Tue, 24 Jan 2023 15:46:01 +0200
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Tue, Jan 24, 2023 at 3:35 PM Henning Schild
> > <henning.schild@siemens.com> wrote:
> > > Am Tue, 24 Jan 2023 11:46:34 +0200
> > > schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

...

> > > I would like to keep the number of files and CONFIG switches low,
> > > with a focus on the config switches. Every new CONFIG=y/m has to be
> > > requested in countless distros. So far i only dealt with debian
> > > where ubuntu might follow, did not check others with recent enough
> > > kernels ... like fedora if they have the SIMATIC stuff turned on or
> > > need to be asked to do so.
> >
> > If you put the proper defaults, you can get good results without
> > torturing distro configurations.
>
> Meaning i could try sending a patch to set "default m" for all three
> SIEMENS_SIMATIC_IPC
> SIEMENS_SIMATIC_IPC_WDT
> LEDS_SIEMENS_SIMATIC_IPC

No, default to another symbol which will be the core part. Again, look
how 8250 is organized. There is no default m (at least new ones, I
don't remember about any historical defaults as such).

>
> I was so far too shy for that. I would even go further and add
> GPIO_F7188X
> W83627HF_WDT
>
> > See how 8250 has been splitting over the time, we have +~5 new Kconfig
> > options and their defaults are to keep the current behaviour without
> > the user needing to do anything in their configurations.


-- 
With Best Regards,
Andy Shevchenko
