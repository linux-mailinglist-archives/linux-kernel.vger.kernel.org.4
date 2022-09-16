Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187605BABEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiIPLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiIPLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:01:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8801120
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:54:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so35394014wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=50kT4WSCwYq/LRrvLhwFs8RTHWYSwsJbzSa3kZ4j5bQ=;
        b=cWmgXPKvCFH38l6xxpFs7vtOrMQ6WS3OeSmBbOHl/18u3ENBQI1dce+9+snxOQk5IT
         YEZImu7L7W4U6DKVjITkSpqWfncblOHwObuWtCCxNWtIE9HkfyZEz6HoekSuqcMiFG4n
         DbYiijQKn+PTZ202HAIBu7QAdePP+svY/f01/IP+DLIy+t+4WXYrNvFjKajj2lXU7I1a
         8RM8DRDOXCYQZNNHyqEg9fXsfySTQA9IvZGWI8/+7E/fg9GFKAWJXJLZpm2TndyY1kTC
         tkkQt1wv8BqpQT8v2YGCndAYf5DiDRLWX5dr+P3fcP36GcHX65+nfIB3IRCHaWKC1Dz1
         SqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=50kT4WSCwYq/LRrvLhwFs8RTHWYSwsJbzSa3kZ4j5bQ=;
        b=zcFl1AoVSbn6jc+wKOVftIxX8q9U1IzVhJ8JpHCSiEBbgxKPax7xNvj6mhRVZfM2Xl
         WrdTE5tQjR2GteVimtYAcs2EWGTNFeUJ/diOU1ZHC4IfTSWFOFwqcK9z63h9nJVwcQ8N
         pUfUf59WVtT7cDnhlVtKMQ+kc7Vv5XjZItgAEqQe+qLVMrwMqYjN6Vx94zJ9/kPRIDuQ
         Xt6AsN6jcRJFAChpDjTSd/JeQWLRxuV6ciYH/fNEMJ6isds9kZbwKOhnSTOPwXEaPcN1
         akPjK4pLYd7Ewb0vFgJBbB/D8V7PjT4heGoihAsHuhUTewOo6bUbZtlcpAVZkn7OG3wD
         Dc0Q==
X-Gm-Message-State: ACrzQf10O6c8Cij2PM5JbMP0M5NRRnCarBGbPXychTy7UvkJMwiOJxvp
        I11eldkYR7VCWw/iZknrT3Hv0g==
X-Google-Smtp-Source: AMsMyM5KeH3ODOLjDZ+5DvUJxRzN9VgYqPm8TdCzCAXPSc7R+xwnk/h2noJ1QunEbdSpiyXrokDJ4A==
X-Received: by 2002:adf:f907:0:b0:22a:6b69:27f3 with SMTP id b7-20020adff907000000b0022a6b6927f3mr2594139wrr.174.1663325648358;
        Fri, 16 Sep 2022 03:54:08 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c26c900b003a3442f1229sm1705275wmv.29.2022.09.16.03.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 03:54:07 -0700 (PDT)
Message-ID: <1b27b135-73c3-07f9-5054-be828b756871@linaro.org>
Date:   Fri, 16 Sep 2022 11:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/2] nvmem: lan9662-otpc: add support
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        UNGLinuxDriver@microchip.com
References: <20220902064540.484967-1-horatiu.vultur@microchip.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902064540.484967-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 07:45, Horatiu Vultur wrote:
> Add support for lan9662 OTP controller that is available on lan9662.
> The driver gives access to non-volatile memory. It allows both write
> and read access to it.
> 

Applied after fixing some conflicts thanks,

--srini
> v4->v5:
> - add reviewed-by tag for patch 1
> - drop the full-stop from subject
> 
> v3->v4:
> - remove lan9668 compatible string from driver
> - fix the bindings by changing the order of entries under items for
>    compatible property
> 
> v2->v3:
> - fix dt-bindings, make sure that make dt_binding_check passes
> - remove lan9662_writel/readl/clrbits/setbits and use writel/readl
> - remove WARN_ON(offset >= OTP_MEM_SIZE) as it can't happen
> 
> v1->v2:
> - remove unneed quotes for $ref: nvmem.yaml#
> - rename lan966x to lan9662 as not to have any wildcards
> - remove compatible string syscon
> 
> Horatiu Vultur (2):
>    dt-bindings: lan9662-otpc: document Lan9662 OTPC
>    nvmem: lan9662-otp: add support
> 
>   .../nvmem/microchip,lan9662-otpc.yaml         |  45 ++++
>   drivers/nvmem/Kconfig                         |   8 +
>   drivers/nvmem/Makefile                        |   2 +
>   drivers/nvmem/lan9662-otpc.c                  | 222 ++++++++++++++++++
>   4 files changed, 277 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
>   create mode 100644 drivers/nvmem/lan9662-otpc.c
> 
