Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347D6186CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKCR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiKCR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95110B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f8so1666044qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vznSjJD3MTC22UgiEIgEwBQISg4telMt7r/lvGWOTAY=;
        b=fum8epZ95c2vcvotsLw2zD4mgCXfMySrmnE0sL66rC0pypUuDddVvwbSlshdfTRGDJ
         ebL0RHQrm061ppipmeSKzu98oguhEBcZlBXVzedYvY2jHTGnVdFYV2mwbn4UwmIkppY9
         3ahOSqVsYvv2mR5ziUzUKDU4rtxSPr5oJVfuBYXDRl9ftcgOT5N5RRo3/tYDtvyZUXt3
         dv7u4o44bhpPTIdMIJxmRlcgRr7f1vWqvizrN+SfFKnQN4ltsa70rJTo5r6N1aL8Yjsx
         9GPZLyXmjHkM4UEA6qImCApxz+Is4iWki0oxMON9hfLLJzS0mx3C6lcUe1/S28C49bZu
         5hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vznSjJD3MTC22UgiEIgEwBQISg4telMt7r/lvGWOTAY=;
        b=TK569IR/QEwAZVCTGCA3nmmdSTmKZFDWZLjpIc4TcXQwtehHQKkSKaY9lNRd76mpaQ
         iNaywWjiI4VBbwBo4b8+QB6veIgeIfyO7Kb6CyRqKJZinq9sOZyA65a6G3sxCJAZIDp+
         JN65YfGbXkKm3DNV5DZ/S+jNrOTKGQgfMOyS+MgJs47sMwbranpdgNWooWPpcdObNNpk
         knHFxlNBdGSJADdf4RyHsMfkwQmLxbjLDi9fgoGqah5gUtVqakwYO42WXynxtumdm9Zh
         wkaI63PTOcA2yQRpQBdQP2t3DMV/DrxBrU2Da024YVba9+IGAwowBCnwaurha1L9F+FW
         k7UQ==
X-Gm-Message-State: ACrzQf2EcU6T8xCNo4sY91FYB3FdDlx6MEiVyzmqSsvLeIPsm/TDJedI
        ZmqV/aGYm2jSJWPem9PNCG/kbTaV6YXo0kKSj/yohXIrtnVq4b5u
X-Google-Smtp-Source: AMsMyM4ZegQ8e26KA/txCZfvLTUZRpJOAs3TJIkQyyG4c32VOP83OJzOi+4gkQQj/vb6zBmLxLw+E1nPFLShoiSbAjU=
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id
 o3-20020a05620a22c300b006ec53bbd296mr23058155qki.158.1667498351065; Thu, 03
 Nov 2022 10:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <Y2OPStg4jXtWpJcd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <d0d6d613-174b-f7dd-7d45-45eecd26a850@inria.fr> <CAHJEyKUA4FG468S5bMsx+XGUR3pB3kKm_bx=LNPNJ6n9yPxCrQ@mail.gmail.com>
 <612f7cf-43db-a684-7a98-8469275b43fd@inria.fr> <CAHJEyKXL=u=7tH2O3tdeSBZHyXLAdP9JcfzKHy6-bc7Bju5NMQ@mail.gmail.com>
 <CAHJEyKWBTxvP_mkSaWw7duhm1_-_AE27FhrnZYOXsTy1Qt_c=g@mail.gmail.com> <9eef21fa-c7bc-9fba-67ae-2a532ee6c3fa@inria.fr>
In-Reply-To: <9eef21fa-c7bc-9fba-67ae-2a532ee6c3fa@inria.fr>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 3 Nov 2022 18:58:58 +0100
Message-ID: <CAHJEyKWsFQ4RW6O+Xq6=LEc7-+LxW6Dx+Pc-neSZZUMKQ80CkQ@mail.gmail.com>
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

On Thu, Nov 3, 2022 at 6:51 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 3 Nov 2022, Tanju Brunostar wrote:
>
> > On Thu, Nov 3, 2022 at 5:04 PM Tanju Brunostar
> > <tanjubrunostar0@gmail.com> wrote:
> > >
> > > On Thu, Nov 3, 2022 at 4:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > >
> > > >
> > > > On Thu, 3 Nov 2022, Tanju Brunostar wrote:
> > > >
> > > > > On Thu, Nov 3, 2022 at 1:38 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Thu, 3 Nov 2022, Tanjuate Brunostar wrote:
> > > > > >
> > > > > > > Remove the use of Hungarian notation, which is not used in the Linux
> > > > > > > kernel. Reported by checkpatch
> > > > > > >
> > > > > > > Fix checkpatch error related to code line ends with a '(', by joining
> > > > > > > some lines and indenting correctly. This improves visibility
> > > > > >
> > > > > > I don't think it will be appreciated to do two things at once.
> > > > > >
> > > > >
> > > > > I sent it earlier as two patches but it seemed to break and fix the
> > > > > kernel which was not appreciated by one of the mentors
> > > >
> > > > OK, then it is a presentation problem.  You have presented the changes as
> > > > unrelated.  Rewrite the message to make clear what is being done.
> > > >
> > > > julia
> > > >
> >
> > Hi Julia,
> > I am having a hard time figuring out exactly how to write this, since
> > I made both changes in one patch and there is no way to send them in
> > separate patches. should I just report just one change and leave the
> > other? I would appreciate your help here
>
> Add indentation to the affected function headers to follow the Linux
> kernel coding style?
>
> julia
>

