Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCD6B6502
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCLKmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:42:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170D3D911
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:42:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s11so37738497edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678617765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfveJSvxtF5CnplYNA0fTkHPZzTAq5ne7Bok/0BiFNE=;
        b=t6bjoPKyiiz3d0pvJdWobd6snOKUJNTrA08WBkRylhxxJqxTW2G7Gh0tsxLZW/QhCA
         pR8BQQiKfAJOgDdTaIK1614xCoVmPgs3OsrRPYVLx2wyx5KbLccL/ohgW7k4B1NJ4+iP
         jPg9RJcRsofqF42KKp4P8tuqa/uDsWlU7JFTMhKaDr3O7sUkcPvZbGufe5QU/XD8nSSA
         l1lRTZuDg+aSPTLSfpSnj7UCR4G46TApxNNaZ8JSKMAHgDaJHID5rHzjDHOojKOHiBfx
         BLlUNCPvzFwsyPxxUHaoV+TbH3DjX8A1pE/A+zWO4kO49jmgxXHhYb2W7FiHJhPKFZs8
         useQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678617765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfveJSvxtF5CnplYNA0fTkHPZzTAq5ne7Bok/0BiFNE=;
        b=f13mstEvw9fUzTlQvtMQkanau+kvVYHKxf82OA9GgjxFQqZO+1EAMoC2EwyJct7t0A
         fo+FkgLZ5sgxgGBHDtCvPP+hFvBsKAy3x16GpUsHefnEDtfcxmWHbbwHPnS4eEzDRuYR
         OUq7qk40P9Bpqsc1KLkv7o6hIlOYzJbbiLRbY4GQXpiKwrxS5B9LMNOrUZQRqgauQw/v
         J/gZdP2O5NAltRPi4nq75GsDpfPTtDnF2F/WMJxUnq0csXy6+oUpwMgqoysxoRyZzXIL
         FAMujfcu3MoMROkIWCKy1HWYByndY/MKwQqR0aOzkPYi7bZJTrZf1tNgyQbuV1/57J+V
         Rm0g==
X-Gm-Message-State: AO0yUKVsjxisVWqYHEdxJplTv97RIKEld7kqyiRAK1jVIqF8voHEze7k
        vuWD0pegL7rflMiCN33S3urvcA==
X-Google-Smtp-Source: AK7set+qeZ4bULgnLA+0O/+hrgXfk//CriH/OguEIP5t6ccRDm09zzk4vwsKMJRnB1etv+ucRt7t3Q==
X-Received: by 2002:a17:906:fd8c:b0:8f7:d5c0:c71d with SMTP id xa12-20020a170906fd8c00b008f7d5c0c71dmr39669625ejb.60.1678617765062;
        Sun, 12 Mar 2023 03:42:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id ox29-20020a170907101d00b008e53874f8d8sm2072527ejb.180.2023.03.12.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:42:44 -0700 (PDT)
Message-ID: <aa142690-d534-a7aa-208a-84a3e324573a@linaro.org>
Date:   Sun, 12 Mar 2023 11:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1678558770.495747-1-sleirsgoevy@gmail.com>
 <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
In-Reply-To: <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 11:18, Krzysztof Kozlowski wrote:
> On 11/03/2023 19:15, Sergey Lisov wrote:
>> Some Samsung Exynos boards using the arm64 architecture have DW MMC
>> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
>> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
>> ---
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml   | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> Missing changelog (I did not get cover letter, so no changelog there
> either).

Correction: I see the cover letter, but anyway without changelog :)


Best regards,
Krzysztof

