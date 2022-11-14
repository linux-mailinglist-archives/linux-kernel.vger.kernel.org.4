Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F11628C80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiKNW7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKNW7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:59:34 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD88C6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:59:34 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id i9so8458351qki.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Bd+hPxRC8CJvSI+iSnYQgyjxDeUguvczWQMfQnYonI=;
        b=INOwPdrEBgADif+uik9Nd2gkrct6olxqpY0ZhI9BzXqZ09CrNJpxz8jb+ks1TClKZd
         un4pScO4qyTOFePGRJJEDfqD0AQ2TxHoJVhK2XJzhf/wTOEHpu/x6YnZJNTuUKkfwbGM
         kxqes3BtnFARLwrMlyie5ppNv61f0D2C7SvB10WsXJjWVy8qSFVT6ZHXcYSlQgBMDM1E
         bWUG0MsZXcR789Qp1NuKdFvrbNzBg4RIDAz9RCRo+N0LYO7qCPUOH3/t8ipjws10WEHU
         TYodoNsj4EGkIWF6pav9iCWwScoSaIp0gxvgr9UN+R3jv/+m6t0N7qJKPc3sTvVapb5v
         /kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Bd+hPxRC8CJvSI+iSnYQgyjxDeUguvczWQMfQnYonI=;
        b=jKyHrb2Ue6x6WPwxMTZ53WhyMZ+5J1Q1q8im7lrG3FtlZUrpgNAbb51IlItpLw76m6
         CwOAks4LotZJ8oEqTJA+ETjnM7Bp8IwgRUogg/PkXugt0iSF01xJKSHp1OrrmIvqQ3+B
         4WWkWGedvKOs7sODe9vjlT0r81wAZjYLm0dgZ+ubOBUDL5ms4dDcH+42C1FtHSD5Dlm2
         TRk7YAJ3e9f9sNLUaSaB0jNAC6qzJKzPJ6PvI2parpGCo9SZFjhxLkHgkLw2OA7rKHZj
         IHIsqgB4rEu2s975Fsy4b5eeVcPNnH5zK4/uncOx5E+AylGlYD31JAk4+0/c8e/nyRHj
         us7A==
X-Gm-Message-State: ANoB5pnaMstCx4ryRXU77P/J+pn5h6Dpl1yTZH6kAZiOeluEM+223YEr
        oAEy3Jt8DPKBSX4ZnddJWQWE4sK940UhvyVOxWeT9Z5iCbg/t0p265M=
X-Google-Smtp-Source: AA0mqf4+uAd8QY4rcmNAPSZ7CzhMsZy85axr1O83SH3ZgfZ/CRIdoZk3kL88Qm+CZzZhZFutnwPBcdcpocHBejOwE1g=
X-Received: by 2002:a37:aec3:0:b0:6fa:2ff9:e9ca with SMTP id
 x186-20020a37aec3000000b006fa2ff9e9camr13377681qke.29.1668466773107; Mon, 14
 Nov 2022 14:59:33 -0800 (PST)
MIME-Version: 1.0
References: <Y3KJBdUue5otWgOT@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <480340b3-c1c1-74b5-1889-f49dcb644469@gmail.com>
In-Reply-To: <480340b3-c1c1-74b5-1889-f49dcb644469@gmail.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Mon, 14 Nov 2022 23:59:21 +0100
Message-ID: <CAHJEyKWRm_wzUcz7wzcveLLGND9F3m3HM23mpwQ=zjeO5zh5FA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: vt6655: change the function name s_vFillRTSHead
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
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

On Mon, Nov 14, 2022 at 9:19 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 11/14/22 19:29, Tanjuate Brunostar wrote:
> > Remove the use of Hungarian notation, which is not used in the Linux
> > kernel. Reported by checkpatch
> > Add indentation to the affected function to follow the Linux kernel
> > coding style. This improves visibility
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> > v2: corrected confusing changlog message on this patch
> > v3: removed unnecessary function prototype
> >
> >   drivers/staging/vt6655/rxtx.c | 40 ++++++++++++-----------------------
> >   1 file changed, 13 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 31ae99b3cb35..715b323cd2a8 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -23,7 +23,7 @@
> >    *      s_uGetTxRsvTime- get frame reserved time
> >    *      s_vFillCTSHead- fulfill CTS ctl header
> >    *      s_vFillFragParameter- Set fragment ctl parameter.
> > - *      s_vFillRTSHead- fulfill RTS ctl header
> > + *      fill_rts_header- fulfill RTS ctl header
> >    *      s_vFillTxKey- fulfill tx encrypt key
> >    *      s_vSWencryption- Software encrypt header
> >    *      vDMA0_tx_80211- tx 802.11 frame via dma0
> > @@ -85,16 +85,6 @@ static const unsigned short fb_opt1[2][5] = {
> >   #define DATADUR_A_F1    13
> >
> >   /*---------------------  Static Functions  --------------------------*/
> > -static void s_vFillRTSHead(struct vnt_private *pDevice,
> > -                        unsigned char byPktType,
> > -                        void *pvRTS,
> > -                        unsigned int cbFrameLength,
> > -                        bool bNeedAck,
> > -                        bool bDisCRC,
> > -                        struct ieee80211_hdr *hdr,
> > -                        unsigned short wCurrentRate,
> > -                        unsigned char byFBOption);
> > -
> >   static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> >                                  unsigned char byPktType,
> >                                  struct vnt_tx_fifo_head *,
> > @@ -555,19 +545,15 @@ s_uFillDataHead(
> >       return buf->duration;
> >   }
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
> >   {
> >       unsigned int uRTSFrameLen = 20;
> >
> > @@ -912,7 +898,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> >                       buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> >
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else {/* RTS_needless, PCF mode */
> >                       struct vnt_rrv_time_cts *buf = pvRrvTime;
> >
> > @@ -931,7 +917,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> >
> >                       /* Fill RTS */
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else if (!pvRTS) {/* RTS_needless, non PCF mode */
> >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
> > @@ -945,7 +931,7 @@ s_vGenerateTxParameter(
> >                       buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> >
> >                       /* Fill RTS */
> > -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> > +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> >               } else { /* RTS_needless, non PCF mode */
> >                       struct vnt_rrv_time_ab *buf = pvRrvTime;
> >
>
> Hi,
>
> I cannot apply your patch.
>
> Here my git infos:
> git remote show origin
> * remote origin
>    Fetch URL:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> ...
> git branch -a
> my branch: staging-testing
>
> Bye Philipp

I was recently asked to rebase to the staging-next branch. I think
this is where there is conflict
