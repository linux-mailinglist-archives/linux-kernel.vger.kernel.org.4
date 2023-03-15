Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EC6BAC52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCOJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjCOJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:40:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744FE25E19;
        Wed, 15 Mar 2023 02:40:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v21so9268170ple.9;
        Wed, 15 Mar 2023 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678873247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUmZOl7yFbAslfZae1XifMRIfdwLVM4dYa2IRmn1anc=;
        b=F1xmis1TeCnQy/jxjjr8pdN5VL5T8m8W/j1TYsgoQ+jkFM9vqKXmSowU+KFd0Srn1B
         9oCyfjILS55Kmop2iSme3/7cN9GgCpMJT9VisAF/ghxQqGtIrZcHLhOeObCSSF0YbXab
         9cGhp2pRdC1QOJ3Tv/nB3+cFyEHKX4pZuDjioh4dsCiV9wvngdGIvRnfvGkqL4oM89tx
         Lw63JE3cTiq7/WRTWrUdoDzmAr7GmQfIpmpKEqi/y2kOCyLNG/oCIS9ebIqdT3HoS53g
         U8PUWLz8c27reaCmujybHnPI2BiIRD9fjZZBQ7JrV8fMREjev78R5qdBgGHJB/lBrwTD
         laMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUmZOl7yFbAslfZae1XifMRIfdwLVM4dYa2IRmn1anc=;
        b=HvAFl5W3g17kryxCvEcSyppxVNJ7fkTllP/gS9Vb4ourkbmmTACHqQNyX7kN6v9Z55
         1PYrrS2bp+zslZdzu5PW4j3tvStwhXlQHwIU3vqlZ6MfwRyox488L4IgggU21MkVvs1G
         d+lYqz95SnGvn+NzQuG1mkNgN9chq2N5KtzfZnapBYDW/o5Hg4BW7sUuo4oV5txCGCZu
         KUiC3l5ZmrjdcEo/uLdy3uBoDgzzZoqZi7uqE+FwwWMPX05N6h6/nq6OFnxwy4i9904I
         uYSXNScDPKHmis5/cgztQX4DHUoCmKGbRF4dTx656NNJfwRMT23SrsrVFChY3vYKrSBo
         Y7xQ==
X-Gm-Message-State: AO0yUKXzgG84NHm5a7eEOszjMmmsYh1o1raxy+cjOthqHF/Q2GjsQAJ5
        TXkBtiu0+rsmtNv2UW1BUpY=
X-Google-Smtp-Source: AK7set9gI7Qlayqr5HrVS1HMVK6osS0lsw8VedIc68RBUGWXjUVRi3fZHeq7GFZY8PJw17lUqDVD+Q==
X-Received: by 2002:a17:903:22c5:b0:19e:8452:1944 with SMTP id y5-20020a17090322c500b0019e84521944mr2480130plg.5.1678873246757;
        Wed, 15 Mar 2023 02:40:46 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b001a076b5a193sm1195806plp.145.2023.03.15.02.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:40:46 -0700 (PDT)
Message-ID: <20fc81c9-5517-ce1e-639a-3b425cf27759@gmail.com>
Date:   Wed, 15 Mar 2023 17:40:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-15-ychuang570808@gmail.com> <ZBF1z5Bx9jnrpxox@kroah.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <ZBF1z5Bx9jnrpxox@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Thank you for your review.


On 2023/3/15 下午 03:37, Greg KH wrote:
> On Wed, Mar 15, 2023 at 07:29:01AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>>
>> MA35D1 SoC provides up to 17 UART controllers, each with one uart port.
>> The ma35d1 uart controller is not compatible with 8250.
> A new UART being designed that is not an 8250 compatible?  Why????
>
> Anyway, some minor comments:

This UART controller was designed for over 15 years ago and was used on 
many Nuvoton chips.
The register interface is not compatible with 8250, so the 8250 driver 
cannot be applied, but
the functions are compatible.

>>   drivers/tty/serial/ma35d1_serial.c | 842 +++++++++++++++++++++++++++++
>>   drivers/tty/serial/ma35d1_serial.h |  93 ++++
> Why do you have a .h file for only a single .c file?  Please just put
> them both together into one .c file.

OK, we will put the .h into .c in the next version.

>>   include/uapi/linux/serial_core.h   |   3 +
> Why do you need this #define?  Are you using it in userspace now?  If
> not, why have it?

Actually, we do not use it from userspace. I will remove it in the next 
version.


>> +static void
>> +receive_chars(struct uart_ma35d1_port *up)
> Please just put all one one line.
>

OK, I will fix it.

>> +{
>> +	u8 ch;
>> +	u32 fsr;
>> +	u32 isr;
>> +	u32 dcnt;
>> +	char flag;
>> +
>> +	isr = serial_in(up, UART_REG_ISR);
>> +	fsr = serial_in(up, UART_REG_FSR);
>> +
>> +	while (!(fsr & RX_EMPTY)) {
> You have no way out if the hardware is stuck?  That feels wrong.

Thanks for pointing this out. I will add a timeout check to this 
infinite loop.

>> +static int ma35d1serial_ioctl(struct uart_port *port, u32 cmd, unsigned long arg)
>> +{
>> +	switch (cmd) {
>> +	default:
>> +		return -ENOIOCTLCMD;
>> +	}
>> +	return 0;
>> +}
> You do not need to handle any ioctls?

Yes, we do not handle ioctls.
I will remove both ma35d1serial_ioctl() and "ioctl  = 
ma35d1serial_ioctl," in the next version.


>> +static void ma35d1serial_console_putchar(struct uart_port *port,
>> +					 unsigned char ch)
>> +{
>> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +
>> +	do {
>> +	} while ((serial_in(up, UART_REG_FSR) & TX_FULL));
> Again, no way out if this gets stuck in a loop?

OK, we will fix it in the next version.

>> +/**
>> + *  Suspend one serial port.
>> + */
>> +void ma35d1serial_suspend_port(int line)
>> +{
>> +	uart_suspend_port(&ma35d1serial_reg, &ma35d1serial_ports[line].port);
>> +}
>> +EXPORT_SYMBOL(ma35d1serial_suspend_port);
> Why is this exported?  Who uses it?
>
> And why not EXPORT_SYMBOL_GPL()?
>
>> +
>> +/**
>> + *  Resume one serial port.
>> + */
>> +void ma35d1serial_resume_port(int line)
>> +{
>> +	struct uart_ma35d1_port *up = &ma35d1serial_ports[line];
>> +
>> +	uart_resume_port(&ma35d1serial_reg, &up->port);
>> +}
>> +EXPORT_SYMBOL(ma35d1serial_resume_port);
> Same here, who calls this and why?

The ma35d1serial_suspend_port() and ma35d1serial_resume_port() were used in
previous ARM9 projects for userspace proprietary suspend/resume control.

As it's obsoleted in ma35s1, I will remove these two functions in the 
next version.

>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -279,4 +279,7 @@
>>   /* Sunplus UART */
>>   #define PORT_SUNPLUS	123
>>   
>> +/* Nuvoton MA35D1 UART */
>> +#define PORT_MA35D1	124
> Again, why is this define needed?

As replied above, we will remove the serial_core.h modification from 
this patch.


> thanks,
>
> greg k-h

Best Regards,

Jacky Huang

