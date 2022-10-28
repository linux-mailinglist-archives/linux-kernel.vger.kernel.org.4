Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A76119C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ1SAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJ1R7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:59:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B613CE4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:59:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g16so3956453qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=py80yI/7D6Xn9HWWuAcn/vNwxQ7cLLUBJ+jBRoMT4NQ=;
        b=aeLyvWahwVGQFPQxJIpZpTMv+niHR0hUSGBQJjThrzBqflXEdXa/yd99ThB0v/4sxm
         QJEuvJPgjsjnI9hCmvE/kAGxaiwsmVFCeUvltiIo5OijPWZMtl1AMn9j5u35NDh+xmeV
         Vl5/Pv1Q/GTxZGoYJLrej6OM/h0RWjAmnFfJHyQwnyCvm2jGPoOjjRgj9zZiSyMjtS/I
         QQ3ubT0i8y5NiZdeZ8gvKoMIbOWk8sZEXDR3ZTg0Lq3gxHmGevxm9/5Y5s9RnZZCIp6y
         bKeR/E3zV8FREMTbuONUd24KMTyxHquvhFu9Sh9RPj/GLtzjTPJEwl7leEQ8NoTr03sc
         FWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py80yI/7D6Xn9HWWuAcn/vNwxQ7cLLUBJ+jBRoMT4NQ=;
        b=d8DRjorCtGSbAC0FlsYT6GsBDxDFtiTjgCVhJhW8K8vYm6c9iB11BstIFjHKqd0Oe6
         ntLoM5CvyVP/WnlhJNkGK5kuG7Z7G2HOXVyAVJVpyV0c8SZPh6tyVgV5WGfHW5pv8qd5
         N/pKSohBq5ykVNgmqQy/E9ZJdveVo45gGJFobtarGS8fi+IWybUNGcannKADzpDj/HvH
         cu0zO0ACeqCu6t/cyMdGkrVvI551wqApuHjgg0zmSH5PYmrJU0cnQXgkdMcobMqlsCYY
         g/lcro1pZp5aovVRzxR4/qHCMMoodfx4+bi/wHxuL37ty0sKz5SWcUWklnsRvZncQD3w
         Z9EQ==
X-Gm-Message-State: ACrzQf1p0HCkkSqvt3Rl7omwwIqzcSvaI+GM34YPjPzKWzvu0wMmlYxJ
        Mvj6fEyjFRvNAtvEGRFc1lOq2/OLQeq6JpxHIMGWg4AvGpWpdzm4
X-Google-Smtp-Source: AMsMyM6iT2ampmGGJMaEnE7vkL0TKHlZVq0TWbQJCW0ZnbK9Cwr0654tfoc+mNhvNLRvBXyUfbuuyKwghb6OQsOstG8=
X-Received: by 2002:ac8:5e08:0:b0:3a4:f479:e0e1 with SMTP id
 h8-20020ac85e08000000b003a4f479e0e1mr620384qtx.656.1666979979425; Fri, 28 Oct
 2022 10:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
 <Y1wW2WNpBMAYPwLA@aschofie-mobl2>
In-Reply-To: <Y1wW2WNpBMAYPwLA@aschofie-mobl2>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 28 Oct 2022 18:59:27 +0100
Message-ID: <CAHJEyKXdq1S9S0nCAJMoYY+oQbmGqyRsCsyimjXduP=9F7oxuw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] staging: vt6655: fix lines of code ending in a '('
To:     Alison Schofield <alison.schofield@intel.com>
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

On Fri, Oct 28, 2022 at 6:52 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Oct 28, 2022 at 06:39:24AM +0000, Tanjuate Brunostar wrote:
> > fix several checkpatch errors related to lines ending with a '(' by
> > joining splitted lines of code and indenting properly to increase
> > visibility
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
>
> Hi Tanjuate,
>
> Thanks for your interest in the kernel community!
>
> The threading on the multiple versions of this patch series
> is unconventional. Please take a look at the archives of
> any mailing list, or the Outreachy mailing list archive.
> I don't expect a new version of the patch set to be sent
> as a reply to a prior version.
>
> Perhaps scale this back to a single patch to see if this
> kind of fix is going to be well received, and to work on
> your patch creation skills.
>
> Greg has pointed you to docs, and of course the First
> Patch Tutorial covers all of this too.
>
> Thanks,
> Alison
>
I do not get how this keeps happening. I think I am doing something wrong,
even after going through the docs over and over again. I will take your advice
and send just single patches for now.

