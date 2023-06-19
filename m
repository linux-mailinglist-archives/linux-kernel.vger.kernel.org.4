Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D507E735DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjFSThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjFSThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:37:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D7E4A;
        Mon, 19 Jun 2023 12:37:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso1548552a12.0;
        Mon, 19 Jun 2023 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687203425; x=1689795425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCiCGDxwMd4WhpJ0lDsOjZu5jiOFyiINH2AXPJn8g98=;
        b=mazydBsOJ61iVOeYzcKkFUdSpcT0CZINW60Bd2tz9IMi4xIBK3nySdwi812xi5Uci6
         khkBbk0so2TEJCr6wSu0rUU2Y30y4fES6Ia1cIPoJfol6RsZr1gVm3nR0h455tR+4ydG
         mEZshXipTnCkwT3+8LMIVB56w4PxbOPJ/njZZ29+rPdgdLlpY84PonJ9yDLTOjY1YEh5
         7zrYsRWfz5+8J/a8sWU2AsouhWn4uQV+pIQq661CHst3llbti3bbiIiOd1VPcfAwn6QD
         l78Wy1umH7r7TYqHtTS7FQGEkIlKvTqJYVwieBfCygw6dbtZ8yDP5ULgHdHRMyIGsfzv
         fldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203425; x=1689795425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCiCGDxwMd4WhpJ0lDsOjZu5jiOFyiINH2AXPJn8g98=;
        b=UJT+qJNGHEBXxsu8veEN9NWKr20e+MxTLIG3FsEJYf3rrvujKOQQCjAcI96uyR+gBl
         XojO4iIaQS9EINtHHHRZv2gMsP0OV1RcWLmxVYGsoa/E6WIsq7JbJDZGVYpzUmrww7OS
         WgNk+3KaGFL/SfKUddJFqSbTDzIq5KDoaR53TtrXGnr4+gJO6ErXjJ1+CdUAl6tBdgKo
         tN9LeHkJxGmF3vrNNLSp9P+bJF2GWK1Shj5Z3szUZ3soMZqTlNd60zbDNV96LjhaSwpP
         kAWxo50QWlNMNwWqWhw62+3TW3nk+SXiNfd3+P5MuR7b6MK6DdE1VZjGk1QNbDOc0DWw
         M9LQ==
X-Gm-Message-State: AC+VfDwQIUidpWQ75atD9b/2ibdO1WfXTownx3Sfrz7i3PYNpszbaqu7
        VeXnNKsAxF3sy3rdGFAeBcaxGJ4iyW19OI4JfjM=
X-Google-Smtp-Source: ACHHUZ6PgQI0YWBvwKEoR+LcYOrOSEz8AY2kbvq0r/sSmxusIBdj5mWaqQxyYSdICImLKtVM0XtSU3UduPPuU86kJM4=
X-Received: by 2002:a05:6a20:3d1c:b0:10d:f812:e4b5 with SMTP id
 y28-20020a056a203d1c00b0010df812e4b5mr7441916pzi.35.1687203424890; Mon, 19
 Jun 2023 12:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230530213259.1776512-1-robimarko@gmail.com> <CAPDyKForsVQ_inZG9+8mWdWM6-_T6O23AiwndLg33Yh7rPYTpA@mail.gmail.com>
 <CAPDyKFrOG=mCW3WBr=n081EBDkKobSK_w+b6AnVAhcp_8gC5nQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrOG=mCW3WBr=n081EBDkKobSK_w+b6AnVAhcp_8gC5nQ@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 19 Jun 2023 21:36:54 +0200
Message-ID: <CAOX2RU5s9EPuwZM0T08HKjpr1TPn=Yvs9xAoJT41+PPRWTMYNw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Luca Porzio (lporzio)" <lporzio@micron.com>, windhl@126.com,
        avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 at 13:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 9 Jun 2023 at 00:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Luca (Bean was added by Avri in another thread)
> >
> > On Tue, 30 May 2023 at 23:33, Robert Marko <robimarko@gmail.com> wrote:
> > >
> > > It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support does
> > > not work when the core is trying to use REQ_OP_WRITE_ZEROES.
> > >
> > > We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora 301W
> > > that we did not previously have and tracked it down to REQ_OP_WRITE_ZEROES:
> > > [   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> > >
> > > Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
> > > to disable TRIM.
> >
> > Let's leave this another week or so, to allow Micron folkz to confirm
> > before applying.
> >
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Applied for next and by adding a stable tag, thanks!

Thanks, I have sent the patch for one of Kingstom eMMC as well that
seems to have TRIM broken
as well.

Regards,
Robert
>
>
> Kind regards
> Uffe
>
> >
> > > ---
> > >  drivers/mmc/core/quirks.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > > index 29b9497936df..77caa0c903f8 100644
> > > --- a/drivers/mmc/core/quirks.h
> > > +++ b/drivers/mmc/core/quirks.h
> > > @@ -100,6 +100,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> > >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> > >                   MMC_QUIRK_TRIM_BROKEN),
> > >
> > > +       /*
> > > +        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> > > +        * support being used to offload WRITE_ZEROES.
> > > +        */
> > > +       MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> > > +                 MMC_QUIRK_TRIM_BROKEN),
> > > +
> > >         /*
> > >          * Some SD cards reports discard support while they don't
> > >          */
> > > --
> > > 2.40.1
> > >
