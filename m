Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D144633622
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKVHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiKVHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:45:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310831DDE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:45:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s8so22338425lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4rrJuYa2IECxYwiMtNKNlK59Iea73AY9K3iEfBn864=;
        b=qI9mYP9YrNMrTKAOvaJOh4GRWwwM/3IgTKmSqgVcJmA7D6iSjNZhRAolaPzQoRu+Wp
         lbnrAX7sa8i8vvP5uJ3eI76jX6DYCxXUgSf9nwNTjbokm2DNtvEFBdM6Nb2f/ZBmSqp/
         s/tHvdYJjyyucQGCdSA+MNhfozef7sylRmt16DDk9bsap0MCo0oG1sWZuutDo5oU4jII
         Ttrms9agzxXacQehSTNOaMzT7NdQgybNevGco8tRCfEl8eFfSP7csmS/sBC3ZrO4dmvE
         vu1wuC+2dhgtXJtmgu0NoxtDTk44FG5O5OavksNE8A+D3GF3Xr+rV1wvjYwIXbI+S0K2
         iRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4rrJuYa2IECxYwiMtNKNlK59Iea73AY9K3iEfBn864=;
        b=PNmcdaLTMZQd7O72hu0tbTZfJv4AevRPDRuGJ6Q2oBrHVcT0b3D3L4CsmWzSIQor3j
         Lw0zsn/xH6JNjiZzuQ0K8EzghNElGZdLAAhJg/BJ7qh7t6e5dFb70uH2EJjuXwGm40UT
         G6JSkRW8jhg5J1O9agGyrjPS7Ai6W9dbrwtdz6lDy3mq3WmaKf6F9ma3EfgXy3o98PjD
         YbzQg6SvDzLxz2fDog3t+riArtwpiT5zDAMqSpUGOd3z2tND7XLMo9ExGp2EL//Xr+tk
         lQeAKhKn7+gM6GB5Nlr2M/lOi30C0D6AYFtXVTuQ1CD6xAbyEC7rTLvSHibfx94YQj4v
         wpEQ==
X-Gm-Message-State: ANoB5pmCAy2j5Hl49WpJ11RS9A14otOhlWdH0tchW0DWht2Gaxs2uphj
        tKI0/Jmj+2I2iNfPvJoYzRv4xA==
X-Google-Smtp-Source: AA0mqf7QDPXGNntVFgiI4Zonhd/+zfJ/KN6RfygStEreI1d2N6+3gTxCPRXsuOKpXmIESg3lrt+hUQ==
X-Received: by 2002:a19:4f46:0:b0:49f:5ddb:f8af with SMTP id a6-20020a194f46000000b0049f5ddbf8afmr7239230lfk.184.1669103121908;
        Mon, 21 Nov 2022 23:45:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004a45ed1ae21sm2344717lfr.224.2022.11.21.23.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:45:21 -0800 (PST)
Message-ID: <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
Date:   Tue, 22 Nov 2022 08:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
 <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com>
 <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
 <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
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

On 21/11/2022 21:46, Geert Uytterhoeven wrote:
>> This does not change anything. Herve wrote:
>>
>>> probe some devices (USB host and probably others)
>>
>> Why some can be probed earlier and some not, if there are no
>> dependencies? If there are dependencies, it's the same case with sysctrl
>> touching the register bit and the USB controller touching it (as well
>> via syscon, but that's obvious, I assume).
>>
>> Where is the synchronization problem?
> 
> The h2mode bit (and probably a few other controls we haven't figured out
> yet) in the sysctrl must be set before any of the USB devices is active.
> Hence it's safest for the sysctrl to do this before any of the USB drivers
> probes.

Again, this does not differ from many, many of other devices. All of
them must set something in system controller block, before they start
operating (or at specific time). It's exactly the same everywhere.

Best regards,
Krzysztof

