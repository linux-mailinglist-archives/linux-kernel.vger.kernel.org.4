Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8D612483
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ2QwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ2QwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:52:03 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D53A4AD
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:52:02 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id v81so3716438vkv.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwYDS/mmucztJvZk+txCcsQ4F8nYeAWY6Om3fRYLydM=;
        b=f7TmAfvDTszzxq9/s7++Odt1tI3NJPLc6cv2uaPhinMxKKDimLhZ0Y7Ef1AsDLlUqK
         83xV20RqDznHPphKGn+8UjbbxEY0TvLEmrP884PDFeQ/UD+HwAxVi+DLZrviU9LNaiCq
         ymSz29Uv6rdm7hymM6w4OIURY8nB3MrHPAKdvclOr5L86u4ED6WkJtQeWs8imXRngNYD
         2TB+X2nkl/OWlOavppNBnCBAsFzb3Tly6Dk4MEYXd/Mqoi2yBPYUy+bvp1eQYW34GBQK
         u2jxTLa6dtKLewQAPwBcS/iO140iFbpRDvII37eY2e+avH2MeJxQPn/YHvuRvEQKqGce
         5XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwYDS/mmucztJvZk+txCcsQ4F8nYeAWY6Om3fRYLydM=;
        b=w7z/UzplQa7YaIpJSwgTytz8zv2Q8Sbi9/dvw2oE2g2U9+MGm8C/cLG84rx9A4iMGa
         SegslYWBKbL4A2yXHVwSxOQy2cWLoRtBBMaTsvNy5vpcWP6n6cCL0aL9MwuZ+/IaWKCY
         dIrDN0PdnnbfRI/s0bwSYu+1zACa+64z9h2la33SNm4LpWjyTu/oHX1Y5wseBokflzdW
         YyBTD80nIi5JyEh6oUBPdDTP8fOQTa0tuPAbGGqjDpK4AqOd87JGxUZRt4nn3+sxCHq+
         hRIBTQAhxklNpK2FzCqL/PqVhoo9R1GGsEXfc027+9g7uRkhnz/SUohpBQ2E6Gur5Zz0
         AuIQ==
X-Gm-Message-State: ACrzQf1auYFhtEqDD/Myh/DuqDFZuU5EWnWEAgyXhuhsBNEWUj6p2EZY
        acuOaZ7tNz/yUF7RnUaq/7LNM8zkxMthVFKN7sKCSaYxmze1bg==
X-Google-Smtp-Source: AMsMyM6Thke+1QuByyV8+re7bh2Evi2XZOlsWq0OhchzcovWijDvkFdCFpeOVChhPguwUmdAitZw6torQ6CRo3eIeaQ=
X-Received: by 2002:a1f:3246:0:b0:3ae:bedf:455f with SMTP id
 y67-20020a1f3246000000b003aebedf455fmr1965024vky.28.1667062321638; Sat, 29
 Oct 2022 09:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221028051420.GA30073@rdm> <Y1wg4y6k1fe/TF0d@aschofie-mobl2>
In-Reply-To: <Y1wg4y6k1fe/TF0d@aschofie-mobl2>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Sat, 29 Oct 2022 19:51:50 +0300
Message-ID: <CAMk1CBOgUPjeMw9NmCthsQsDJXY8U4WCBTmNi-3h_BroGnh_QQ@mail.gmail.com>
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noted. Thank you sir

On Fri, 28 Oct 2022 at 21:35, Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Oct 28, 2022 at 08:14:20AM +0300, UMWARI JOVIAL wrote:
> > i used checkpatch.pl script to identify the above
> > Repetition of the same word in one sentence same line
> >
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
>
> This is my (not yet automated) response:
>
> You are sending patches to the Outreachy list, in a way
> that makes me suspect you have overlooked the Outreachy
> Project Contribution Information.
>
> Please review:
> https://www.outreachy.org/outreachy-december-2022-internship-round/communities/linux-kernel/  (only accepted applicants can see this link)
>
> https://lore.kernel.org/outreachy/Y0D+dzbjRtuc0KT4@aschofie-mobl2/
>
> Alison
>
> > ---
> >  drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> > index 090345bad223..30a0276b8b58 100644
> > --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> > +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> > @@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
> >   * If we turn on USE_RXTHREAD, then, no need for critical section.
> >   * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> >   *
> > - * Must be very very cautious...
> > + * Must be very cautious...
> >   *
> >   */
> >  struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
> > --
> > 2.25.1
> >
> >
