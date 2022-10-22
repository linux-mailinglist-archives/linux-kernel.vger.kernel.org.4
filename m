Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E83608AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJVJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJVJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:17:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4FE5B9EF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:31:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o8so3385601qvw.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci1g2jTtvoSe7PJcNgNyYuF4Ea5CkP/pjC29djDMeMc=;
        b=bz/800+kZiSWRW5eELLh3EEWv0h632amG6g23xRhi2Oc5Gz85thclWR0q0CbQhntyp
         NCu6BLZ4iZ5tHLit/EImHgVbqPei33MckIWAUskDNBuvihbTOh0m+EPtqA5DTcUK2oKk
         CnLDJSP/wUeSIU4cr9e7x1lDyM6tFhYB1pjDg7e1iW8+BWUyz3j1JlGiTF34T2XJVmQ3
         daT/CslOFXrX52Rnuj7+WtwohTfT/UBco9ISa7SYadTXQQ3NnmqCRVCuQKxxUPf+IQO+
         ryIbTZvqms7LklLhWqmTH85FtONN2pxrYRx5Mm0JHnf3m/8L6AKQDqj/hxE/BEGvoNod
         Vlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ci1g2jTtvoSe7PJcNgNyYuF4Ea5CkP/pjC29djDMeMc=;
        b=SEBAaFJIqGXp4qzmgCObtWCfX+2lG3cQwaZwc2kTOfGRadA0hftGQUNd9TvUGYXd5E
         K+bE2T6nptV/XY9/EuXgEPVkrnaiZZK0XwBY61784lytZYBpmwxHScrhnwbcf7VztxlZ
         gynI4dH0uOpdy/bIGHFZH/saDp+tyJ7VJ1vqLSjwmsselTLPe6qUwEF4ez6Huo/pmIXL
         AurSBRGTqKv/38E6HEJSDzL7WewrWZPdJw7anLwJqdXEtAo6e66+/egf5TyaupHagW3D
         eWNAXWO5rPmj6oNDN7bIZeyqg2+TI/670UYO0dQ2eThf4h3UsG5YNqla1OFAAcztDCIH
         vcWQ==
X-Gm-Message-State: ACrzQf3BS+2r7qAm8oCfo8CssohxK9KV2Ss+DY9hhJJ5jGX9eY0tUdPT
        Ia+GH7oa4+I5T6X6hK+3TwORzEcNi18l6jx28v/DVse04GH5liDgJlU=
X-Google-Smtp-Source: AMsMyM4tdATGGSHSsxFhhHhgOOD1SsALRWNHFzYXXV1YcvY4qi7IkUjWS3dkchSvyVdFQzIKaPbt5y7fddLIlRjhXY4=
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id
 fn12-20020ad45d6c000000b004afb5e063f1mr19534141qvb.35.1666427374275; Sat, 22
 Oct 2022 01:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-6-tanjubrunostar0@gmail.com> <Y1Omg6Tfv/lc7Fu4@kroah.com>
In-Reply-To: <Y1Omg6Tfv/lc7Fu4@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:29:22 +0100
Message-ID: <CAHJEyKWM0kRVkR_mHfUho6bdpb1eQ3eH6_W8ZAow4O=B9zWfbQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] staging: vt6655: refactor long lines of code in
 the rest of the file
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
> On Sat, Oct 22, 2022 at 07:06:11AM +0000, Tanjuate Brunostar wrote:
> > fix checkpatch errors by refactoring long lines of code in the rest of
> > the file
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 105 ++++++++++++++++++++++------------
> >  1 file changed, 67 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 951d4172e9f2..572be45cdbeb 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -1105,44 +1105,60 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> >               if (byFBOption == AUTO_FB_NONE) {
> >                       if (bRTS) {/* RTS_need */
> >                               pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
> > -                             pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize + sizeof(struct vnt_rrv_time_rts));
> > -                             pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize + sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
> > +                             pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
> > +                                        sizeof(struct vnt_rrv_time_rts));
> > +                             pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
> > +                                              sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
>
> Casting to void * is very odd.  Try working on fixing up that mess
> first...
>
> thanks,
>
> greg k-h
OK
