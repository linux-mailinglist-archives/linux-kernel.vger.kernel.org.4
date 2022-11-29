Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC85763C55C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiK2QlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiK2QlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:41:16 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E0760EBC;
        Tue, 29 Nov 2022 08:41:15 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so9474813otl.3;
        Tue, 29 Nov 2022 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQuv/dI7+GsU69YJUbsjnHv/r1JvRmLmHWg4GFC62Y=;
        b=L7jOMrTGpMOy+lvld7IsWy0dUWpLGlaIKFMlqxeozk/84ub6lXWALRtFJ3NjPik7FI
         vgdlQC8ICoCMn0TNuJpLSc+D4nVBz10ty+4KHUrnGuAR9T+5oChkGBe3kkUnGozndJ93
         sw2VsmZw18oIYwEYwcf8GNmBLXtvqp00YIFi8bMe3EhFAiQ00t5LwgXvDYeEWOShb3D+
         bzsRRNFLTUbH65uLlBfgjTgoD5RkRTnlJyB/KgyERPZ7FanbEW5TMFxn9wPChRJb8y/X
         kALHcocJ5sSJKerTOP26eevCGp1t19bConlTAEa4yU/03/38IlbVNtX5vzOdOcIR4R8y
         FYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUQuv/dI7+GsU69YJUbsjnHv/r1JvRmLmHWg4GFC62Y=;
        b=CaArAgT7zv4OvjVJ9j5WCr3uRwS5R3+bPpHgUWR3mcIh0UmLrEqorqJo9Iz2Q4ZX7H
         mh0cC6Nn7TmCoCcZngq3n5OP1YuCHRvvxNhF1G6qaY1va7VZpWzI+ebOR+YGQSBsF/MI
         1OAQcHVYjqfdY2Qs/LLpQagI9x3WgXm/n0STqDZDZdqhjDdQnY/NdqozucxBI/jd8m1/
         3o5z71JOyOkrkaUFIZoLUOiR8W4Kui/SMckayHvdtmo4HuG6BvAdwq/maH52LVqF0Mzn
         SbHhhtFRiZxSsL4LZ7tshVkHkPXJAjHHGpSWpJEDRX1MGYaHI8fSFiXyyBiefsKznWtx
         jFIQ==
X-Gm-Message-State: ANoB5plKQzPty77P6pTc6G9CQW9zBmR16CVoi0YdOCpa0xJNpN8pBrwd
        vFrqj93J05HHyJ5S5cPDuyk=
X-Google-Smtp-Source: AA0mqf69Ahr5oPG1twbq6KsH1O8tbrJgV+O9jh9VMxpGkvLbqylZsFZZ7KO9IUOtBinYNw2M2PoGDA==
X-Received: by 2002:a05:6830:61ce:b0:66c:a613:9843 with SMTP id cc14-20020a05683061ce00b0066ca6139843mr20176039otb.8.1669740074395;
        Tue, 29 Nov 2022 08:41:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cb13-20020a056830618d00b00655ca9a109bsm6114699otb.36.2022.11.29.08.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:41:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
Date:   Tue, 29 Nov 2022 08:41:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 4/4] hwmon: (max6639) Add pwm support
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
 <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 08:34, Uwe Kleine-König wrote:
> On Tue, Nov 29, 2022 at 05:11:34PM +0100, Naresh Solanki wrote:
>> Add pwm support for max6639. Also configure pwm fan speed based on pwm
>> provided in DT.
> 
> Did you do anything to resolve the questions I had in reply to v5? If
> yes, I must have missed it.
> 

I don't see a response to my concerns either, especially regarding fan mode
(dc vs. pwm) in the bindings. For that reason, I won't even look at the series.

Guenter

> Note that maintainer time is scarce and with sending new versions of a
> patch with no sign that you improved in the aspects that were critized
> before, you're burning that scarce time and loosing the good will of the
> responsible maintainers.
> 
> Best regards
> Uwe
> 

