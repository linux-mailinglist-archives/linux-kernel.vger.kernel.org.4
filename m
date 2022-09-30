Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6671E5F1010
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiI3Qea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiI3Qe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:34:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DBCEE8D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:34:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f11so4998353wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IOj8MIvs6pCG7xXKXbmV7p1W5+v6njgOUPKcDz49m4k=;
        b=pVmL8dBXSm4Lp6ViL6BaGqM6X4qvLQOoRsnv5ZsONOFiz9sOFT3cR4wjyz+mscsiZO
         VKxFdkGCmC4dIgF1lHCPH3HrTI4pCswtJWxBOwt+xRzdBKlG4mF1HDAOD/nxegNgnatE
         hrMIa+shyuZw4T54Q8cSN8hvoHx+qusYAkAtf9vS2FAdF6qWhuiUQbUeTAdXdLh6wnJI
         pP72Qe+odXYi249GEodS8u5Q25iPp29Fc56rR4AYsYYiPro4hXE7WzpUlHgIunKAFdkk
         5EJYWJD9PrTc7MbyzitucOuQ285VB/8J5LpL8I3u5bVm/VejGUHl7vSeELkVgIEvkIOI
         JdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IOj8MIvs6pCG7xXKXbmV7p1W5+v6njgOUPKcDz49m4k=;
        b=iyJjGEDpO6mASagBGkTUFR+54XxB/grWsRoBFI3WIGemrbBwPQ5LTsX6el06Sb4jBd
         c/Hk3myrWd6Wt/bgCNNG80NYLPplqP6cGLG2YhjCRMmPLrT/dljN1vEOjqnf8X6ZrDMC
         OGOZli7G+15Gu7ln/j/cVvvXmD6/zXdGyLUqjYy2bDWBBEKes0HcxSYv77sc5tJrVhYx
         o/RibyRy21EtYIEp15RbmHAEBufOGmwQNUnE9lq04Y6QpCNeGq2LP3qZs5UewdXnlM+V
         mzFdQIUEJmeyfoGr6itV2xmv6rSJcm3p8Bs4XTfEFl5c5Z0l4ZgDUUZ6PsJI2tocm7de
         JxTg==
X-Gm-Message-State: ACrzQf265GtHMvCcZ1Ezy3LM91k1ZUuIVW15s+sFJFqw38GSYAVOzX0o
        e+RE1EdrOf6UEx2zlOZZc8uqeQ==
X-Google-Smtp-Source: AMsMyM4TQSpXmbz8VhmBdk9K2mkV5fYjpfglsjTdDgqWure4FATv6fee5pfir2IJikz/s5pEazZzXw==
X-Received: by 2002:a05:6000:2aa:b0:22b:1dd4:f72d with SMTP id l10-20020a05600002aa00b0022b1dd4f72dmr6898011wry.616.1664555665192;
        Fri, 30 Sep 2022 09:34:25 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm2359777wrz.32.2022.09.30.09.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:34:24 -0700 (PDT)
Message-ID: <2be9c226-fe38-20f3-d620-6ea57d168c33@linaro.org>
Date:   Fri, 30 Sep 2022 17:34:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, tytso@mit.edu
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
In-Reply-To: <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 17:18, Bryan O'Donoghue wrote:
> I guess all you need would be just a short notice along the lines of:
> 
>       "supporter" in the output from get_maintainer.pl means "maintainer
>       of a supported subsystem".
> 
> No?

Ah I see you are suggesting a document not a get_maintainer.pl edit, my 
mistake.

Yes, I'm fine to change the text to something like this if you feel it 
reads better that way.

I'd still appreciate some more eloboration/rationale on what you don't 
like about giving an example.

Is it the example in general you dislike ? Personally I find an example 
a useful thing but, that's just a personal preference.

---
bod
