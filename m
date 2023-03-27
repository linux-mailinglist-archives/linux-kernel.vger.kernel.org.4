Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362156CA0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjC0KJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjC0KJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:09:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2649F8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:09:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so4853807wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679911752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hw+/RHBhs6qoBuvjwE715wDDIv45tvIt89aqUEaXIH8=;
        b=N3Hr5w5nCaDfzUSpQRCDtPx/Qvsd4Gm+6qfGW2UtaaQSsKN9Pw4QMjzMKwhgZsTn7y
         XhwI5vliTtQdo1E44Wo9dntl87Mv4rcyPrvjrNiZ5mDoElXrOFwYoPjUzEu1nRBQGqOv
         sNNZusonmNapXEyqUqPiMo2jCD3FScrrSEy+7rAEsVVmrQPgj/yGYqmyNZ/RERs3fQTg
         rv8qYaB7igo9EHXclRaHWjlr870TAu9AyDdaRaAaJ7Lh8JznpTVyenVDu5/xiVqZ2gUd
         LU0JgrEPhleHqQkP17BRPq52yP3rRYrVS6N7xwTFrZxYQc5I1Oida6MgeEZmWGkbBlDy
         yL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw+/RHBhs6qoBuvjwE715wDDIv45tvIt89aqUEaXIH8=;
        b=P6rKG7U64aGiKpcVqQGJ/0tJvsZ9TjNcHPJ8NRTOOjmvKFkw0DhtuVvvJ8LOhKJ1jW
         04KaYxDvbHyUSUhIfAZ2gVOakmy/27KGQFx1H/yJCjYBAaaZD8zgImGqSjpcJ7CUdSjN
         RBe5b9GTj0pviUgKWnhtnUobH8EXtJ24cVredjEi6SMNmJqPxjqg+rxfNvm04oqXDspH
         ILOiCFmZlGCcc+7Ha9XfCFrK0D2xhNFn879XPbs5sWsPFpW8d55X5544ArwH6IFIL8lG
         lmvhJfKC6qyxQoBYc4dkYgWAh9ubfrXCXRyAtvmfjuia0pmnM8wmA6rjyBCbyMIHOZJ0
         sk1g==
X-Gm-Message-State: AAQBX9cAs3H9iQKFn11QfcfbbBRNHEZC/r/aoH4XEYKcNjJBxOAngom7
        m6QxsCVmb+IR/E/VvT7CwtW1Cw==
X-Google-Smtp-Source: AKy350bAklOYTUxUxdr7ZG0/oisXLxeuAEwoOFvEmh6uLNgFLQqBGEXCgbCn+KqQuOwgQXmm7IdKFQ==
X-Received: by 2002:a7b:c009:0:b0:3ef:62c6:9930 with SMTP id c9-20020a7bc009000000b003ef62c69930mr5425149wmb.3.1679911752085;
        Mon, 27 Mar 2023 03:09:12 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b003dd1bd0b915sm8402995wmq.22.2023.03.27.03.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:09:11 -0700 (PDT)
Message-ID: <5a72f14d-636d-8328-fc56-23be11c6737c@linaro.org>
Date:   Mon, 27 Mar 2023 11:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/2] mtd: rawnand: stm32_fmc2: do not support EDO mode
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230327094742.38856-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 10:47, Christophe Kerello wrote:

Hi!

> The first patch removes EDO mode support from FMC2 driver as the controller
> does not support the feature and has to be applied on Kernel LTS. The second
> patch uses timings.mode instead of checking tRC_min timing for Kernel next.
> 

Would have been good if you specified that the fix is needed for v5.4+
and that the timings.mode was introduced in v5.8, it would have spared
readers of checking if two patches are really needed. No need to resubmit.

> Changes in v2:
>  - second patch added for Kernel next
> 
> Christophe Kerello (2):
>   mtd: rawnand: stm32_fmc2: do not support EDO mode
>   mtd: rawnand: stm32_fmc2: use timings.mode instead of checking tRC_min
> 
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
