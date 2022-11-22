Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C7633646
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKVHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiKVHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:49:54 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B16464
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:49:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ft34so33760962ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIHnh5Weqii3bMFUq/Q3s8DVR9XTPzJucBuKeOnZBJE=;
        b=MdLTO49BHpElc9B8TkmaizXcLPANaJej+UQwQcj0ZuMz97W2zJHAk1d7FHlNWM7pWM
         TFQ2xa18tMAmcoz/W3XZhsIbIaP6jIrnRfy0gW1QoWvKvMe90gGvrKsbb2++gDm22fbE
         TO98ZXze9usn9GHYdS+TS/YPeuvCf3j/OSb2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIHnh5Weqii3bMFUq/Q3s8DVR9XTPzJucBuKeOnZBJE=;
        b=lp4MBVNW9S2vA7t/9YbDHxpW7XzQXbf1U3V06bMsfOsvngeAfihO6BMlOx+0UdMI9Q
         uv5EFDWiQ9SAwUdV3uroY9k3n7IGsik14xfXr7LDP6WcnLUS6sudhkZb68zqcVPR5oA6
         Fyih7XedaU8ZGVw3y/OI3HF4z4ZU6MfGZN9zau1vgOl76d8fz1KSqSjuCIkqsOqShUnB
         7nFjq7K9IRRv+C7QJaiackktMJy8YXptSfDEc1jFmfRMlL1JCk57Wof/3OlZHrkGGx+M
         ygBnyajZsBESq8zkHvwuinx9LW/LDpSrbGn8R5B43mnjjKjSyiRtrH2O/qaZSC4rOnuC
         qbhg==
X-Gm-Message-State: ANoB5pnjI/zXCxFSpS4gy6x3iKJtm5n+Th9MkxeujGrzfq9B6mNg+cv6
        V3spQ4qTF44UOX5zlZY8YgbK5w==
X-Google-Smtp-Source: AA0mqf7+4ETMgNAMF3Zl5W0BwD31+HiD6WJucuCHM0DoG5jQHGS+cxVTvS7Gr6Bbg6ec2Ip8wyTgYQ==
X-Received: by 2002:a17:907:37c:b0:7b2:73d0:4b9c with SMTP id rs28-20020a170907037c00b007b273d04b9cmr18356203ejb.746.1669103391118;
        Mon, 21 Nov 2022 23:49:51 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d896000000b00459f4974128sm6130933edq.50.2022.11.21.23.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:49:50 -0800 (PST)
Message-ID: <97c249fd-21c5-acc2-6195-bf0aed5bee8f@rasmusvillemoes.dk>
Date:   Tue, 22 Nov 2022 08:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US, da
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <Y3ucncQOBNHpZaxn@linaro.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y3ucncQOBNHpZaxn@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 16.43, Abel Vesa wrote:
> On 22-09-28 14:41:08, Rasmus Villemoes wrote:
>> We have an imx8mp-based board with an external gpio-triggered
>> watchdog. Currently, we don't get to handle that in time before it
>> resets the board.
>>
>> The probe of the watchdog device gets deferred because the SOC's GPIO
>> controller is not yet ready, and the probe of that in turn gets deferred
>> because its clock provider (namely, this driver) is not yet
>> ready. Altogether, the watchdog does not get handled until the late
>> initcall deferred_probe_initcall has made sure all leftover devices
>> have been probed, and that's way too late.
>>
>> Aside from being necessary for our board, this also reduces total boot
>> time because fewer device probes get deferred.
>>
> 
> I'm gonna be honest here. I can't say I'm happy with this.
> I would suggest finding a solution to disable the external watchdog
> before booting the kernel, up until the driver probes, would be preferable
> to me.

That's not an option (it would violate the very purpose of having an
external always-running watchdog), and also simply not possible on the
given hardware.

I don't understand why this simple patch can't just be applied. It hurts
nothing, it makes all imx8mp boards boot very slightly faster, there's
no maintenance burden associated with the boilerplate code, it allows
hardware that already exists to actually work with a mainline kernel
out-of-the-box. And in an alternate universe where the init function had
been arch_initcall in the initial commit (such as those in
drivers/clk/mediatek/), nobody would have asked any questions.

Rasmus

