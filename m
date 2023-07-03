Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF1745AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGCLYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:24:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C36CC1;
        Mon,  3 Jul 2023 04:24:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fba74870abso4119857e87.0;
        Mon, 03 Jul 2023 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688383443; x=1690975443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4F0JphlS60aIlO89X6KCISi3bIatLzrPpJxxUwzNc=;
        b=PiAchaq+cIdndnc6Ryfhwmdg8OAkoyZX6JGF3vsf8poTX4uPL66vGCqtxmkA1/c3jJ
         24DL/trF7kW4+lL6ebg7BAHT8ZvcJflh8CgrLgT93JAz6MYMHiT8sVEFUrxYpebuA1Lb
         pyD8pKbkURADHKH5pBWIfHr8F52B2ZF8/oK7W90EX/uhPhHtKU3Dv8fKESc3id0WbFQE
         MTQB1eCRm9QY/kN/Z7W8ZxOtl3qOCKSbkyz75eTVcQk0LxZXQE3GEX5n0x92LR4vPY4f
         Y4DuhlDLuKXhaVFmMMzmU5meFpRqGl60uwv3GjnmcvXl1Gq0Qyj2Ys+Lk/ccfoH3su8x
         n5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383443; x=1690975443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J4F0JphlS60aIlO89X6KCISi3bIatLzrPpJxxUwzNc=;
        b=Wi6qFRYZLtpKZxqfPrI1KD2tCqD/u4tJ24vZr5f/aWXSjHXxFHbPpNqHP8Ysml013H
         IFfKwEIbykGof9obTSfnU+Vdtsy/bgDQc5dhh5pu4dBLkwyGv3e7ja3PPmVOZCM14YNA
         WifPXwsGR3a4j1keEBZDp2sTALC7Z9CBpn4VevGOInbCSTkOEWr1LuVLuTjgX06DZr7/
         Fk+DwDGYxbtSZ6VsK06dg7zsXm/8NX0IjffFc+3b/F9mFyDYvi9daYPp7tv0oMr3bQwZ
         I5LQONoVQaOUSl4ydn5MVhUBoN6sZCaAaXYQXEZWUzMxbo3JyQSEtW03aiYrKKiy45br
         gwvw==
X-Gm-Message-State: ABy/qLYrRvUw/DtzG8owMXNKBpIagwEuFfSdSlhs8uMyru0MZBJ6odOe
        J/gk1TlRBhnk6dR3VqsK7ub7az25qzU=
X-Google-Smtp-Source: APBJJlEN9W/KerWD+vLnjCiPAzG7pJLadxw29KfXv86kaMCxpdEBc8a5VgmDE5vE96GQVz6yTF+p5A==
X-Received: by 2002:a05:6512:32b1:b0:4fa:5e76:7ad4 with SMTP id q17-20020a05651232b100b004fa5e767ad4mr5672119lfe.10.1688383443207;
        Mon, 03 Jul 2023 04:24:03 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm19632410wmr.31.2023.07.03.04.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 04:24:02 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Bulk LED API
Date:   Mon, 03 Jul 2023 13:24:02 +0200
Message-ID: <5324811.I0CZgJUjXn@archbook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope this message can either clear up some questions I have or
prompt some discussion concerning a potentially new uAPI to control
LEDs through.

Right now, as far as I can tell, the way to control LEDs for an
userspace application is through sysfs. This works fine for stuff
that has very few LEDs (e.g. your average laptop).

However, looking through some online listings[1], we now have
multi-colour LED strips addressable over serial protocols that,
assuming an SPI frequency of 1 MHz and 1024 LEDs, we can update
30 times per second. Beyond just the problem of opening x * 1024
file descriptors (where x is the number of parameters we want to
change), we'll probably run into other inefficiencies pretty
quickly.

The scenario I'm picturing is the following: we have some Linux
SBC, and an LED strip hooked up over SPI. We now want to have a
certain pattern displayed on the LEDs, e.g. based on some machine
vision input. This should be as interactive as possible, or else
the machine vision part would be pointless. The way to do this
right now is to bash around spidev from userspace which leads to
very little reusable code across different addressable LED vendors.
Supply chains happen, a different vendor is chosen, code is thrown
out, nobody is happy.

A solution to this might be a bulk LED API. We add a new concept of
bulk LEDs, and have LED strip drivers implement that. These show up
in sysfs like regular LEDs (though that might be a bit overwhelming)
but they also have some character device for which a userspace
program can query the format (colour components + maybe brightness
components) and then write binary data to the device in said format
to set each individual LED's components to individual values. We
could then also add another ioctl or whatever to "flip" (present)
the newly written values, causing them to be actually applied to the
LEDs by the implementing driver.

Beyond LED strips, LED matrices exist too. I'm not sure if those
would rather be best implemented as DRM panels instead however.

So here are my questions:

1. Am I correct in my assumption that such an API currently does
   not exist?

2. Does mainline Linux care about addressable LED strips enough
   to theoretically accept some of the concepts proposed in this
   message, ignoring the fine details for now?

3. What is the current LED subsystem technical debt that needs
   addressing before one could get started on this work? I see
   in the TODO file that there is some concern over multi-colour
   LEDs, which would be tangentially relevant to this.

4. Should the LED subsystem even be the subsystem to implement
   these, or should they be 1xn panels in the DRM subsystem?
   The DRM pixel formats might not map to wacky multi-colour
   LEDs very well, but 8-bit RGB + 5-bit brightness as in the
   example strip I linked would probably work in some vaguely
   HDR-adjacent way.

And, addressed at nobody in particular:

5. Is any company willing to sponsor me in doing the work to
   implement something like this?

I'd also like to gather some ideas at this stage as for how
such a bulk uAPI (and kernel internal implementation) might
look like in more concrete terms, as I am quite new to kernel
development and probably glossed over some important details.

Kind regards,
Nicolas Frattaroli

[1]: https://www.adafruit.com/product/2239


