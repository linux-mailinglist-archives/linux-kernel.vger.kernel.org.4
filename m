Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4365BC98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjACI7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjACI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:59:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402102DE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:59:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so44780537lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU2+WCtX132tL/fh6bJF3ka2kMaMnHZImYWVwAwJcNg=;
        b=jnXRGe2Jocg1Et6CPXmA0ayhtQyqcs/lFZ9v9hbhDS1roPksNnHbq/UdAYy2DOvag3
         1WOjGyo76716wwQbD2OOBm/yoOZFeF9njwqT+CkoZjMkDpo8+0cxTUR+SQMsLUv8WSyO
         w+Q+AujQ2T4WWSUGOR8+wS5E7H/xMFFsNLUJ7yTk+DCZ/sem9SHuCz1YDHFlIXi6pjLx
         YIz/rXPcStFY4+wx84+xMUGl78EUw/kYa+hvTUj2zdk8//N22qDbpijD676GEArsM6pN
         4oiQzfWe/Dg7AuYLk7Z91jEauegvCS3k6znTJnMMdeeE8qrQHQ70iugxYkeRktkvSCsT
         lBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU2+WCtX132tL/fh6bJF3ka2kMaMnHZImYWVwAwJcNg=;
        b=rKU3IiUr7kjr20+DgSXk/8r02BGimGCkL+sNlWw9EtansgzEPhPji6YWpFzjEPQINJ
         B1ie+Qz6roMc4zgV3sUlqhgX/qSXXIAq9N56w/2rPXw3F/OnWNc1/TXvBkj9yldsxSW5
         WMDhS38D81/W1bIlHtKFQO7uBfmS4gd56WbjkPOq1jKtghshy3f+TbexVjE339E5GRd+
         1ZRdP7EoAtgZCiwdeY/mwsDfhvQd57X0UNBRumuIY+zMQzA5K4WWu5glqalSzG9PkSl1
         v2mUqnE/0DT7LyDkQXDGA5tQZrWkckeqOIaIctxrZDZxvCWE2WyjNWu1DHA4UHhPiNNk
         5AnQ==
X-Gm-Message-State: AFqh2kpNSqfUmjSXmRVlYOj2Xs9bIjpqGZETspwXOAxadvffBA3EQ335
        fUOR+BBNSHzIbU9hUJXSC9G2Xg==
X-Google-Smtp-Source: AMrXdXu9HYqwwCox3GXFGttfDpq2qBsn94BYzOx9Wk/R+XJGEb1EUFh/MBYkFyYmIWneezkJokov3Q==
X-Received: by 2002:a05:6512:e9d:b0:4b5:5476:4c27 with SMTP id bi29-20020a0565120e9d00b004b554764c27mr15897513lfb.43.1672736346664;
        Tue, 03 Jan 2023 00:59:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w5-20020ac24425000000b004cb0256116csm3733546lfl.26.2023.01.03.00.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:59:06 -0800 (PST)
Message-ID: <082eb006-75b8-dead-c014-9ba41a697e50@linaro.org>
Date:   Tue, 3 Jan 2023 09:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Content-Language: en-US
To:     Anup Patel <anup@brainfault.org>, Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <Y3EQ4JU7uGbIMGiW@spud>
 <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 17:50, Anup Patel wrote:
> On Sun, Nov 13, 2022 at 9:14 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> Hey Anup,
>>
>> Ditto the $subject nit here.
> 
> Adding "interrupt-controller:" to subject makes it longer than 80 characters.

Because you added redundant double "bindings". Subject line is precious,
so do not add useless words.


Best regards,
Krzysztof

