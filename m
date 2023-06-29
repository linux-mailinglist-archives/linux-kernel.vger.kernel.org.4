Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A3742901
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjF2PAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjF2PAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:00:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E1730C5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:00:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so903942a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688050845; x=1690642845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETtFCrnQYr6edNt0WVaM+W5aXpK84RAz4fMfEZi0yeQ=;
        b=oOc2PMCKLQtUygz9R3kfuh3OBo1ycIMvWCDG0yarF+iXan9VDs1fISgxu/BMiL3n3s
         XlywPH7WGKhtHOjhCtVVb8BjeclApoFnizZ4k1DfiVTLUchpWepnkM5VfI/qKVkVaVll
         s9P/60YGApZqQbcbMlUcS699RFXKzMIWMsXewzJ2OrTP9q4wNzRYQklEB3q89ktyxzT5
         su5Zjx/F921/hJaBBjQAzA3i9Q23rjif63n6n1dlE9UcHmtw7fh7kqDFwFzqaFPDMQes
         N60ItOvmWi4GXQCov7o14Mz8i1y0BGgD5uz8Q909yshxT4eq0sPixqTaHGCOO7OBybXS
         jqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050845; x=1690642845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETtFCrnQYr6edNt0WVaM+W5aXpK84RAz4fMfEZi0yeQ=;
        b=Icp3aQ7wxZk9BQfKdayrS9vaY66gNabvyLA21U3RNNeDte2+BH1p2DAJ5ADwvb0HGr
         b4MZZrtAI4L6ILq5/QTr31g+f6QlVo0p9mX5BHaTHhL/QvG6ZmqBPlcfOTM3jvudASiU
         fY1+MHyTLxm1xG1s3J0vY/Cz3K4oefHmepQCAibjS0hq5/ZsSVRdEl8IoJq0XhyTJmJc
         KGW2v6k+lid0Gvi1EhoDSPbOlVg1FQhu5A603LGlD03gzX4sMSN0mrzcqn/5cxg00NAD
         2BbD2U7rwPiFCibO6gQWW7b5UIZhOis0eYLEpTvxrczCjavMGZnB/k+3Lom9E5niL896
         sQLA==
X-Gm-Message-State: AC+VfDzkhSOHYcq55RQDdXQtA88zZqzUQl6lMhiubxSusg8IYY+RNSAl
        NkbG8pMC566tOKg7yldMWVFmfw==
X-Google-Smtp-Source: ACHHUZ7/9js9dCjrJ006AuaYMdp1J6y7o8m3P5jVaH9sZtjpFLuE68IHcbd9Php3srq3KjmxaNLpmA==
X-Received: by 2002:a50:ef01:0:b0:51d:adc5:22c1 with SMTP id m1-20020a50ef01000000b0051dadc522c1mr5376300eds.36.1688050845242;
        Thu, 29 Jun 2023 08:00:45 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id v1-20020a056402184100b0050488d1d376sm5864875edy.0.2023.06.29.08.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 08:00:44 -0700 (PDT)
Message-ID: <29968249-3fce-d53f-4515-1c7b815cd4b4@tessares.net>
Date:   Thu, 29 Jun 2023 17:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sysctl: fix unused proc_cap_handler() function warning
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230607120857.3621364-1-arnd@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230607120857.3621364-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 07/06/2023 14:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since usermodehelper_table() is marked static now, we get a
> warning about it being unused when SYSCTL is disabled:
> 
> kernel/umh.c:497:12: error: 'proc_cap_handler' defined but not used [-Werror=unused-function]

Thank you for the patch!

We also hit the same issue on our side after today's sync with Linus'
tree. I confirm this patch fixes the issue.

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I didn't see this patch applied in Luis' sysctl-next branch, do you know
who is taking care of it?

> Just move it inside of the same #ifdef.
> 
> Fixes: e6944e3b75df7 ("sysctl: move umh sysctl registration to its own file")

A small detail: it looks like the SHA has been modified, it should be
861dc0b46432 instead of e6944e3b75df7:

Fixes: 861dc0b46432 ("sysctl: move umh sysctl registration to its own file")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