Thank you

>
> > Thanks
> >
> > tanju
> >
> > > okay
> > > > >
> > > > > > >
> > > > > > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
> > > > > > >  1 file changed, 22 insertions(+), 26 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > > > > > > index 31ae99b3cb35..debc5d5daede 100644
> > > > > > > --- a/drivers/staging/vt6655/rxtx.c
> > > > > > > +++ b/drivers/staging/vt6655/rxtx.c
> > > > > > > @@ -23,7 +23,7 @@
> > > > > > >   *      s_uGetTxRsvTime- get frame reserved time
> > > > > > >   *      s_vFillCTSHead- fulfill CTS ctl header
> > > > > > >   *      s_vFillFragParameter- Set fragment ctl parameter.
> > > > > > > - *      s_vFillRTSHead- fulfill RTS ctl header
> > > > > > > + *      fill_rts_header- fulfill RTS ctl header
> > > > > > >   *      s_vFillTxKey- fulfill tx encrypt key
> > > > > > >   *      s_vSWencryption- Software encrypt header
> > > > > > >   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> > > > > > > @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
> > > > > > >  #define DATADUR_A_F1    13
> > > > > > >
> > > > > > >  /*---------------------  Static Functions  --------------------------*/
> > > > > > > -static void s_vFillRTSHead(struct vnt_private *pDevice,
> > > > > > > -                        unsigned char byPktType,
> > > > > > > -                        void *pvRTS,
> > > > > > > -                        unsigned int cbFrameLength,
> > > > > > > -                        bool bNeedAck,
> > > > > > > -                        bool bDisCRC,
> > > > > > > -                        struct ieee80211_hdr *hdr,
> > > > > > > -                        unsigned short wCurrentRate,
> > > > > > > -                        unsigned char byFBOption);
> > > > > > > +static void fill_rts_header(struct vnt_private *pDevice,
> > > > > > > +                         unsigned char byPktType,
> > > > > > > +                         void *pvRTS,
> > > > > > > +                         unsigned int        cbFrameLength,
> > > > > >
> > > > > > Strange spacing in the above parameter declaration.  Maybe there is a tab
> > > > > > that should be a space?
> > > > > >
> > > > > > julia
> > > > > >
> > > > >
> > > > > I was also shocked when I noticed that. It seemed like a tab but when
> > > > > I removed the space, the two words were joined and when I added the
> > > > > space, it became this lage space once again. checkpatch does not
> > > > > complain about it though
> > > > >
> > > > > > > +                         bool bNeedAck,
> > > > > > > +                         bool bDisCRC,
> > > > > > > +                         struct ieee80211_hdr *hdr,
> > > > > > > +                         unsigned short wCurrentRate,
> > > > > > > +                         unsigned char byFBOption);
> > > > > > >
> > > > > > >  static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> > > > > > >                                  unsigned char byPktType,
> > > > > > > @@ -555,19 +555,15 @@ s_uFillDataHead(
> > > > > > >       return buf->duration;
> > > > > > >  }
> > > > > > >
> > > > > > > -static
> > > > > > > -void
> > > > > > > -s_vFillRTSHead(
> > > > > > > -     struct vnt_private *pDevice,
> > > > > > > -     unsigned char byPktType,
> > > > > > > -     void *pvRTS,
> > > > > > > -     unsigned int cbFrameLength,
> > > > > > > -     bool bNeedAck,
> > > > > > > -     bool bDisCRC,
> > > > > > > -     struct ieee80211_hdr *hdr,
> > > > > > > -     unsigned short wCurrentRate,
> > > > > > > -     unsigned char byFBOption
> > > > > > > -)
> > > > > > > +static void fill_rts_header(struct vnt_private *pDevice,
> > > > > > > +                         unsigned char byPktType,
> > > > > > > +                         void *pvRTS,
> > > > > > > +                         unsigned int cbFrameLength,
> > > > > > > +                         bool bNeedAck,
> > > > > > > +                         bool bDisCRC,
> > > > > > > +                         struct ieee80211_hdr *hdr,
> > > > > > > +                         unsigned short wCurrentRate,
> > > > > > > +                         unsigned char byFBOption)
> > > > > > >  {
> > > > > > >       unsigned int uRTSFrameLen = 20;
> > > > > > >
> > > > > > > @@ -912,7 +908,7 @@ s_vGenerateTxParameter(
> > > > > > >                       buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > > > > >                       buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> > > > > > >
> > > > > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > >               } else {/* RTS_needless, PCF mode */
> > > > > > >                       struct vnt_rrv_time_cts *buf = pvRrvTime;
> > > > > > >
> > > > > > > @@ -931,7 +927,7 @@ s_vGenerateTxParameter(
> > > > > > >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> > > > > > >
> > > > > > >                       /* Fill RTS */
> > > > > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > >               } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> > > > > > >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> > > > > > >
> > > > > > > @@ -945,7 +941,7 @@ s_vGenerateTxParameter(
> > > > > > >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> > > > > > >
> > > > > > >                       /* Fill RTS */
> > > > > > > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > > > > > >               } else { /* RTS_needless, non PCF mode */
> > > > > > >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > > >
> > > > >
> > > >
> >
