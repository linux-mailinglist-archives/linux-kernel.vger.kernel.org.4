Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B31F5B4C74
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIKHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIKHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:12:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143B27B3C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:12:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3321c2a8d4cso65907217b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fOne5REx3dfFRIt7Ms5taiBcmpnVEiUY4XZ+R/6BY9w=;
        b=hMmnRYTSakinCEP6SGw6Jp7CEqe48xDiDxXrrMm2mZF3Sy1OsgVNst2xIKymbxYOV6
         2oQu0Hy3We9J4fpDH7fv9iGty1ia4qVy8DtkWW5sNMD0MRcDk7C88jmFh3HD0X32kqPY
         vk3zlQS+1hzrHiajSwyKJrLP8sf59eT7eKUAKhCfsQVR89vwE9VMgZWkXzum+fuSfy12
         oiCieHEb/xs/UNgCviwLRnc8RfILaTcCrT5UE4JiskvbEffD884O1AhwN5b/9HnT3e3t
         yb/OnSw4yGrtPojohdTF9qYb32Z1zjd21QjGalN734MnVJjn0NIOuJtRpzfc0pAkt42A
         pyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fOne5REx3dfFRIt7Ms5taiBcmpnVEiUY4XZ+R/6BY9w=;
        b=1F34MaAWbzrniKHojXGWX8bYVv0IvysZjQxHkyMNwtswe7mSJVOqHW0Va131rC2rpS
         ALkg4bAiEaWdfGSMx3r9NvNf8fJ2ovdahzWlFJvRxDutcWMwSyXjwvs76bSD1W1lofdi
         QW4DfkuELGAhh7Tt71XjZQIxyJx7FbLnNidWEeA9zLbC7u8P7IO3CVV79++bFJXch51W
         9oLtQDcYShABXOZgLcwRtYaSPC5+z5BrOulU1t+mURsje6CBitbNYdHyoshJxHdH23vB
         ZrFYzk7l295mDyvTtlv9aVOaPYXwvhyMAOlGjnJeu3KIDxn4obCRf/bp/9ZSZDZnWX/A
         mu0g==
X-Gm-Message-State: ACgBeo3ITa3F5aL+1GQKcWB0qXdt4pFf/1xrNaV1uzZejhh2qBAbha7e
        RCMepvtannJM5Rjkg5szbcLQUBUc5wDA97u4sPE=
X-Google-Smtp-Source: AA6agR4f21MGHZ4mTrOOEls/7i4BSoXeuL7NT6r/8h1hYirpPlu2WDHgj/JOs1bcZTjLygMlBWiBtJohJT5jFNVUUi8=
X-Received: by 2002:a0d:c981:0:b0:330:dc03:7387 with SMTP id
 l123-20020a0dc981000000b00330dc037387mr18272329ywd.380.1662880375353; Sun, 11
 Sep 2022 00:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662724786.git.namcaov@gmail.com> <c3a7d9963b1c38c5f493786d7268c430617412dd.1662724786.git.namcaov@gmail.com>
 <Yxt/3FOysEbwCm9T@kroah.com>
In-Reply-To: <Yxt/3FOysEbwCm9T@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Sun, 11 Sep 2022 09:12:44 +0200
Message-ID: <CA+sZ8B8Y1ZGou1Y4tQYJC1Wp_2MVdYKO0Bd3SfxMAU1DF+mz_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] staging: vt6655: remove unnecessary volatile qualifier
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 8:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 09, 2022 at 02:17:55PM +0200, Nam Cao wrote:
> > Remove volatile qualifier for the member rd0 of struct vnt_rx_desc,
> > because there is no reason it must be volatile.
> >
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  drivers/staging/vt6655/desc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
> > index 17a40c53b8ff..3f0f287b1693 100644
> > --- a/drivers/staging/vt6655/desc.h
> > +++ b/drivers/staging/vt6655/desc.h
> > @@ -182,7 +182,7 @@ struct vnt_rdes1 {
> >
> >  /* Rx descriptor*/
> >  struct vnt_rx_desc {
> > -     volatile struct vnt_rdes0 rd0;
> > +     struct vnt_rdes0 rd0;
>
> You can not just remove this without describing _WHY_ it is ok to do so.
>
> Have you properly determined why it is, or is not, ok to use volatile
> here?

I did not carefully look at the volatile usage here. After looking at it
again, using volatile is actually valid: the structure resides on coherent
memory.

Sorry for being careless.

Best regards,
Nam
