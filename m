Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE076777A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAWJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAWJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:47:02 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6722007
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:46:40 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 203so13996623yby.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xIUym0fwoqVcnwrLqJ1dlH8RrGoqDxVxxRatMQes/zo=;
        b=RIrwFUKSI6+/6BixY/Sn4gTt4tJf6xuoCzVJnDNttT5Q+udEOvN2bgHKspTZfMba7S
         RCIDaCwVUu+rkXHlmp2N9hl9ZTJuqBnvklJRNSRV7So6fwW2X5Pi3bnrCCXlbUk689lJ
         zMrGOlEkBnsfAX0S4+fjy3feuJ7p3+YrYOAfSuxintjQKnYgdUFXNmcbZYwPW30lYiqN
         KQFPd/Xgjw1k6Uc8T6UOY3o0D6kRfjUs8mUKldJjhmNDOjjTs6kMAfXcnPntwHzhR7Zw
         t+0msTOqgEDzTjj0IM0o54sMFks29mL7pJFkATDWWP+M0/9Ds/5buAkXREknfRUNUvT4
         jrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIUym0fwoqVcnwrLqJ1dlH8RrGoqDxVxxRatMQes/zo=;
        b=Txtna/GcyPcw/nDMe0hpwcq5P5fZBJKeoeXoAz6nrfiXbiNrVCxHPdcQ6tCY1ZnaBK
         mzCP/jh2KQGUs+8r5v5r+2+fc/7iMK1kRRR4xnhP+q7Jf/0Pm628QhRM2Yl1AdU3S3/i
         iszBRvWAXQbgzbEgvKk7mVs7Gz0wffdaqB0RqTd6GVXqdX7WvcUScQWMAcSUcwfcJo+0
         p9JsQA9Mq7KReRZ9eA2EqKjk2iaoUhX6gl6MRcUqpn/QBbJ7lVEwbhjW+nSRDpjuw6Vo
         gdfULwP+I8+Hktbz9ft425J1dQuFGVOK1cjpyFTqmmIR8r92vXhkgGCdEBAsVBmzXRwn
         WKkw==
X-Gm-Message-State: AFqh2kpMbwzGL5ZoW8/0/KUbCtSjrcP5RnZXEYWC+ei3mhcGZ7QP7Ylc
        zhxGjKnCVN/xIJHJqhu9YRTRTetpAtAvOzTOexnOKr/qkD7/XsDm
X-Google-Smtp-Source: AMrXdXtHFLlW73/xuckMMv/yxYwQVv1nWZWllzQ5qLA6qr9QRZGiS6Mkz2Jv0QYmNSpT6jxees3XdM6V4SxIwO7jwfw=
X-Received: by 2002:a05:6902:4cc:b0:7ca:f229:4642 with SMTP id
 v12-20020a05690204cc00b007caf2294642mr2772765ybs.233.1674467199574; Mon, 23
 Jan 2023 01:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20230123131818.2785f4e8@canb.auug.org.au>
In-Reply-To: <20230123131818.2785f4e8@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 23 Jan 2023 10:46:28 +0100
Message-ID: <CACMJSevdzO7QuYqQ8B1QoAPC5CUW--+AeDm2dHbf1TGGL0=aMA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 at 03:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> drivers/tty/serial/qcom_geni_serial.c: In function 'setup_fifos':
> drivers/tty/serial/qcom_geni_serial.c:1058:17: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
>  1058 |         if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
>       |                 ^~
> drivers/tty/serial/qcom_geni_serial.c:1059:21: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
>  1059 |                 port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
>       |                     ^~
> drivers/tty/serial/qcom_geni_serial.c:1059:63: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
>  1059 |                 port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
>       |                                                               ^~
> drivers/tty/serial/qcom_geni_serial.c:1062:26: error: 'struct qcom_geni_serial_port' has no member named 'rx_fifo'
>  1062 |                 if (!port->rx_fifo)
>       |                          ^~
>
> Caused by commit
>
>   2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
>
> interacting with commit
>
>   b8caf69a6946 ("tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buffer")
>
> from Linus' tree.
>
> I have applied the following merge fix patch for today (I am not sure
> if it is actually correct, but it builds).
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 23 Jan 2023 13:09:27 +1100
> Subject: [PATCH] tty: fix up for "tty: serial: qcom-geni-serial: add support
>  for serial engine DMA"
>
> interacting with "tty: serial: qcom-geni-serial: fix slab-out-of-bounds
> on RX FIFO buffer".
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index d98e0a8aae7c..61350007bf1c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1055,11 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>         uport->fifosize =
>                 (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>
> -       if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> -               port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
> +       if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> +               port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
>                                               port->rx_fifo_depth * sizeof(u32),
>                                               GFP_KERNEL);
> -               if (!port->rx_fifo)
> +               if (!port->rx_buf)
>                         return -ENOMEM;
>         }
>
> --
> 2.35.1
>
> --
> Cheers,
> Stephen Rothwell

This looks fine and works fine:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
