Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC36A4C00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjB0UH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjB0UHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:07:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944D279B6;
        Mon, 27 Feb 2023 12:06:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ck15so30936549edb.0;
        Mon, 27 Feb 2023 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8uInxHePMiAlwvbGNwI0Ugw9k3Wci0tWnR38NP9c0+o=;
        b=MeSmGwQ/HmmBFMFaypLzcQiaH3ObjO8JAEpXdx+4wryYDhZg4v/dgFbvwzQoancUEC
         re5tVAHMzNYllS4LrS+9f6JkXeWGOWc5y6cHleQ7pw3qnZwjwzvTec56FGUbX0lb96oq
         764RFnD9qxYmvWsCASLSRoOdcIDEq29HZ0/RQvmPPQpAox1S1R/cz7N+JEkuSP7TtR0n
         8dqEVWMGjjUaNAVu1VBPKvpVu1CXwvRbL1LRus2ErmwuOnWPK3pbCvY0nvowMu5LBqtX
         C1Qs3G3Fd/K300A2XjRVbnB/WmwQxdZtKOCqXEoGrilYPZX2D6AlqptEEIjs3HG4nxw0
         Yxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uInxHePMiAlwvbGNwI0Ugw9k3Wci0tWnR38NP9c0+o=;
        b=uaPLgbcWfN/B0y/aYEVeqWJnCp3n5WHZC2/bIutHefJbdjcTgghBJNdKkt6NSYupt8
         lZBb2ZzoxsF9pY33msN+R925VnecuHb7x2+ms5f1+Oig3WaHisqtOgrzxNRXcD589ozw
         iWruC1VJ3Pk2STygG2VC2fGm9jC+/oUxmR8cOI4Gb1KiyAnUQpcOI/nqoGibE2Rn9kQ5
         jqR0BGFpaMZtPnJQpHoaw9AcOMHY6ACwbaD5j0FJLS4bOcUIP6VicIJLiUiE0Ig1x+r4
         My/+3KcRBqLcQ2WGtb8/eVM/spBF6SZ+8qVRVReV11sdrixEif89kjnkqSaChNfLi3BB
         mBrg==
X-Gm-Message-State: AO0yUKVujWSdHZXIZOpKHslWqyt5pF9M5BQZbmQElsOShBci2h+i/R2C
        vFAQwzWKl5avgUqJLWqZZMH95yf4W641UvbNlxg=
X-Google-Smtp-Source: AK7set+rFRwwuHlNUo6YttoaHQUv1gV4hohZb6nayx6SZjljKZP1HvI16epTaVLppOg3ZaqYoXlGCrsWA0NVSYZEKns=
X-Received: by 2002:a50:d494:0:b0:4ad:72b2:cf57 with SMTP id
 s20-20020a50d494000000b004ad72b2cf57mr461379edi.0.1677528400166; Mon, 27 Feb
 2023 12:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com> <20230227195139.GA677578-robh@kernel.org>
In-Reply-To: <20230227195139.GA677578-robh@kernel.org>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Mon, 27 Feb 2023 21:06:28 +0100
Message-ID: <CAMT+MTRodB_+sMtoPxv-gP_+sJAwNb36XuLOGo=HvuCQq6h+gQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
To:     Rob Herring <robh@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 27 Feb 2023 at 20:51, Rob Herring <robh@kernel.org> wrote:
>
> > +properties:
> > +  compatible:
> > +    const: apple,z2-touchscreen
>
> Is 'z2' anything other than a touchscreen? If not, '-touchscreen' is
> redundant. If so, then what else is there? You should be describing
> physical devices, not just a protocol for touchscreen.
>

This is a class of touchscreen controllers that talk the z2 protocol
over spi.

> > +                    touchscreen-size-y = <640>;
> > +                    apple,z2-device-name = "MacBookPro17,1 Touch Bar";
>
> Why do we need this string? If you want a human consumed label for
> some identification, we have a property for that purpose. It's called
> 'label'. But when there is only 1 instance, I don't really see the
> point.

I want a libinput-consumed label to distinguish between devices
using this protocol. It is used both for 'normal' touchscreens, and,
as is in this example a 'touchbar', which absolutely should not be
treated as a normal touchscreen, and needs special handling in
userspace.
