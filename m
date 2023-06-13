Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E272E03D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbjFMK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbjFMK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:58:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17310D4;
        Tue, 13 Jun 2023 03:58:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-662f0feafb2so3927995b3a.1;
        Tue, 13 Jun 2023 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686653918; x=1689245918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g816wKmTzjGrsMqAUO96nczc9ajLi9Tce0NGl/fCFGM=;
        b=Nu8qTTKGvJQqvV1LFAeRfPJhXuBfvDyjaBCqv6/J8ihQx4ErFwpT+047weYG2+iFYa
         lHUm9xjeseq1+ysAJl/Y8C0Vl11j3LrsdANbT9H4oHxCpUhBNggO2orPCLMQgy9/VuKg
         6+gt+nIuugGRZjCmr+fJNT+UmzsOk0YQ2ZpRWZE/ZtbM+6SnH82QRO81oaSRSKXkNzYC
         7Wc0u4omCGYmr12liRAxIqVvNpV9Fm53sn1hSUpaYV/t25MPsE2SqZj1bruTYodjVou+
         l/hINNGMkv6ba6ui+DaBcZXCYlXHJPzfON9UDqdSZ2nBjnS+4dAGuh+61my3+yK6QBN/
         mPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686653918; x=1689245918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g816wKmTzjGrsMqAUO96nczc9ajLi9Tce0NGl/fCFGM=;
        b=fG4BiZ1m0igxTxRtyEbQoqOmIx5q6URIJXpHzqX/8afv6LG8YGWwE6EpGUeftmEbHH
         G05JQvl9jfGcODS7HmQbb25S75HyueOueVsVb90ifangYOjbh9TBDQaQlhWevuSWcNMn
         1eG6RXlCYkd7YdxruTihd1FseujHL5oNGVn0iCu1SSPGoyW0+2emdYBspBzOslueNCdf
         RwxrwPadQlfdTFfk6wJfje3dvDhQY47acTd6Q4TQCP9sPxBEjGd0tsjl9o1sf4FXCFYb
         MCTuh68NAhRgqrV8JQf+gUe30WY1YcfqPH6tEVfXNFr8ruVND4OcKy9yBqAw5NjnfUgi
         ylXQ==
X-Gm-Message-State: AC+VfDzyuR+V7M7fVRa4FOmdpAfVp7YCf11Q8h4Cl6qC/a8+MK1Vbsaq
        A/NUscQuL1a16UrkhQ3u3VPzszvSi4I=
X-Google-Smtp-Source: ACHHUZ7I0b/NZGw98SSO8yJUQN29EI2VL52PVwFx8ph3ohep3LgKkFRLoYXYQg4146/Vf2KJ3gceJQ==
X-Received: by 2002:a05:6a20:3c8d:b0:101:1e75:78e with SMTP id b13-20020a056a203c8d00b001011e75078emr17197706pzj.14.1686653918142;
        Tue, 13 Jun 2023 03:58:38 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s15-20020a65644f000000b00543bfe33fedsm8349191pgv.20.2023.06.13.03.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:58:37 -0700 (PDT)
Message-ID: <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
Date:   Tue, 13 Jun 2023 18:58:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, jirislaby@kernel.org, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023061338-lunchbox-snorkel-e6a9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,


On 2023/6/13 下午 06:28, Greg KH wrote:
> On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>> It supports full-duplex communication, FIFO control, and
>> hardware flow control.
> You get a full 72 columns for your changelog :)
>
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -279,4 +279,7 @@
>>   /* Sunplus UART */
>>   #define PORT_SUNPLUS	123
>>   
>> +/* Nuvoton MA35 SoC */
>> +#define PORT_MA35	124
>> +
> Why is this change needed?  What userspace code is going to rely on it?
>
> thanks,
>
> greg k-h

Because the serial driver requires a port->type, and almost all serial
drivers defined their port type here. We follow the practice of most serial
drivers here.
If we don't do it this way, we would have to directly assign a value to
port->type. However, such modifications were questioned in the past,
which is why we changed it back to defining the port type in serial_core.h.


Best regards,
Jacky Huang




