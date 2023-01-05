Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25865E76E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAEJNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAEJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:13:01 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 01:12:57 PST
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136B5015E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:12:56 -0800 (PST)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id DMHvpvDoUfraoDMHvpSmyW; Thu, 05 Jan 2023 10:11:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1672909912; bh=+XW3CL00tj+fe55KGNLVJ9XLABIjy2ulWPGGl8Tamdg=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=LWPhJJbuy+S43nfxcJ/MMN4+SNI/f/lN3yLbTqBl5WYZQycdBkI+myI9YMIrpofPA
         zOZx6qYsgXGyjnznreYTg5pVNgbFtKr2DkTSqiPKMdgzsErHuJZ3IO7r49ruiIHW/M
         aBrq/i6IrpKKk2DrTlHFmnP/c10Z3ihe6lb9DlpRsGr+p31n0XbyvUob+SG2T5cVEK
         KhxCuSTtzJKoxn5RjPVqaKM4ptp+Yq4R4Nz99avKW7d78oPW+Q+hkuFmA3UcaIbeRu
         NxgX/ErMjP6kQXte/BMYbB9SY8E8jmRzXf3OStSh+cwarfLponiS7cmradCPtmT2pL
         h0WWuVWZu0oGQ==
Message-ID: <a0bf4ed2-bf68-ff9c-41d1-6fa4634b6911@enneenne.com>
Date:   Thu, 5 Jan 2023 10:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/10] tty/serial: Make
 ->dcd_change()+uart_handle_dcd_change() status bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-9-ilpo.jarvinen@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20230104151531.73994-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGsllanyz1tqYaA47eoQvw8rULIQX0Nnk8AVK9S3VkkeK8U9G/b4+EdHcRA10Jfj8HervvBJ3coUI6AeSJvoiOs129wXh4LAbWCRARepGQYA78X97/Cv
 CkI2kaUH3IMSQizdJfNc4t+DDNlYt7p7n+Jgp2ZyZzI1OMPvsh+BcVK34q6QyOhWYToklEJa9eGL83GDoN5IDeD0Pg/d6cqrW70dIGjCb7MWEKtiXWNc1hz5
 7oxsPH/9k0uoOUv0XexaTq9TlCWI1E4q+JZa3cQwiJF2ENp5J5t5bBkapi/tNRkzjCQrnp8HelpPpKVrzYB7ymQaf3jeGrOom9zmNQPG5MzARa8j3KrMCQ7C
 yNFkG4zuUYv0+yrZsCApSQohDHqR8qMEoeTLVDBj9bhhCIue1d5QXmgosUzxrTwgVj5rluMKh78v/OaFyPN7xG/QnhwuAuBpsDEOb9vyvKAya6IHSJ5nV+zn
 Gzr3JAe60TiFtMuh0UoOZNu9TZz3kfknUfPGDg==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/23 16:15, Ilpo Järvinen wrote:
> Convert status parameter for ->dcd_change() and
> uart_handle_dcd_change() to bool which matches to how the parameter is
> used.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/pps/clients/pps-ldisc.c  | 2 +-

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

