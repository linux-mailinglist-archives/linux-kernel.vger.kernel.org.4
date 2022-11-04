Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE616194C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKDKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:47:04 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C062A723
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:46:59 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 766FE401A9;
        Fri,  4 Nov 2022 11:46:57 +0100 (CET)
Message-ID: <71ac8750-8a15-4d0c-7b0e-8992b68992cd@somainline.org>
Date:   Fri, 4 Nov 2022 11:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] serial: Fix a typo ("ignorning")
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-serial@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221104103719.2234098-1-j.neuschaefer@gmx.net>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104103719.2234098-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 11:37, Jonathan Neuschäfer wrote:
> Fix the two instances of this typo present in the MSM and VT8500 serial
> drivers.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   drivers/tty/serial/msm_serial.c    | 2 +-
>   drivers/tty/serial/vt8500_serial.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 7dd19a2815794..d9a3aa941427c 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -819,7 +819,7 @@ static void msm_handle_rx(struct uart_port *port)
>   			port->icount.rx++;
>   		}
>
> -		/* Mask conditions we're ignorning. */
> +		/* Mask conditions we're ignoring. */
>   		sr &= port->read_status_mask;
>
>   		if (sr & MSM_UART_SR_RX_BREAK)
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 10fbdb09965f3..37c8a55b48eda 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -168,7 +168,7 @@ static void handle_rx(struct uart_port *port)
>
>   		c = readw(port->membase + VT8500_RXFIFO) & 0x3ff;
>
> -		/* Mask conditions we're ignorning. */
> +		/* Mask conditions we're ignoring. */
>   		c &= ~port->read_status_mask;
>
>   		if (c & FER) {
> --
> 2.35.1
>
