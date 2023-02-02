Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD41B687B02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjBBLAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjBBLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:00:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416F6CCBE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:00:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v10so1567110edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwqA0bBFdWXpkidocitSvFjFmrRrthZmwzOeQ241hAw=;
        b=aipaeHLyimbrh1xIjYjK59ul9gAgvIOJ2htzisG3cM9E9fQBV4j9HyoWNS9L6ksC+8
         3ojfsravWZC4EKP3hZbJN2NzYSKOU9CdewMmamb/G0tVnZ8zr+J+KQFvwneJ9hyvGC3g
         yKFLProLre67toexwebebS1Ffcsfjm9VbjROVnCnpFILS7rm/9XfLKMKfky/AKMYtTBr
         nV5tBgxlmzoPrSwUB8Q8dJKssXQiiuVneolusJouMWwU2YmPjwH/NK9XB/cIASBFTNU4
         5F7a9H8sg0eCgKiSNNxsy2FV1UNaNz16KOWLBhvBrmYNfZFA7o086Z52L4dfUaLgXbH1
         NZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwqA0bBFdWXpkidocitSvFjFmrRrthZmwzOeQ241hAw=;
        b=2I74/M8f7/hvtXnc6NLSwZk/mSGrgq0/30AMaegCxtVDL2i5+1WBqMBTt7+88Z5vrl
         2LwFRHv4UmnayLgbggxjT7hs3aps1p+U5XyFtTKe6aP1738aBJ66FQ+fJsNuikvcARE+
         elT6JKF6xN8GP87rPaHZ+E82SxY566dUJhL30N1I1YjAlGNUPwgvsXaGlZ69fjLvXNCZ
         HZEZxDa4GrhmeqfS41Faj1ZS/b2JciChOUsC5dgIBFldkVnfV4E9a1d58PkhBv5ZYimp
         hEV6rkhhfWUGllE54Lwkb20tNRctemDUJYJBh/JQ4cHN3MIaxjfTY+CEqgKVKpUpDWPz
         NM0A==
X-Gm-Message-State: AO0yUKUl7WKIll3QOZEcuxbYBmRF+1WvH+iQtNcBZ+kx+c0KIT3b3+9M
        XDjmHjNkx7fM+9aJ8HEs3dRGIA==
X-Google-Smtp-Source: AK7set+lY4LEQD/RMWmnBoE2nzZ+sWoTI4ZajAngUzcOw3CeU/millZuUm/cSZxcpezLou5yUZOWVA==
X-Received: by 2002:a05:6402:2b8a:b0:499:d1ca:6d83 with SMTP id fj10-20020a0564022b8a00b00499d1ca6d83mr5436747edb.2.1675335647543;
        Thu, 02 Feb 2023 03:00:47 -0800 (PST)
Received: from [192.168.2.9] (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7cfd8000000b00495c3573b36sm11183798edy.32.2023.02.02.03.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:00:47 -0800 (PST)
Message-ID: <74f30b27-6999-0f67-48e7-85f0acd19cb9@mind.be>
Date:   Thu, 2 Feb 2023 12:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/2] leds: lp55xx: configure internal charge pump
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202092325.21241-1-maarten.zanders@mind.be>
 <71c9963c-98e3-d90b-116a-68a295feb24a@linaro.org>
Content-Language: en-US
From:   Maarten Zanders <maarten.zanders@mind.be>
In-Reply-To: <71c9963c-98e3-d90b-116a-68a295feb24a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback. V4 has been sent.

On 2/2/23 10:34, Krzysztof Kozlowski wrote:
> On 02/02/2023 10:23, Maarten Zanders wrote:
>> A new option in the devicetree "ti,charge-pump-mode" allows the user to
>> configure the charge pump in a certain mode. The previous implementation
>> was "auto" mode, which remains the default.
>>
>> v1 of the patch implemented a bool to disable the charge pump and had some
>> issues in the yaml binding.
>>
>> v2 implemented all options of the charge pump as a string which was too
>> complex to parse & check.
>>
>> v3 (this version) replaces the string by constants.
> Please resend without ignoring the feedback.
>
> Best regards,
> Krzysztof
>
