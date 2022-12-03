Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08FE6415C2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLCK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLCK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:26:11 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEA4F1BF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:26:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so11104712lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra8ag5JwGsu2n/PMLBQp2/vWbrz0PvsAVwA6vwQLOS4=;
        b=NHi8006d3FnCHxbww8DsOpg4rQuKLDlAStzF+l9dtdTiSdLuPraja8rIEVuFPpWjfh
         cDFU/DcEHkrvqeNfceRat7Edxewe9+YkPFVr1McPTCjonnyEJSEmDJQpsdCVTaZSs1+A
         33tS4lQpxn7Okzq4o1gqyoSGdWbwVRsX/Y+fx2BgDxdn4qkDb8ybqYNQBjOB5Fqt+geH
         aE8w9iUhvbNZS/SYllxlvF60YK+QslhrOI+5AF66MrfhfMkUVsjXdAsAf5su9NBEI2ls
         0aAjH6w47n4UtwQgpn39TMPQHlbVbHZOMiH8jL2FsuTlnrAo+lWcNGB+/h/ngnibOuso
         Nh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ra8ag5JwGsu2n/PMLBQp2/vWbrz0PvsAVwA6vwQLOS4=;
        b=shD9eKO2x+ba4+jecdzOczUJXxe4Y93RLQEvd6e/ae2i1MUFc46sGxms8LpSdjnXfv
         N8RdhIrFhZANRx8Zei1AQKBYV5xkhGp1SUyQ+5cQRUmG/khMxW2tNxQHCLixeNZxtqMV
         o5Wj8qaC4oW2d1oOVnpt7/os8th24Pa5yKnBTGpJK3fBvwF/MHQhP1oz2pi5mdC0fYJW
         7OEH8txvmd3NFtAVQM6waeAa//IJA2iaTgKOxiAsgVCORCNrYyWU2RjCG1jm4oxbQPeQ
         JdIHLcjH9JFF9KH2NRC3RVceOGpDv/n5BY03IkvOpGLZuQ11BfH894wvTwLq0zastF9L
         LiQA==
X-Gm-Message-State: ANoB5plB7G0b923+leMCUHCZDpdnhhBCYwZKn4Uhn3PUkUYY8rCbROAz
        jWkmu/IJFRP26AySncHf1riiAj8tqoiowLmcY1kj2t1jYh4=
X-Google-Smtp-Source: AA0mqf7Yvj3iFaxRiegH/05vvWCCjPrgIJT2hiylFuT3M1TXQL/yLXyx+YOc9TAgNmXznmZVu7k5uksnORdU8KP0pNI=
X-Received: by 2002:a05:6512:23a5:b0:4a4:7e77:664f with SMTP id
 c37-20020a05651223a500b004a47e77664fmr19328765lfv.603.1670063168333; Sat, 03
 Dec 2022 02:26:08 -0800 (PST)
MIME-Version: 1.0
References: <2d54b0bb-9252-a4be-7de5-a5b1bf7f2c37@gmail.com> <Y4sc1NXmKKnl8rSv@kroah.com>
In-Reply-To: <Y4sc1NXmKKnl8rSv@kroah.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 3 Dec 2022 19:25:31 +0900
Message-ID: <CAGTfZH0Tk1uKCx=+K-oVRe0ns=qLYatMM-GHDESO9yNW0oGwaA@mail.gmail.com>
Subject: Re: [GIT PULL] extcon next for 6.2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On Sat, Dec 3, 2022 at 6:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 03, 2022 at 03:17:00PM +0900, Chanwoo Choi wrote:
> > Dear Greg,
> >
> > This is extcon-next pull request for v6.2. I add detailed description of
> > this pull request on below. Please pull extcon with following updates.
> >
> > I'm sorry for late pull request. If possible, could you apply this pull request?
> >
> > Best Regards,
> > Chanwoo Choi
> >
> > The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:
> >
> >   Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.2
>
> The key you have used to sign this has expired, I get this warning when
> pulling:
>
> # gpg: Good signature from "Chanwoo Choi (Personal) <cwchoi00@gmail.com>" [expired]
> # gpg:                 aka "Chanwoo Choi <cw00.choi@samsung.com>" [expired]
> # gpg:                 aka "Chanwoo Choi <chanwoo@kernel.org>" [expired]
> # gpg: Note: This key has expired!
>
> I'll take this now, but please update your key in the kernel.org gpg
> keyring.

I'm sorry to bother you.  I'll use the updated key on next time.
Thanks.

-- 
Best Regards,
Chanwoo Choi
