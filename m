Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483EE607E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJUSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:14:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD03207B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:14:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z30so2522538qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRIaVA7IbW37xMjt4UyIoi28oEObcp55eUOuloap5Tw=;
        b=qMAwsEPVkK5iLMOkgHAlLTC38guT9l7ljuUpTvRrwgxRPDg0eUZTeO/NICq8KVjkte
         AmVHEvueKRFUg1AZjsIs76spu1UveR0u6BARgWX+lyguZ+o+DURe2t+Zs2M+SfL9nGuR
         DzCEczS0fPgd0szccqg+Ug2K0O1qtEJcZe7QVYIwvskBLpLFiDME0BYLBTTK6CdQOiL5
         qF/YlQfNb4nHtVUPCOC0UAaJkXDso5MU6BOih8gai6Q9ftzTwyKnKyHKA84m016bXt2K
         7qa9nYl05sD4uJ+QMgNkjMWxWW+ZV5Ai7Q8DA/UxeeGZLzrmJ3g1o9OZ30lzODFTwiqg
         afeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRIaVA7IbW37xMjt4UyIoi28oEObcp55eUOuloap5Tw=;
        b=FX/Iol4wOSDhNIOUO8e/R3oHtVnzRAOAcUpt/QeQURp/qVYIElR8piAIf+b1PObjQn
         TbLBXblxylpu+n5MGrG3AODMrhqnciL0z0zEVHVRaAq4aiTQ2UOsv/3PYYbDw/FFqmHF
         YQUzar7q9r74HNanC1O0Wg8WXuDLtSuaY4dAvnizC+ax1pStkYZBGKvgKPFAf7evnqT4
         HO6H4vDO25uBbUOegl8hirdmDoevsCmOkdZRbQ9Mad8kdpkZoYowh90XgZuresJHkCB4
         SNuBZ57wFFyrMXICLkn9kuX4ZmUOJsfnyIls1/6ktF1R6ohrhlmZ8qkibg4BTl2NMYyV
         OhSQ==
X-Gm-Message-State: ACrzQf1xWbCATpSj6gD1107M4NayBdx7wc9ftuO5OWXsBBb7fMR354aZ
        UhkH6cMnel8RiHYw9ctgBqX72uid46Wuwqb8Gsk=
X-Google-Smtp-Source: AMsMyM5Ruc36WWqiwRhr0PSWg+i/b/XuayDAluZzK6NB0RR89IS5IpdtRmVm4jOxoPQfE2znH7T6lYWm1WwtMo46aQg=
X-Received: by 2002:a05:620a:2699:b0:6cf:3a7f:5fe6 with SMTP id
 c25-20020a05620a269900b006cf3a7f5fe6mr15246902qkp.103.1666376080464; Fri, 21
 Oct 2022 11:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666347511.git.tanjubrunostar0@gmail.com>
 <03dd39114b1e5c029cd8022245403a079ff03ae7.1666347511.git.tanjubrunostar0@gmail.com>
 <02a45afb-f81d-639c-1cc6-6376e31351a6@gmail.com> <CAHJEyKW4QZHf_wjaR1bGs8vtb6Gu-inJ4oxcFkPPnAKEAd5-9w@mail.gmail.com>
In-Reply-To: <CAHJEyKW4QZHf_wjaR1bGs8vtb6Gu-inJ4oxcFkPPnAKEAd5-9w@mail.gmail.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 21 Oct 2022 19:14:28 +0100
Message-ID: <CAHJEyKUGJ+E13-oLTHr4PS6za==gyCPWm6siGZaasUw6dJxGmQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

