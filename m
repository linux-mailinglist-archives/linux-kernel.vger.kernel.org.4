Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028D5BA700
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIPGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIPGvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:51:49 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09248A3452;
        Thu, 15 Sep 2022 23:51:48 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id u9so47333541ejy.5;
        Thu, 15 Sep 2022 23:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o2XlwjtAMeTt0hvDwIypniSjs/FqCBbvrfmyDdOqbAM=;
        b=2kwgUgjJerMlHg5EzsWXl8nTihkYt01Z6G9arX5luAIbkbvOLuh2XcEC1Y4t2Xynbc
         iLhlopYRJ2kPl5qS/oCfpNiKrv72gIVMJh6HrH3vNTYiSJuIVSg/nKLcnulvIW/t3wr0
         gAE/MXA5WaGHzM8hBcfXadkPeJj7V8pTqqxaqdKWJkhLc7GEIWEC4sWdktZTbAT7gM0a
         Gy/v7K0C8Gd5phVbm6XH7dhDc/NvwPU6dhPpBcuQeXYeP++pj7YCf0vM139oRPStWaDp
         YnG6iSK3rHKxvIghcqvP4ybnBhGuUbdB/cHM+2NlGERfJmT2aHETN5+fOdwqr/nVIq4E
         RpUw==
X-Gm-Message-State: ACrzQf2+9iMhpra17U9FnoWYdSE5sXqDN6+zV5XmonM8PpQ4kxyY75Ff
        wKLfh2M65yM0z4WdQcaD2EA=
X-Google-Smtp-Source: AMsMyM5iW7UVarVL5iG/E0+v1hX4lBgRY2a/z90x2Z+t7+RqWaWqtfScU+gdhk8VoRZjMSPK0b/W+g==
X-Received: by 2002:a17:907:2705:b0:77b:521e:8b5e with SMTP id w5-20020a170907270500b0077b521e8b5emr2614184ejk.260.1663311106598;
        Thu, 15 Sep 2022 23:51:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id gc33-20020a1709072b2100b00731803d4d04sm9865929ejc.82.2022.09.15.23.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 23:51:46 -0700 (PDT)
Message-ID: <6184eded-dcc3-f90d-23ac-cbd534e01c0b@kernel.org>
Date:   Fri, 16 Sep 2022 08:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/5] tty: n_hdlc: remove HDLC_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
 <c31d228302da3f426cebf6fcff855181a5590a66.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <c31d228302da3f426cebf6fcff855181a5590a66.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 09. 22, 3:55, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   Documentation/process/magic-number.rst        |  1 -
>   .../it_IT/process/magic-number.rst            |  1 -
>   .../zh_CN/process/magic-number.rst            |  1 -
>   .../zh_TW/process/magic-number.rst            |  1 -
>   drivers/tty/n_hdlc.c                          | 27 -------------------
>   5 files changed, 31 deletions(-)
> 
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index d47799ba0ca4..fdaa3e4b1953 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -71,7 +71,6 @@ Magic Name            Number           Structure                File
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
>   CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>   MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
> -HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>   DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
>   DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index 24022ab52ebb..1898f98875de 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -77,7 +77,6 @@ Nome magico           Numero           Struttura                File
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
>   CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>   MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
> -HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>   DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
>   DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index 811804996283..911cdaeaf698 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -60,7 +60,6 @@ Linux 魔术数
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
>   CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>   MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
> -HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>   DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
>   DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
> index 8e37e00590f5..ac87f188235f 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -63,7 +63,6 @@ Linux 魔術數
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
>   CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>   MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/net/mkiss.h``
> -HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>   DB_MAGIC              0x4442           fc_info                  ``drivers/net/iph5526_novram.c``
>   DL_MAGIC              0x444d           fc_info                  ``drivers/net/iph5526_novram.c``
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index 94c1ec2dd754..b5aa27051119 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -76,8 +76,6 @@
>    * OF THE POSSIBILITY OF SUCH DAMAGE.
>    */
>   
> -#define HDLC_MAGIC 0x239e
> -
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> @@ -124,7 +122,6 @@ struct n_hdlc_buf_list {
>   
>   /**
>    * struct n_hdlc - per device instance data structure
> - * @magic: magic value for structure
>    * @tbusy: reentrancy flag for tx wakeup code
>    * @woke_up: tx wakeup needs to be run again as it was called while @tbusy
>    * @tx_buf_list: list of pending transmit frame buffers
> @@ -133,7 +130,6 @@ struct n_hdlc_buf_list {
>    * @rx_free_buf_list: list unused received frame buffers
>    */
>   struct n_hdlc {
> -	int			magic;
>   	bool			tbusy;
>   	bool			woke_up;
>   	struct n_hdlc_buf_list	tx_buf_list;
> @@ -200,10 +196,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
>   {
>   	struct n_hdlc *n_hdlc = tty->disc_data;
>   
> -	if (n_hdlc->magic != HDLC_MAGIC) {
> -		pr_warn("n_hdlc: trying to close unopened tty!\n");
> -		return;
> -	}
>   #if defined(TTY_NO_WRITE_SPLIT)
>   	clear_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
>   #endif
> @@ -386,12 +378,6 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
>   
>   	pr_debug("%s() called count=%d\n", __func__, count);
>   
> -	/* verify line is using HDLC discipline */
> -	if (n_hdlc->magic != HDLC_MAGIC) {
> -		pr_err("line not using HDLC discipline\n");
> -		return;
> -	}
> -
>   	if (count > maxframe) {
>   		pr_debug("rx count>maxframesize, data discarded\n");
>   		return;
> @@ -542,9 +528,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
>   
>   	pr_debug("%s() called count=%zd\n", __func__, count);
>   
> -	if (n_hdlc->magic != HDLC_MAGIC)
> -		return -EIO;
> -
>   	/* verify frame size */
>   	if (count > maxframe) {
>   		pr_debug("%s: truncating user packet from %zu to %d\n",
> @@ -609,10 +592,6 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
>   
>   	pr_debug("%s() called %d\n", __func__, cmd);
>   
> -	/* Verify the status of the device */
> -	if (n_hdlc->magic != HDLC_MAGIC)
> -		return -EBADF;
> -
>   	switch (cmd) {
>   	case FIONREAD:
>   		/* report count of read data available */
> @@ -673,9 +652,6 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
>   	struct n_hdlc *n_hdlc = tty->disc_data;
>   	__poll_t mask = 0;
>   
> -	if (n_hdlc->magic != HDLC_MAGIC)
> -		return 0;
> -
>   	/*
>   	 * queue the current process into any wait queue that may awaken in the
>   	 * future (read and write)
> @@ -739,9 +715,6 @@ static struct n_hdlc *n_hdlc_alloc(void)
>   	n_hdlc_alloc_buf(&n_hdlc->rx_free_buf_list, DEFAULT_RX_BUF_COUNT, "rx");
>   	n_hdlc_alloc_buf(&n_hdlc->tx_free_buf_list, DEFAULT_TX_BUF_COUNT, "tx");
>   
> -	/* Initialize the control block */
> -	n_hdlc->magic  = HDLC_MAGIC;
> -
>   	return n_hdlc;
>   
>   }	/* end of n_hdlc_alloc() */

-- 
js
suse labs

