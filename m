Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6C7281C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjFHNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjFHNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:50:19 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46052269F;
        Thu,  8 Jun 2023 06:50:17 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7872d7b79e1so238361241.0;
        Thu, 08 Jun 2023 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686232216; x=1688824216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JefbxwS8aqfuO0sltL/BjEgEJCmd7+lJraBN297Csfc=;
        b=gI44YAxQgTnjznzQn2SDbJz/ROox9M3dDZY1tM//RKFoqqa48pSfL4my+cg/eVO/SK
         Jq4Pqe+bFR3HxJHI32UEgE05DFuCBEjH2UOlk+5ob8WzuQNjU5G4wONpOnoZ/y9F4iuP
         +KTwEoIDM836YxVhfGJNGbFXyC4AIQMXpd8JgFZaj23c9EtSsnDK/YiQfIAyOjadLhrg
         PfYZO9dBqaEVlISq0Jhndl8aLYw2lHRXMbMV5QYfgOQijcSuyt82lI3AHdrB+13ND8rt
         uyfcqtjKJ7w7j0fABf/OIoqn2LY+Osjp7fwxOKtRSJxiAs71inyiDlk2M/NhZ4MqQL2v
         KyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232216; x=1688824216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JefbxwS8aqfuO0sltL/BjEgEJCmd7+lJraBN297Csfc=;
        b=RQ9zxb+H6VHe8GkQLLm5Dcn22Ux+AW6W37k7VF+wwaaeubt8B7TBJbCMwD08fV6mJ9
         DvYW+DFOTau+x8jXYWrDe4lFeMKfCgOOkOyLDcFFbS2PLdgPEDkhK2oJaM2czZxUeiOO
         agwC3c6kZZOyQX0/SjiYKm1UVeDnSO76X5mNcRafnl/RISQUASNuYqOrIbFgMNfnkWdd
         z4ftSqSJsLCcYMPEkCfbeMVkYDIC9HolXsUKC6RM/1WqldexEVjDIoDYxdfSDpvfRwhR
         X9gtK7q4WV+T0omitDbxMQdGo4h7dihfqMRKgYSkFsxXacnWsif9Dfcsm+TjMEHX9dyY
         KCqw==
X-Gm-Message-State: AC+VfDwkU09jroSBrf61CFw35EGSsRBx0OX5L0Ups/ZnNrUDNDhwRvkR
        aBpb930pcpe2dOZPs3ZppOYbbyY3L7HWW/ogeC0=
X-Google-Smtp-Source: ACHHUZ7gmWtDKl/M4FY7lf0bQE7Qk1T1opApqqFmC/gXZVCVC1vLjjRwuye0BqBPLkv0dfGiMHDYgrWP5SHUAe+0KQI=
X-Received: by 2002:a67:fdd5:0:b0:43b:2fa9:eb3a with SMTP id
 l21-20020a67fdd5000000b0043b2fa9eb3amr2002066vsq.9.1686232216233; Thu, 08 Jun
 2023 06:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <1427388117-20101-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1504021432310.843@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1504021432310.843@pobox.suse.cz>
From:   =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
        <abyss.7@gmail.com>
Date:   Thu, 8 Jun 2023 16:50:05 +0300
Message-ID: <CAJc7LbpGLaFhmSKzPdrr4k+Mf-x5-W30nO8Eq4LQmEJYDhS_XQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: add a module parameter to keep
 firmware gestures
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!

I recently rebooted my laptop just to find out that my touchpad
stopped working: no more gestures, no more button clicks supported,
tap-to-click is very laggy.
Just checked the module history and found commit
https://github.com/torvalds/linux/commit/cae253d6033da885e71c29c1591b22838a52de76
with description about "desktop environments can and
should support touchpad gestures through libinput". Unfortunately my
environment (Fedora 39 KDE) doesn't support it out-of-the-box, and I
don't know how to return all the handful features that my touchpad
provided.

Right now it's slightly better than useless.

Is there a way to return this option back? Or provide any guides on
how to properly setup all the features?

P.S. Sorry for the duplicate - the mail-lists rejected my previous
message because of an accidental HTML subpart.

On Thu, 2 Apr 2015 at 15:32, Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Thu, 26 Mar 2015, Benjamin Tissoires wrote:
>
> > The Logitech T650 used to report 3 fingers swipes to the up as a press on
> > the Super key. When we switched the touchpad to the raw mode, we also
> > disable such firmware gesture and some users may rely on it.
> >
> > Unfortunately, 3 finger swipes are still not supported in most of the
> > Linux environments, which means that we disabled a feature of the touchpad.
> >
> > Allow users to revert the raw reporting mode and keep going with the
> > firmware gestures by providing a new module parameter.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Applied to for-4.1/logitech.
>
> --
> Jiri Kosina
> SUSE Labs
