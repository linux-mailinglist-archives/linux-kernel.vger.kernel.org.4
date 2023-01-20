Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65698675DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjATTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjATTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:18:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A229155;
        Fri, 20 Jan 2023 11:18:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so9541395lfv.2;
        Fri, 20 Jan 2023 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYPQJWlniGBmq4AzLRQJWodVCfnM6YRZwibUhCT+d5A=;
        b=heb15bTtdZT17xmmqjNbgXZT0dR2QN6/fu8nuXR960n6sInBBperAgntX22WCjwI2n
         I+g6HqywVBYfiBrGn/zojiY5V3EHTnonOlNP3RdOw44+HwSm34z5JjBJz65SuGhOCXC9
         j+iv6bzjhCisC3KHwxyceKjn5A2X5q1fy0Pc3sF2M34Fp8VqntW18liDTWnUl8MWrLUA
         OIIgmEnMkN9lfCwBscWFHFAXWURMk6uvWbUx2WSxUdtg9mmwAxunaqv6Gty9RdskDzjw
         W2NrC8hH594iosmYoGQ3BGNbWdf93K6yNPM3md3/ij/lk289A5YBrVcQRwMsbRqdHTPw
         v1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYPQJWlniGBmq4AzLRQJWodVCfnM6YRZwibUhCT+d5A=;
        b=bJvD5rXIFoE+YnkIAXrtvMYp6S7jo2hjy5nYyiRnaKbOcxl2r3sLj5xJNc4CK1h/h0
         R1QCD/U9ohy7rOIwJYq0+s/TJGeyb9TADc1gMulWDKCsSLni+So7eip55w7bO18wKcC7
         2fjQIiXRLaaJEiHrI7HZvMyxZBaF7G6Z9MkTB7Qn8xzJBGSYPUPT/WnAN4eEt+9nXcli
         PKHy/bUJ7B04oHlyPAL4TGWFyil7uRiYgaMWqTwyyJo8jx5YbaMEGuMIOjK0xUIAb+8z
         ZZZmJYjRwx/2j09C6x7luoaZPUXCZbvwBmNaUDZ6w+F8ADvRka1wtEnAJm6/cgJ+zFta
         EfNg==
X-Gm-Message-State: AFqh2krtowqfd9h93PZWis+tLIzEebpDUUUGdKq51ZrH4nWJKAcFlSt3
        /mEgVgR2LlWbwJeSNDGTvm2O9DmzxRgdsNpSklw=
X-Google-Smtp-Source: AMrXdXtDjM/fxl3sPQunHrLRY+Jj0Ha2oXd/y57zrVpFObrM9t3REGLn9LV3cDjpgSmVtgRrV4wMJxAi7FbJPsX/uXE=
X-Received: by 2002:a05:6512:2397:b0:494:842e:3f6 with SMTP id
 c23-20020a056512239700b00494842e03f6mr858882lfv.225.1674242278695; Fri, 20
 Jan 2023 11:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20230120120857.60444-1-andriy.shevchenko@linux.intel.com> <87r0vpe182.fsf@cjr.nz>
In-Reply-To: <87r0vpe182.fsf@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 20 Jan 2023 13:17:47 -0600
Message-ID: <CAH2r5mvgSnVhLSx=sjAu=dK1C5q9tqby-EmSz6_3rp+Azw-hKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cifs: Get rid of unneeded conditional in the smb2_get_aead_req()
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steve French <stfrench@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
        Tom Talpey <tom@talpey.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
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

merged into cifs-2.6.git for-next

On Fri, Jan 20, 2023 at 8:22 AM Paulo Alcantara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> > In the smb2_get_aead_req() the skip variable is used only for
> > the very first iteration of the two nested loops, which means
> > it's basically in invariant to those loops. Hence, instead of
> > using conditional on each iteration, unconditionally assing
> > the 'skip' variable before the loops and at the end of the
> > inner loop.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  fs/cifs/smb2ops.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>


-- 
Thanks,

Steve
