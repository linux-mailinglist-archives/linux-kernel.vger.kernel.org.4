Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0778608B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJVJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJVJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:23:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B830DDF1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:36:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a5so3447746qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=025bctJnC6v5kJzOMmMkALIZKID9ay+0wrUaacLttgA=;
        b=q38Kzp0kA0A2ewZXYrKAJovuF4VMgrWkK0bOYd3K6AVagLy5Hch73dbXkqDSS1Icif
         fx7R0UBtQggMHVpamFx5YrWQ97XcZobi7smSUPDWRMJeAMd05R0UzwLApAUTXRdkA5nl
         zm9k8vV5i/CxS/f7eVoDF0PfhBoVkVG+0alM3zX911ukSj3BR5D8Lg5Hr7n5t+bqB77+
         HO5pPEdpabK/I50///bO82yqHTFGnH+m9tDZZRLKpqXUfYM6cWOeobsKVM3gJwAENTKi
         Dqmu9/QEBpVQwcI15vmEHWe+yXsgL+nQXn+8W432146im2bk0hXbTkAeoyomUuzsSO9l
         FerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=025bctJnC6v5kJzOMmMkALIZKID9ay+0wrUaacLttgA=;
        b=JXgCLYceirH6MbgPeVkjBKkPenoqulHLsE99zUtTn8PEAdPbOXr7mg9tTFw8yiVTq8
         FXhJv/or7jwRM7el9SLByAd7w6ttcT5ZfhGB+jQLPiEaddI5lo/o+pj7+AKtzEzJLuC7
         +DQTLbtdILp8r5mIvJFUx6BMffd2kyS4Hv0rTFR1UTcRhfjzBHEcd9/UXMUux+h00C3G
         SPNkc4iZqqOmrVwPA4rrRMwyk8eP9YBiXao2GWKEG2cSgEHkVmVA5PQU3ZMKVG7gOnIF
         kRX63MG0bDqNYOMrTDyNV1I15zGCNcEiYPAS52YEkf/Rk1nt9VuSF4EaN0kvo7MWDRSK
         zCiw==
X-Gm-Message-State: ACrzQf23g+hVUqkp1ZljnzJsC20qMaRTzCHVQvm5gWDOuXlLvJ771VZR
        Ti54zpNgeZLkcyF4QCbE/mwO9rGZ70/tjTHGa59VDJQmKuqxWSpEZW0=
X-Google-Smtp-Source: AMsMyM7gMqM27Jsc0M8UoH55Qquukfzouoy9ascj4Gt4Gx4ay1q7uTo2a0kAAXYQZurDlL0KtcFId2PN1hYr/uVz0H8=
X-Received: by 2002:a05:622a:254:b0:39c:b5d1:63 with SMTP id
 c20-20020a05622a025400b0039cb5d10063mr18859341qtx.296.1666427273958; Sat, 22
 Oct 2022 01:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-4-tanjubrunostar0@gmail.com> <Y1Ol7aLwJVdNtzph@kroah.com>
In-Reply-To: <Y1Ol7aLwJVdNtzph@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:27:42 +0100
Message-ID: <CAHJEyKU4NSrpRmRTG4q9D3xcTr-L2gtO7a_WPYTD7-nXoSQL_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] staging: vt6655: refactor long lines of code in s_uFillDataHead
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 9:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 22, 2022 at 07:06:09AM +0000, Tanjuate Brunostar wrote:
> > fix checkpatch errors by refactoring long lines of code in the function: s_uFillDataHead
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 97 ++++++++++++++++++++++++-----------
> >  1 file changed, 67 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 01e72999831b..dc853b83459b 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -484,19 +484,28 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
> >                       } else {
> >                               /* Get Duration and TimeStamp */
> >                               buf->duration_a =
> > -                                     cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
> > -                                                                         byPktType, wCurrentRate, bNeedAck, uFragIdx,
> > -                                                                         cbLastFragmentSize, uMACfragNum,
> > +                                     cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
>
> Why is this function not returning u16 to start with?  Everywhere it is
> used it is casted.
>
> Please fix that up first, then fix up the function name itself, and then
> work on shortening these lines, as that will be much better overall.
>
> thanks,
>
> greg k-h
OK
