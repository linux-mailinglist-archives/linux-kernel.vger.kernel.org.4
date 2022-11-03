Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF366183B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKCQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKCQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:06:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB91BEBE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:04:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z1so1417299qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/87SyahHYbwSlH02JkGLaqw/hD9Qaz9v7IraDvo2ww=;
        b=ELoiMFdakhbNbTC1cHNfG45HwjrFEEjem7lpCB2r9zq6dXhS1OcQWWkrEhklosjeVT
         CgH3WQQKCRJkHDSY4bbmiFJ+Ggn+BAbh5vHqQYHtZRmZBOIq+AZHBAmbMAurPUS4Sn8k
         qM79nmY2V8E+K57rJPtl3W8FmoWtgxa0lr6DCplfFXf9ndtrm7OAwlN2c+b4ea6+uszg
         N5lbbEp0igCMNWKAIxyspSN+wHxtDKDSguubPgkFRCu4Fj88u26vnlh9sZ2ZCCtRnhdS
         yXrvF5lFJ+A2aJLaddDZxNlzg1/CGbhmPGk7BexEFywdoG/OXFJrLYMh5x/WLqQl2AEY
         01RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/87SyahHYbwSlH02JkGLaqw/hD9Qaz9v7IraDvo2ww=;
        b=0v/d8w7SganKF4acX0aDbi6YMVC9BASNZJDqGr+tP7G/ieXWu5IsfwUcCBoLOdbp8U
         9xZ51gBYxyp41p1vukrzxy0rggFqFx03Hi7NKk+rgjCk9LCuSuKMQ+Nk8orC/JxGFOYT
         PXqG5GtxNcW5djMymH0ecK/qX1BAyxzSdHGXb0jkLqyxKEloC4Cl6EbvPgyz/Cvv4Odu
         toVQwXdK90XVSAPjzMj9goAi4X+e2CAtMhMcHzRoeFlun02J8kvyd0h7NeevEvUdAkcM
         IWDFKYNdnkZWyYpsPLEfDecb6IX+xhwWHtJBOr72vBb4MNtZLeybLa4NXJQIXS/+3OyQ
         kD6A==
X-Gm-Message-State: ACrzQf1UJLmTXo2HKm7mmBBbEhz2BSRuY+aKDOkxTVEQBibVsu9wd4Bf
        HgXzj4J3ItbHwZz2+FmwyDNRwSN6r/O2DExqWVE=
X-Google-Smtp-Source: AMsMyM6oRvykHakM/P+2nGCwq8RlP2uIkk28WR2QG88XNSPxT6pMfLOrWp3E+jx0X4MZpBQECLAkCPtce/rBfUVJQVk=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr22615839qki.158.1667491471546; Thu, 03
 Nov 2022 09:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <Y2OPStg4jXtWpJcd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <d0d6d613-174b-f7dd-7d45-45eecd26a850@inria.fr> <CAHJEyKUA4FG468S5bMsx+XGUR3pB3kKm_bx=LNPNJ6n9yPxCrQ@mail.gmail.com>
 <612f7cf-43db-a684-7a98-8469275b43fd@inria.fr>
In-Reply-To: <612f7cf-43db-a684-7a98-8469275b43fd@inria.fr>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 3 Nov 2022 17:04:18 +0100
Message-ID: <CAHJEyKXL=u=7tH2O3tdeSBZHyXLAdP9JcfzKHy6-bc7Bju5NMQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: change the function name s_vFillRTSHead
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

