Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490015F3E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJDIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJDIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:33:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905D02B18A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:33:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c11so20177012wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6iRYJugV682jiUbVOYJtPTK+d3RstALtI/4Pgw0prs8=;
        b=bIl9VSaISoHa48mO28+rtErmA3lP2y0jmAGXmwjOcpR33JY3pAJiyCGVrL5NTBXtoY
         oBSMLzN9FGhg4EEv+jCKpUPwHE5S46dRHqrxXUYF2vTn9aHL0wFLhElz7sXLmfc9Gr1q
         h3UkENSoOS2FYvv0p8QLwhxTmTVC6Gh+RldUitfmpjoqU6GtY1ixvc2vO8UXxiDMjCR1
         ejA5XuOjhPyrhstdowF+P9LIX3h8y+brH05GKZ4qQUJnEOYr53ZnR+9MYKszPUJIQxha
         lV8dHMmvyPo0jSRqv9Wqsieav/FiUTaIHhDOdFMbSeXykikA2jgJdT8oyQyZWyksr3q2
         /zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6iRYJugV682jiUbVOYJtPTK+d3RstALtI/4Pgw0prs8=;
        b=YE69hH+hX4hFWXiyzHLLphObZYqyZ8n2porH91IUPzuji7VfP/8dAflHY7icekQ4Pq
         avvHpEVYOVZh8jy6N+bf9s/Yun4UBui5qeGF9wtrRdMTDReSG2tOAALxt7tjhz89HTMD
         7lkSVYDonFNB2fFT6dZ5JN+Ng9wyJVeK+LanfefuUF8QFFazz5DIjs62J/x5RmjAWOmv
         zF1N9pwvpn89OlR5GEKyZMLxoXYIk21FjuVGjBRcvxyV+/MHrKfTNE/DTlKWqSVJVmY2
         35Qj8F9Z8IG5LaDRiZQuA7jeJ+Oh/AsCxQl5zPJSuTg3B3qYuUJ/6ZbSDNFCL00TrvnE
         sGhQ==
X-Gm-Message-State: ACrzQf1v0PPIqOI+kb1P+kiUxmbnPaES+su/NGzsjGSQ0o8O4JCqOL/5
        Xm6GUzSd5G9mc3y1+vA6ys+hTg==
X-Google-Smtp-Source: AMsMyM55E9Sr8mJ1jN8zlDcQNQ3B3If5m/ZkY0Ha+z/OqtNN4rzsDc1UDt3JeAjkH6cP95Xc/Gph3g==
X-Received: by 2002:a5d:65c6:0:b0:22e:36aa:65be with SMTP id e6-20020a5d65c6000000b0022e36aa65bemr6441642wrw.531.1664872418137;
        Tue, 04 Oct 2022 01:33:38 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q22-20020a1ce916000000b003b56be51313sm14019540wmc.44.2022.10.04.01.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:33:37 -0700 (PDT)
Message-ID: <7df3e367-0dea-9249-222a-5d6c38c8ce26@linaro.org>
Date:   Tue, 4 Oct 2022 09:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND v4 1/2] get_maintainer: Print maintainer for S:
 Supported
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, akiyks@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20221003162411.431774-1-bryan.odonoghue@linaro.org>
 <20221003162411.431774-2-bryan.odonoghue@linaro.org>
 <30776fe75061951777da8fa6618ae89bea7a8ce4.camel@perches.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <30776fe75061951777da8fa6618ae89bea7a8ce4.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 09:02, Joe Perches wrote:
> As it should.
> 
> I think this patch is misguided and do not agree with the concept.
> 
> Either do away with the concept of S: Supported or use it.

Sure, I can simply resend as V5 minus this patch, since the 
documentation change calls out "supporter" - which is FWIW what the 
original proposed patch did, albeit with different wording.

---
bod
