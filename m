Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDD5EDBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiI1LW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI1LWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:22:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C1DCEA2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:22:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso994058wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5r/R/zTIA+UHBL8+NNIn1gm9HIoK0uBpWfJYbDlV8fM=;
        b=rmOlj0O5Gox6voSOmmA5cQZt7ZLl8o7m7KKbOWy5gB6tBqU24bcTnPGTVioXvCwgMu
         gN/ULWyC5rDIEma3ZK+xu239v4SzOq6Hrv6UQxsvLaWFHpSs2PCB1pSQPzKwb3dnG9zz
         Hk2yKnyOvKSI4pbHBVkFXOgF8ReOk5vCmiMMYPpw5KK1XUYARXXKiRelifdisViWSNaT
         onUnmIHDgpFrRTZz+WSYJa5vHO5JT4dae4EU/j9rHvNpp+hhc5ZRcHOpdOqD8gAJbJ+9
         3gRIbMFm7nFXchiK9vGMZOVoqunMdm4x9oRiUj38toeOAm7J/6gTvL9UE/pARnrTQmZz
         IMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5r/R/zTIA+UHBL8+NNIn1gm9HIoK0uBpWfJYbDlV8fM=;
        b=rJ6AkkuNWoX6F4r2rc8KeQ+cjQrhbL3+/scDtrDcZ1NGXkOhUGhH5fsQLxHtwGZgFT
         tX+k9BvHoSdG/TIzip1dax1xKWajpIlOpOAPSfIR0K+3gUtvsCY7B5g61F1GARz5DCBN
         4YOULixdbJEwQuhEdKW3/75uWjvQFbZW2Jssv3tCb7mn5W9xvX3s3FzZs5vdex/Ai3qA
         XEPOZhbWYVE3jKwN9lDk1HF6PfSR8B5QfqJ14jSpBSvvXv/eJ+StUpeSq31SHbNLQjdX
         geb4qiFMFUPddzo2LR8FR4rciT4MewdX43pKl7AvHgtZP99QIJeKf7R173AxLZ5bdcW3
         m6mQ==
X-Gm-Message-State: ACrzQf3Ahq0Nk4zp8Haso6uKw8Mg4W1ayyq8cv6+9dHi3OMNEEZgOKCv
        q/OzNJVCo8IKL4dmyGpo/Fecjw==
X-Google-Smtp-Source: AMsMyM4IRzJUnjS5cjxciVMnT5ISSlNEu4XDbmDM2yNgF1XqotFEavzESCfNxM5yFS42yWqqKYYQ5Q==
X-Received: by 2002:a05:600c:1da8:b0:3b4:8fd6:5132 with SMTP id p40-20020a05600c1da800b003b48fd65132mr6326840wms.99.1664364171921;
        Wed, 28 Sep 2022 04:22:51 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b002253fd19a6asm5093793wro.18.2022.09.28.04.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:22:51 -0700 (PDT)
Message-ID: <c9d2b6b2-6f67-fccd-6e57-844ad1455cdd@linaro.org>
Date:   Wed, 28 Sep 2022 12:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
 <f74a9883-3a9b-8606-b20d-f046835fb827@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <f74a9883-3a9b-8606-b20d-f046835fb827@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 07:53, Krzysztof Kozlowski wrote:
> That's still a bit misleading, because you should also send the patch to
> reviewers and mailing lists. 😄

I can add something along the lines of "and whatever subsystem mailing 
list is called returned by the script"

and leave it to the discretion of the patch sender to determine if they 
want to include LKML or just go straight to the subsystem.

---
bod

