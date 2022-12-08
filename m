Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEE646968
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLHGnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLHGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:42:57 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83C24F09;
        Wed,  7 Dec 2022 22:42:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso374559oth.5;
        Wed, 07 Dec 2022 22:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Lf6TLbAlDvGkLXakdNfu88j2XsGakj+kolJRyi9VaU=;
        b=U2E2I6qSCHUWi2YlIz3b5AdXJjkOH0Tvfim7ffgWOKJkimzoNoCWOUO9sppiR5HNQP
         IbRWBxkw1Egjsvdu4euegkhnj24XdwKtcWyLFBT/ZkNB+ijtLGI439x14+3g1L2h1l4E
         eLmZu9pWyjx6rPVUZU7YJUDc12CeB8/C69n9M0up088w78wc8n67swuwEVryzxiDBvMh
         ql/4G7ehToXVYoHv7AiSgZ4BCjueS4JS0a7riZr2bv/Vsr/37fBrEDvKHYJDRfibEILF
         zkIpxGEsiT/VrheBOl3x81mQ2KHjzMBO1h9C4/CZIgkaMD7rICcmAbUJne+w1/tkkWwZ
         hN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Lf6TLbAlDvGkLXakdNfu88j2XsGakj+kolJRyi9VaU=;
        b=lCyyFGT63605J7tL6e0HTA2prDd2HdpPndUeH2y4eHIplnbGwY8ZICml1sBxkBXw/L
         9Iybp8W1yy9Qh5VJL4oiS76Wl0zqNZ8hSF0UCTo4YXvEf8bs4e7ZpNXMYmVawjii+sf1
         ZQr4ZLHxzEe5w9oWxzgN9WJeb1Y1BFp2IP6AJdh6YIgsm1kZkDDSWSM6g6RVX1MPFmy1
         vaw7lhcE6QZ+6F4AEqFTBNe9Yr7X6pKnJZ9aANdWVqIUW3lKwkEtRwX9qW7kxCehl21L
         SMQp3y+G8sKVcDLAuBerM1uNzvTsy1aw2sdhEghD1Bb4gLOMaR/4FVePzHsVW7SSAKVr
         NI2A==
X-Gm-Message-State: ANoB5pmOFDV7LeNz9u9se2Wmu8a1UkfLXR4bwr+TzWuwTOK/r4PCU6LF
        cE06l03Hkq7iyLkk0ybXkOHCbH/yDt37psMZRv0M21EN
X-Google-Smtp-Source: AA0mqf6qPbVfMZHws+9PHSiOhU8A9Gj3EyzoOSq+IsWd+Z7JB5IQadSt81xXL2waXVU9lOXOCSsPswjXqOI8syEK1lI=
X-Received: by 2002:a05:6830:699b:b0:66e:7ba6:5e0f with SMTP id
 cy27-20020a056830699b00b0066e7ba65e0fmr14448649otb.312.1670481774961; Wed, 07
 Dec 2022 22:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20221207040904.582585-1-gch981213@gmail.com> <20221207040904.582585-4-gch981213@gmail.com>
 <Y5By0YeGVlS5TlO3@google.com> <CAJsYDV+PBvEBWp=2LLbLkiNqQ0qQgWDOyZ4-onMC9_1B0mTfww@mail.gmail.com>
In-Reply-To: <CAJsYDV+PBvEBWp=2LLbLkiNqQ0qQgWDOyZ4-onMC9_1B0mTfww@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 8 Dec 2022 14:42:43 +0800
Message-ID: <CAJsYDVJK3jnHezHRHOdfN9oPgA+cVwuRszXDorObNjVZWF9_1A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] leds: add driver for SPI driven WorldSemi WS2812B
 RGB LEDs
To:     Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Dec 8, 2022 at 11:00 AM Chuanhong Guo <gch981213@gmail.com> wrote:
> > You're saving priv in priv.  What is this used for?
> >
> > There must be a way around this.
> >
> > In fact, doesn't the spi_set_drvdata() below already save priv to
> > cdev->dev->driver_data?  If you move to devm_*() you may have to
> > rename this to dev_set_drvdata() to the APIs are symmetrical, but it's
> > better than this incestuous solution.
>
> I'm saving priv to struct ws2812b_led. This struct is what we got from
> LED callbacks. This struct is an array in ws2812b_priv. In order to
> use the container_of magic I will have to save the index in leds[] array
> to this struct itself.
> Since I'm saving a value anyway, save priv can make my life a lot
> easier than saving an index and calculate priv out of it.

Oh, I didn't notice that I also have access to dev in LED callbacks.
I'll try implementing your suggestions.

-- 
Regards,
Chuanhong Guo