On Thu, Nov 3, 2022 at 4:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 3 Nov 2022, Tanju Brunostar wrote:
>
> > On Thu, Nov 3, 2022 at 1:38 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Thu, 3 Nov 2022, Tanjuate Brunostar wrote:
> > >
> > > > Remove the use of Hungarian notation, which is not used in the Linux
> > > > kernel. Reported by checkpatch
> > > >
> > > > Fix checkpatch error related to code line ends with a '(', by joining
> > > > some lines and indenting correctly. This improves visibility
> > >
> > > I don't think it will be appreciated to do two things at once.
> > >
> >
> > I sent it earlier as two patches but it seemed to break and fix the
> > kernel which was not appreciated by one of the mentors
>
> OK, then it is a presentation problem.  You have presented the changes as
> unrelated.  Rewrite the message to make clear what is being done.
>
> julia
>
okay
> >
> > > >
> > > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > > > ---
> > > >  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
> > > >  1 file changed, 22 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > > > index 31ae99b3cb35..debc5d5daede 100644
> > > > --- a/drivers/staging/vt6655/rxtx.c
> > > > +++ b/drivers/staging/vt6655/rxtx.c
> > > > @@ -23,7 +23,7 @@
> > > >   *      s_uGetTxRsvTime- get frame reserved time
> > > >   *      s_vFillCTSHead- fulfill CTS ctl header
> > > >   *      s_vFillFragParameter- Set fragment ctl parameter.
> > > > - *      s_vFillRTSHead- fulfill RTS ctl header
> > > > + *      fill_rts_header- fulfill RTS ctl header
> > > >   *      s_vFillTxKey- fulfill tx encrypt key
> > > >   *      s_vSWencryption- Software encrypt header
> > > >   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> > > > @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
> > > >  #define DATADUR_A_F1    13
> > > >
> > > >  /*---------------------  Static Functions  --------------------------*/
> > > > -static void s_vFillRTSHead(struct vnt_private *pDevice,
> > > > -                        unsigned char byPktType,
> > > > -                        void *pvRTS,
> > > > -                        unsigned int cbFrameLength,
> > > > -                        bool bNeedAck,
> > > > -                        bool bDisCRC,
> > > > -                        struct ieee80211_hdr *hdr,
> > > > -                        unsigned short wCurrentRate,
> > > > -                        unsigned char byFBOption);
> > > > +static void fill_rts_header(struct vnt_private *pDevice,
> > > > +                         unsigned char byPktType,
> > > > +                         void *pvRTS,
> > > > +                         unsigned int        cbFrameLength,
> > >
> > > Strange spacing in the above parameter declaration.  Maybe there is a tab
> > > that should be a space?
> > >
> > > julia
> > >
> >
> > I was also shocked when I noticed that. It seemed like a tab but when
> > I removed the space, the two words were joined and when I added the
> > space, it became this lage space once again. checkpatch does not
> > complain about it though
> >
> > > > +                         bool bNeedAck,
> > > > +                         bool bDisCRC,
> > > > +                         struct ieee80211_hdr *hdr,
> > > > +                         unsigned short wCurrentRate,
> > > > +                         unsigned char byFBOption);
> > > >
> > > >  static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> > > >                                  unsigned char byPktType,
> > > > @@ -555,19 +555,15 @@ s_uFillDataHead(
> > > >       return buf->duration;
> > > >  }
> > > >
> > > > -static
> > > > -void
> > > > -s_vFillRTSHead(
> > > > -     struct vnt_private *pDevice,
> > > > -     unsigned char byPktType,
> > > > -     void *pvRTS,
> > > > -     unsigned int cbFrameLength,
> > > > -     bool bNeedAck,
> > > > -     bool bDisCRC,
> > > > -     struct ieee80211_hdr *hdr,
> > > > -     unsigned short wCurrentRate,
> > > > -     unsigned char byFBOption
> > > > -)
> > > > +static void fill_rts_header(struct vnt_private *pDevice,
> > > > +                         unsigned char byPktType,
> > > > +                         void *pvRTS,
> > > > +                         unsigned int cbFrameLength,
> > > > +                         bool bNeedAck,
> > > > +                         bool bDisCRC,
> > > > +                         struct ieee80211_hdr *hdr,
> > > > +                         unsigned short wCurrentRate,
> > > > +                         unsigned char byFBOption)
> > > >  {
> > > >       unsigned int uRTSFrameLen = 20;
> > > >
> > > > @@ -912,7 +908,7 @@ s_vGenerateTxParameter(
> > > >                       buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > >                       buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > >
> > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > >               } else {/* RTS_needless, PCF mode */
> > > >                       struct vnt_rrv_time_cts *buf = pvRrvTime;
> > > >
> > > > @@ -931,7 +927,7 @@ s_vGenerateTxParameter(
> > > >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > >
> > > >                       /* Fill RTS */
> > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > >               } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> > > >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> > > >
> > > > @@ -945,7 +941,7 @@ s_vGenerateTxParameter(
> > > >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > >
> > > >                       /* Fill RTS */
> > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > >               } else { /* RTS_needless, non PCF mode */
> > > >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > >
> >
>
