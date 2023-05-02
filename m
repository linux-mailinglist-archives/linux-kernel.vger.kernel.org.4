Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C46F45FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjEBOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjEBOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:24:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C597191;
        Tue,  2 May 2023 07:23:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-306342d7668so967294f8f.1;
        Tue, 02 May 2023 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683037437; x=1685629437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfItElVK3b/VLS4J5wK0572UKi844kpJ9g4fvuAZ23g=;
        b=U1xlpkbonMZA1UHiVaKAc3+O86Jbhu+NtZS4LuwiOXhl2iBchXEFPWErADUExIv9IP
         8sL2Kqn7giAmdRn8y0dDeQGgq10XBISvYJy5xoVi8H/mHc6yCYWXZC8frxuuEk1wmYeF
         FIhhNGQDtfULIZ0r/HpOmKBNKnKatHaO3IbQ93UQyZ+PQ7KtR5PN6W6mvoofSir9NZch
         KHgSpIIBssTNwpxN0bhhL4JqkdONzc9eqhlQrOQZ5lmqmmnvn4k6304TfCXCw6ge/JVR
         XImbO8I3twcGwm18nSIKIHd8VJXkIXMtFwBPpvUPhUqd5R4goPZfGZI3JAPmVRxGV+Qu
         8TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037437; x=1685629437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfItElVK3b/VLS4J5wK0572UKi844kpJ9g4fvuAZ23g=;
        b=efsexEEpL48taS/anN77SwR6BKuLEHh5CENnC8+SWzBW2T2RZR4ctspvx1U2HqLJl/
         ZhEecT+j0MJtIzozrkG8qvRkg8bHu+qOuOUN+qMQfFmeiUeInFzVvBVUtPR+qdJq8ipp
         Of7iiDMnRyOxgo6vV7/Op65GDP3uCW+zVh1W9vDWw92kmMGbXSaah2RtR4y/0fFhm9cU
         giqwMvJBx3bS6svGC1/niKfEXfoQlL2VPxPrHB5VMHWXbdltyayFoZZA3+WtSdd4REp/
         Iw3NjExZ12belozKVkhxDvQQM+QciP4ywTIPSCDJHm2eQP2BloNZq4p+CHMMCEpleR1U
         bOrw==
X-Gm-Message-State: AC+VfDzoyia8VjKEsDezoo+oRyajNKVVhOrMPk9N/dSQ6K1qJDYVP4+y
        vjZf2gQN9jGDyOryRNQ+P8s=
X-Google-Smtp-Source: ACHHUZ4vnS5LbIAZPa1gxZd2ymGV28rja7jG4Eb6qXU5MVmFiPH6p1L++UB74M6pF6QGggxbnu89gg==
X-Received: by 2002:a05:6000:110f:b0:306:35fa:202b with SMTP id z15-20020a056000110f00b0030635fa202bmr1937849wrw.6.1683037437253;
        Tue, 02 May 2023 07:23:57 -0700 (PDT)
Received: from [192.168.1.131] (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id a13-20020a056000100d00b003063c130ef1sm147115wrx.112.2023.05.02.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 07:23:56 -0700 (PDT)
Message-ID: <5aaba4d1-f7e2-9d30-5f15-0713f9fc6a8c@gmail.com>
Date:   Tue, 2 May 2023 16:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] dt-bindings: input: cypress,tt21000 - fix
 interrupt type in dts example
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-4-mweigand@mweigand.net> <ZFBYIZc5zKs6dpHF@google.com>
From:   Maximilian Weigand <mweigand2017@gmail.com>
In-Reply-To: <ZFBYIZc5zKs6dpHF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.05.23 02:24, Dmitry Torokhov wrote:
> On Mon, May 01, 2023 at 01:30:07PM +0200, Maximilian Weigand wrote:
>> Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
>> probing issues with the device for the current driver (encountered on
>> the Pine64 PineNote). Basically the interrupt would be triggered before
>> certain commands were sent to the device, leading to a race between the
>> device responding fast enough and the irq handler fetching a data frame
>> from it. Actually all devices currently using the driver already use a
>> falling edge trigger.
> 
> I'd prefer we adjusted the driver to handle level interrupts properly.

Ok, I will have a look at that. Just to be clear: The driver should work
only with level interrupts, or should it optimally support both level
and falling edge triggers?

Thanks and best regards

Maximilian
