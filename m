Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6326B64E4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCLKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCLKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:21:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B639B8E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:21:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so37579098edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678616505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1h/w0HfIp0xEemsSqF/agYlc0ey54oyjIBslB0ucKas=;
        b=quXzSnG3FdZOEbXWkvQR9NNCJ4zfohuEgbZ0YJJbsAJm5F1bVEszvCM0KXoxJZa0V3
         Bsst+7x5iYiwY8d6JNS1hP5fy5HVQwVo0fv73AdX/OSCP3xHpbydVHWVNgG45I9ohGqb
         aDtNJQIOEWja5fW+/VpO6q5OzDVUswz6PbXIOuWDvXCrcjN/DhrM4wCLl10paIHdZdil
         tiuc703Gz/WWnnZXBHq0WWy30zqF8O6Sf9UwTHBpNEIyTVi0+/fI1zSN/ptrHITt6bzQ
         4RF9WoRJ/9YWeJOiEjOyBMDv+OGUgYIWbXaeeLCpRrq3SO2irMrIZt5stDBO50Qk27KA
         JIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h/w0HfIp0xEemsSqF/agYlc0ey54oyjIBslB0ucKas=;
        b=jIOuC3C1RAwYtfxNjQ82AvR/z/1wcuHr6dSy18xtqbG4W4IyMilLsFjMzt9hc/0K+Y
         /yXpH0fIMQ4SdWqA0yqNHsxj5Zimw15iCWLK6h4DWTE7/KKG4BuP3UzRYFsxZacPSpxs
         kSAbdpZH6+ZNc+1XfwD0fTaPPNNmjSwWQZ6eU52TfNB9guevRxnWPjzS9D7XoRSQ278r
         goX56hlbWtgkDeh/t3rmIyJL5Q2BFQ9PK9Z8sTY/1PCHzhOXKZvRvxYsD9CVbo6dP+ar
         O/9fMOGMn/SkQSKLjOUcR/Ri7wOS3MOLJfzMALiqlhlk/xkMnpkbc0RbPSWOa9k7fKzK
         etcg==
X-Gm-Message-State: AO0yUKUAHjkVupLNDdhGOxUigVdpArq8XWkNKdJ8c468nQGoZal9f8ju
        3Hg1ajmd4Fy59WmduQOPHHqVWA==
X-Google-Smtp-Source: AK7set86eqo6coYB8MEUcm4PlbowNWUch+/+yYuw9VDE2pQH7ILN4t3SPyWQR5JG7VowXLLBcknOlA==
X-Received: by 2002:a17:906:99c9:b0:8b2:5262:562c with SMTP id s9-20020a17090699c900b008b25262562cmr30315587ejn.34.1678616505285;
        Sun, 12 Mar 2023 03:21:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id t29-20020a50d71d000000b004fb419921e2sm875760edi.57.2023.03.12.03.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:21:44 -0700 (PDT)
Message-ID: <e62cfcf5-e43a-ee14-f290-9004818df839@linaro.org>
Date:   Sun, 12 Mar 2023 11:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] leds: tlc591xx: Mark OF related data as maybe unused
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
 <ZAxnl9zn/IrHMx9S@duo.ucw.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAxnl9zn/IrHMx9S@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 12:35, Pavel Machek wrote:
> On Sat 2023-03-11 12:17:17, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/leds/leds-tlc591xx.c:138:34: error: ‘of_tlc591xx_leds_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

I was thinking you will take it... or the Ack is for Lee then?

Best regards,
Krzysztof

