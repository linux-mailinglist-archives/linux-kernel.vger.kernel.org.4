Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D87086A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjERRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjERRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:21:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E35E4E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:21:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7606d460da7so57861639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684430478; x=1687022478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9/hdOKM8lX2kePaytkSkipfgyWUeo7xdLlybv8t5TM=;
        b=h+Xirbwj+0GBnYDqtI4bCJDQLF3Zc0jYgaK5hCkNxwlJaTsFgSC+YUUJVOfz6OwSM1
         CN6no0EGOtdQJPgZJd02uOJsXAZghMzH82aGJmcNUO9p3OHLHV62mMgw46TR7aMCRPy9
         50VqpgA+d+p4Mf4409KjWF1NVJc296iH98xmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430478; x=1687022478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9/hdOKM8lX2kePaytkSkipfgyWUeo7xdLlybv8t5TM=;
        b=W6KIW0sjLuJ6NRBVYbQjiJH/I3PLb+CAkz8RnfrnjdxUCCf9VC5XqukOXM7gwgl5u5
         wj0thhTpxS6Er3GQsNfjUs0DkbEEwFuEVM3kKWWvboJL8F0bg9YbHIPWE1lv7h3pn3+u
         9hYvGr6i63zkc+2AEHmtgn8mwPEOaEQR/NBd3f5aYIhD4dRIMPaRJkHgGe8fnTwgWlHs
         gvDTxTX0fjEKyzDifp7ZeNVoB5YHiiJ1OThsgn14jk6jbMyt1EYIxlyHVSmxpWADYSkx
         CJtOJL0f72Yt882a8z1uo/URFDiXYv+9r0Px7zZ7I71a0VaU8Xbc50FzAwIPOOT95Ub2
         1xPA==
X-Gm-Message-State: AC+VfDxtBAGOb1d6IGNP+qZS+YqwDmLRzPLcx7IseKjyBjH4kH85G6PC
        Dbc8GDKCXtm/n8d+hZ5qqahxF0dguf2JSQh1jeAn8Q==
X-Google-Smtp-Source: ACHHUZ45S+Vkzij49qJjmzvrSW1Ya0R/fwgjB7/Crzw2B7NcN3TVxhe2+rOrVBMN/nXDBFWvzNc+sA==
X-Received: by 2002:a5d:991a:0:b0:763:dbe5:c718 with SMTP id x26-20020a5d991a000000b00763dbe5c718mr7069813iol.4.1684430477991;
        Thu, 18 May 2023 10:21:17 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id v2-20020a05663812c200b0040faf78330asm605809jas.28.2023.05.18.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:21:17 -0700 (PDT)
Date:   Thu, 18 May 2023 11:21:15 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: libps2 - remove special handling of ACK for
 command byte
Message-ID: <ZGZei+KBg+Sn99ZW@google.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
 <20230511185252.386941-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:52:42AM -0700, Dmitry Torokhov wrote:
> When getting unexpected data while waiting for an acknowledgement it does
> not matter what command phase is currently executed, and ps2_handle_ack()
> should indicate that no further processing is needed for the received data
> byte. Remove PS2_FLAG_ACK_CMD and associated handling.
> 
> Note that while it is possible to make ps2_handle_ack (and
> ps2_handle_repsonse) return void, it will be done when the code will be
> converted to common PS/2 interrupt handler later.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/libps2.c | 9 ++-------
>  include/linux/libps2.h       | 1 -
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 764990723847..399cda0d34f5 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -253,9 +253,6 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
>  		for (i = 0; i < receive; i++)
>  			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
>  
> -	/* Signal that we are sending the command byte */
> -	ps2dev->flags |= PS2_FLAG_ACK_CMD;
> -
>  	/*
>  	 * Some devices (Synaptics) peform the reset before
>  	 * ACKing the reset command, and so it can take a long
> @@ -267,9 +264,7 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
>  	if (rc)
>  		goto out_reset_flags;
>  
> -	/* Now we are sending command parameters, if any */
> -	ps2dev->flags &= ~PS2_FLAG_ACK_CMD;
> -
> +	/* Send command parameters, if any. */
>  	for (i = 0; i < send; i++) {
>  		rc = ps2_do_sendbyte(ps2dev, param[i], 200, 2);
>  		if (rc)
> @@ -436,7 +431,7 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
>  		 */
>  		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
>  		ps2dev->flags &= ~PS2_FLAG_WAITID;
> -		return ps2dev->flags & PS2_FLAG_ACK_CMD;
> +		return true;
>  	}
>  
>  	if (!ps2dev->nak) {
> diff --git a/include/linux/libps2.h b/include/linux/libps2.h
> index 53f7e4d0f4b7..193dd53ad18b 100644
> --- a/include/linux/libps2.h
> +++ b/include/linux/libps2.h
> @@ -28,7 +28,6 @@
>  #define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
>  #define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
>  #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
> -#define PS2_FLAG_ACK_CMD	BIT(5)	/* Waiting to ACK the command (first) byte */
>  
>  struct ps2dev {
>  	struct serio *serio;
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
