Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81DA65A3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiLaMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:01:39 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B85F78
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:01:38 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id z3so5273850uao.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaaY97QCcyGMEMmi6/j1i3/RRPxl4/1opD6hoeKEX1s=;
        b=aFbcxy3jnOjz7OpodmFHVOnEAlu4wWKJSepnSVGKgdOfp0GHhD+MFuGHgg4owJzytI
         sMJntPbeZJEJsqNxwdjeUHBjRdiDN1PUo2WJkPItrzw7sbk6dZXhGbQ44nCT1kfUuw2G
         LhPD4Az6kN7MEEGKLSwo4lARBg1dbL7Az4OdcnpR5A68f1L/CFZgaOdHToUvof8AlSnV
         E1le7BiOZGIfnXbLeIL31HjAAq3drHWSfPBw3kxyz76U0BNKVsl+muuDDcz1RvpsImhu
         jFn3H8cENN47Bk40+Cfz5BGvprjdG1YrueD0GzPxjfy8iSIICJ9DN7gU1ndhiNIg945g
         EcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaaY97QCcyGMEMmi6/j1i3/RRPxl4/1opD6hoeKEX1s=;
        b=dvYL2BLRrpZTHUppDalvv2N/hE1Rx/0nMOlwfzjwVfSQUH17Ng3d8KaEkB9ad159Ks
         J89jourSTSO4kavpFoEiHzFXe7mU0ESaGisH90EeKq1WOVUk2buLoqyuCfK2AFo5YROe
         cgpQQU/aQM1ZpxMVjL8IULYRMNDPCICnJbxRjMmkdRpy6PKoSTIfDZ1H0unbPKsNpESo
         5OzIgqwADWKN6B8tWQR9TJ8DnK4vzzUfzfsz36S6EBclHomf8eO23JzcGK3+u6SZxqyZ
         W8Ft541TR4R5husZLJmixzlqRNvTOzRq8W+vUNuYiHBGnOu3s3nxcmx/DcIjyuRma+Rq
         Mqow==
X-Gm-Message-State: AFqh2kqCp4JvYOqJH8FHirPb69EqFZPGZGKkOCgZPaussN/YNOdwgH5S
        XINx0I3GDEyzxRKnSvtBE1n6+TwL1awp3sNjL0Q=
X-Google-Smtp-Source: AMrXdXvKsx7afIiyOlQM/fAlfuwc8EKU3ooyXeRscS6LI85K3vl1IjQhM0xPm1vjdu9B/ewqKGwhz9dluWLXaAle0e8=
X-Received: by 2002:ab0:784f:0:b0:4e5:ad78:8523 with SMTP id
 y15-20020ab0784f000000b004e5ad788523mr2027966uaq.50.1672488097970; Sat, 31
 Dec 2022 04:01:37 -0800 (PST)
MIME-Version: 1.0
References: <Y66Hk6waTeXQDz1/@sol.localdomain> <20221230071551.61833-1-frank.li@vivo.com>
In-Reply-To: <20221230071551.61833-1-frank.li@vivo.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sat, 31 Dec 2022 20:01:27 +0800
Message-ID: <CAAJw_Zs7W5yToJ0L0eB55Ch30k-E1+L_B9YHHv9LTCVhHM7LCQ@mail.gmail.com>
Subject: Re: Fwd: f2fs write error Linux v6.2
To:     Yangtao Li <frank.li@vivo.com>
Cc:     ebiggers@kernel.org, bagasdotme@gmail.com, chao@kernel.org,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 3:16 PM Yangtao Li <frank.li@vivo.com> wrote:
>
> > What happened to the f2fs developers? No response from anyone yet. Am
> > I the only one facing this? Linux-6.2 is unusable until this is fixed.
> > What can I do to help?
>
> It's been a long time since I saw Kim and Chao respond to messages. I thi=
nk
> it may be because of the holiday in the US=EF=BC=8Cand China loosened res=
trictions
> on COVID-19 (lots of people got sick, I just recovered today).
>
> BTW, the log you uploaded corresponds to which kernel git is, and which
> commit it corresponds to.

Using the latest git pull ...

commit c8451c141e07a8d05693f6c8d0e418fbb4b68bb7 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 262eef26e350 0948a9ef1d59
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Dec 30 10:47:25 2022 -0800


I just applied Chao Yu's patch and it seems to hold ..

Thank you! Happy New Year!

Jeff
