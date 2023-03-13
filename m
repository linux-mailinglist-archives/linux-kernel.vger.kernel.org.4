Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2D6B7047
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCMHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:49:42 -0400
X-Greylist: delayed 24263 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 00:49:40 PDT
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160582887A;
        Mon, 13 Mar 2023 00:49:39 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [81.4.110.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZphd4Mp2z4BKKr;
        Mon, 13 Mar 2023 09:49:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678693777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylwn1Cp6/6T+4r8SlPTaUhQ7S+EAODxlXIhjxQcnjyQ=;
        b=MQ/Z0jWkeMcham7PS8bljEgILDJaT+AUzIYNOFzsA0CcQJOOMY4nDP2z+IK84BWva8rOeJ
        QFUCEeAyHgzftht21KClRKtDoOISGiDnAuXprG2zheZT3h3diwVExcIYqk13pJ2dbtFTZt
        kI4RN4C01DxO0NOungY7pEwCNsZnLEAWAGfbX9ezf3tpvDnmzSMdVpkLJkprUrXGI8uXqe
        HZfiR5LVEHhhi4DyfN/j3edqoAYGxntoBBde8fb6QC0ReHsoZtsrM2V3DACRBBHnlwzk0d
        ZekSWnDcck903OMY86OOGFfHwyE8Kqgtq6Z2oxUkURBGKX5DG7heANdUvlMEaw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678693777; a=rsa-sha256;
        cv=none;
        b=tp2HjuI1112YamS0rwbCkDSY6qpMGLN1HYqkOvGql4bk4z0MxXjtjS2mc4/Vr9aK8gUIi1
        bSWB0msFbdzj/rLinWlTFIRB8akYOOnEfrGFeDa7p06OlVko9EWAzBw382TWfgl52wIeoc
        bToH5iIRl5etv3UJvXxYjbL0sMEL3oubfDl5avE3MJ9GV3kgSPE99HTodIXkITZ3VyPDTz
        BJGnIbAem58pRK71ibW0IghkSv9Haz0NaKNfc+0VDdXXq1YrIqp/bi2382gXXwjUOkkYMo
        QcvJb6BVgvYSUytCMCKsgdco/OmQIaJi1bEzgpzkNYvNffWQCoSUZ/7b9pYPzw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678693777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylwn1Cp6/6T+4r8SlPTaUhQ7S+EAODxlXIhjxQcnjyQ=;
        b=R3dTeepsYelnSClYmKa6m/DjQZvSpXszqiTeRh630GYUxiML7EmT0TIy4JQaVgOHogEbEJ
        26LjWi9fXA2r7vNUeg8nMLSmCKcr2eaKb5BsU8haR479P8ff3PuIbmbiLps8A7i5ZKViUp
        qO/bLObvkB+MB94SH8aCsENvmeeshfcj/U5MOB/c7+a1ujiOUub+L7/tX4MaYRC5NSAzsv
        0zuxyg1x141ePenhNjI85FTTMAwNZLof4OSQ2wnIspK2nEuQcVUNBA+UV+ZqqGKeevYykg
        3Qcat8I/mpQPo54bemCjfgVRkf034ih3X1tIrnSPuITVNiyoNQQxlloBg8zcEA==
Received: from [IPV6:2001:14ba:440a:f000::3] (dktgsyyyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::3])
        by dungeon.fi (Postfix) with ESMTPSA id 184213F270;
        Mon, 13 Mar 2023 09:49:35 +0200 (EET)
