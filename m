Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A871A0BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjFAOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjFAOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:45:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76791B5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:45:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d44b198baso800465b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685630729; x=1688222729;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YQCK1ZMTPVFC0hNz2XxNwzxBOwp3cgRSfLcJFTQuIw=;
        b=bhlXorxkc0OwCO9A8CEkL7XkwUEZ8Rd6eQz4IrBnSkg6DltVeH7ZCJWRqfdfcbJg5t
         Pohj6fLbTJe+43UPvRIBfQ1asT8QOPC+/u8X2rhwC1fWRnVh26+Wshmi/mSB2zOt1iWI
         n4z52Pf4h27v/YLs+bNSKyFxCI79zfCqHTHbT9FTOswOUEz0TuD5XuIsG8B0/96cR9yP
         Us1mN4BNY8X/UgochW0JWaakbyuAOU9TSwPHLOaX3g9Wax+nHrN4LnLAjZNvlNH7H7fG
         cFdlgnvbkPDGX3VPb4hHBPx26d+/qNziai4yvyEXFOtoI0F12MfLxioeME03HlI8qGGj
         ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630729; x=1688222729;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YQCK1ZMTPVFC0hNz2XxNwzxBOwp3cgRSfLcJFTQuIw=;
        b=QN8LXaLEmZ49i9kjkgp/ao29krv7a0nVTPi8O5w6+Fy/HJyHIRdvCO0hCq/on/U4sJ
         6mc+DYErEeLtwENpmgs7SDF7/ntEkfOWbWfbb6MOjV8ceOaKl06PHQgzpLtDirgW/u9P
         SMSwkez166icZLMg///uofMOyldl5SS4jZHkD0d6pX44+sXNDjtTYnaG5uOxkD1JJE0u
         vCSu7AmcXX/IRX+Xw06ICOeAvnh1DRByV/4eHR3tdBzaH6iRHRY8q291qHXI9Fdx0kbl
         VtEY3LzGQg5atEzZqI+xqtjXvotxk1lt7pWYKXmBgBnxUHamnU/w33lffy1ALfZQwn55
         xTtw==
X-Gm-Message-State: AC+VfDwsIeAy5dZdV3wxOlZQoscgP1COQZCGrowEtv1y753bdkph16/h
        Fys87tKyd3T+AmIvyK7EDhU=
X-Google-Smtp-Source: ACHHUZ7O2iGa9l05hFlijS1IxLyIXHwG4FzzdemSfGIBl8JjJvFoMu9pjmvmoBmbt4Z8n3DASBDWiQ==
X-Received: by 2002:a05:6a00:987:b0:5a8:9858:750a with SMTP id u7-20020a056a00098700b005a89858750amr2567913pfg.13.1685630728567;
        Thu, 01 Jun 2023 07:45:28 -0700 (PDT)
Received: from [172.30.1.35] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b0064358d032a4sm5294132pfn.145.2023.06.01.07.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:45:28 -0700 (PDT)
Message-ID: <20591cc8-8442-b9cb-545e-d5cbca543484@gmail.com>
Date:   Thu, 1 Jun 2023 23:45:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] extcon: Switch i2c drivers back to use .probe()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230530051726.2155461-1-u.kleine-koenig@pengutronix.de>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230530051726.2155461-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 5. 30. 14:17, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> On Mon, May 29, 2023 at 11:48:43PM +0900, Chanwoo Choi wrote:
>> When I tried to apply it, there is conflict for extcon-usbc-tusb320.c
>> extcon-usbc-tusb320.c was already changed to probe_new. 
>> I'd like you to resend it on latest extcon-next branch. Thanks.
> 
> I rebased onto
> git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next.
> (It would have helped a bit if you mentioned the URL, I assume you would
> have found it out more quickly than I did.) The relevant difference is a
> conflict with commit 3adbaa30d973 ("extcon: usbc-tusb320: Unregister
> typec port on driver removal") which added a .remove callback in the
> context.
>

Basically, all merged patch should be discussed on mailing list.
As you mention, I already knew that why conflict happen.

So I replied that you need to rebase it on latest extcon-next
and then ask the resend the patch without conflict. 

Applied it.

Thanks,
Chanwoo Choi