>   drivers/tty/serial/serial_core.c | 4 ++--
>   drivers/tty/serial/sunhv.c       | 8 ++++----
>   drivers/usb/serial/generic.c     | 2 +-
>   include/linux/serial_core.h      | 3 +--
>   include/linux/tty_ldisc.h        | 4 ++--
>   include/linux/usb/serial.h       | 2 +-
>   7 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
> index d73c4c2ed4e1..67aee758ac1d 100644
> --- a/drivers/pps/clients/pps-ldisc.c
> +++ b/drivers/pps/clients/pps-ldisc.c
> @@ -13,7 +13,7 @@
>   #include <linux/pps_kernel.h>
>   #include <linux/bug.h>
>   
> -static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
> +static void pps_tty_dcd_change(struct tty_struct *tty, bool status)
>   {
>   	struct pps_device *pps;
>   	struct pps_event_time ts;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 07b4af10a7e9..76536c74e907 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3250,11 +3250,11 @@ EXPORT_SYMBOL(uart_match_port);
>   /**
>    * uart_handle_dcd_change - handle a change of carrier detect state
>    * @uport: uart_port structure for the open port
> - * @status: new carrier detect status, nonzero if active
> + * @status: new carrier detect status, true if active
>    *
>    * Caller must hold uport->lock.
>    */
> -void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
> +void uart_handle_dcd_change(struct uart_port *uport, bool status)
>   {
>   	struct tty_port *port = &uport->state->port;
>   	struct tty_struct *tty = port->tty;
> diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
> index 16c746a63258..7d38c33ef506 100644
> --- a/drivers/tty/serial/sunhv.c
> +++ b/drivers/tty/serial/sunhv.c
> @@ -87,10 +87,10 @@ static int receive_chars_getchar(struct uart_port *port)
>   
>   		if (c == CON_HUP) {
>   			hung_up = 1;
> -			uart_handle_dcd_change(port, 0);
> +			uart_handle_dcd_change(port, false);
>   		} else if (hung_up) {
>   			hung_up = 0;
> -			uart_handle_dcd_change(port, 1);
> +			uart_handle_dcd_change(port, true);
>   		}
>   
>   		if (port->state == NULL) {
> @@ -133,7 +133,7 @@ static int receive_chars_read(struct uart_port *port)
>   				bytes_read = 1;
>   			} else if (stat == CON_HUP) {
>   				hung_up = 1;
> -				uart_handle_dcd_change(port, 0);
> +				uart_handle_dcd_change(port, false);
>   				continue;
>   			} else {
>   				/* HV_EWOULDBLOCK, etc.  */
> @@ -143,7 +143,7 @@ static int receive_chars_read(struct uart_port *port)
>   
>   		if (hung_up) {
>   			hung_up = 0;
> -			uart_handle_dcd_change(port, 1);
> +			uart_handle_dcd_change(port, true);
>   		}
>   
>   		if (port->sysrq != 0 &&  *con_read_page) {
> diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
> index 15b6dee3a8e5..50016ee1026a 100644
> --- a/drivers/usb/serial/generic.c
> +++ b/drivers/usb/serial/generic.c
> @@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(usb_serial_handle_break);
>    * @status: new carrier detect status, nonzero if active
>    */
>   void usb_serial_handle_dcd_change(struct usb_serial_port *port,
> -				struct tty_struct *tty, unsigned int status)
> +				struct tty_struct *tty, bool status)
>   {
>   	dev_dbg(&port->dev, "%s - status %d\n", __func__, status);
>   
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index fd59f600094a..f1b69a36bb2b 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -896,8 +896,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
>    * The following are helper functions for the low level drivers.
>    */
>   
> -extern void uart_handle_dcd_change(struct uart_port *uport,
> -		unsigned int status);
> +extern void uart_handle_dcd_change(struct uart_port *uport, bool status);
>   extern void uart_handle_cts_change(struct uart_port *uport,
>   		unsigned int status);
>   
> diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> index dcb61ec11424..8f4a684973c9 100644
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -170,7 +170,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
>    *	send, please arise a tasklet or workqueue to do the real data transfer.
>    *	Do not send data in this hook, it may lead to a deadlock.
>    *
> - * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, unsigned int status)``
> + * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, bool status)``
>    *
>    *	Tells the discipline that the DCD pin has changed its status. Used
>    *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
> @@ -238,7 +238,7 @@ struct tty_ldisc_ops {
>   	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
>   			       const char *fp, int count);
>   	void	(*write_wakeup)(struct tty_struct *tty);
> -	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
> +	void	(*dcd_change)(struct tty_struct *tty, bool status);
>   	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
>   				const char *fp, int count);
>   	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
> diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
> index c597357853d9..6fa608cb4d98 100644
> --- a/include/linux/usb/serial.h
> +++ b/include/linux/usb/serial.h
> @@ -372,7 +372,7 @@ static inline int usb_serial_handle_break(struct usb_serial_port *port)
>   #endif
>   
>   void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
> -		struct tty_struct *tty, unsigned int status);
> +				  struct tty_struct *tty, bool status);
>   
>   
>   int usb_serial_bus_register(struct usb_serial_driver *device);

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

