Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0664FC2F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLQUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:06:00 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB910547;
        Sat, 17 Dec 2022 12:05:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 130so3838900pfu.8;
        Sat, 17 Dec 2022 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJvFao2kum+z/fRIMmSQ6AmqGMnYsMDljV3fMQWk5zA=;
        b=Rvb7IOdopngt0BcTjJcQQ2vCbW5QyTbvCXh/hf8jI5PfdObMLw25ghLyHgA2ML4sfa
         vEjpo3w8rkbfl82dStG2UvDwZ6HUmXRAWE2TDwS0wDUT+qW++y3a07YOCdR23LgJ5wyQ
         ZrFJMxWfG4up800F43BogCj7mqm8l8/Y4BX6VGDUXy9pnwkBvs4+eYAA2MdWzFC45dah
         sm8VoWeZchvn6kEd6RZRnWTUaefZhymbK9fHkFyHXRj4rK3RHsm6006jL+UgbxutzZ3G
         w1B5EXtblob9kKtt1OT/9MxY/hT1uXwc6Ll6H8U6On+S/FbiIpspy0sjJpv0SrZSbdwe
         vnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJvFao2kum+z/fRIMmSQ6AmqGMnYsMDljV3fMQWk5zA=;
        b=MgiAJAw0ei+eFDSER3ELlxBq6zYxXy9UbZfQ+wmUhecJ7AZUzdvCFdkjIbN9OGyysg
         EECC2urnsB6YRsm7p0KJYHAzvlmY0o2IWQYIhC7WFuoOXFdoeAkRr+cEFgL/jui0ffJI
         ZsVgvIdhlkvoWtJGOTv0Rmo8zgH+DozdcjJqcxTCEmXMWhX5kyPJHqsY2qph3RDceo4x
         WEyakb64FrF2/jydbLwicTW6qBRd0nVpCalCV9LwLSXCch93YUdLbC/wyDXTKQ8URjD+
         6B+snns+bESkaeKWp/pwmJlIdgoblrBAgfInC+T2l3xtTDGDKbA1IFlLLnXhPY7CeSqE
         3Npg==
X-Gm-Message-State: ANoB5pkSEQTf/4n5a6pYKBO2ZyiiLXW3XSgKO8ejDnFN7CEa+z72fG82
        TchFMr1vBJa/XmEcl0suKM4=
X-Google-Smtp-Source: AA0mqf5r7u9O0zYn2CAB3n7q1oStHj6rVMmZTNKuyyIFVVwd/AegbRRQDt9GBvMtGVPY4k+OAu1aqg==
X-Received: by 2002:aa7:8b48:0:b0:56b:ae1d:a3c6 with SMTP id i8-20020aa78b48000000b0056bae1da3c6mr8845616pfd.1.1671307558741;
        Sat, 17 Dec 2022 12:05:58 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id k10-20020aa79d0a000000b00575da69a16asm3615691pfp.179.2022.12.17.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 12:05:58 -0800 (PST)
Date:   Sun, 18 Dec 2022 09:05:51 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: Re: [PATCH v3] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
Message-ID: <Y54hHyoUW/tGioLx@mail.google.com>
References: <Y5uN9Rr3v1uWH765@mail.google.com>
 <Y5z4Og3XmCGQwTO9@mail.google.com>
 <CAHp75VeNcPjngJcF96Y9hV=Y+NeaGadSMGMvgCTD6kdBi=+9fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeNcPjngJcF96Y9hV=Y+NeaGadSMGMvgCTD6kdBi=+9fg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 01:43:40PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 17, 2022 at 12:59 AM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct RXBUF and refactor the rest of the code
