Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B0610B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJ1HnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1HnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:43:04 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1DC1BB963
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:43:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q127so4356991vsa.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KFL9adKihekM8F4k25d98PC2Ll0xHE9L3wfiEmdcsI8=;
        b=ja4yWZKyRolktBga8ujdVEg5//IwG7IHFxFwFCKwBbuCsZT82D3fGh8l4z1YaRu2rc
         FtlLWEr09PyYdtIl/Jk+RlGoSFX7PvvRO8VomL0QYmFiB9/Trv6nuXbLLJgsX1qlWoll
         6YIfEplsbqikpMStY8KLTY8hFfouX6VMvRIPpGt4VHcYxEawlZ79ddo4uEJSXtOLOUHV
         b2sDEJztYSA304XkegQ90g5MbHvhohx3cqIbT8nCl4qR+7qFDw4SJri4Es57Yx9mT8r8
         H6KrPjhQOVetwenmhL1Kg486RH7YIYSORaKvMroM3Sfq+2aVDHkNIbeSusOxV1P1oEG8
         v3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFL9adKihekM8F4k25d98PC2Ll0xHE9L3wfiEmdcsI8=;
        b=IyJxeQUTHCt/yHfnnpAIqmHIrPP1Zq5ZZ36BPN+k8ErKva/dXLkyIenJbxL8XS9NWA
         fyhIBGNKwAnw4gdZO4KXvabHW6zxW/o4nzeG3wEqg0b7jrfeu4aG/2J60O7tZJ71o2mi
         wn+bmyVlr2P8XWWWDUXbDMHQsPS8Psiiv0hpoSHhgH5orQTBa9wFnyHu37DvmTXM/JiH
         bKFJse+Zg6XI5mAQhwGmoJtUABuJtU0McoTGeyf2k80zQI0f73eLymbBUSmmjupw1C2R
         egmJjhL8b1oxuc2DiDYPk6b4QWBYfMQmMYk77ZSPuhfQGlITR1dnrPH+GZNjPCn19uXx
         TpjQ==
X-Gm-Message-State: ACrzQf2HwO1jU1eZ248AeDWLam3crxgFVqRUbEDt6/LoIfGjzyNA8mGP
        uMziTxWTZBcBnJx+cnsBnr23s2ATjUwJZOAqjzg4Cj7jHT6FEb6a
X-Google-Smtp-Source: AMsMyM7tXiJc82o76JD4AaikiR4k2fSve2dBxpFxJoHlHd2ppquul8tY7yZ3tXhlK8qHYge4JwfGKS3I0TlFU7uvpYg=
X-Received: by 2002:a67:1902:0:b0:3aa:3c4c:72c4 with SMTP id
 2-20020a671902000000b003aa3c4c72c4mr8457483vsz.67.1666942983231; Fri, 28 Oct
 2022 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221028063711.GA35659@rdm> <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Fri, 28 Oct 2022 10:42:52 +0300
Message-ID: <CAMk1CBN2Vf7XLw-J_XLTyZwASg3WHNXdnv7NxKSJDGszvu2kwQ@mail.gmail.com>
Subject: Re: [PATCH] Remove Unnecessary typecast of c90 int constant
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

let me again look in deep into it and see why
Thank you for the comment

On Fri, 28 Oct 2022 at 10:22, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 28 Oct 2022, UMWARI JOVIAL wrote:
>
> > According to Linux kernel coding style.
> >
> > Reported by checkpatch:
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.412e8' could be '2.412e8'
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.487e8' could be '2.487e8'
>
> It's not ideal to just include the checkpatch messges verbatim in your log
> message.  It woudl be better to say what you are doing and why, in
> complete sentences ("According to the Linux coding style" is not a
> complete sentence).
>
> I also suspect that the checkpatch message is wrong.  Floating point
> numbers cannot be used in the kernel, and the case of the constant ensures
> that the value will be converted to an integer at compile time.
>
> julia
>
> >
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > index fdf867a5dd7a..4fc4fb25d8d6 100644
> > --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > @@ -41,8 +41,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
> >
> >       /* if setting by freq convert to channel */
> >       if (fwrq->e == 1) {
> > -             if ((fwrq->m >= (int)2.412e8 &&
> > -                  fwrq->m <= (int)2.487e8)) {
> > +             if ((fwrq->m >= 2.412e8 &&
> > +                  fwrq->m <= 2.487e8)) {
> >                       int f = fwrq->m / 100000;
> >                       int c = 0;
> >
> > --
> > 2.25.1
> >
> >
> >