Message-ID: <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
Date:   Mon, 13 Mar 2023 09:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <ZA7KIs2jA/acpN9n@kroah.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZA7KIs2jA/acpN9n@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 09:00, Greg Kroah-Hartman wrote:
> Nit, your "To:" line was corrupted :(
>
> On Mon, Mar 13, 2023 at 03:04:16AM +0200, Jarkko Sonninen wrote:
>> Add support for RS-485 in Exar USB adapters.
>> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
>> Gpio mode register is set to enable RS-485.
>>
>> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
>> ---
>>   drivers/usb/serial/xr_serial.c | 72 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
>> index fdb0aae546c3..edbb6add087c 100644
>> --- a/drivers/usb/serial/xr_serial.c
>> +++ b/drivers/usb/serial/xr_serial.c
>> @@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
>>   #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
>>   #define XR_GPIO_MODE_SEL_RS485		0x3
>>   #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
>> +#define XR_GPIO_MODE_RS485_TX_H		0x8
>>   #define XR_GPIO_MODE_TX_TOGGLE		0x100
>>   #define XR_GPIO_MODE_RX_TOGGLE		0x200
>>   
>> @@ -237,6 +238,8 @@ static const struct xr_type xr_types[] = {
>>   struct xr_data {
>>   	const struct xr_type *type;
>>   	u8 channel;			/* zero-based index or interface number */
>> +	struct serial_rs485 rs485;
>> +	spinlock_t lock;
>>   };
>>   
>>   static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
>> @@ -629,6 +632,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>>   	struct xr_data *data = usb_get_serial_port_data(port);
>>   	const struct xr_type *type = data->type;
>>   	u16 flow, gpio_mode;
>> +	unsigned long flags, rs485_flags;
>>   	int ret;
>>   
>>   	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
>> @@ -645,9 +649,16 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>>   	/* Set GPIO mode for controlling the pins manually by default. */
>>   	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>>   
>> +	spin_lock_irqsave(&data->lock, flags);
>> +	rs485_flags = data->rs485.flags;
>> +	spin_unlock_irqrestore(&data->lock, flags);
>> +	if (rs485_flags & SER_RS485_ENABLED)
>> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
>> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
>> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>> +
>>   	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
>>   		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
>> -		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>>   		flow = XR_UART_FLOW_MODE_HW;
>>   	} else if (I_IXON(tty)) {
>>   		u8 start_char = START_CHAR(tty);
>> @@ -827,6 +838,64 @@ static void xr_set_termios(struct tty_struct *tty,
>>   	xr_set_flow_mode(tty, port, old_termios);
>>   }
>>   
>> +static int xr_get_rs485_config(struct tty_struct *tty,
>> +			 unsigned int __user *argp)
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +	unsigned long flags;
>> +	struct serial_rs485 rs485;
>> +
>> +	spin_lock_irqsave(&data->lock, flags);
>> +	memcpy(&rs485, &data->rs485, sizeof(rs485));
> Why are you using the stack for this?  Why not directly access the real
> structure instead?  And are you sure you need a lock?  If so, why?

I suppose the lock is not really needed and I'll change this. I was 
unsure about it.

>> +	spin_unlock_irqrestore(&data->lock, flags);
>> +	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);
> dev_dbg() provides __func__ for free, so you never need to provide it
> again.  Just use the +f flag when enabling it from userspace.
>
>> +
>> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int xr_set_rs485_config(struct tty_struct *tty,
>> +			 unsigned long __user *argp)
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +	struct serial_rs485 rs485;
>> +	unsigned long flags;
>> +
>> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);
> Again, no need for __func__.
>
>> +	rs485.flags &= SER_RS485_ENABLED;
>> +	spin_lock_irqsave(&data->lock, flags);
>> +	memcpy(&data->rs485, &rs485, sizeof(rs485));
>> +	spin_unlock_irqrestore(&data->lock, flags);
>> +	xr_set_flow_mode(tty, port, 0);
>> +
>> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int xr_ioctl(struct tty_struct *tty,
>> +					unsigned int cmd, unsigned long arg)
> Very odd indentation, please fix up.
>
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +
>> +	switch (cmd) {
>> +	case TIOCGRS485:
>> +		return xr_get_rs485_config(tty, argp);
>> +	case TIOCSRS485:
>> +		return xr_set_rs485_config(tty, argp);
>> +	}
>> +	return -ENOIOCTLCMD;
> Wrong ioctl return value :(

What is the correct ioctl error return value ?
ENOIOCTLCMD was used in most places in usb serial as an error return.


> thanks,
>
> greg k-h

     - Jarkko

