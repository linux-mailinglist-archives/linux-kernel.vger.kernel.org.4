Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1486160E395
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJZOmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiJZOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:42:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25BDDED27;
        Wed, 26 Oct 2022 07:42:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y16so16257435wrt.12;
        Wed, 26 Oct 2022 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQ+kDA4G+wlVL+Ry3C2hNPCcp5na+qrAnLo83Besj4=;
        b=NsT4aKIWNh8VI1pqGxDuMdij95PeSRomq9fcVnLuUdufvUhkiJenOSIq4zjBZcpguL
         YHwYgOdkenfpk64mO5RIPHJOucrjh2Ak0Q0NrslVONPd/XfgVznuQTvYmiVTkWmEDUx3
         CSW1gg23t7h/JH4EkTVhztriJju1ZSQBqvvYQ9blkWaDu/W7fGmOY60IQL50ffUV5eG3
         AuxSAJwmjXCDkZLf63CIkr4yYedZ5gSKGYTpoEixWgeZ0Y9lMNRlxliPiPDQI3UkfdEh
         idW0PZT2K5Z6pirybjnWPe2e7aZ5Ei2QAzt4bioCuWu4jfToiAZc2HCuj27wU9SBzOty
         euNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOQ+kDA4G+wlVL+Ry3C2hNPCcp5na+qrAnLo83Besj4=;
        b=TY3feQJ8De2jqkKSKUzDX6XsK6sXaHKQl+foPr57/gUoMEvua0P8P3Z1QIUnsKprPE
         QI1RMdekSGNaCMsCAFokfHMq9Kx+4aW+DGmOTZq3wQ7Zj+Ap2S5ZLE8KT3fjmWE1yT54
         Y4xC0B5caZavizzdZOp8rnnMwL+rFK4FQjkL6ol5OyLM2Dhrg7UFRGxYemx0pn+B0pA8
         R56C8zGDsCW+aA1up0mSrAzA6rSBD96o590i2CftXUhBwK82gPsCacWGNu+w84VXPBaz
         sEXFvq2jEDRZ6r+2OIZBQofhPRG7J4N0dlMTxl7LuJeGRNh4KBSQjBtD70K9t1dkHmIR
         TUHA==
X-Gm-Message-State: ACrzQf3/EeMEXwpWls2ss2RAfMLr300DSX+pO/wwhvT8UPIkiEzS9Nen
        QMETuT5DDQo2nXLmp97bnFZIrx2xPtDKLA==
X-Google-Smtp-Source: AMsMyM6+iea+6w9Q40omuHqI7vrbCP13G0UnlyON5YvJ3pwG56gCmnZU/yp0hMeTDVBPdrJbQC1f/A==
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id w7-20020a05600018c700b0022e55039c46mr27782051wrq.668.1666795351099;
        Wed, 26 Oct 2022 07:42:31 -0700 (PDT)
Received: from localhost (94.197.44.200.threembb.co.uk. [94.197.44.200])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c365100b003cf4eac8e80sm690283wmq.23.2022.10.26.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:42:30 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <Y1Z74/vKHbnaCLrX@sirena.org.uk>
 <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
 <Y1fCfej+/WH8TI39@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
In-reply-to: <Y1fCfej+/WH8TI39@sirena.org.uk>
Date:   Wed, 26 Oct 2022 15:42:31 +0100
Message-ID: <FgO8Xz5MtaEBdBidpT8So4X5posjL95Y@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Tue, Oct 25, 2022 at 12:17:25AM +0100, Aidan MacDonald wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > We already have clock bindings, if we need to configure clocks we should
>> > be using those to configure there.
>
>> The existing clock bindings are only useful for setting rates, and
>> .set_sysclk() does more than that. See my reply to Krzysztof if you
>> want an explanation, check nau8821 or tas2552 codecs for an example
>> of the kind of thing I'm talking about.
>
> I thought there was stuff for muxes, but in any case if you are adding a
> new binding here you could just as well add one to the clock bindings.
>
>> I picked those codecs at random, but they are fairly representative:
>> often a codec will allow the system clock to be derived from another
>> I2S clock (eg. BCLK), or provided directly, or maybe generated from an
>> internal PLL. In cases like that you need to configure the codec with
>> .set_sysclk() to select the right input. Many card drivers need to do
>> this, it's just as important as .set_fmt() or .hw_params().
>
> There is a strong case for saying that all the clocking in CODECs might
> fit into the clock API, especially given the whole DT thing.

The ASoC APIs don't speak "struct clk", which seems (to me) like a
prerequisite before we can think about doing anything with clocks.

Even if ASoC began to use the clock API for codec clocking, it's not
clear how you maintain backward compatibility with the existing
simple-card bindings. You'd have to go over all DAIs and mimic the
effects of "snd_soc_dai_set_sysclk(dai, 0, freq, dir)" because there
could be a device tree relying on it somewhere.

So... given you're already stuck maintaining .set_sysclk() behavior
forever, is there much harm in exposing the sysclock ID to the DT?