On Fri, Oct 21, 2022 at 7:08 PM Tanju Brunostar
<tanjubrunostar0@gmail.com> wrote:
>
> On Fri, Oct 21, 2022 at 5:52 PM Philipp Hortmann
> <philipp.g.hortmann@gmail.com> wrote:
> >
> > On 10/21/22 12:33, Tanjuate Brunostar wrote:
> > > fix checkpatch errors by refactoring long lines of code in the functi=
on: s_vGenerateTxParameter
> > >
> > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > > ---
> > >   drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++--------=
---
> > >   1 file changed, 48 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/r=
xtx.c
> > > index dc853b83459b..42f4261293ba 100644
> > > --- a/drivers/staging/vt6655/rxtx.c
> > > +++ b/drivers/staging/vt6655/rxtx.c
> > > @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> > >       }
> > >
> > >       if (byPktType =3D=3D PK_TYPE_11GB || byPktType =3D=3D PK_TYPE_1=
1GA) {
> > > -             if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=3D TYPE_A=
TIMDMA && uDMAIdx !=3D TYPE_BEACONDMA) {
> > > +             if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx !=3D
> > > +                 TYPE_ATIMDMA && uDMAIdx !=3D TYPE_BEACONDMA) {
> > >                       /* Auto Fall back */
> > >                       struct vnt_cts_fb *buf =3D pvCTS;
> > >                       /* Get SignalField, ServiceField & Length */
> > > @@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
> > >
> > >                       ether_addr_copy(buf->data.ra,
> > >                                       pDevice->abyCurrentNetAddr);
> > > -             } else { /* if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx=
 !=3D TYPE_ATIMDMA && uDMAIdx !=3D TYPE_BEACONDMA) */
> > > +             } else {
> > > +                     /* if (byFBOption !=3D AUTO_FB_NONE && uDMAIdx =
!=3D TYPE_ATIMDMA &&
> > > +                      * uDMAIdx !=3D TYPE_BEACONDMA)
> > > +                      */
> > >                       struct vnt_cts *buf =3D pvCTS;
> > >                       /* Get SignalField, ServiceField & Length */
> > >                       vnt_get_phy_field(pDevice, uCTSFrameLen,
> > > @@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_p=
rivate *pDevice,
> > >                       /* Fill RsvTime */
> > >                       struct vnt_rrv_time_rts *buf =3D pvRrvTime;
> > >
> > > -                     buf->rts_rrv_time_aa =3D get_rtscts_time(pDevic=
e, 2, byPktType, cbFrameSize, wCurrentRate);
> > > -                     buf->rts_rrv_time_ba =3D get_rtscts_time(pDevic=
e, 1, byPktType, cbFrameSize, wCurrentRate);
> > > -                     buf->rts_rrv_time_bb =3D get_rtscts_time(pDevic=
e, 0, byPktType, cbFrameSize, wCurrentRate);
> > > -                     buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > -                     buf->rrv_time_b =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > -
> > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                     buf->rts_rrv_time_aa =3D get_rtscts_time(pDevic=
e, 2, byPktType, cbFrameSize,
> > > +                                                            wCurrent=
Rate);
> > > +                     buf->rts_rrv_time_ba =3D get_rtscts_time(pDevic=
e, 1, byPktType, cbFrameSize,
> > > +                                                            wCurrent=
Rate);
> > > +                     buf->rts_rrv_time_bb =3D get_rtscts_time(pDevic=
e, 0, byPktType, cbFrameSize,
> > > +                                                            wCurrent=
Rate);
> > > +                     buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, byPktType, cbFrameSize,
> > > +                                                             wCurren=
tRate, bNeedACK);
> > > +                     buf->rrv_time_b =3D
> > > +                             vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_=
11B, cbFrameSize,
> > > +                                                   pDevice->byTopCCK=
BasicRate, bNeedACK);
> > > +
> > > +                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC,
> > > +                                    psEthHeader, wCurrentRate, byFBO=
ption);
> > >               } else {/* RTS_needless, PCF mode */
> > >                       struct vnt_rrv_time_cts *buf =3D pvRrvTime;
> > >
> > > -                     buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > -                     buf->rrv_time_b =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > -                     buf->cts_rrv_time_ba =3D get_rtscts_time(pDevic=
e, 3, byPktType, cbFrameSize, wCurrentRate);
> > > +                     buf->rrv_time_a =3D vnt_rxtx_rsvtime_le16(pDevi=
ce, byPktType, cbFrameSize,
> > > +                                                             wCurren=
tRate, bNeedACK);
> > > +                     buf->rrv_time_b =3D
> > > +                             vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_=
11B, cbFrameSize,
> > > +                                                   pDevice->byTopCCK=
BasicRate, bNeedACK);
> > > +                     buf->cts_rrv_time_ba =3D get_rtscts_time(pDevic=
e, 3, byPktType, cbFrameSize,
> > > +                                                            wCurrent=
Rate);
> > >
> > >                       /* Fill CTS */
> > > -                     s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvC=
TS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> > > +                     s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvC=
TS, cbFrameSize, bNeedACK,
> > > +                                    bDisCRC, wCurrentRate, byFBOptio=
n);
> > >               }
> > >       } else if (byPktType =3D=3D PK_TYPE_11A) {
> > >               if (pvRTS) {/* RTS_need, non PCF mode */
> > > -                     struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> >
> > Error during compiliation in next line
> >
> > > +                     struct vnt_rrv_time_ab *buf =3D pvRrvT
> > > +                             ime;
> >
> > make: Entering directory '/home/kernel/Documents/git/kernels/staging'
> >    CC [M]  drivers/staging/vt6655/rxtx.o
> > drivers/staging/vt6655/rxtx.c: In function =E2=80=98s_vGenerateTxParame=
ter=E2=80=99:
> > drivers/staging/vt6655/rxtx.c:1014:34: error: =E2=80=98pvRrvT=E2=80=99 =
undeclared (first
> > use in this function)
> >   1014 |    struct vnt_rrv_time_ab *buf =3D pvRrvT
> >        |                                  ^~~~~~
> > drivers/staging/vt6655/rxtx.c:1014:34: note: each undeclared identifier
> > is reported only once for each function it appears in
> > drivers/staging/vt6655/rxtx.c:1015:5: error: expected =E2=80=98,=E2=80=
=99 or =E2=80=98;=E2=80=99 before
> > =E2=80=98ime=E2=80=99
> >   1015 |     ime;
> >        |     ^~~
> > make[1]: *** [scripts/Makefile.build:250: drivers/staging/vt6655/rxtx.o=
]
> > Error 1
> > make: *** [Makefile:1992: drivers/staging/vt6655] Error 2
> > make: Leaving directory '/home/kernel/Documents/git/kernels/staging'
> >
> This error occured on the first version of this patch. I corrected it,
> compiled the code and the error was gone before I sent this version.
> please check again. You may have seen this error on the first version
> and not this one.
> thanks
>
> Tanju
On the first patch, this error was detected by the kernel bot. This
time around, the kernel bot did not detect it, meaning it was fixed.
> > >
> > > -                     buf->rts_rrv_time =3D get_rtscts_time(pDevice, =
2, byPktType, cbFrameSize, wCurrentRate);
> > > -                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                     buf->rts_rrv_time =3D get_rtscts_time(pDevice, =
2, byPktType, cbFrameSize,
> > > +                                                         wCurrentRat=
e);
> > > +                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, byPktType, cbFrameSize,
> > > +                                                           wCurrentR=
ate, bNeedACK);
> > >
> > >                       /* Fill RTS */
> > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC,
> > > +                                    psEthHeader, wCurrentRate, byFBO=
ption);
> > >               } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> > >                       struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                     buf->rrv_time =3D
> > > +                             vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_=
11A, cbFrameSize,
> > > +                                                   wCurrentRate, bNe=
edACK);
> > >               }
> > >       } else if (byPktType =3D=3D PK_TYPE_11B) {
> > >               if (pvRTS) {/* RTS_need, non PCF mode */
> > >                       struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                     buf->rts_rrv_time =3D get_rtscts_time(pDevice, =
0, byPktType, cbFrameSize, wCurrentRate);
> > > -                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                     buf->rts_rrv_time =3D get_rtscts_time(pDevice, =
0, byPktType, cbFrameSize,
> > > +                                                         wCurrentRat=
e);
> > > +                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize,
> > > +                                                           wCurrentR=
ate, bNeedACK);
> > >
> > >                       /* Fill RTS */
> > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > +                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFra=
meSize, bNeedACK, bDisCRC,
> > > +                                    psEthHeader, wCurrentRate, byFBO=
ption);
> > >               } else { /* RTS_needless, non PCF mode */
> > >                       struct vnt_rrv_time_ab *buf =3D pvRrvTime;
> > >
> > > -                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > +                     buf->rrv_time =3D vnt_rxtx_rsvtime_le16(pDevice=
, PK_TYPE_11B, cbFrameSize,
> > > +                                                           wCurrentR=
ate, bNeedACK);
> > >               }
> > >       }
> > >   }
> >
