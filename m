Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B254618343
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKCPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKCPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:49:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DAE65C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:49:26 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s20so1395575qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=higXkm0LW2zoWVjTq5AcZkAGIoBPdyEY88hywSDs37E=;
        b=myh6yFbKgW0McggPRfiRwH82aL4jGPjgRZe39ke8oFWtpxWlI2cDaR5ABXRX6O0/gR
         vCpK55jRyIuu7dxa0sj4GvU89oWESlA9YI57OxcEZxCbnvRNoN5vhVRHfvQm56KvMVA9
         DGEep7wc1gYnkWfykkw7AL3zBL3vKs05vQ25BsCfoK7HyQg4iwqib3soxIevdgVbvnsu
         7r1TG3e/nlSvogmtqoLY6ok1FwJVPCLw9zQrPY86GLGfs3Z7YcobceYUiwd00tAJR+Xs
         0kjptNj/b5MdiDyBLfids37nZsUY+ZKuC5lSA6pMuh7svpDc/+js/9ynRjQoAoc3rDgh
         sMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=higXkm0LW2zoWVjTq5AcZkAGIoBPdyEY88hywSDs37E=;
        b=Hi+qZF9K+/s+jPA5AaDLGr0GbCXG+cJDMGbz9gFGGIPFgbl/C9wBtnuEFWW/UBecfm
         OWZJuTskRX0JLpEF6Qd7j9SSd3pysyCIRFpIt2CN+o40PZ3VhE3379V2epmB4G7ROGeS
         oSPur99+0tMTbgXM7mvfyOX3/XFOqzyIaqQiI/7Oo0KVHyDiNYhpUEFsj1T7VxX/DOiX
         k4tUJFClCF+9JLWJjk4cqwB1Jgw6uEFGcjt++EZuMQYFNYzIxeSJ54+GxYZbiWVyHHDv
         Lk0HPTM5azWb2WyAMz4lYaD64QCpWap4UfkVbKu8w9jSBmzbEitfrcrxFxVFRsqHQ3Sz
         KCew==
X-Gm-Message-State: ACrzQf2TMOeCHrIr8kX+RmuhXCQdEVoTvWRUNKZk5k5DT88CDunY2gM7
        iffay8MlY8GNf4oLxkZLXN+c1+8/3OfJ6W4lrzU=
X-Google-Smtp-Source: AMsMyM4/XXWSFfT2Hn4Ndhk+5JrHpvdYzm44hC5Qlc2PLOoG12so+jZedVFCF3CSejoYP2LFps0I13nJZzUYPMkTpy0=
X-Received: by 2002:a37:b5c2:0:b0:6fa:67fd:a2d5 with SMTP id
 e185-20020a37b5c2000000b006fa67fda2d5mr6197584qkf.29.1667490565565; Thu, 03
 Nov 2022 08:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <Y2OPStg4jXtWpJcd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <d0d6d613-174b-f7dd-7d45-45eecd26a850@inria.fr>
In-Reply-To: <d0d6d613-174b-f7dd-7d45-45eecd26a850@inria.fr>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 3 Nov 2022 16:49:13 +0100
Message-ID: <CAHJEyKUA4FG468S5bMsx+XGUR3pB3kKm_bx=LNPNJ6n9yPxCrQ@mail.gmail.com>
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

On Thu, Nov 3, 2022 at 1:38 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 3 Nov 2022, Tanjuate Brunostar wrote:
>
> > Remove the use of Hungarian notation, which is not used in the Linux
> > kernel. Reported by checkpatch
> >
> > Fix checkpatch error related to code line ends with a '(', by joining
> > some lines and indenting correctly. This improves visibility
>
> I don't think it will be appreciated to do two things at once.
>

I sent it earlier as two patches but it seemed to break and fix the
kernel which was not appreciated by one of the mentors

> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
> >  1 file changed, 22 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 31ae99b3cb35..debc5d5daede 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -23,7 +23,7 @@
> >   *      s_uGetTxRsvTime- get frame reserved time
> >   *      s_vFillCTSHead- fulfill CTS ctl header
> >   *      s_vFillFragParameter- Set fragment ctl parameter.
> > - *      s_vFillRTSHead- fulfill RTS ctl header
> > + *      fill_rts_header- fulfill RTS ctl header
> >   *      s_vFillTxKey- fulfill tx encrypt key
> >   *      s_vSWencryption- Software encrypt header
> >   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> > @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
> >  #define DATADUR_A_F1    13
> >
> >  /*---------------------  Static Functions  --------------------------*/
> > -static void s_vFillRTSHead(struct vnt_private *pDevice,
> > -                        unsigned char byPktType,
> > -                        void *pvRTS,
> > -                        unsigned int cbFrameLength,
> > -                        bool bNeedAck,
> > -                        bool bDisCRC,
> > -                        struct ieee80211_hdr *hdr,
> > -                        unsigned short wCurrentRate,
> > -                        unsigned char byFBOption);
> > +static void fill_rts_header(struct vnt_private *pDevice,
> > +                         unsigned char byPktType,
> > +                         void *pvRTS,
> > +                         unsigned int        cbFrameLength,
>
> Strange spacing in the above parameter declaration.  Maybe there is a tab
> that should be a space?
>
> julia
>

I was also shocked when I noticed that. It seemed like a tab but when
I removed the space, the two words were joined and when I added the
space, it became this lage space once again. checkpatch does not
complain about it though

> > +                         bool bNeedAck,
> > +                         bool bDisCRC,
> > +                         struct ieee80211_hdr *hdr,
> > +                         unsigned short wCurrentRate,
> > +                         unsigned char byFBOption);
> >
> >  static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> >                                  unsigned char byPktType,
> > @@ -555,19 +555,15 @@ s_uFillDataHead(
> >       return buf->duration;
> >  }
> >
> > -static
> > -void
> > -s_vFillRTSHead(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     void *pvRTS,
> > -     unsigned int cbFrameLength,
> > -     bool bNeedAck,
> > -     bool bDisCRC,
> > -     struct ieee80211_hdr *hdr,
> > -     unsigned short wCurrentRate,
> > -     unsigned char byFBOption
> > -)
> > +static void fill_rts_header(struct vnt_private *pDevice,
> > +                         unsigned char byPktType,
> > +                         void *pvRTS,
> > +                         unsigned int cbFrameLength,
> > +                         bool bNeedAck,
> > +                         bool bDisCRC,
> > +                         struct ieee80211_hdr *hdr,
> > +                         unsigned short wCurrentRate,
> > +                         unsigned char byFBOption)
> >  {
> >       unsigned int uRTSFrameLen = 20;
> >
> > @@ -912,7 +908,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> >                       buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> >
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else {/* RTS_needless, PCF mode */
> >                       struct vnt_rrv_time_cts *buf = pvRrvTime;
> >
> > @@ -931,7 +927,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> >
> >                       /* Fill RTS */
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > @@ -945,7 +941,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> >
> >                       /* Fill RTS */
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else { /* RTS_needless, non PCF mode */
> >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > --
> > 2.34.1
> >
> >
> >
