Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF863D4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiK3LfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiK3Lel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:34:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DD7B611
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:34:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so16371119plc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt+jeUCmbHRpuzK+fZSc4ivofSbJWHqyWABXtLQhRg4=;
        b=BjtAnrSIXCjAQgYt9mCdERiAKHjXFsA4027zCQv5WiHcFipEGZJT8DlcKZGWL3fcjN
         JjaAi+8fMb/c4KMtrbB/I7gY0alPQ1pSOmJHKN1akuEE+Rj+C292k7Pabj60vrRHqFru
         relSyX2cxswGaQ9m+5aT+zMeDrPBm7lgJo3v87fc6Cxczmmg9g/X5UF2SlWLBWj+2LeD
         AsXKb+cy5BSoxU8PRdsUHEHltlqgaD669pcBAdmRN09rCUi5/S+B47TzE0oBXIoLZeGm
         muYAcHb9C/GxT+Le4QrANDcE4RkQ4l0W+PF3GT5t5HfpIxUzC3T28X1QNBacK88/rOso
         k19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vt+jeUCmbHRpuzK+fZSc4ivofSbJWHqyWABXtLQhRg4=;
        b=GWYyEK5yxCHBBXJePDUF5QsNGikGr1tw4C1whNCnRBQSknfsrDWEfaFCTTszQ1EBGf
         Mm8whJW8VgCf/+aP4XlHpQnF05lmLXLPzCXxjVQfdhRKVvNqyziqGyskUYaci5wAKlHe
         gP3xScG0QIFh+6HaBVBfYPPJDZve7id8AntWA8Dv4d/a0PLZSWZzFuqCycTpI+tw2WxK
         2cPyE3fWZvTzZBOOef39dwS76VnrGI/K+UrohXFYCEqrLXD16Vir5gJPnwUl0gO9KGv3
         4RSwUQHstxLjIe/zXPpdkMuyJe88AqW/tMYmMv+g5rc4SGJYubjr7w/ZP34ZbpWVPR/e
         gEGw==
X-Gm-Message-State: ANoB5pmxfKY1OSi+yb0hWwBul6dJyqr1nfe3b2eTaudA3KRJkQp/rH32
        aYa43bj58RnA2QTt8mAhycwCf/UpbsNIo6euwptYElaUZUs=
X-Google-Smtp-Source: AA0mqf7p9b5ayCsGlKeXiBkIRIpTQd5EnIRo8eNLpVLk8NlcKvLW8dKFi/08brczBWlXxhqrXrBfcM8cm/JQl+XD79M=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr63145200pjq.202.1669808041406; Wed, 30
 Nov 2022 03:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20221130092847.2092-1-thunder.leizhen@huawei.com>
 <CAPDyKFphNdR-TorULpbsMtM6MzqsaK_UdSmG9Hin=wunUwJwJQ@mail.gmail.com> <d9d44a9c-e61e-2803-731b-cfa5f3d3d46c@huawei.com>
In-Reply-To: <d9d44a9c-e61e-2803-731b-cfa5f3d3d46c@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:33:24 +0100
Message-ID: <CAPDyKFrbRcEgtwbgBY8bsDW3YTtXJBS0zRhJq-Emf89hDWaUjg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix error return code in sd_read_ext_regs()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 12:18, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2022/11/30 18:04, Ulf Hansson wrote:
> > On Wed, 30 Nov 2022 at 10:29, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> Fix to return a negative error code from the error handling
> >> case instead of 0, as done elsewhere in this function.
> >>
> >> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  drivers/mmc/core/sd.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >> index 3662bf5320ce56d..7b64f76f0179ca8 100644
> >> --- a/drivers/mmc/core/sd.c
> >> +++ b/drivers/mmc/core/sd.c
> >> @@ -1277,6 +1277,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
> >>         if (rev != 0 || len > 512) {
> >>                 pr_warn("%s: non-supported SD ext reg layout\n",
> >>                         mmc_hostname(card->host));
> >> +               err = -EOPNOTSUPP;
> >
> > The original intent was to not return an error code. Simply, because
> > the card remains functional and all but the new features from the SD
> > function extensions registers can still be used.
>
> OK, I got it.
>
> >
> > Perhaps, we should update the comment a few lines above to better
> > reflect that this is in-fact what we intend here.
>
> How about also add 'warning' to the output? The other two outputs
> contain the 'error' keyword.

There is already a pr_warn(), or is there something you want to add to that?

>
> >
> >>                 goto out;
> >>         }
> >>

Kind regards
Uffe
