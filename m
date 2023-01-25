Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CE167B500
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjAYOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAYOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:42:44 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E561BDF;
        Wed, 25 Jan 2023 06:42:11 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 187so19952239vsv.10;
        Wed, 25 Jan 2023 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kODBhOs5SF/g+uKKdGLvYQ1uu9onF2vNH+SdUo5BiI=;
        b=aVwUVFhMTb8XjI5LFcDMTUWQumvqpJiF/5rsORKZkMSpoyjjDhM3LS6kHT2ODXPMwC
         8z3dRrv9t5ow0Idu2TYW755IxsMeseHCM7DoMwwXwr4BrsOvV/MXd/swkOiuCvuEeSkv
         jakH+mhd8Ibp0gvy2RyYgRfyj+9r54BWTECL3lXF5hPNtYwHBSBE3pK6jubf5mFne84n
         5R6wp0ItP9wDUlaVkH/dLsFP/VaoN4lLw2thV/0uLFrP0k1n1kTkEjcydNh+E7sx+OEA
         Im9g/sg5lSn4mnlA4B7li2dcapRNEGnwSuhAp/gaiNGNxPTrzjfs9TOwOFAHj6tAW4oE
         snZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kODBhOs5SF/g+uKKdGLvYQ1uu9onF2vNH+SdUo5BiI=;
        b=LN4k8vf2kRkJEgL692e7S1RQ1l5DzZDKa3qcysnu3t6XipuFrMkOz/iABgDmbjZ+Me
         YTDlUGImV4OSm6td5Q1tRY61H3tR834JlVe+zTqS6qLnaAc18+IbHUyHovizSyP3nAIZ
         cOJMu6ybOIcJsAiZqojDFEAtsRhk5XcVC3IASuge73sTdk0N93gWzmLLrmkTmnSDU26n
         4hiNAdvjbPKWZLq10prR0F1Yw3xJqJT1abRilAD1id5pY0iqoaKi6nAfOvrVbhIhV4ir
         7qZxsYQmF0YnBysslc26MzAbcItSpgwMCknESgvltKUYxrzrs9WHMjguhmR6O+M572vX
         cdRw==
X-Gm-Message-State: AFqh2kpg35C5T6jMx2Z2FW90fDwqht5hv/HYO69htyyF/JMKCbnRgIxf
        zp0Dk4WwwE7wgpemkNJFpm6DCbsmMwAKMeBxdpksfc/F
X-Google-Smtp-Source: AMrXdXtWNtz7jGkvrEjuW/eC43d0euK66cieClgRJo4Ag8TIa/cgv5PNKGO3RiqydqTOtwzFpXTffRtcFZiv2Wi6MIk=
X-Received: by 2002:a67:d097:0:b0:3d0:cb3d:ad47 with SMTP id
 s23-20020a67d097000000b003d0cb3dad47mr5103870vsi.76.1674657690896; Wed, 25
 Jan 2023 06:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20230121175639.12818-1-linux.amoon@gmail.com> <20230121175639.12818-2-linux.amoon@gmail.com>
 <Y9E98OLYedOsXHHV@kroah.com>
In-Reply-To: <Y9E98OLYedOsXHHV@kroah.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 25 Jan 2023 20:11:13 +0530
Message-ID: <CANAwSgRe0PdB5iWi-fvK4NFsH4XbaSR3M_KwBNm7wQXzxTkrRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: usb: Add device id for Genesys Logic
 hub controller
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Greg,

Thanks for your review comments.

On Wed, 25 Jan 2023 at 20:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 21, 2023 at 05:56:29PM +0000, Anand Moon wrote:
> > Add usb hub device id for Genesys Logic, Inc. GL852G Hub USB 2.0
> > root hub.
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3: - add Ack of Krzysztof
> > v2: - drop the vendor name from compatible string.
> >     - drop the -OTG and -QFN76 suffix from commit message.
> >     - drop the GL3523 USB 3.1 root hub device id.
>
> I only see 4 of the 9 patches sent to the linux-usb list and cc: me, so
> I'm totally confused.
>
> I'll drop them all from my review queue now and expect a full series to
> show up if they are needed to be merged through the USB tree
>
> thanks,
>

Sorry for this mixup from my side.
I will send the full series of patches again tmr

> greg k-h

Thanks
-Anand
