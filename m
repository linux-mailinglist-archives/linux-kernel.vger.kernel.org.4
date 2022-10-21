Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034DC607D92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJURcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJURcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:32:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECE44CF9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:32:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 8so2482981qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YsPJ6YAEeb+wvwrd2DUY6/tG224J3XS2r7bRlx+/Ns=;
        b=FRyyiO85auQ2mjd1N9YVBg+1RctotWb+KPqF019ikZ6jcJ9+Y0cGsMxgDfZU9jjB2B
         XybCONEp8KgybtPD1wolhfjV4hslgrjjlyX7sdZV1VvHuVtwbDlqQaoW0fjIwobR90au
         Giyzl2eloPif2IbcLVUy6UkY7F7xUUWEGS9mTXDbP0/SopZFA+9stxbB5XWwRxU6g7QV
         YDf4k+YvEhNOq+IzETXbX02l8Jy4R060beofSk1Htm2eCDwaEROprviJAaLhF+KSp/hd
         JZFqwcVjSNljxm10p+WXGK+77Q9XuRIic6b9xGPq/JALUPC/gX/JU0S9Y7Bk9wm9R0n0
         LdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YsPJ6YAEeb+wvwrd2DUY6/tG224J3XS2r7bRlx+/Ns=;
        b=scvpt1K+a6dvqyivAtIDb1c5J9hnMNpjWCwkwOQDsa0eHzGzw212o1jBstRu9LcuAc
         Cib8a5SopqIYLQBieOf3dK80oCS7Gikl+u89q5dta3qR4welBh60DE/S8c/i6ekRdsSP
         6rBkAD71Uzzb6uhYjb+ILwRnGMTieYmkwclj2oiOsv2vhr2LFVbraloZotmX0+umKEe9
         8UjmTWS7R7ZGMrhmeDOHqD55zhWbdhhG6lqc47r6V72H6hAqChNkv+tl0eKeuX9Oq8lg
         8NiIj46M7JT7hpdhpl/e3Ej/lCxFh8VQrttcJ4TwKcST+PXhrvVMZfgrIowCyGevRXIp
         YkRw==
X-Gm-Message-State: ACrzQf3oTNeVOQKdeX8y1eUQJcOocFjW6taxavHwaLGUH1UN6Ojc6jTu
        gSNjZulHEL2UbbHWi3KushEDm7l7Lu5oIiwgLRPza6VOWIo6+XEGlQA=
X-Google-Smtp-Source: AMsMyM4xV/hfGYrXACJL6TzKjc3tD8Fk/yxCpSYr9hqTCdiR1yHLvtnvMAXP+xm7ftQhuQK1vg+QJFgE04ISGOiamKs=
X-Received: by 2002:a05:620a:2699:b0:6cf:3a7f:5fe6 with SMTP id
 c25-20020a05620a269900b006cf3a7f5fe6mr15093597qkp.103.1666373526980; Fri, 21
 Oct 2022 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <Y1JlnJ/UpBgm9XEC@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <1db48b50-6dac-5f36-315d-72208156f196@linux.microsoft.com>
In-Reply-To: <1db48b50-6dac-5f36-315d-72208156f196@linux.microsoft.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 21 Oct 2022 18:31:54 +0100
Message-ID: <CAHJEyKVxBNm+3hVy605+HJ6M6qa2nSONZ-aHc62B7eeRwowQiw@mail.gmail.com>
Subject: Re: [PATCH v4] staging: vt6655: Fix Lines should not end with a '('
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
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

On Fri, Oct 21, 2022 at 11:49 AM Praveen Kumar
<kumarpraveen@linux.microsoft.com> wrote:
>
> On 21-10-2022 14:55, Tanjuate Brunostar wrote:
> > Code style warnings reported by checkpatch.
> > Improve the layout of a function header:
> > Put the first parameter immediately after the '(' and align the other
> > parameters underneath it.
> >
> > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> >
> > ---
> > v2: put static and void on the same line and adjusted the indentation as
> > suggested by Greg KH
> > ---
> > v3: Reformat the code by inserting tabs and white space as recommended
> > by Nam Cao and Julia Lawall
> > ---
> > v4: final version of this patch
> >
> >  drivers/staging/vt6655/rxtx.c | 78 +++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> > index 5bdb5176772c..1e5036121665 100644
> > --- a/drivers/staging/vt6655/rxtx.c
> > +++ b/drivers/staging/vt6655/rxtx.c
> > @@ -85,35 +85,27 @@ static const unsigned short wFB_Opt1[2][5] = {
> >  #define DATADUR_A_F1    13
> >
> >  /*---------------------  Static Functions  --------------------------*/
> > -static
> > -void
> > -s_vFillRTSHead(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     void *pvRTS,
> > -     unsigned int    cbFrameLength,
> > -     bool bNeedAck,
> > -     bool bDisCRC,
> > -     struct ieee80211_hdr *hdr,
> > -     unsigned short wCurrentRate,
> > -     unsigned char byFBOption
> > -);
> > -
> > -static
> > -void
> > -s_vGenerateTxParameter(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     struct vnt_tx_fifo_head *,
> > -     void *pvRrvTime,
> > -     void *pvRTS,
> > -     void *pvCTS,
> > -     unsigned int    cbFrameSize,
> > -     bool bNeedACK,
> > -     unsigned int    uDMAIdx,
> > -     void *psEthHeader,
> > -     unsigned short wCurrentRate
> > -);
> > +static void s_vFillRTSHead(struct vnt_private *pDevice,
> > +                        unsigned char byPktType,
> > +                        void *pvRTS,
> > +                        unsigned int cbFrameLength,
> > +                        bool bNeedAck,
> > +                        bool bDisCRC,
> > +                        struct ieee80211_hdr *hdr,
> > +                        unsigned short wCurrentRate,
> > +                        unsigned char byFBOption);
> > +
> > +static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> > +                                unsigned char byPktType,
> > +                                struct vnt_tx_fifo_head *,
> > +                                void *pvRrvTime,
> > +                                void *pvRTS,
> > +                                void *pvCTS,
> > +                                unsigned int cbFrameSize,
> > +                                bool bNeedACK,
> > +                                unsigned int uDMAIdx,
> > +                                void *psEthHeader,
> > +                                unsigned short wCurrentRate);
> >
> >  static unsigned int
> >  s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> > @@ -121,22 +113,18 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> >                 unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
> >                 unsigned int uNodeIndex);
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
> > -);
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
> > +                           bool is_pspoll);
> >
> >  /*---------------------  Export Variables  --------------------------*/
> >
>
> Can we also work upon the naming convention from pDevice -> p_device and other places if that make sense here.
>
> Regards,
>
> ~Praveen.
>
I intend to do this as a separate patch
