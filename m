Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948CF687F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBBOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBBOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:12:37 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502238F262
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:12:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mc11so6243031ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36/zgaiJ3vcUE+pkQOajDZH6QDOEpwsWqGv3Wm8E224=;
        b=EK6nadhuEaV8/bpB6M/w+DhVhgMHM/ojZE5vxrq+EfdfFUvwOgIqSH3L4tNKlC6Sd8
         Vmsq7jITSfA0j6gy2KX4epK0gFHegv/hQEabaabFLVQINHSAh0Mbo/qdiZJPd7auchGA
         QJ4kK2sAUqbSwz67zAtZFXDkLZS+jV/azIs7SzeGk0J4Sskz9dOKI+WHFSk19XjK0r7D
         dVJwIXfrT16BBPbtPRwAmtM7rfHpa2g1eE7zVtkZE8S6pQpHi+1nRrax0NDLdCyr4Xy5
         5wggYfsdFL5GwIvN+a2BsphV7pvV6OSl9F+CfTv+i3BGPdS7kL6VJTLKIK7wzCJII1+V
         Inaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36/zgaiJ3vcUE+pkQOajDZH6QDOEpwsWqGv3Wm8E224=;
        b=ElrFOiJwDAhzefmKNFqGzXisCkTnKDkRwF8Z8y+ZBZBnUf1Iom5lsi8+hHXBIUBkfQ
         PKeAK2HfxEQxsXW/4V9QqROUzqARxD5fVfdflCdv8Bmd4gQpKhvZnQ19nN7v98ojhBdk
         L/jKgkFU1GXQqJED1XdZCxtnJxu6NukZq487cMWZOir17nFQ74MkxOVcBV+CeJSHpJnv
         JiqS/kkhWosH9fqd8oi8y3itIrtDD/Pn8ieTbTGxxOh/t2IdJxl+6kPoKjLOwIFZnMZV
         bU42DcgopMtIYe8OKvds3tUKEF2UXzwMMg2OTWQn/AX7u2U0uW4KkljX5v0FyctQ+rbo
         XeJw==
X-Gm-Message-State: AO0yUKWJu0D+s9Cr/8zp6PgtOT23n8+H7hxzvwebSNDiSuSDi2fCODk9
        sLMIOdBErlbd+ZD1TQfCjXeEOg==
X-Google-Smtp-Source: AK7set/C2r51EVGqTuEG/Rb/gzpA5AZ8AYxxnc51SdCQFpqUHRd98fzR5Gq/YRCQIrSCTYVSFIjIZQ==
X-Received: by 2002:a17:906:5e17:b0:882:1b70:8967 with SMTP id n23-20020a1709065e1700b008821b708967mr6633491eju.35.1675347129645;
        Thu, 02 Feb 2023 06:12:09 -0800 (PST)
Received: from [192.168.2.9] (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906d21400b008897858bb06sm5903041ejz.119.2023.02.02.06.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 06:12:08 -0800 (PST)
Message-ID: <fa47912f-ec10-f22b-0447-0b7c998711b3@mind.be>
Date:   Thu, 2 Feb 2023 15:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
 <20eb5589-8287-90bd-3703-2818b61c6ba3@linaro.org>
 <b9c6c74b-65d2-46bf-bd7c-e031d420f31c@mind.be>
 <5fbb6d80-7280-604a-3e1e-4bd98e9776cd@linaro.org>
From:   Maarten Zanders <maarten.zanders@mind.be>
In-Reply-To: <5fbb6d80-7280-604a-3e1e-4bd98e9776cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/23 14:43, Krzysztof Kozlowski wrote:
>
> Strings in DTS are usually easier to for humans to read, but it's not a
> requirement to use them. The problem of storing register values is that
> binding is tied/coupled with hardware programming model, so you cannot
> add a new device if the register value is a bit different (e.g.
> LP55XX_CP_OFF is 0x1). You need entire new binding for such case. With
> string - no need.
I understand and this is why I started with the string in the first 
place (as suggested by yourself in V1).
> With binding constants (IDs) also no need, so was this
> the intention? Just to be clear - it is then ID or binding constant, not
> a value for hardware register.
>
For simplicity sake, yes, now the setting is propagating directly into 
the register as a bit value. But this is how the current implementation 
of the drivers work. If we add a device in the future which indeed has 
different bit mappings, that driver will have to do a mapping of the DT 
binding to its own bit field definitions. I consider this DT binding as 
the "master", which is now conveniently chosen to match the register values.

Cheers,

Maarten
