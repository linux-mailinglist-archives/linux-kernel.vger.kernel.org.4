Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C16277E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiKNIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiKNIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:38:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A11C130
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:38:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s8so972489lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F65D6wP7x5X052MyNJlEyUIkEOJA9df83maNEAxoFlA=;
        b=SLmbNisfEZa220qEeUcjMkOX0OV5NIOEAYcv6i8c2pEfdzWPz1IYCjzmOV5S7AEv0z
         E3Zkiqc1yNufmA6OcAvnrrVehhgRO68E22W/FMgZytjQddxngoW8+mC9Dh14GuCm8eBh
         lX9RU8d3O5TmkRHRTg9NlYpD8dUi/EVl4ZyVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F65D6wP7x5X052MyNJlEyUIkEOJA9df83maNEAxoFlA=;
        b=K/zuiQwsvTCrvb5mVhspNIvC1KSI/BRwfuSmM035ZpCtrFAxLolOoeKVouO4pgpcUJ
         g36oQ/wH7iijOPkMuQFc+VjEGP8oEDWQXnRgJPnRgFnkUyyu/nImoj1ZsfHM8vagSiYr
         Vw4JQNPqhkkSGezuQCWEuTq/xgpuvcHgCIhhQfpxmoYjFW5Zrhuj/fhJ3eLhFgG5bMWO
         smEFXczdc1NBo7mrbRcxTfsByIUlthU26023Icbb0sIBPI6eMXrsXrqecJygKxEvX8hq
         tzuiErHwSl8oxmbhnrceEFlQapRQSDpfLX4iStjXLiLKtpKzS463JvyqxepntEyGRMYf
         txUw==
X-Gm-Message-State: ANoB5ploxep/9ioiAUiyKPmqlaVcT6M2rGJZA1Me/znC+Mq9L8KjpwL8
        i0FVZetXZr5cHyeOii7RS60hQw==
X-Google-Smtp-Source: AA0mqf6BieLBmgmKxdr1DOtVQ9Pm/TUzJkqgRC+co3AriPY3/f4R/0+Lym0jwfizY+BzVMwF/EaqdQ==
X-Received: by 2002:a05:6512:3f9:b0:4af:baf9:7d4 with SMTP id n25-20020a05651203f900b004afbaf907d4mr3584746lfq.460.1668415081088;
        Mon, 14 Nov 2022 00:38:01 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bu42-20020a05651216aa00b004aac3944314sm1732284lfb.249.2022.11.14.00.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:38:00 -0800 (PST)
Message-ID: <ccb148b2-c669-0317-e2b5-c59e595e4299@rasmusvillemoes.dk>
Date:   Mon, 14 Nov 2022 09:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221111143921.742194-6-linux@rasmusvillemoes.dk>
 <20221112170705.7efe1673@jic23-huawei>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221112170705.7efe1673@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 18.07, Jonathan Cameron wrote:
> On Fri, 11 Nov 2022 15:39:21 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> We have a board where the reset pin of the ad74412 is connected to a
>> gpio, but also pulled low by default. Hence to get the chip out of
>> reset, the driver needs to know about that gpio and set it high before
>> attempting to communicate with it.
> 
> I'm a little confused on polarity here.  The pin is a !reset so
> we need to drive it low briefly to trigger a reset.
> I'm guessing for your board the pin is set to active low? (an example
> in the dt would have made that clearer) Hence the pulse
> in here to 1 is actually briefly driving it low before restoring to high?

Yes. I actually thought that was pretty standard. I do indeed have
something like

  reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;

in my .dts, so setting the gpio value to 1 (logically asserting its
function) will end up driving the signal low, and setting it to 0
(de-asserting reset) will set the signal high. I will add that line to
the example in the binding.

> For a pin documented as !reset that seems backwards 

Well, it depends on where the knowledge of the pin being active low
belongs. In this case, the driver itself handles the gpio so it could be
done both ways.

But if, for example, the iio framework would handle an optional
reset-gpio for each device, it couldn't possibly know whether to set it
to 1 or 0 for a given device, it could only set it logic 1 to assert
reset and then rely on DT gpio descriptor to include the active low/high
info.

Also, see the "The active low and open drain semantics" section in
Documentation/driver-api/gpio/consumer.rst.

Rasmus

