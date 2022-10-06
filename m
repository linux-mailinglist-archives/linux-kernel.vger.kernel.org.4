Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4D5F6E41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiJFTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiJFTaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:30:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FBA0303
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:30:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so682188ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2PLX7t8akejXX2rlvi6ieaQqVuMDuBcH+372rToY1E=;
        b=D5rsC75yDUF9kWV3SquzIST3kPDsCVq58ukVLeJ5qmZglaoUSOcG3mq/Kw1MhbQXt1
         YdLMe6XV4Yxmbg7yhHXcsAyt2922i6I8tCuoQNIeZoiAhUbwmggWK27n8m9FAWx4XKeY
         0Ktpzjw4yvUWDXdDOWH9yFBMxQQrXCU2eGQma5j5beosI5UCpcvI6yq34F6Xkzj+51pt
         6Jw2DeI6Rc03l7WXtCMp40MPb3VI54QHBKSYpTzaK7ESaxjkiNYLB6cO6EzjyZPpG+Mc
         mwOuf7y/fp5iJ/wLRZesKkdGJR3KMB4+Bvmw2+PBUFPBG6tHFu+WiSTB9v3lBuvojg0/
         C7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2PLX7t8akejXX2rlvi6ieaQqVuMDuBcH+372rToY1E=;
        b=fl+hVhfzv3rc88Ji/MCD+tg8ssuye48ShrJ0O5zJiuKtPg7eY9Os20hsiPat9prfa5
         7FuSK6C3jvPT2Mp6040vJthqz86Rrlr5qu+hOoVTUk4kSUatObStZtRjy9NxuEywdykr
         6occysG05ID90OqE/JtqCcKINO6FGS7d7aA0f08MK4PqTSkTFqLACP3yTE1HwFhLaELn
         +J6IEuhc2+nPXdKVfMpaK5HEtRDYNN6FJjK73gpRLOFt9e3n0bO9MsWj3ePxcZHRu3iY
         vXtC73YSf1duWYjbBvSg5x0FzY/FWqqmzspnSyB2GgOCop1C94DXC7SB3/70kuquMvCf
         PJGw==
X-Gm-Message-State: ACrzQf3k05wLDPvvluHj2CgNPp4ftJ/Db03SMPgJCkDxQnfp3SxffgG8
        ++fiuWNA1m9rDivkZrI9G8M47taSUrdZtABd3YfIjp6U
X-Google-Smtp-Source: AMsMyM5B4b9kXUU1nZSUXa3bnfD4TPjf2+WmtG8vzAMZ3L/4bjMQge3FqWc3rAzZz/eazJuyQiuRj/DzwNNGDxg2MgM=
X-Received: by 2002:a17:906:5a44:b0:78d:4c17:9856 with SMTP id
 my4-20020a1709065a4400b0078d4c179856mr1177122ejc.477.1665084609198; Thu, 06
 Oct 2022 12:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
In-Reply-To: <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Oct 2022 05:29:57 +1000
Message-ID: <CAPM=9tzr1EAA=OaFmrPFT3UqQO+dixdZTPzs=tqdmgP+F_ojEA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, 7 Oct 2022 at 04:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Oct 4, 2022 at 8:42 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Lots of stuff all over, some new AMD IP support and gang
> > submit support [..]
>
> Hmm.
>
> I have now had my main desktop lock up twice after pulling this.
> Nothing in the dmesg after a reboot, and nothing in particular that
> seems to trigger it, so I have a hard time even guessing what's up,
> but the drm changes are the primary suspect.
>
> I will try to see if I can get any information out of the machine, but
> with the symptom being just a dead machine ...
>
> This is the same (old) Radeon device:
>
>    49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
>
> with dual 4k monitors, running on my good old Threadripper setup.
>
> Again, there's no explicit reason to blame the drm pull, except that
> it started after that merge (that machine ran the kernel with the
> networking pull for a day with no problems, and while there were other
> pull requests in between them, they seem to be fairly unrelated to the
> hardware I have).
>
> But the lockup is so sporadic (twice in the last day) that I really
> can't bisect it, so I'm afraid I have very very little info.
>
> Any suggestions?

netconsole?

I'll plug in my 480 and see if I can make it die.

Dave.
