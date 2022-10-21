Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA86070E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJUHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJUHWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:22:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5C2465C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:22:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m6so1519761qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPaKmoRvE4A6rVLRWlc1oTKPBkfWc57c8TVW/tjBN/I=;
        b=J9dCtJqpzowa7lVBK3NnxIreJqUCpAIDk0yFkd8MPV5WnT+0UocofbESO6sf71da1F
         5FjFCORIOyJBs7grusOp0Goy+c17O6H1GiDzZjOFxTeQ24DDUkzfoPAobqO0rWX1tHWq
         MC9ItwqpsC6bcj0CTxuj82IbhN1roDVI2YzQNBsnKa2gt3HD2RBHocInVQicR3FHx7Yb
         htLWXwQmLg92DFJk86FnPrRRNpx4wAnCsTGDsSIPI8V+0U6AcDynfQQfulkt8prfHDau
         d8HcZmRYEldpG+/EytZU99nOCNBUMb3aDwXVPlDY77LjrHH+2VzN4P9KBcepSHMDuPMC
         xJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPaKmoRvE4A6rVLRWlc1oTKPBkfWc57c8TVW/tjBN/I=;
        b=K8OR6SsqsMnuKHI83Td/Vd3dw0kytydB2aKqUYhvyJZwSLSfBY2JLqWJwOvljc7V+V
         16nvizAWstZ7NNfj6muSVx6BNpoiJNbHAONCFbEnmLuEhpRENszeojF3K0H2+k1kxiGp
         zK3uz3iX82iGFvrWJYnxaq+/58sIh2jQUoRkQfo5B8NMN2N5YYjeKwM/rVTbT1BKeI4I
         j8O+IQrUXGiPAZWSZ60R3apCvOm/nNRzeAetMkUdhnswkWFkzYeycNiImj87w3VzkkDF
         r+s8GayVpOMrZtYTEHcTB5eIHV3ihXCWk2lfqeerb7/dr2Uw2S9YGVzqikLQHxE2exp2
         qlgQ==
X-Gm-Message-State: ACrzQf0F8X+r1wSNSB3YmZ9OLNxFQ3+132m9lGVXiLFEfnDtPXQogawr
        LzLoRk0BqAshNGdg0NNdxmjCMp0aSQUKZHvygIU=
X-Google-Smtp-Source: AMsMyM5bjLprSKFt/xgZ0x3bzJauLa0VyrOnZRrQCu96kTdTur04cDUUg/uC3JIxdFFx1+0+klvtHGzVJygS/9ofmKM=
X-Received: by 2002:a37:cd3:0:b0:6e9:b157:c5ac with SMTP id
 202-20020a370cd3000000b006e9b157c5acmr13004928qkm.565.1666336924480; Fri, 21
 Oct 2022 00:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666288416.git.tanjubrunostar0@gmail.com>
 <03dd39114b1e5c029cd8022245403a079ff03ae7.1666288416.git.tanjubrunostar0@gmail.com>
 <605ec34c-202f-dcba-20f8-a0f2653b59dc@linux.microsoft.com> <15b531fb-7e8b-3cf2-3e79-e266292922e@inria.fr>
