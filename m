Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AE6060F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJTNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJTNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:07:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA415626B;
        Thu, 20 Oct 2022 06:06:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so34298997wrb.13;
        Thu, 20 Oct 2022 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeCQ5sM6HGTlxEz4lb3Se+mlZySzK3kfNds/fHnOdZc=;
        b=Qbw73y6SNk1o/p6Gi96DVqHijWWwGfg9Msc536p4mop7E4RuCRtGF68GHDuH3QQ0tW
         xKKtFUyJESuAa5oWV5EDj5DF2c464eoWRLz3T6gGix1mQpgkgyswlFXskpwtRPnaYoio
         e8lz44ee0XzVbHyTz6Anv0OVyjAdeItXV3McjKffRCcMWImZwiY7TpuRXIeQZXz0+PfF
         dN7JFconqyrTgUhZQQH7IOC1C4aFt4x7VyZ/EHekcTKM7ZN5lniQNBx3d1ZTc6Y2CLnb
         mF7VD4RnUjpgHWMDQtk71ZJtxR5NZC1nbtg3wowq7D1fXR+tb9iugJG5LlxjnCfQxHgP
         KnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeCQ5sM6HGTlxEz4lb3Se+mlZySzK3kfNds/fHnOdZc=;
        b=v/V4F3oW6xFvgjo6em42aTYKZicA5/0fXSs4zCa2EDUZ9JWw/EpFqXWYoIH3QMPip6
         wkOFo7MEyiVm6A/DhIVwRoPJnRzzm3BV/SyLgirSU7OA5zV/nTottgnya2SiH/GocG49
         YIcuV26uygp79ia5oVziSzWspHfzFx6wnlxhuFCbadTyGfhr+pdbHzkjMo0pb40msLV2
         KqJtYwdR2yBZwD/QbDcqsjSjyClnkCieh2WPJ3PtBIJqBQSIVpNirta5HPeitJePOO1R
         Rj96jwQpV2FPfcvuIAKWXq2JkeNzHSi+uQUKZ6zVcj637xKaaaIdgcqlYc5hccWZCsNk
         z0ew==
X-Gm-Message-State: ACrzQf3w3Upv5JB9IlO64Tq6ztsjMpmbrklE4A6v8SQhPncgecgHYtI7
        3ZZMyiE0rKCZfI78RcfO8Le9qCck10E=
X-Google-Smtp-Source: AMsMyM7idGtKU2t7AczziXN6swq29pC2womUhpL3djCn3hPke4vWhZlCP/hheaf7UUsBIlNC0xVtxQ==
X-Received: by 2002:a5d:47cd:0:b0:22e:f98e:3b0b with SMTP id o13-20020a5d47cd000000b0022ef98e3b0bmr8481800wrc.556.1666271216358;
        Thu, 20 Oct 2022 06:06:56 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0022f40a2d06esm16746301wra.35.2022.10.20.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:06:55 -0700 (PDT)
Message-ID: <f1c0b2e1-3de4-ee24-c91a-6be308b69c56@gmail.com>
Date:   Thu, 20 Oct 2022 15:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 11/44] serial: atmel: Use uart_xmit_advance()
Content-Language: fr
To:     Claudiu.Beznea@microchip.com, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-12-ilpo.jarvinen@linux.intel.com>
 <8a47af92-98eb-b2cf-c022-1a1987ff8449@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <8a47af92-98eb-b2cf-c022-1a1987ff8449@microchip.com>
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

Le 20/10/2022 à 11:01, Claudiu.Beznea@microchip.com a écrit :
> On 19.10.2022 12:11, Ilpo Järvinen wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Take advantage of the new uart_xmit_advance() helper.
>>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-By: Richard GENOUD <richard.genoud@gmail.com>

>> ---
>>  drivers/tty/serial/atmel_serial.c | 11 ++---------
>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index bd07f79a2df9..4485f2d26b77 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -875,10 +875,7 @@ static void atmel_complete_tx_dma(void *arg)
>>
>>         if (chan)
>>                 dmaengine_terminate_all(chan);
>> -       xmit->tail += atmel_port->tx_len;
>> -       xmit->tail &= UART_XMIT_SIZE - 1;
>> -
>> -       port->icount.tx += atmel_port->tx_len;
>> +       uart_xmit_advance(port, atmel_port->tx_len);
>>
>>         spin_lock_irq(&atmel_port->lock_tx);
>>         async_tx_ack(atmel_port->desc_tx);
>> @@ -1471,11 +1468,7 @@ static void atmel_tx_pdc(struct uart_port *port)
>>         /* nothing left to transmit? */
>>         if (atmel_uart_readl(port, ATMEL_PDC_TCR))
>>                 return;
>> -
>> -       xmit->tail += pdc->ofs;
>> -       xmit->tail &= UART_XMIT_SIZE - 1;
>> -
>> -       port->icount.tx += pdc->ofs;
>> +       uart_xmit_advance(port, pdc->ofs);
>>         pdc->ofs = 0;
>>
>>         /* more to transmit - setup next transfer */
>> --
>> 2.30.2
>>
> 

Thanks !
