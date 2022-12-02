Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8736407A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiLBN0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:26:01 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B337483261;
        Fri,  2 Dec 2022 05:25:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q7so5386106ljp.9;
        Fri, 02 Dec 2022 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fbqsAW7yNSYmAKZph5yljTbbuXGanOhBHPWVUYjbPQ=;
        b=kggjxvPhLNL/n/vWfYKtJhs89215LXZl9APNkG5e9u8gzfcCLLfqngre/Ac9m+YyKd
         ford9dXoTlA2mnU6HRc9DDoXWkFlDMt/TnrA0fS4OqmtknmTQ8i3Ml57lUm5+l+TXAL/
         N6Nermz/u12wIKekY1TZVoLIKQ0pn0vw2h/DPaN5q2FfRrS9X9WalFKaR0SeYd6VOedw
         YAmCnKGAEdfrjnFhe4SW5gRknwvOjirzBDI/+PikbIxf9Na0BLbqWYHGwlq0WV/0M1qq
         Ak1FIAsvLBDZ83HSgW7AkFtpZ3Lulq1io0wjxwaJtueM8psqGBTN0FWNeeaBEObjJtUK
         2PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fbqsAW7yNSYmAKZph5yljTbbuXGanOhBHPWVUYjbPQ=;
        b=X5UXbUS00ZA54bdrvY0aQJURRQikWAKLQQhBspLabeZ8TZaMCp8U16YfTO/W4pqArD
         m97dH403u0oXDRTAeYrKdB9EfuClri3B3PYCmv37+zjrmzvyqnoyvTel61V1wEMrqPAv
         SKCdq6+FQV5J3VBdUZCbBpAbg3Wah8KXukPU2h6Bg9jGmjKi7OCpz0eDuFlTzXkuyWWu
         M5u/hb09rvCSqG3pAlu6FDRFzsfN66uxzTWdrL/Q6bF89ft2xE71mG5YMmA3r7Cw6mb/
         Wv8hOc29RtMYZuNQrRRejm/HDhn5IrB0rYDX831TVd+jB5s4sv5EgtJkIjqVOdahifxn
         ruug==
X-Gm-Message-State: ANoB5pmGPxsPF4i85Y3smZKkKBNykEVeDREljbScicVllspqxn1zOBVB
        D3BvCXk385kwuT94DmfqtsDe76fB2lnqiV9+sj4=
X-Google-Smtp-Source: AA0mqf7ZWE1pMx0cK9n+8KeS0QId0aFAvQMhiUiLdcOD4CZ0ul98T/osG5zSa3t4emvV6oApnUzq1drNN3E0FAccT1E=
X-Received: by 2002:a2e:bc88:0:b0:26f:ae32:a207 with SMTP id
 h8-20020a2ebc88000000b0026fae32a207mr24573651ljf.321.1669987555666; Fri, 02
 Dec 2022 05:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com> <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
 <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com> <c73f7261-ec33-ec88-df3e-a34cf9b8015c@ideasonboard.com>
 <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com> <910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonboard.com>
 <Y4nCnEwqs69QezPn@pendragon.ideasonboard.com> <CAPY8ntAK9yh6ZQkuOrZqUn2GC2=qGaJrcxEjWyGep7KcWvxkhQ@mail.gmail.com>
 <Y4nrPuq0OjWKCzfS@pendragon.ideasonboard.com> <d44a4819-1d4c-255e-212d-70abcf9fbb05@i2se.com>
In-Reply-To: <d44a4819-1d4c-255e-212d-70abcf9fbb05@i2se.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 2 Dec 2022 13:25:44 +0000
Message-ID: <CALeDE9Mnko8r6kRKitJyzEofUSei5Lqt8e9VdgfwVHPARkTWQg@mail.gmail.com>
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
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

Hi Folks,

> > On Fri, Dec 02, 2022 at 11:23:29AM +0000, Dave Stevenson wrote:
> >> Dropping anything prior to those points would be rather premature in my book.
> > Something I forgot to mention is that there should be no issue at all
> > keeping bcm2835-camera fully supported in the Raspberry Pi downstream
> > kernel for a longer period of time. It's in upstream that I don't think
> > it should be destaged, as it's already considered legacy and should be
> > phased out. Do you know if there are users of that driver with a
> > mainline kernel ?
> >
> In Fedora there seems to be no official support [1], but openSuSE seems
> to mention it [2].

It's enabled in Fedora but I've never had a huge amount of luck with
it, I would be OK with the firmware driver to disappear when ever.

From our point of view I'd sooner we can just move to the unicam in
kernel one sooner rather than later even swapping one for the other in
staging to get the libcamera one in and improve it in kernel via the
staging process, I feel that would be better use of the very few
cycles I have for RPi bits.

Peter

> [1] -
> https://docs.fedoraproject.org/en-US/quick-docs/raspberry-pi/#_does_the_add_on_camera_work
>
> [2] - https://en.opensuse.org/HCL:Raspberry_Pi_Camera_Modules
>
