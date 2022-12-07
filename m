Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493C64608E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLGRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiLGRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:44:53 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3556557;
        Wed,  7 Dec 2022 09:44:52 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id v8so10505387qkg.12;
        Wed, 07 Dec 2022 09:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTxIkdQw+FZkhn3OUt+5u9vgzVcJeWzgDBM5IBCMlVE=;
        b=4hcNFhsed8agu0c0/UgeU3E9fpxnIeUM1n/gslEoJWyCWRW6ubuGzBX6yvT7pj5syC
         M7PH6ljhnmrRpZPGlVs9Vjvs2W56BJqtFnlUWoTAnMycnCCTA/gAZgEfMfEhOQxnSrw6
         xKFyspFV7njhnJYwV0x+7U2aWEWocRRt4a5y49FHOiZ2pLY6D0WzCJGS8KE2JplO/0Sy
         6yQXJrmi7X5CCwho9BlhNRGLxTuv/2j6ZmxcqoXaixd2dXC4grig4h+u4+tVifDSELMl
         f9f2XPNgFqm2pnbYZaYSB3oZY2auQ1HTHw/0O2iRAhloqZ4C0uGpJI2KsDlCX1R8sAlY
         KnLg==
X-Gm-Message-State: ANoB5pmXMft+bdYfofBVT6WZ5VKKniQviRTsl7nBBC7U1sPF2naExj8U
        Z4os3GxLqVk9jL6C6wnUYy7dXBzzxhQ6u9k3kgo=
X-Google-Smtp-Source: AA0mqf6qRSvLttgkHNahteuYJzczh+XMv9nOQmu/y4QeMOeOLbP4P5mqxzrkxhh22LPKkrd41LhKd+NAIFdJuVPXSxU=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr79280179qkb.443.1670435091997; Wed, 07
 Dec 2022 09:44:51 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
 <2145955.irdbgypaU6@kreacher> <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
 <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
 <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
 <cd8b2a2160f5d36d1b73bc0567cd0f6e7e5751c4.camel@hadess.net>
 <CAJZ5v0gRm1NG=QuDFDFdcZgTu7Q0Z3cW3fwGg09sD+3BBV8E1A@mail.gmail.com> <91367d07a72ecb2065faebe974c54ebd966e0d59.camel@hadess.net>
In-Reply-To: <91367d07a72ecb2065faebe974c54ebd966e0d59.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 18:44:40 +0100
Message-ID: <CAJZ5v0ghW2DdC0quVQ-+Oad7bR95Pyp4Uhd9=XUYk9SQrXKj5w@mail.gmail.com>
Subject: Re: [Regression] Logitech BT mouse unusable after commit 532223c8ac57
 (still in 6.1-rc8)
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 6:19 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 12:07 +0100, Rafael J. Wysocki wrote:
> > # hidpp-list-features /dev/hidraw1
> > Bluetooth Mouse M336/M337/M535 (046d:b016) is a HID++ 4.5 device
> > Feature 0x01: [0x0001] Feature set
> > Feature 0x02: [0x0003] Device FW version
> > Feature 0x03: [0x0005] Device name
> > Feature 0x04: [0x0020] Reset
> > Feature 0x05: [0x1e00] Enable hidden features (hidden)
> > Feature 0x06: [0x1800] Generic Test (hidden, internal)
> > Feature 0x07: [0x1000] Battery status
> > Feature 0x08: [0x1b04] Reprog controls v4
> > Feature 0x09: [0x2100] Vertical scrolling
> > Feature 0x0a: [0x2200] Mouse pointer
> > Feature 0x0b: [0x2205] Pointer speed
> > Feature 0x0c: [0x18b1] ? (hidden, internal)
> > Feature 0x0d: [0x2121] Hi-res wheel
> > Feature 0x0e: [0x1f03] ? (hidden, internal)
>
> Would you be able to enable debugging for the hid subsystem to get some
> debug data when getting the version from the device fails?

I guess I could, but I think that the device is just quirky.

At least the BT layer appears to think that it is connected.

Anyway, what exactly do you need?

> I can't see any problems in there that wouldn't also have impacted all
> the other Logitech Bluetooth devices listed in the support devices
> list.
>
> If the problem is a timeout, maybe we should lower the timeouts we
> currently have (5*HZ = 5 seconds, right?), so we can retry 5 times one
> second instead.

No, it doesn't take 5 sec to get a response from it.  It rather looks
like __hidpp_send_report() returns an error.

>
> Still, as I mentioned earlier, I can't reproduce the problem on another
> Bluetooth Classic device...
