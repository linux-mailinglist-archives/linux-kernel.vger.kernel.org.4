Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12F63C5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiK2RAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiK2Q74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:59:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB96D96A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:55:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c15so4954862pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZHZ3xLER05lERGmVtojr5I/PMD3IeMahsWj4IK2BO4=;
        b=FLTqGfw883rvILtX1vl/qcfz1Uk0n8/VtcJ2aZ0sHZFcTaQtSJ7UE2CtgeDaKMfls4
         45iltsi9nBcj+Gh9BuC6PSJh7YBtViexq6xQLKPimOPClsBFkr1ORh2K7uQujzCI2rll
         MeDZIdgeDj9Z9FY73QnYgc7D3YcVfK90kszlBRAdwYla21DuHzGBezFPqAk05eO4xlt/
         +raaZN7pphXcggRvP9rGR2mZB2fhesGTObt5wFziFx955KsqVdWGtzWjsLOkA3dTSdS2
         iIFLIKm7aDmGTWaG2w/wrvgriSo48nNyZDod5ZzuX+fdc3blyx0JbPCKq85ZrcI+C5KK
         2btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZHZ3xLER05lERGmVtojr5I/PMD3IeMahsWj4IK2BO4=;
        b=pbD4+XdHbyLvPP4H7Fov3T/P8UF0a5XeC/gjXwWK96WWLsi4SHwMyYlSmiOf9kZbSS
         HutCfupiCtylFeVsrYJlXEwD7KQ1LGMMk5DvxcgeZXx5/QVg1apXJjBGHOVEiF8P6vO3
         EzNPbIamU4GsTtA/b1XY2EPAlrV6cfr3rcZwxUZlXHr4kW4Mgf5acKmr6kRcYNmjfn1M
         3XqJheinMiwo8tTm/IAK+nFa1U2cfYMkzt1jHa5pP3oKEOPoL9p4H79FWkwOR57cUHmF
         lNGmiwFHBqOybmNSlFY+INBhUTgQqgT/ogRNl9+GoTapiqE1l63wUIA5HVBGOIQf8EIZ
         ZFLw==
X-Gm-Message-State: ANoB5pnKvEbGs9f6YuQsqV0EuDbh2Fz+5UmzLRP2GlCuAgaOTGz5PQ87
        aKwPXdnP+GBxfKL4myRNlobGTQ==
X-Google-Smtp-Source: AA0mqf4zbadJGZLXlVcQk6yMXvQO5BV+w3tjYzjLIuoy8pYCkzrKq7A/sFqwdEXyzNbFUYLr4fSDxw==
X-Received: by 2002:a62:e717:0:b0:572:df9e:d57d with SMTP id s23-20020a62e717000000b00572df9ed57dmr61064060pfh.10.1669740932564;
        Tue, 29 Nov 2022 08:55:32 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b0018997f6fc88sm2234583plc.34.2022.11.29.08.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:55:32 -0800 (PST)
Message-ID: <3faaa168-9802-9773-aa10-ee8ff0447d97@9elements.com>
Date:   Tue, 29 Nov 2022 22:25:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 4/4] hwmon: (max6639) Add pwm support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
 <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
 <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 29-11-2022 10:11 pm, Guenter Roeck wrote:
> On 11/29/22 08:34, Uwe Kleine-König wrote:
>> On Tue, Nov 29, 2022 at 05:11:34PM +0100, Naresh Solanki wrote:
>>> Add pwm support for max6639. Also configure pwm fan speed based on pwm
>>> provided in DT.
>>
>> Did you do anything to resolve the questions I had in reply to v5? If
>> yes, I must have missed it.
I did split the patch to separate dt changes & pwm specific changes.
>>
> 
> I don't see a response to my concerns either, especially regarding fan mode
> (dc vs. pwm) in the bindings. For that reason, I won't even look at the 
> series.

I intend to use max6639 driver but with DT support.
Did additional changes(like using PWM provider) based on feedback I 
received.

> 
> Guenter
> 
>> Note that maintainer time is scarce and with sending new versions of a
>> patch with no sign that you improved in the aspects that were critized
>> before, you're burning that scarce time and loosing the good will of the
>> responsible maintainers.
>>
>> Best regards
>> Uwe
>>
> 
Regards,
Naresh
