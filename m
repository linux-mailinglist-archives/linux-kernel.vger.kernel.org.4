Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5E635EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiKWM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiKWM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:57:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37194A7C;
        Wed, 23 Nov 2022 04:46:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1205716wmp.5;
        Wed, 23 Nov 2022 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LW62Ti7mfshMfxCZUJVluE7umXYJJzUzfDjrUZcXpU=;
        b=VShjlACwmJy3zF3ybErpld9hZR/86uTUySpyCy0LKeYE0xudLRVlE2qDXcGadnzHY5
         pgLxw4WIEuZ0srU3r0FXkFzdXGcJ5nenn56oVh07rXmqmznZejzg7a8hdkW0oN0cqs4E
         vB9cup0ZhxSI+R1OlhQvbj997E4qougSUt+FJ72Wj3Lj/vuBSW1ezWBDb9UVfF8XMUgF
         WoCVO/SLVAWVfCPkzdK/z8UOQnCClUThck9ihzGelfKTELiKjkDhiTqiz9/zus1y0Zhl
         QOBMa7Lmv2B4H9G7f6IyZ/Rw4BLzrWOO8yS9IPgzR6lBC6D/5hT2tSqghzeTwr5hAjXn
         CtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LW62Ti7mfshMfxCZUJVluE7umXYJJzUzfDjrUZcXpU=;
        b=VeWk7a063l6S1bjk9m0otWyi1tvLVbSEdccgx3IlPnAEkJydrD8vCGMX1YngpJAz3C
         KSGKj+tMt0ebmajoiC7q+ikYXvZCEK1lJP0hYoQSpQUnDabQKxTt0pY7sTZJHvDXLMMZ
         UxPB4ah3ru89o9urjfGfPNRpgKcvakD18HQaeE9PUBmTdUUouXXdPQbwyY/oiNV+yKlQ
         nqUlkDoaCDxyrS19mvw0UQLFiMYmfCmhSPMo2kj7qS/9WcL/S0Gz5OnbPSVu7DkA2igg
         Ld2TbZNrbtQWzYcUnslm+1dm5mlxdei1gsD26iysASDhEFk0piLI4l9KcGa1Rzjc94lB
         vVIg==
X-Gm-Message-State: ANoB5pmnPxlA9c6k8UWbSt7I5+DIf/x9W1eHikyHc4Dj0CqzNGctbgbm
        S1Bki8idmVimG4XoV27ut9XePcWHaD0=
X-Google-Smtp-Source: AA0mqf61wJK7TB1tH9sT3E/AjZZ4eV17JPD+famsDd5w3gXU3efvkpaAl3HGbgiV+XnQx7JubXMO9w==
X-Received: by 2002:a05:600c:4e8e:b0:3c6:b7cc:79d2 with SMTP id f14-20020a05600c4e8e00b003c6b7cc79d2mr24289145wmq.42.1669207578715;
        Wed, 23 Nov 2022 04:46:18 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6291000000b0022e66749437sm16623931wru.93.2022.11.23.04.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 04:46:18 -0800 (PST)
Message-ID: <ffb1f40b-bbe8-5431-63cf-a53fc0606971@gmail.com>
Date:   Wed, 23 Nov 2022 13:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] serial: atmel: don't stop the transmitter when doing
 PIO
Content-Language: fr
To:     Michael Walle <michael@walle.cc>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221123082736.24566-1-jirislaby@kernel.org>
 <20221123082736.24566-2-jirislaby@kernel.org>
 <df233ce37626fdb194b583808326d966@walle.cc>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <df233ce37626fdb194b583808326d966@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/11/2022 à 09:50, Michael Walle a écrit :
> Am 2022-11-23 09:27, schrieb Jiri Slaby (SUSE):
>> Writing ATMEL_US_TXDIS to ATMEL_US_CR makes the transmitter NOT to send
>> the just queued character. This means when the character is last and
>> uart calls ops->stop_tx(), the character is not sent at all.
>>
>> The usart datasheet is not much specific on this, it just says the
>> transmitter is stopped. But apparently, the character is dropped. So
>> we should stop the transmitter only for DMA and PDC transfers to not
>> send any more characters. For PIO, this is unexpected and deviates from
>> other drivers. In particular, the below referenced commit broke TX as it
>> added a call to ->stop_tx() after the very last character written to the
>> transmitter.
>>
>> So fix this by limiting the write of ATMEL_US_TXDIS to DMA transfers
>> only.
>>
>> Even there, I don't know if it is correctly implemented. Are all the
>> queued characters sent once ->start_tx() is called? Anyone tested flow
>> control -- be it hard (RTSCTS) or the soft (XOFF/XON) one?
>>
>> Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
>> Cc: Richard Genoud <richard.genoud@gmail.com>
>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Reported-by: Michael Walle <michael@walle.cc>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> 
> Already merged, but:
> Tested-by: Michael Walle <michael@walle.cc>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> 
> Thanks,
> -michael
Thanks !
