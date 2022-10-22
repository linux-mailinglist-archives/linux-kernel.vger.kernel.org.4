Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A946085B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiJVHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiJVHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:36:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1324B31F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:35:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l28so3000735qtv.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTgwvmCwshFQNtdtBgqjMRnvCyC/Xl8rvUH5mkou+6w=;
        b=an7tzkeyjHNGfmNqiV8MF7LnV+EamsmZjtpaDzasnoGpc0ZthGxdDMMSjpBqpcTxtf
         T8DPHXNttV7ep4IxxyzusqdRTidcXxstFwEGJVWSrlsIGHdX9eutFo4pEi1kHY658KRt
         b8RNoZpjZ2F44VL4JUL81Rp7+ygYPc3lGxoQCWwMfg/yCT584jlEWuQZgoDYe2/3yuZb
         S4w6XKqD7CPr1YepVVT3QdU7wTMMxf7coBIazsMMdc00HId6Al8KURBe09PspIKuX6i3
         gNfQN9ia+tNEBVsiAiH4mnAFPKo8meHgOVPowCMjqxg8ugXWvTbZCjrBaUibdBcmUifa
         P0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTgwvmCwshFQNtdtBgqjMRnvCyC/Xl8rvUH5mkou+6w=;
        b=EjVPtNQEa5LiWOxO11VXoDWOrRhmpoeDOqzinTEaMqpp2Rhjgz6ufFlfsUi7IsOX6s
         8kKsTCbX3btTQywlkriiidl9RuWiS/hSnRrnrzU9Eg9pxKD7qQKHd+wTWi9FnUFgE0jw
         GI5UZj4auJQhMW/O96UWN5Z8nxLUKpDMmvBNXJxGVBg5gvXaxvF52hNDUOt4pPUXSjus
         ybzayQaWxkujeJB+uQvPVlmr+2ZMUSoccyjJ1LpS44dqNuQu2SKrNFRfciN0ORkHZIPt
         5aHYFOoWkxIKW6jnVE55XxsE04H14q3Xxsc4IPYDE7NL47uLU0gA1BuX+aSegjaDYPtW
         YeEQ==
X-Gm-Message-State: ACrzQf1MSybNfK3ht/1a1ktQvIj/wJD4nuH2QKgBnnJlI/rY+K3hRqK+
        MEfnTUip2AvepOhrs5R2hmhmaC/WumqbTP65eCStHvN34Im32eTibJQ=
X-Google-Smtp-Source: AMsMyM7uLuNV6EpVW8mxH8VqxE3DFqPy5Qu2WdFiwjqBl/ewFeWLLSesYfHyTOJXNTow/F9voRX180fgU3ywsAQHALo=
X-Received: by 2002:a05:622a:411:b0:39e:354e:b537 with SMTP id
 n17-20020a05622a041100b0039e354eb537mr5632545qtx.656.1666424130617; Sat, 22
 Oct 2022 00:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-2-tanjubrunostar0@gmail.com> <cae0a94e73b1e44a7d8c750a406aa77d1942a06a.camel@perches.com>
In-Reply-To: <cae0a94e73b1e44a7d8c750a406aa77d1942a06a.camel@perches.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 08:35:18 +0100
Message-ID: <CAHJEyKU1qSoSy3AB0sJL7OAtkQX3H67dCL2ZFTMdb913F5oURQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] staging: vt6655: fix lines ending in a '('
To:     Joe Perches <joe@perches.com>
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

On Sat, Oct 22, 2022 at 8:18 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2022-10-22 at 07:06 +0000, Tanjuate Brunostar wrote:
> > fix serveral checkpatch errors related to lines ending with a '(' by
> > refactoring the code lines
> []
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> []
> > @@ -141,13 +141,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
> >   */
> >  static
> >  unsigned int
> > -s_uGetTxRsvTime(
> > -     struct vnt_private *pDevice,
> > -     unsigned char byPktType,
> > -     unsigned int cbFrameLength,
> > -     unsigned short wRate,
> > -     bool bNeedAck
> > -)
> > +s_uGetTxRsvTime(struct vnt_private *pDevice,
>
> If you end up doing more work here, ou might consider removing the
> Hungarian style notations
>
> Maybe something like:
>
> s_uGetTxRsvTime -> get_tx_rsv_time
>
> > +             unsigned char byPktType,
>
> byPktType       -> pkt_type
>
> etc...
>
> Perhaps patches by unique rename.
>
Yes I plan on doing that as a separate patch. It could be overwhelming
keeping track of so many changes at a time
thanks
Tanju
