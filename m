Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F4610A18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ1GN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1GN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:13:26 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146491B7F01
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:13:26 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 1so4229109vsx.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=svUKb/qGduMTdMpMANs9sftdQURYpjN7AKh6kz9DZ6I=;
        b=lAnaWCGYhih1u7TWtMjy+gL28ADi0aS/VKHL8wVCLiQ7cdRnxEF62JJIPDKQi3xLn3
         MwOolUGV100XU77+5strKd4TJu/wu1+mAZaRQ1qXZw/b0LgUA7YsISKIzI6n/HlTYvcV
         GmtR1l0SmVQSLcLZp6p61aiR3W0PQ1ORR3UwH+CmajrqdBblDmT4DhZ1wjnLYO1tVrl7
         A3FEGW54Pc1MmmOv1EAi93dTfpP0HVRS6RNL1G2UkOtullgBhWqCz05vuX9Vvz30Y4Vf
         g/vkB+zy3aF+QpnbAKxRaGBgO1bot8pant36vEOT69Iff63cTTxj9PrWRodK968buJvB
         Z9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svUKb/qGduMTdMpMANs9sftdQURYpjN7AKh6kz9DZ6I=;
        b=q7to9yawIIPVD+BHPwaG2wi/7gcnqW4zLvx0ZxJU58ueRlU7fwCStxdApbgfv3mxWZ
         H24EDHTkllKUgRlmcCmiWus6DZEPfm5f+ezL8z4uEqjGtljNsbEJegQdAkJ44MRqPzwQ
         KNXI3vmTO5aaYZNFTEIreZnwQ2iYtU6YBjvS2CU2yGX4J4zeFgmuJxzvW+OpW1OWl9pL
         YJU/gUTU71LLUEl1vv8y9YgJqM59NoVZIW3wJSVFELGdvWLrf2CoX7NYQi8lGRfH2K9w
         4daNdEMDqHSknw4zh4v6ELlWeadWiRHYeAM+1OdGeFRFMOQK9avb3VoL7HeVefTQKcEt
         itsw==
X-Gm-Message-State: ACrzQf1CJTEnTldUeq5dyEZonRq7NJRgszxFKErU0YTYbRPplmvNs/fp
        t9p0XA557fahyNKkeiz4ypSfYXgmyu5PYG0ygqYFVQl8x0PiKA==
X-Google-Smtp-Source: AMsMyM5yYz4YZOQ8J/3ry14yHAjgQh8eJL0ctUFcoxocbjaFkHKniRrnfwdUS5loiGVK0aNpDPUmkjB5xFd8BqyLBUs=
X-Received: by 2002:a67:c313:0:b0:3aa:3a91:690d with SMTP id
 r19-20020a67c313000000b003aa3a91690dmr8873394vsj.25.1666937605163; Thu, 27
 Oct 2022 23:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221028051420.GA30073@rdm> <Y1tx8XjmR5QKV9lQ@kroah.com>
In-Reply-To: <Y1tx8XjmR5QKV9lQ@kroah.com>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Fri, 28 Oct 2022 09:13:14 +0300
Message-ID: <CAMk1CBOdgwnt3E7ByZMASv+O1WAmgKvsvMv5Gy9UNgg=kMBRJQ@mail.gmail.com>
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
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

Thank you
working on it now

Best Regards
Umwari Jovial

On Fri, 28 Oct 2022 at 09:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 28, 2022 at 08:14:20AM +0300, UMWARI JOVIAL wrote:
> > i used checkpatch.pl script to identify the above
> > Repetition of the same word in one sentence same line
>
> Please read the documentation for how to write a good changelog text.
> Hint, "i" is not something you see in a text, right?
>
> Also, why do you have WARNING in the subject line and not the driver
> name?  Again, read the documentation please.
>
> >
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
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
>
> The original text here is correct.
>
> thanks,
>
> greg k-h
