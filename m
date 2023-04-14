Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4B6E195B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDNAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDNAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:55:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329826B8;
        Thu, 13 Apr 2023 17:55:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id lh8so3890749plb.1;
        Thu, 13 Apr 2023 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681433734; x=1684025734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpHU9YxApA1ZTwJM58qtSmQ3DAXg++Ijjf/3LEHCZOE=;
        b=SYv+xqmhUKPO/BqQmTHclmV8WG2ugMN6WHnZ5NGCWvDGaeFH3U+WeKkIo7x7qmomjv
         Ej5ZKlARiwjXkH6o8k+/5DGj+yToPFeewRgzDjcXdCWpjBJlWIp+twZlDDJt7R0ZSS6F
         Hun4pA0jUZtE7NUNg/gqSAdFUigLWrxKlPT39cG1bqLzIKlUWQ+c/PZvk1/ilPAKJtqF
         4VIx+4Hjum2TgZCjDCgZtr2LjmWH+h6/queEirWL6SFvEIjjeFDT3gNtQRyvivyZxtjo
         bDh/92nZRtIyFLxrVaFH5/3t1aio8kAfNStIEPu//s4up4//zb2HOkQDMiJYlxSFZtgx
         BFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681433734; x=1684025734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpHU9YxApA1ZTwJM58qtSmQ3DAXg++Ijjf/3LEHCZOE=;
        b=Ae+09IwAjjRGCt0dCTlK0QvFvclB09SVq9v249GHcLt6X3z30zm7qvmoCNAOapQIOu
         hG5dWjg43W0/Ym5cy6fkM3+wl33/QwhydgAKzdyHHfLDcYUOGRlrolycpkULJ4FyJTC2
         uzoHWGdhFuw+AowWBfAka2nFx2Zb4Fptvk05SDC2KNThNlnhj0JLZqDq/Hu9hjXI4Uft
         z204nG3eaDB58hKSyzdmyS21a9MpWT+cLPrykOy7UCbF4MZvU93sh7Z9BjGNiZCumTBR
         N6TmJe3eGQwqXv9roeLA9lWx2+bs2M3cjTSrHSG8wkZUs2oJtdz8kUbW0U/UBRHVPyPZ
         8D6g==
X-Gm-Message-State: AAQBX9dcOg3/nLr7Cd+ZwyZfzYlNknG+Fvc9oTAmk7Pjs8fZn+xblQRR
        RDQ4cGchrulPrLFad+w3vKZkdgPmOJQ=
X-Google-Smtp-Source: AKy350b7ieJJ6BjqKMsXT60jZuiYxBbQoHhNssVmZ6GX2/YBWtkZ4XWybUefT/7qMUJw/a3FDaW0mA==
X-Received: by 2002:a17:90a:fa4f:b0:247:4c7:4d53 with SMTP id dt15-20020a17090afa4f00b0024704c74d53mr3543640pjb.36.1681433734244;
        Thu, 13 Apr 2023 17:55:34 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709028c8400b001a653a32173sm418179plo.29.2023.04.13.17.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 17:55:33 -0700 (PDT)
Message-ID: <41807e8d-b081-6c91-3fc8-f273770ea493@gmail.com>
Date:   Fri, 14 Apr 2023 08:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-5-ychuang570808@gmail.com>
 <874a1e5c-f82e-68d7-3617-042deb928071@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <874a1e5c-f82e-68d7-3617-042deb928071@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/4/14 上午 12:58, Krzysztof Kozlowski wrote:
> On 12/04/2023 07:38, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>> between the reset controller and reset references in the dts.
>> Add documentation to describe nuvoton ma35d1 reset driver.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you do not know the process, here is a short
> explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for acks received on the version
> they apply.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>
> Best regards,
> Krzysztof
>

Thank you for your explanation. I was not aware of the rules for adding 
tags, and it was my mistake.
I thought that it was necessary for the reviewer to proactively add the 
"reviewed-by" tag to the patch
before I could attach the tag. I am glad to collect the past records and 
add the tags and will update
in the next version.


Best regards,
Jacky Huang

