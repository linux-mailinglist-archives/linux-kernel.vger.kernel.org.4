Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC15B6E81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiIMNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiIMNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:40:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60911811;
        Tue, 13 Sep 2022 06:40:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so11818550plb.13;
        Tue, 13 Sep 2022 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eUQtXPuZOHSInqglcmJWSxEqwzn5y2ZzrqQ8OdSK2T0=;
        b=Ceb3xIAr2sL/UZBNbck+FyPGcQsBsMeQF35+p3tG8m+chky1C+lGAFlndKGqQ2hS2w
         /7HLcrvgGyeI77nQIE/XHQ+zEZcdCM5AZZgYlRehhFOIkR0bxNvzDovmKL+rwL0FODFm
         qKWnHaCP9ohD33oLxHWAfv0KtZa+H4L+vC3T86+E9JboqCbG0bqYAbacD4cR9Y5AUAQ4
         IMCgzlhpkogqM5mqqsBFLyUWB3pgw7cEB5G13p9EFNRu1MPIBXu9fOFW0y0kBUg68TXE
         +3o+I4ewLfrq54ZTp/YV7ICXaWbC2t+yLgk1KxsZ/88cnReVyq5iIVjnNl1mMyK211d9
         pPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eUQtXPuZOHSInqglcmJWSxEqwzn5y2ZzrqQ8OdSK2T0=;
        b=apeOFHMFL3F6e8k5oiPwmo0iLQsuhMgKQHCxPb/VNyWmyv+4OYdQnQBfHPTbkzngCe
         4sPEFMR+XiOkzO8OCHppjckl+rkQ0SkqXE2krzH4zln34fv6qesAMlnu4SAUC2b209hT
         F9wIVjNNnZdhhum9jKVynrGz5lbW48OiTrPMbT8Qu75Sr3L7nJ8Nevam/bJSO5SAufQI
         U45WGFOL+gcrx1iIF5QX0oO4MC8vkAaQ6ozZzByRkKKXLbqRzm8ZP/bwHbkItLVoJkZJ
         rphwGzX4rUYUO4VHcdonW5gQQE/omcNfSH0rJi/MHo8fpSa1FNiAGu0ok5cH+Fqt+6Um
         PNTg==
X-Gm-Message-State: ACgBeo1cV1VhDqNg2POzX9LUMwTUXDcoSZCJ9HWaoR09I8vGltOKD8tY
        Fb2I6UkFxN2nzr+ofMB3Egg=
X-Google-Smtp-Source: AA6agR7qySMkWqn+Gf7rKz7LDsuf0vQYX5MH0BefxVhX3kAZGcxwi6deStq2ydRSQlQr60qgL6gK3g==
X-Received: by 2002:a17:903:41cc:b0:176:d89d:63e3 with SMTP id u12-20020a17090341cc00b00176d89d63e3mr31785941ple.31.1663076409422;
        Tue, 13 Sep 2022 06:40:09 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b005379c1368e4sm8049204pfi.179.2022.09.13.06.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 06:40:09 -0700 (PDT)
Message-ID: <7862b646-9214-3f0c-54d4-6183157f2c2a@gmail.com>
Date:   Tue, 13 Sep 2022 20:40:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation: process/submitting-patches: misspelling
 "mesages"
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, corbet@lwn.net
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Erik Ekman <erik@kryo.se>, Jiri Kosina <jkosina@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tencent_6A928C02229619E8099167DD5CCAA8D8BF0A@qq.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <tencent_6A928C02229619E8099167DD5CCAA8D8BF0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 12:11, Rong Tao wrote:
> Fix spelling mistakes, "mesages" should be spelled "messages".
> 

Hmm... I guess this is [PATCH v2], right?

> -Backtraces in commit mesages
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Backtraces in commit messages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  

The diff looks OK, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