Thanks,
Tanju
>
> > ---
> >  drivers/staging/vt6655/rxtx.c | 165 ++++++++++++++--------------------
> >  1 file changed, 69 insertions(+), 96 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 1e5036121665..7eb7c6eb5cf0 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -139,15 +139,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
> >   * PK_TYPE_11GB    2
> >   * PK_TYPE_11GA    3
> >   */
> > -static
> > -unsigned int
> > -s_uGetTxRsvTime(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     unsigned int cbFrameLength,
> > -     unsigned short wRate,
> > -     bool bNeedAck
> > -)
> > +static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
> > +                                 unsigned char byPktType,
> > +                                 unsigned int cbFrameLength,
> > +                                 unsigned short wRate,
> > +                                 bool bNeedAck)
> >  {
> >       unsigned int uDataTime, uAckTime;
> >
> > @@ -214,20 +210,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
> >  }
> >
> >  /* byFreqType 0: 5GHz, 1:2.4Ghz */
> > -static
> > -unsigned int
> > -s_uGetDataDuration(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byDurType,
> > -     unsigned int cbFrameLength,
> > -     unsigned char byPktType,
> > -     unsigned short wRate,
> > -     bool bNeedAck,
> > -     unsigned int uFragIdx,
> > -     unsigned int cbLastFragmentSize,
> > -     unsigned int uMACfragNum,
> > -     unsigned char byFBOption
> > -)
> > +static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
> > +                                    unsigned char byDurType,
> > +                                    unsigned int cbFrameLength,
> > +                                    unsigned char byPktType,
> > +                                    unsigned short wRate,
> > +                                    bool bNeedAck,
> > +                                    unsigned int uFragIdx,
> > +                                    unsigned int cbLastFragmentSize,
> > +                                    unsigned int uMACfragNum,
> > +                                    unsigned char byFBOption)
> >  {
> >       bool bLastFrag = false;
> >       unsigned int uAckTime = 0, uNextPktTime = 0, len;
> > @@ -316,17 +308,13 @@ s_uGetDataDuration(
> >  }
> >
> >  /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
> > -static
> > -__le16
> > -s_uGetRTSCTSDuration(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byDurType,
> > -     unsigned int cbFrameLength,
> > -     unsigned char byPktType,
> > -     unsigned short wRate,
> > -     bool bNeedAck,
> > -     unsigned char byFBOption
> > -)
> > +static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
> > +                                unsigned char byDurType,
> > +                                unsigned int cbFrameLength,
> > +                                unsigned char byPktType,
> > +                                unsigned short wRate,
> > +                                bool bNeedAck,
> > +                                unsigned char byFBOption)
> >  {
> >       unsigned int uCTSTime = 0, uDurTime = 0;
> >
> > @@ -409,22 +397,18 @@ s_uGetRTSCTSDuration(
> >       return cpu_to_le16((u16)uDurTime);
> >  }
> >
> > -static
> > -__le16
> > -s_uFillDataHead(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     void *pTxDataHead,
> > -     unsigned int cbFrameLength,
> > -     unsigned int uDMAIdx,
> > -     bool bNeedAck,
> > -     unsigned int uFragIdx,
> > -     unsigned int cbLastFragmentSize,
> > -     unsigned int uMACfragNum,
> > -     unsigned char byFBOption,
> > -     unsigned short wCurrentRate,
> > -     bool is_pspoll
> > -)
> > +static __le16 s_uFillDataHead(struct vnt_private *pDevice,
> > +                           unsigned char byPktType,
> > +                           void *pTxDataHead,
> > +                           unsigned int cbFrameLength,
> > +                           unsigned int uDMAIdx,
> > +                           bool bNeedAck,
> > +                           unsigned int uFragIdx,
> > +                           unsigned int cbLastFragmentSize,
> > +                           unsigned int uMACfragNum,
> > +                           unsigned char byFBOption,
> > +                           unsigned short wCurrentRate,
> > +                           bool is_pspoll)
> >  {
> >       struct vnt_tx_datahead_ab *buf = pTxDataHead;
> >
> > @@ -555,19 +539,15 @@ s_uFillDataHead(
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
> > +static void s_vFillRTSHead(struct vnt_private *pDevice,
> > +                        unsigned char byPktType,
> > +                        void *pvRTS,
> > +                        unsigned int cbFrameLength,
> > +                        bool bNeedAck,
> > +                        bool bDisCRC,
> > +                        struct ieee80211_hdr *hdr,
> > +                        unsigned short wCurrentRate,
> > +                        unsigned char byFBOption)
> >  {
> >       unsigned int uRTSFrameLen = 20;
> >
> > @@ -750,19 +730,15 @@ s_vFillRTSHead(
> >       }
> >  }
> >
> > -static
> > -void
> > -s_vFillCTSHead(
> > -     struct vnt_private *pDevice,
> > -     unsigned int uDMAIdx,
> > -     unsigned char byPktType,
> > -     void *pvCTS,
> > -     unsigned int cbFrameLength,
> > -     bool bNeedAck,
> > -     bool bDisCRC,
> > -     unsigned short wCurrentRate,
> > -     unsigned char byFBOption
> > -)
> > +static void s_vFillCTSHead(struct vnt_private *pDevice,
> > +                        unsigned int uDMAIdx,
> > +                        unsigned char byPktType,
> > +                        void *pvCTS,
> > +                        unsigned int cbFrameLength,
> > +                        bool bNeedAck,
> > +                        bool bDisCRC,
> > +                        unsigned short wCurrentRate,
> > +                        unsigned char byFBOption)
> >  {
> >       unsigned int uCTSFrameLen = 14;
> >
> > @@ -868,21 +844,17 @@ s_vFillCTSHead(
> >   -
> >   * unsigned int cbFrameSize, Hdr+Payload+FCS
> >   */
> > -static
> > -void
> > -s_vGenerateTxParameter(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     struct vnt_tx_fifo_head *tx_buffer_head,
> > -     void *pvRrvTime,
> > -     void *pvRTS,
> > -     void *pvCTS,
> > -     unsigned int cbFrameSize,
> > -     bool bNeedACK,
> > -     unsigned int uDMAIdx,
> > -     void *psEthHeader,
> > -     unsigned short wCurrentRate
> > -)
> > +static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> > +                                unsigned char byPktType,
> > +                                struct vnt_tx_fifo_head *tx_buffer_head,
> > +                                void *pvRrvTime,
> > +                                void *pvRTS,
> > +                                void *pvCTS,
> > +                                unsigned int cbFrameSize,
> > +                                bool bNeedACK,
> > +                                unsigned int uDMAIdx,
> > +                                void *psEthHeader,
> > +                                unsigned short wCurrentRate)
> >  {
> >       u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
> >       bool bDisCRC = false;
> > @@ -954,11 +926,12 @@ s_vGenerateTxParameter(
> >       }
> >  }
> >
> > -static unsigned int
> > -s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> > -               unsigned char *pbyTxBufferAddr,
> > -               unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
> > -               unsigned int is_pspoll)
> > +static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
> > +                                   unsigned char byPktType,
> > +                                   unsigned char *pbyTxBufferAddr,
> > +                                   unsigned int uDMAIdx,
> > +                                   struct vnt_tx_desc *pHeadTD,
> > +                                   unsigned int is_pspoll)
> >  {
> >       struct vnt_td_info *td_info = pHeadTD->td_info;
> >       struct sk_buff *skb = td_info->skb;
> > --
> > 2.34.1
> >
> >
