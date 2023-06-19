Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EEE735954
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjFSOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjFSOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:18:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BDE7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so31967515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687184298; x=1689776298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ieukck4GdWwSOM0IaN03mGrFO4L8fyZjVvjJAy/SMx0=;
        b=oYzRhX1ya6f6fn5I6aEDUIkC5jYo8pYU608smwaiZRhhK7tcA64kp55b4qyytlwDoq
         3EJWVFTd0eJTh/NKlKotIFha0DlXKbs5ct0YM+SSAPRpdwnA0nsPffFgI0nyAuQ8fk5i
         vKPm8mHH+ZSaXyhN+PNbuqq9jTwvmGSnxqRrJywCbbUozXHe1dLCOu4Xn2G1AgGTQME0
         z4mkCobfG13Eyac0U4KXfYeVUwQLIo9TW0gBQOfFirf98W6jpXZmEtYE8vjvzkNe3wiz
         axuAjj21f/ipzKfNJGj7bvFcOqP+FYpqk+VXXX1qdDtNJRFjv83bsXx2BlkRubpx3jbC
         SlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184298; x=1689776298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieukck4GdWwSOM0IaN03mGrFO4L8fyZjVvjJAy/SMx0=;
        b=U7C608rrw4VfaoBzSIJd/uqbzljZImOJ9Y0tgS/lCs3+B3aD9P/803GSi19z3UrZC7
         VMe56xcMXS1zPAfH+DW/8k6Ms4BKZqKPw7nv50jLrcCIqhGIA+v8PjjaWVIjvPu80EKd
         0+b1XGR9q+Muj9n68y/l6oJdMwAtGM/IDrvO9qjiDHvTunjsdePIJ5uexkzovu/EfYtd
         eUWdNNmiCY+XWqOONKQUdBUs7KZ3+fgnWaiDH8ioq2WDYtSMgcWnnz59VVuqLpXd40xC
         /EJheKO3IMDPjI4YvTr9eXwl2DqwsoWjZ3r5UpjFwfoo9vD+ln+vAH6SL+5UFnDWh8Wq
         fQsw==
X-Gm-Message-State: AC+VfDw/1g1GjNx3ozTdIBSY3Sw6Ao8TiTOuR1WtBYJod1oPSqQFc8EL
        8mtf7LLMWdhmK0x9ksxnmk6fFg==
X-Google-Smtp-Source: ACHHUZ4tJdLFvRuZ8bQAyy42JUZNbAYiYwgF8nzZRQw68B7vqKYpWw2z0XDmvVMGn63XuBk4DAZ6qA==
X-Received: by 2002:a05:600c:2104:b0:3f9:988:b77d with SMTP id u4-20020a05600c210400b003f90988b77dmr4260379wml.38.1687184298521;
        Mon, 19 Jun 2023 07:18:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id l23-20020a7bc457000000b003f9b4330880sm1084410wmi.29.2023.06.19.07.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:18:17 -0700 (PDT)
Message-ID: <e146e5d0-e2b8-c1ac-b47e-300b2afaef57@linaro.org>
Date:   Mon, 19 Jun 2023 16:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clocksource: ingenic-timer: Use pm_sleep_ptr() macro
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     list@opendingux.net, linux-kernel@vger.kernel.org
References: <20230618153937.96649-1-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230618153937.96649-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2023 17:39, Paul Cercueil wrote:
> The use of the pm_sleep_ptr() macro allows the compiler to always see
> the dev_pm_ops structure and related functions, while still allowing the
> unused code to be removed, without the need for the __maybe_unused
> markings.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