> > accordingly. While at it, fix an edge case which could cause
> > rx_buf_count to be 0 when max_frame_size was set to the maximum
> > allowed value (65535).
> >
> > It's worth mentioning that struct RXBUF was allocating 1 byte "too much"
> > for what is required (ignoring bytes added by padding).
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> 
> ...
> 
> >  static int rx_alloc_buffers(MGSLPC_INFO *info)
> >  {
> >         /* each buffer has header and data */
> > -       info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > +       if (check_add_overflow(sizeof(RXBUF), info->max_frame_size, &info->rx_buf_size))
> > +               return -EINVAL;
> >
> > -       /* calculate total allocation size for 8 buffers */
> > -       info->rx_buf_total_size = info->rx_buf_size * 8;
> 
> > +       /* try to alloc as many buffers that can fit within RXBUF_MAX_SIZE (up to 8) */
> > +       if (check_mul_overflow(info->rx_buf_size, 8, &info->rx_buf_total_size))
> > +               return -EINVAL;
> 
> This check is implied by kcalloc(). But to make it effective we
> probably need to get a count first.
> 
> > -       /* limit total allocated memory */
> > -       if (info->rx_buf_total_size > 0x10000)
> > -               info->rx_buf_total_size = 0x10000;
> > +       if (info->rx_buf_total_size > RXBUF_MAX_SIZE)
> > +               info->rx_buf_total_size = RXBUF_MAX_SIZE;
> 
> If max_frame_size > 8192 - sizeof(RXBUF), we bump into this condition...
> 
> >         /* calculate number of buffers */
> >         info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
> 
> ...which means that rx_buf_count < 8...

that's correct. My reading of what the original author intended is the
following:

- rx_buf_count can be < 8 if max_frame_size needs to be > 8192 so that
  userspace tools don't need to collate the different packets together
  then again, SyncLink_CS supports a variety of protocols.

- the more circular buffers, the better, but it looks perfectly acceptable
  to have 1 big rx_buf (max_frame_size possible) if the communication is
  orchestrated nicely (which part sends what and when) especially for
  RS-232-based communications.


> (and if max_frame_size > RXBUF_MAX_SIZE - sizeof(RXBUF), count becomes
> 0, I don't know if below clamp_val() is the only place to guarantee
> that)
> 

I can confirm that the clamp_val() below is the only place that
guarantees the max_frame_size isn't greater than RXBUF_MAX_SIZE. That
happens at the device probing stage: 

( mgslpc_probe > mgslpc_add_device > clamp_val-like routine )

As max_frame_size can only be set as a module parameter and no other way
is exposed to userspace to tweak that afterwards, my 2 cents is that 
clamp_val() routine should be fine as rx_buf_count will always be > 0 
after this fix.

> > -       info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
> > +       info->rx_buf = kcalloc(info->rx_buf_count, info->rx_buf_size, GFP_KERNEL);
> 
> ...hence rx_buf size will be less than rx_buf_total_size.
> 
> That is probably not an issue per se, but I'm wondering if the
> (bigger) value of rx_buf_total_size is the problem further in the
> code.
> 

rx_buf_total_size isn't used outside of this function so it
could be a local variable IMO.. so I would say that this wouldn't be a
problem.

I had noticed that rx_buf_total_size could be moved into a local
variable before but I thought that removing it from MGSLPC struct
should be part of a separate patch instead.

> >         if (info->rx_buf == NULL)
> >                 return -ENOMEM;
> 
> Maybe something like
> 
> static int rx_alloc_buffers(MGSLPC_INFO *info)
> {
>     /* Prevent count from being 0 */
>     if (->max_frame_size > MAX_FRAME_SIZE)
>         return -EINVAL;

This boils down to whether having the clamp_val() on the probe method is
sufficient in your point of view. You make the final call on this :-)

>     ...
>    count = ...;
>    ...
>    rx_total_size = ...
>    rx_buf = kcalloc(...);
> 
> Then you don't need to check overflow with check_add_overflow() and
> check_mul_overflow() will be inside the kcalloc.
> 

check_mul_overflow point -> agreed.

check_add_overflow -> similar suggestion as my previous point, if the
clamp_val on probe is sufficient for you, I would say that we don't need
it as of now too. But if you still think that we need it, I'm flexible
with that too.

> ...
> 
> > -       if (info->max_frame_size < 4096)
> > -               info->max_frame_size = 4096;
> > -       else if (info->max_frame_size > 65535)
> > -               info->max_frame_size = 65535;
> > +       if (info->max_frame_size < MGSLPC_MIN_FRAME_SIZE)
> > +               info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
> > +       else if (info->max_frame_size > MGSLPC_MAX_FRAME_SIZE)
> > +               info->max_frame_size = MGSLPC_MAX_FRAME_SIZE;
> 
> You can use clamp_val() macro here.
> 

Nice, I didn't know about this macro. I will make that change for v4.

All really nice points you've made Andy, I'm learning heaps of new
things with this patch :-)

thanks!

- Paulo A.

