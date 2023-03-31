Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D036D1BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCaJQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjCaJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:14:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC84D4F9C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:13:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a11so22330598lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680254012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3/dMT5UuvB37dzopTiUDnIZpm0CxSZnHqspthqK8JA=;
        b=WC+wOwWsj7fRR25XoXXAcsaXtlPkMrYEP9HQrUhPItIXCsAKujQ+jhC85kkmJIwDj4
         YuwlzhEuZhRYxemC60ky7ScWF4O/0qJmdVjzbfN+zR/Tj+uVK4dK/p5StJKLwz6NUgOC
         rktLz37FXgVzoYaYnahi7FBL3lwIX6IvHYuX2E33MpJOPCAKZBdiUpLu29nH/0V9nq4y
         gJZr3UqhKk7ysi4Obz7k3FRlv9oevLU2nWqRM1k1azIm/mDbsec+FSqwTmhmlLE72fwh
         6xmHBUJ7YA3whLJQkeyj/4ta6daNjC9oWqLJ32gY6Z7FM4o3WL1J3cmQKnl3p8ocnOpf
         18AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680254012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3/dMT5UuvB37dzopTiUDnIZpm0CxSZnHqspthqK8JA=;
        b=hqhvdwUP9C1xaUnCiI2TeUn1w4hdH0iARijl0uNLdwxUUlGGA1S4ozNsJtMJW6pyWk
         ywwcAFTKyYhlfN35JJPkS9tDdWtlOoVKHgl94r+Pgq1YaWolvT6fQ+tYAzwqi//jY8Xj
         4UZ/lAmsxQZJoVpBzhk04hT8MyH4nyMzff6duxBO5uLPGv4iqkvCMGWiJgyHlV1Q2+Cd
         X4y9WRPmLWxfLBXi02UUwNsbQENR292Z/vx9Nm3wZ46aOayQZglQzDs4h4jZ/VtRArrb
         oilRMpaUG4cFrebxmyiK9DTquHxwhC7jSQGvlc8njJluMuntxAdNbN2Jhh0SrJH4W2aa
         xAdQ==
X-Gm-Message-State: AAQBX9d+A4GN3ELjq0Eha6/WhiBvbmxLPewAGZJ1EQzJyhtsWWNLsM0w
        hKtEAXlrkl7nVCs1lxqNZjjM8A==
X-Google-Smtp-Source: AKy350aHqb4lGEq9xuL+CqwXWf+p1B4k/YE/fjbuw1FXgrTSK9GNORIG36d7rS2+r93bTRU954vAmA==
X-Received: by 2002:a2e:9e98:0:b0:29c:d0ef:481c with SMTP id f24-20020a2e9e98000000b0029cd0ef481cmr7710603ljk.28.1680254012225;
        Fri, 31 Mar 2023 02:13:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j18-20020a2e8512000000b00297dad1a2b0sm267241lji.103.2023.03.31.02.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:13:31 -0700 (PDT)
Message-ID: <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
Date:   Fri, 31 Mar 2023 11:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
 <20230328092645.634375-3-herve.codina@bootlin.com>
 <20230330160510.GB489249@google.com> <20230331094208.41ab4420@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331094208.41ab4420@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 09:42, Herve Codina wrote:
> Hi Lee,
> 
> On Thu, 30 Mar 2023 17:05:10 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
>> On Tue, 28 Mar 2023, Herve Codina wrote:
>>
>>> The Lantiq PEF2256 is a framer and line interface component designed to
>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
>>> digital PCM system highway/H.100 bus.  
>>
>> My goodness!
>>
>> It's been a long time since I've seen anything quite like this.
> 
> Yes, old things but working on recent kernel.
> 
>>
>> My suggestion to you:
>>
>> * Split this up into components that fit functional subsystems
> 
> It is done. The audio part is present in ASoC subsystem (path 5 in this
> series). pinctrl function is implemented in this driver and, as I don't
> want to share registers, I would prefer to keep this function inside this
> driver.

The amount of defines and huge functions like pef2256_setup_e1()
contradict it.

Even the pef2256_setup_e1() really does not follow Linux coding style -
you know the size requirement, right?

pef2256_get_groups_count, struct pinmux_ops and others - this is
pinctrl, not MFD! They cannot be in MFD driver.

> 
> Also, I sent a RFC related to HDLC and PHY. In this RFC, the pef2256 is
> considered as a PHY and handled in the PHY subsystem.
>   https://lore.kernel.org/linux-kernel/20230323103154.264546-1-herve.codina@bootlin.com/
> 
>> * Run checkpatch.pl
> 
> I did.

There are tons of weird indentation,e.g.:
+#define     PEF2256_2X_PC_XPC_XLT	(0x8 << 0)
        ^^^^ there is only one space after #define

... and other style issues:

CHECK: Please don't use multiple blank lines
CHECK: spaces preferred around that '+' (ctx:VxV)
CHECK: Alignment should match open parenthesis
CHECK: Macro argument reuse '_groups' - possible side-effects?
CHECK: usleep_range is preferred over udelay; see
Documentation/timers/timers-howto.rst
CHECK: spaces preferred around that '/' (ctx:VxV)


> 
>> * Remove all of the debug prints
> 
> I can do that in the next iteration if really needed.
> 
>> * Move all of the defines out to a header file
> 
> These defines are related to registers. As I don't want to share these
> registers, is it really necessary to use a header file for them ?
> 
>> * Be more verbose in your documentation / comments
> 
> I can improve the API documentation present in include/mfd/pef2256.h.
> Do you thing that is necessary ? Only a few devices will use this API.
> 
Krzysztof

