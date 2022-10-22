Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE73608AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJVJRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJVJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:16:23 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B02DF46C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:30:45 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g11so3048055qts.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IdLhdqZd5jMuGhUlOGaIRaKi0tmcMH8Qv7JaFOJC9E=;
        b=g2JDkIm9iqwOd5ul/PFvbxFQ0KVH6dqNEpQGDpQLgoWia1h40REPOMcjc1exETkDeB
         hXPC85D3AtRyHnNcsT2P7FuhK8a9wFJf59uIa6otT/lJREud0IosAGsLwLc4w9g08EWz
         wPxJmv8zOK+lwOOcZOA6meGdffR2SPxmk4e0BLEK7iyTfBWetK5eLHhtkD1UW6EtTaLE
         h6quAoH73eDJKWB+yO8IlNNnH3liRRzhJRABD+oesjYqWmeRcA0KAznFVn1aQl8nzigU
         AhQTcnijDbjYrTGmKqXZpFAv4CgKLi6XyoV9EjZb32zPEva2MJPqHzAMg/2DkMRTq4he
         xTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IdLhdqZd5jMuGhUlOGaIRaKi0tmcMH8Qv7JaFOJC9E=;
        b=tF/9DfVjiNW4gTp5c2h2VirHzs2DJs8FqThFvC20C4IBOoBEAVoeU1XS9jyCrp/9WW
         rkRt2t4PjAM73H1cf3zqsef2oLwVMt15BvisdNcgJc83SNKqpn9wGfKenrioRohc2okV
         RQCQm5/+JfdiJgPuG+o5OXwxQhdZz8PyTyBBcix+esvzxt3oHiXpnP4oJF672dUuTJHH
         oRSpGsI9a+QY72rhhb+dqnu7+4E+WfzbT/y82xdudaA1zLsMnMMcp2IkHMeGbN6090hl
         lWBhwNn9kVkVvBr4CH2Jhlv6XrNAgeWBc1N7BpNcbsXEy/1lEDQ0NDUURyRpUTKl1tXw
         UOPw==
X-Gm-Message-State: ACrzQf3r0L2GP5vC05AuDKdvoDLcz1qqbkbDHi4dqQqp02rNKb6z21Dy
        uL3inJ/ydy+GGPmq8SiVvUYJ3TnWC9zchVxvTA0=
X-Google-Smtp-Source: AMsMyM4Ikc1bXKT06XWQVfC9PiTj6AT9wUKPOHo4GcmQKnaf7HrPQns3zMmhg+NBoPNzcrjn8zGr58F/qX2iuIvDF9Q=
X-Received: by 2002:a05:622a:c5:b0:39c:f1c2:6732 with SMTP id
 p5-20020a05622a00c500b0039cf1c26732mr20225224qtw.588.1666427343453; Sat, 22
 Oct 2022 01:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-5-tanjubrunostar0@gmail.com> <Y1OmXf0Zn2eTo8us@kroah.com>
In-Reply-To: <Y1OmXf0Zn2eTo8us@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:28:51 +0100
Message-ID: <CAHJEyKW0mctANMnV77yuYu6ZYmyC9tCGtHd50eW11=ym=R70kQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
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
> On Sat, Oct 22, 2022 at 07:06:10AM +0000, Tanjuate Brunostar wrote:
> > fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 67 ++++++++++++++++++++++++-----------
> >  1 file changed, 46 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index dc853b83459b..951d4172e9f2 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> >       }
> >
> >       if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
> > -             if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
> > +             if (byFBOption != AUTO_FB_NONE && uDMAIdx !=
> > +                 TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
>
> Don't break lines like this, this is now much harder to read.
>
> It should look like:
>                 if (byFBOption != AUTO_FB_NONE &&
>                     uDMAIdx != TYPE_ATIMDMA &&
>                     uDMAIdx != TYPE_BEACONDMA) {
>
> If you want to make it more readable, right?
>
> And that is the main point here, the coding style is to make it readable
> to us humans, the compiler doesn't care.
>
> Your change makes the logic harder to understand, not easier, which is a
> step backwards.
>
> We write code for developers first (as we have to maintain it), and the
> compiler second.
>
> thanks,
>
> greg k-h
Got it
