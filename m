Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E05735BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjFSQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:12:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9182B1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:12:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso40133595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191150; x=1689783150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0/b2EjSkCTg8kSWGnyoY5ofxy0GORXIjVW1oN5fAkI=;
        b=hOrLIhP3eghCi8ZLw5KuAl3EYvGzAwacdIJP8r3PCS8+eO157uGjvOl0mswuigm8i+
         3rWQ4iVLhlnpxk/Ho7ovyZ0ewMaczC27GDpfXoxwkYXAyOj4Rf1tmm6j6zlj33kHuLp/
         nv3BINASFrSa3aEx+PqEDPICI/DnOxY4fFU0PvIR2C5ahPBW5Nr/FVI9rB7k3BCnBB7j
         1EJ9DApUIWAGUguoZ7duFObmn8SNd2WtWGh75XKdVkAXx3x/m4JeApU1bmw4WzQGQTa1
         7snk4W16BWgZgdu8zEnssNTquwTxDF+jkqX9Xb7dtipmQwNeGOzHp3La4kv+BuwkrWgC
         FkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191150; x=1689783150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0/b2EjSkCTg8kSWGnyoY5ofxy0GORXIjVW1oN5fAkI=;
        b=Oj548uXWWseRXTChPwxpQAR1Bxy7v/9APVtI0VheYEy382L4q6sLAhrbEztMm90rWC
         MMS1BAQSW+fy3WmhXJLHH62VF54/VX5YvzqUZ37voPa6ei4SqTOt71Z8/VYlJCG3PYB2
         vuX8L39I2U6qVqvrODSvIUd4hg3iLVkVQvyvE5eIj1w86aiLOC6GIKvZAKMjQ5I0lMkh
         r4vxmZz0ROJZog0OgOudDicjw7/C5yNh2Q6VbdAoR18p++j9pa/mD161UpWFAEI7hJIr
         Bgb+1bI2ktqzDYhTeBy91Ge5qVz7M2YtykFcJm+nuXPHsM++W0KMU2moMcgonLO18xsB
         7GGg==
X-Gm-Message-State: AC+VfDyJv5vk26ifDtGDoJc7qLK5UfqkHJb94M/gaJefk61JDY2VxvA8
        2ZCEwbsT6cdZplRyqRqWT8EBltr9hgI+HIAthwo=
X-Google-Smtp-Source: ACHHUZ7Jius8lE7B9o8DmcK3xv1xBW2j/h8yXk8k2d4mvYFLUUvsMtvnPOG+51chV5CbC9Tj5mrOeA==
X-Received: by 2002:a1c:ed08:0:b0:3f7:f584:5796 with SMTP id l8-20020a1ced08000000b003f7f5845796mr10625015wmh.2.1687191150340;
        Mon, 19 Jun 2023 09:12:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id u23-20020a05600c00d700b003f78fd2cf5esm78197wmm.40.2023.06.19.09.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:12:29 -0700 (PDT)
Message-ID: <a98f4b5b-5656-a960-61d1-a258a1681784@linaro.org>
Date:   Mon, 19 Jun 2023 18:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] clocksource: Add StarFive timer driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230320135433.144832-1-xingyu.wu@starfivetech.com>
 <20230320135433.144832-3-xingyu.wu@starfivetech.com>
 <506c0a1e-a839-c9b7-1b04-7fb3af535fe0@starfivetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <506c0a1e-a839-c9b7-1b04-7fb3af535fe0@starfivetech.com>
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

On 02/06/2023 11:45, Xingyu Wu wrote:
> On 2023/3/20 21:54, Xingyu Wu wrote:
>> Add timer driver for the StarFive JH7110 SoC.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---

[ ... ]

> Hi Daniel and Thomas,
> 
> I have submitted patches for Timer driver. Could you please help to review and give your comments?

You told in the series you will send a new version


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

