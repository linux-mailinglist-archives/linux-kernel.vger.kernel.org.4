Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052FA687F05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBBNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:43:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D67FA10
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:43:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t18so1767240wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IuSBfwdRJaPAhZzO8F4JMNkHZ9z06+R3aWpV/S9ID8=;
        b=kFS4JafDnLw5OwhranVBljxjUKLv6RW9ovDJDCkfHCLcC9m9Knalx0s7suDgqtvxsQ
         n8srlscOrYfVJZbJWToImGoEA1mUzpXXEg9mmdeBU+JSfyC8oXMW1DrsvrOFNInQC20K
         kvbJkGyN3TMaAgrYZHp4QEPrVT3rNpB2dbegvysETLunrUoI8SAFPdghDepo0xS89eGg
         oDNhLk6/IVPxmxRXFjC3dWbPneUKB73RWmgYHMT7NtWTpLA9SkkXbG6kBZXT/BsBnnnS
         flCnEQPwvKiLTp5ZPn/6gWnS7UAaHSUmcwqtycArNaBliKjvvj8XDjl9k+APCAl8Tl1E
         pbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IuSBfwdRJaPAhZzO8F4JMNkHZ9z06+R3aWpV/S9ID8=;
        b=EiiGBUKJhtpysczUSuMMwHJtaN64fkrQzAP2iNfVZDh2VDpGawzRYC1pG9ntALM5du
         FhRdIoOzLSyEcdmJhS7qnHZxkTYUkZEGpswcG65GCCyZ6zeasAsypzw/1ztq4ciOXho4
         vsndYE4xwvHQuvaI+8tUR7Bp15BONJ4Se8d2Iv85t6Plksz4VKqJWIJPQhRQKJsmZ51j
         gtvsS0lcDtmQe9IJmsK5pbutoxafpseKsFviqSw2/Pjp8+FqdBiUBADIybzZJ1k/ggZv
         Ugzi1d0XIaWOVMThBqKgCTnnRljS2fWi53PSF9of8g/pTle1vaGkhWYcGn+wLKhq4vYi
         wpTQ==
X-Gm-Message-State: AO0yUKXDcPYw+GwLC6wHL7sFFYd3uN+6A4lXIgA4uVGLB8cy/VSJHlUA
        htNRjji3PFPmxU12cZTEc7ZmUQ==
X-Google-Smtp-Source: AK7set/PYZx0K9JVcjwfky3PcFVLTHgC2W+/v/STvIrEFvWO2Jf8TbeCmt8yJbztZxnkD1byfx5FeQ==
X-Received: by 2002:a05:6000:a0f:b0:2bf:afaf:9d71 with SMTP id co15-20020a0560000a0f00b002bfafaf9d71mr6875831wrb.48.1675345421918;
        Thu, 02 Feb 2023 05:43:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r8-20020adfda48000000b002be25db0b7bsm19979573wrl.10.2023.02.02.05.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:43:41 -0800 (PST)
Message-ID: <5fbb6d80-7280-604a-3e1e-4bd98e9776cd@linaro.org>
Date:   Thu, 2 Feb 2023 14:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b9c6c74b-65d2-46bf-bd7c-e031d420f31c@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 14:35, Maarten Zanders wrote:
> First off, bear with me here, I only recently started upstreaming 
> patches to kernel. It still feels like navigating an extremely busy 
> shipping lane... Either way, your feedback is highly valued.
> 
> On 2/2/23 14:15, Krzysztof Kozlowski wrote:
>>
>>> diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
>>> new file mode 100644
>>> index 000000000000..8f59c1c12dee
>>> --- /dev/null
>>> +++ b/include/dt-bindings/leds/leds-lp55xx.h
>>> @@ -0,0 +1,10 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _DT_BINDINGS_LEDS_LP55XX_H
>>> +#define _DT_BINDINGS_LEDS_LP55XX_H
>>> +
>>> +#define LP55XX_CP_OFF		0
>>> +#define LP55XX_CP_BYPASS	1
>>> +#define LP55XX_CP_BOOST		2
>>> +#define LP55XX_CP_AUTO		3
>> Additionally, these are not used, so it's a dead binding. Drop. Sorry,
>> this is not the approach you should take.
>>
>> Best regards,
>> Krzysztof
>>
> These definitions are intended to be used in the DTS's, so it seems 
> normal to me that most of them go unused in the code? What am I missing?

Bindings mean drivers are using them. Your driver is not using it. It's
a register value, isn't it? Register values are not suitable for
bindings. There is no need for them to be in bindings.

> 
> As for the changes v2 > v3, this was based on input I got on v2 from Lee 
> Jones, maintainer for leds, on the implementation of the parsing of this 
> option:
> 
>>> +	pdata->charge_pump_mode = LP55XX_CP_AUTO;
>>> +	ret = of_property_read_string(np, "ti,charge-pump-mode", &pm);
>>> +	if (!ret) {
>>> +		for (cp_mode = LP55XX_CP_OFF;
>>> +		     cp_mode < ARRAY_SIZE(charge_pump_modes);
>>> +		     cp_mode++) {
>>> +			if (!strcasecmp(pm, charge_pump_modes[cp_mode])) {
>>> +				pdata->charge_pump_mode = cp_mode;
>>> +				break;
>>> +			}
>>> +		}
>>> +	}
>> A little over-engineered, no?
>>
>> Why not make the property a numerical value, then simply:
>>
>>    ret = of_property_read_u32(np, "ti,charge-pump-mode", &pdata->charge_pump_mode);
>>    if (ret)
>>            data->charge_pump_mode = LP55XX_CP_AUTO;
> 
> I found examples of similar configuration options of both types with 
> other drivers in the kernel tree (ie string & uint8). I can appreciate 
> both viewpoints but unfortunately cannot comply with both.

Strings in DTS are usually easier to for humans to read, but it's not a
requirement to use them. The problem of storing register values is that
binding is tied/coupled with hardware programming model, so you cannot
add a new device if the register value is a bit different (e.g.
LP55XX_CP_OFF is 0x1). You need entire new binding for such case. With
string - no need. With binding constants (IDs) also no need, so was this
the intention? Just to be clear - it is then ID or binding constant, not
a value for hardware register.

Best regards,
Krzysztof

