Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0496117C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ1Qmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1Qmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:42:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0011E3EE3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:42:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a27so497428qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/62OrwGclpDYBooag3XtISZVZF7tfAvwgkcx6ffsI8=;
        b=Wp0hf7+sC54waOQ3PL2hLEIzXBDZdqOZY8g4zuTlyBC5Zxgh9IiBWEmeCsC4lXNHEZ
         Eap6bp8EQZfKKKsu4Y6fRNl1PG/ZwFKpeyPFOq4z0iBnECRg1mYHjdrCfTMNi/JaEWxi
         6SarMM9eO4S6PIrpns/IsF4aB6SyFshU3uKsybAOnOAESca13KrdAh6Qv4V7BIOmp3bF
         gvgl17j+0WqXBTBbFH6Hyb7BgKVxfrs3FT89lvfvRnwRWL4R+6uPvUi+A6oVQYag2FBz
         TqLdf7xU8t5vJJah1jnB8gVUHBnEUnZR7f0H8bKIi/Cblj7c0eK4cSTU7QBR6ObmSIMh
         uPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/62OrwGclpDYBooag3XtISZVZF7tfAvwgkcx6ffsI8=;
        b=z1FqS93/srjIcOJ8gTqlWlVAD5Qf4MvuLQ3ZbzuxC6I0A/Mi4qk3XLEQ3NnofTliUd
         If/S8ux3an03AVWH9lFDov7Mk3GBuWSIBaBWVMaB1yzS2yx36ma1wthB2+wjJGL9v1O2
         FTh6wXa+ZEscGpK+2r6P5uloytgt5I2FT5rrv2kIK2TLUp+5tZ45E8811xNQ7tBlelc2
         c/l9OSgtfPnDnrouR9+N8bQCLBq4meaie4XFfsFhIQHPMtJp1Pi2OWd41Kp3K2RgGX8Q
         dMc3Kn2sO+pEdjLxSmUyQb7k7tT7w9xjlguu2EamuXLh1W9tLrLfLW3kUdbbBZXBxmSf
         sCZA==
X-Gm-Message-State: ACrzQf3uhvl7VIIIXKm7IBLORWj3XrVLEaDovznU9TYsWz2BjMjpdo9w
        SPOHcwSziEnzKsbivv2EKK8qNtpdDcJeBcDNlSgHTrwX/PxglgGs
X-Google-Smtp-Source: AMsMyM57xcefN3dQlJW2OkVRTwQskQNiOF2dtnHshowbcuNAl2hSdGBJG90wJwf9IyVMJKksUlV3nSw5wLCxsg9b+Y4=
X-Received: by 2002:ac8:5902:0:b0:39c:e440:6adb with SMTP id
 2-20020ac85902000000b0039ce4406adbmr353148qty.18.1666975358343; Fri, 28 Oct
 2022 09:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
 <647b1d2d-f25a-c088-6a0e-0c2a39904150@gmail.com>
In-Reply-To: <647b1d2d-f25a-c088-6a0e-0c2a39904150@gmail.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 28 Oct 2022 17:42:26 +0100
Message-ID: <CAHJEyKVruckpK2mrc3uET2nP0yNtdBY335UVvXjWudCd-cijbw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] staging: vt6655: fix lines of code ending in a '('
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

On Fri, Oct 28, 2022 at 3:57 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 10/28/22 08:39, Tanjuate Brunostar wrote:
> > fix several checkpatch errors related to lines ending with a '(' by
> > joining splitted lines of code and indenting properly to increase
> > visibility
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > ---
> >   drivers/staging/vt6655/rxtx.c | 165 ++++++++++++++--------------------
> >   1 file changed, 69 insertions(+), 96 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 1e5036121665..7eb7c6eb5cf0 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -139,15 +139,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
> >    * PK_TYPE_11GB    2
> >    * PK_TYPE_11GA    3
> >    */
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
> >   {
> >       unsigned int uDataTime, uAckTime;
> >
> > @@ -214,20 +210,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
> >   }
> >
> >   /* byFreqType 0: 5GHz, 1:2.4Ghz */
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
> >   {
> >       bool bLastFrag = false;
> >       unsigned int uAckTime = 0, uNextPktTime = 0, len;
> > @@ -316,17 +308,13 @@ s_uGetDataDuration(
> >   }
> >
> >   /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
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
> >   {
> >       unsigned int uCTSTime = 0, uDurTime = 0;
> >
> > @@ -409,22 +397,18 @@ s_uGetRTSCTSDuration(
> >       return cpu_to_le16((u16)uDurTime);
> >   }
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
> >   {
> >       struct vnt_tx_datahead_ab *buf = pTxDataHead;
> >
> > @@ -555,19 +539,15 @@ s_uFillDataHead(
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
> > +static void s_vFillRTSHead(struct vnt_private *pDevice,
> > +                        unsigned char byPktType,
> > +                        void *pvRTS,
> > +                        unsigned int cbFrameLength,
> > +                        bool bNeedAck,
> > +                        bool bDisCRC,
> > +                        struct ieee80211_hdr *hdr,
> > +                        unsigned short wCurrentRate,
> > +                        unsigned char byFBOption)
> >   {
> >       unsigned int uRTSFrameLen = 20;
> >
> > @@ -750,19 +730,15 @@ s_vFillRTSHead(
> >       }
> >   }
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
> >   {
> >       unsigned int uCTSFrameLen = 14;
> >
> > @@ -868,21 +844,17 @@ s_vFillCTSHead(
> >    -
> >    * unsigned int cbFrameSize, Hdr+Payload+FCS
> >    */
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
> >   {
> >       u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
> >       bool bDisCRC = false;
> > @@ -954,11 +926,12 @@ s_vGenerateTxParameter(
> >       }
> >   }
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
> >   {
> >       struct vnt_td_info *td_info = pHeadTD->td_info;
> >       struct sk_buff *skb = td_info->skb;
>
> Patch series coverletter is missing or the wrong one was send.
>
> Changelog is also missing.
>
oh the wrong cover letter was sent.

thanks for pointing it out
