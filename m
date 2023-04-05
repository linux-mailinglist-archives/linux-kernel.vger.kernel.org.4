Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99396D79B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjDEKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:30:48 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D63C0E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:30:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m16so25724999qvi.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680690641;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5cOVsQHjUPg9p+6axT95ctaBF+QjUcuiaptCEnHD3sE=;
        b=FpkcQ5iNISBWfJRC+/L1izkd8JIpt1GKnAs/K7zQ24H8OoE/EPqk3/+lkHlFM0pMzq
         0nPWTSYxK0jPDmvO7liWMAzt+kA4cIHwHsCxlano2sHzOyK09Df6TuhQrw/1WIhOWRGk
         CV1xI7VUlzS6u9DwYVzQl+XyWnYA8VPWwfDqxSNIqL0fixseLWo/gvLSZAgB82fdxF7l
         ZWsAO0E8WLI2PnUvp0WMbjY0nD9970l22WNiIc1HHrtmEdiU8ovplvZOIcLzDAiZBo9j
         zuZZUxuncRfWKSdEbVUkg96yExYXjaHA3qw/BOFwf173XObDVUFZKU2IVRozbMiCj2PX
         Fqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680690641;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cOVsQHjUPg9p+6axT95ctaBF+QjUcuiaptCEnHD3sE=;
        b=22J+GGjiHqcbbV9VEJgHJ0oVBGJOGfbceYXQhSvVxo9RwLatg6ah6o/HZZyKenajnL
         AHMAqjowpy7c9cPqDxwr8J4n14fcEAW3LTMiD+PxF4Wka4Lpa70CzfljBQrLFugyj/lp
         OaMy1EUY0iXmBIJYg2jNPdLyOwKdPZHSCgsfYS27n1QJoubUIlr7NCIwlWEGNvzQFBFK
         u99kzxHqATRrU4sgjOaUECuULRl3DEye/bV1G+MiOmwRGoUK0QMHiotxdDUZ495CqbtV
         Ed0L3Zx7lyRBuS9ls5a942a3YFHRhJLW3CgLaTIqltaqwtco2LIF9swd2xcIoyUOzuPD
         iNTA==
X-Gm-Message-State: AAQBX9fY9dADrrpFRfYrh9mtbVH9iugHysrgSeNqosEQzjdYUrMU/zjY
        Jb+2oXG7F07rfmj2KI6vhJEJaDBHEvvV5kol
X-Google-Smtp-Source: AKy350b0ir1QFi4At9HEFOSSc2i9QUfWZJFykTvpRYeh9lJAq1nnscoCLAvDU8MOPrNANQRfAeppvw==
X-Received: by 2002:a05:6214:5190:b0:5e0:2461:d312 with SMTP id kl16-20020a056214519000b005e02461d312mr7968496qvb.13.1680690641417;
        Wed, 05 Apr 2023 03:30:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id og18-20020a056214429200b005dd8b934587sm4085617qvb.31.2023.04.05.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:30:40 -0700 (PDT)
Message-ID: <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        alexandru.tachici@analog.com, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 05 Apr 2023 12:32:45 +0200
In-Reply-To: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thanks for reporting this...

On Wed, 2023-04-05 at 11:53 +0200, Fabrizio Lamarque wrote:
> Link:
> https://lore.kernel.org/all/20210906065630.16325-3-alexandru.tachici@anal=
og.com/
>=20
> This commit broke the driver functionality, i.e. cat in_voltage1_raw
> triggers a correct sampling sequence only the first time, then it
> always returns the first sampled value.
>=20
> Following the sequence of ad_sigma_delta_single_conversion() within
> ad_sigma_delta.c, this is due to:
>=20
> - IRQ resend mechanism is always enabled for ARM cores
> (CONFIG_HARDIRQS_SW_RESEND)
> - Edge IRQs are always made pending when a corresponding event
> happens, even after disable_irq(). This is intentional and designed to
> prevent missing signal edges.
> - Level IRQs are not impacted by IRQ resend (i.e. IRQ_PENDING is
> always cleared).
> - SPI communication causes the IRQ to be set pending (even if
> corresponding interrupt is disabled)
> - The second time ad_sigma_delta_single_conversion() is called,
> enable_irq() will trigger the interrupt immediately, even if RDY line
> is high.
> - In turn, this causes the call
> wait_for_completion_interruptible_timeout() to exit immediately, with
> RDY line still high.
> - Right after the SPI register read, the MODE register is written with
> AD_SD_MODE_IDLE, and pending conversion is stopped. Hence DATA
> register is never updated.
>=20
> I would suggest to revert this commit or set the flag with
> IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING, but I am not sure
> about the problem solved by this commit and how to replicate it.
> Another option would be to keep IRQ flags within bindings only.
>=20

I'm starting to think that what's stated in that commit=C2=A0

"Leaving IRQ on level instead of falling might trigger a sample read
when the IRQ is enabled, as the SDO line is already low. "

might actually be related with something else...

> As a side note, AD7192 datasheet says that the falling edge on SDO
> line _can_ be used as an interrupt to processor, but it also states
> that the _level_ on SDO/RDY line indicates the sample is ready. What
> happens on SDO/RDY interrupt line before the ADC conversion is
> triggered should be ignored.
>=20

Well, from the datasheet (as you already know):

"
In addition, DOUT/RDY operates as a data ready pin, going low to indicate
the completion of a conversion. If the data is not read after the conversio=
n,
the pin goes high before the next
update occurs. The DOUT/RDY falling edge can be used as an interrupt to a
processor, indicating that valid
data is available.
"

So I really read IRQF_TRIGGER_FALLING in the above and all the other sigma
delta=C2=A0devices have the same setting (I think). So the fact that it wor=
ks with
level IRQs might just be lucky instead of fixing the real problem. Can you =
try
the below patch (I'm starting to think it might be related):


https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/


- Nuno S=C3=A1