In-Reply-To: <15b531fb-7e8b-3cf2-3e79-e266292922e@inria.fr>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 21 Oct 2022 08:21:51 +0100
Message-ID: <CAHJEyKU9AK3+sKgdwH_eqPdCCB7foNEnSyEsEf5w_OmVD81JJQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        forest@alittletooquiet.net, greg@kroah.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 8:16 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 21 Oct 2022, Praveen Kumar wrote:
>
> > On 20-10-2022 23:57, Tanjuate Brunostar wrote:
> > > fix checkpatch errors by refactoring long lines of code in the functi=
on: s_vGenerateTxParameter
> > >
> > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > > ---
> > >  drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++---------=
--
> > >  1 file changed, 48 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/r=
xtx.c
> > > index dc853b83459b..42f4261293ba 100644
> > > --- a/drivers/staging/vt6655/rxtx.c
> > > +++ b/drivers/staging/vt6655/rxtx.c
> > > @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> > >     }
> > >
> > >     if (byPktType =3D=3D PK_TYPE_11GB || byPktType =3D=3D PK_TYPE_11G=
A) {
> > > -           if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=3D TYPE_ATI=
MDMA && uDMAIdx !=3D TYPE_BEACONDMA) {
> > > +           if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=3D
> > > +               TYPE_ATIMDMA && uDMAIdx !=3D TYPE_BEACONDMA) {
> > >                     /* Auto Fall back */
> > >                     struct vnt_cts_fb *buf =3D pvCTS;
> > >                     /* Get SignalField, ServiceField & Length */
> > > @@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> > >
> > >                     ether_addr_copy(buf->data.ra,
> > >                                     pDevice->abyCurrentNetAddr);
> > > -           } else { /* if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=
=3D TYPE_ATIMDMA && uDMAIdx !=3D TYPE_BEACONDMA) */
> > > +           } else {
> > > +                   /* if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=
=3D TYPE_ATIMDMA &&
> > > +                    * uDMAIdx !=3D TYPE_BEACONDMA)
> > > +                    */
> > >                     struct vnt_cts *buf =3D pvCTS;
> > >                     /* Get SignalField, ServiceField & Length */
> > >                     vnt_get_phy_field(pDevice, uCTSFrameLen,
> > > @@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_p=
rivate *pDevice,
> > >                     /* Fill RsvTime */
> > >                     struct vnt_rrv_time_rts *buf =3D pvRrvTime;
> > >
> > > -                   buf->rts_rrv_time_aa =3D get_rtscts_time(pDevice,=
 2, byPktType, cbFrameSize, wCurrentRate);
> > > -                   buf->rts_rrv_time_ba =3D get_rtscts_time(pDevice,=
 1, byPktType, cbFrameSize, wCurrentRate);
> > > -                   buf->rts_rrv_time_bb =3D get_rtscts_time(pDevice,=
 0, byPktType, cbFrameSize, wCurrentRate);
> > > -                   buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > -                   buf->rrv_time_b =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > -
> > > -                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                   buf->rts_rrv_time_aa =3D get_rtscts_time(pDevice,=
 2, byPktType, cbFrameSize,
> > > +                                                          wCurrentRa=
te);
> > > +                   buf->rts_rrv_time_ba =3D get_rtscts_time(pDevice,=
 1, byPktType, cbFrameSize,
> > > +                                                          wCurrentRa=
te);
> > > +                   buf->rts_rrv_time_bb =3D get_rtscts_time(pDevice,=
 0, byPktType, cbFrameSize,
> > > +                                                          wCurrentRa=
te);
> > > +                   buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize,
> > > +                                                           wCurrentR=
ate, bNeedACK);
> > > +                   buf->rrv_time_b =3D
> > > +                           vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11=
B, cbFrameSize,
> > > +                                                 pDevice->byTopCCKBa=
sicRate, bNeedACK);
> > > +
> > > +                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC,
> > > +                                  psEthHeader, wCurrentRate, byFBOpt=
ion);
> > >             } else {/* RTS_needless, PCF mode */
> > >                     struct vnt_rrv_time_cts *buf =3D pvRrvTime;
> > >
> > > -                   buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > -                   buf->rrv_time_b =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > -                   buf->cts_rrv_time_ba =3D get_rtscts_time(pDevice,=
 3, byPktType, cbFrameSize, wCurrentRate);
> > > +                   buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize,
> > > +                                                           wCurrentR=
ate, bNeedACK);
> > > +                   buf->rrv_time_b =3D
> > > +                           vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11=
B, cbFrameSize,
> > > +                                                 pDevice->byTopCCKBa=
sicRate, bNeedACK);
> > > +                   buf->cts_rrv_time_ba =3D get_rtscts_time(pDevice,=
 3, byPktType, cbFrameSize,
> > > +                                                          wCurrentRa=
te);
> > >
> > >                     /* Fill CTS */
> > > -                   s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS=
, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> > > +                   s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS=
, cbFrameSize, bNeedACK,
> > > +                                  bDisCRC, wCurrentRate, byFBOption)=
;
> > >             }
> > >     } else if (byPktType =3D=3D PK_TYPE_11A) {
> > >             if (pvRTS) {/* RTS_need, non PCF mode */
> > > -                   struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > > +                   struct vnt_rrv_time_ab *buf =3D pvRrvT
> > > +                           ime;
> >
> > I'm not sure if this patch is compiled ? In my understanding the recomm=
endation is have the patch compiled and if possible basic sanity done (can =
discuss with respective maintainers if they can help / guide) before sendin=
g here. Please do the needful. Thanks.
>
> In particular, always be sure that you have a .o file for the .c file tha=
t
> you changed.  The safest is to first try just compiling the file:
>
> make path/to/my/file.o
>
> Some files can't be compiled in that way.  You may need to do, eg
>
> make path/to/my/
>
> instead, but then there is a risk that even if you have compiled the
> directory, you have not actually compled the file that you changed.  So
> always check for the .o file.
>
> julia
>
>
> >
> > >
> > > -                   buf->rts_rrv_time =3D get_rtscts_time(pDevice, 2,=
 byPktType, cbFrameSize, wCurrentRate);
> > > -                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                   buf->rts_rrv_time =3D get_rtscts_time(pDevice, 2,=
 byPktType, cbFrameSize,
> > > +                                                       wCurrentRate)=
;
> > > +                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
byPktType, cbFrameSize,
> > > +                                                         wCurrentRat=
e, bNeedACK);
> > >
> > >                     /* Fill RTS */
> > > -                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC,
> > > +                                  psEthHeader, wCurrentRate, byFBOpt=
ion);
> > >             } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> > >                     struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                   buf->rrv_time =3D
> > > +                           vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11=
A, cbFrameSize,
> > > +                                                 wCurrentRate, bNeed=
ACK);
> > >             }
> > >     } else if (byPktType =3D=3D PK_TYPE_11B) {
> > >             if (pvRTS) {/* RTS_need, non PCF mode */
> > >                     struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                   buf->rts_rrv_time =3D get_rtscts_time(pDevice, 0,=
 byPktType, cbFrameSize, wCurrentRate);
> > > -                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                   buf->rts_rrv_time =3D get_rtscts_time(pDevice, 0,=
 byPktType, cbFrameSize,
> > > +                                                       wCurrentRate)=
;
> > > +                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
PK_TYPE_11B, cbFrameSize,
> > > +                                                         wCurrentRat=
e, bNeedACK);
> > >
> > >                     /* Fill RTS */
> > > -                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                   s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrame=
Size, bNeedACK, bDisCRC,
> > > +                                  psEthHeader, wCurrentRate, byFBOpt=
ion);
> > >             } else { /* RTS_needless, non PCF mode */
> > >                     struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                   buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice, =
PK_TYPE_11B, cbFrameSize,
> > > +                                                         wCurrentRat=
e, bNeedACK);
> > >             }
> > >     }
> > >  }
> >
> > Regards,
> >
> > ~Praveen.
> >
> >
Thanks for the guidance. Will do that
