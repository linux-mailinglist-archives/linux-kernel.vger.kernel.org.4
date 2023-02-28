Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559156A5751
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjB1K6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjB1K6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:58:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2CB769
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:58:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so9174752wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677581881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6A2Sc2TLWOMEQ5y9qjHmMZKsT1Mi1qRqi+sfSjfpO0=;
        b=QqHiXL8xz6P0TwObJgri1HUKQUaS8QRVLWP1zU/kcdZdLcOZfuS5LDo0CS5erblAss
         i3mypQ/t5If0PlKVO61jzWGlWmhg5iEbWbVAJTt3c/96K1HPpgFdTgkGsdah4LuMTPwD
         fnCX9JgcR1J9JaLiR8LQCOAqmX0u0Hh/hRjIgiK5GzJp9UlARoRRiba8GJvtAuACohiF
         XCvoPuYjEyVDUWaHz3N/HSDzhCIf0MpsRIZzq9mUHo9ch8t7+BCyvKtKV3vDwWCdAWjW
         hm3QDZr1IgJXPvCyKzLVDXISQaIKaeMJgoaCP4/OgQK0T5wviBJNNPhoAI7f1FICoZbm
         ZqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677581881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6A2Sc2TLWOMEQ5y9qjHmMZKsT1Mi1qRqi+sfSjfpO0=;
        b=EVryy2pHZZHpBdOwJ5V71RV/L+AM5/TI+/9kclJF8aUW8l7LNrh5EXx3B9JHVnFp9P
         Ts4Uepekc/xu6Ux9HxetgFsRwuUBBJ6sxtlY1/fsWPGOGytFb5f7f3YEvhqmgG9XKq/4
         yWYpLJ6e6XSpC+oc5C94egdh4zixmp3BB52dZqO9581jpaQWnYECY/T6gE5cxCAvzgfY
         8QBpEGBkU4atkg+4wgXn7ls9dy5Pc2yw3R7TJcMQcv75XIM77yFpmv75RPQcMhO10UsG
         VoPc+Pfwe08LyPTxFl0iY053AX2R3OR6/snGnkpzITUPVJmH7bBCGY9UimAOck/0lXPY
         YUMA==
X-Gm-Message-State: AO0yUKWFqErcIlTIH+p895JSQlcToBvhATm1cZ6J9TYmox48OypSJdt5
        EAXzoKk9/okupxOZZI3fpPQFGA==
X-Google-Smtp-Source: AK7set9aj//n9rmdyGmH3/dOQnO4mTtlCGyI8o1O6rY/P5ntjM8Tk+WDegjEDx/5j8Gn/DHp/NQNyQ==
X-Received: by 2002:a05:600c:4d20:b0:3eb:2e66:8 with SMTP id u32-20020a05600c4d2000b003eb2e660008mr1731362wmp.35.1677581881467;
        Tue, 28 Feb 2023 02:58:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b003e1f6e18c95sm16244493wmb.21.2023.02.28.02.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:58:01 -0800 (PST)
Message-ID: <545c23f3-1d68-2bff-89d9-584e3ca31044@linaro.org>
Date:   Tue, 28 Feb 2023 11:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
 <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
 <Y/3coFvMWOLaaY9p@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y/3coFvMWOLaaY9p@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 11:51, Conor Dooley wrote:
> On Tue, Feb 28, 2023 at 11:36:49AM +0100, Emil Renner Berthing wrote:
>> On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>> On 2023/2/26 22:14, Emil Renner Berthing wrote:
>>>> On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> 
>>> So the dt-bingdings need to rename, and which one could be better,
>>> 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?
>>
>> Sure, starfive,jh71x0-wdt.yaml sounds good to me.
> 
> I feel like a common comment I see from the dt folks is to not put
> wildcards in filenames & just pick the first compatible.
> I could very well be wrong on that front though...

First compatible is a bit better, unless you are sure this will cover
all such compatibles now and in the future. For many bindings the
family/wildcards were fine in filename.

Best regards,
Krzysztof

