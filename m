Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC269BB87
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBRTLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBRTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:11:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B71555A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:11:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z7so2441113edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGzk4u2LaXho6Aee+OsMi1UnXx5jEaEJVgW+Rl2vmw4=;
        b=Dt320SEZ8fQgLJL4IXIzora99cbuv9QlQdJnmpooVINwirf+jvE3zrfWpVucw3MK5j
         sC0219XnPgRKu8gisjn9a1vt8nObnT2HzOg8M6oVhODEdjxy1nAG9PP2VC8gvzWc2G6s
         +SnHP9AGfzhYkf5tBHBxc6+HANWMbP+KlSfcuLDW7Yit4CjPwrXUWLeHoKGjZoG6GOQP
         ilWXtVfUPqC7P+bN7+7IRKfqcIp5B1Keg+3at9kPP84fl6T8pIUAb3Qjh5EC3Ti6B2xq
         buh+OotRiEczU6d+sviHYVvAaWlRt2m8arOAidCBGEOst74BZfvA7nS4J++VsJwVTqCc
         bIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGzk4u2LaXho6Aee+OsMi1UnXx5jEaEJVgW+Rl2vmw4=;
        b=sYrkLB1/vyxt24u4fktQFpWa4mo268JdnxSSsJsesMSl3Kk5gxr/i5FjPRUfwXluX3
         R/q/kiWF+ZT9YxZl4TfErbnNxN+EN0B8ePn4wdJr5NMt9xm8YlPsEH0UvnZHGgeyAJUB
         HbLKrfXEr9wfxpxMiITONpjtWs3/PAEr9brOvHv3JtuUekFTr3/AHuB5Eh+5k7CWVy1P
         gaPXsihH7udgkiU5h2E4ubPjbdigUt80bmYc7HheUl+yhrq5Clg1uIHdFgdbxwG+4Rb6
         9f4CyNPj28r/tMbEGxD44YfKTqciw3AbPbYPx2szG7FOqfo3gCssJurAkcZRZWSRzcUR
         KGSw==
X-Gm-Message-State: AO0yUKVJACxXLdshpsVqcjQXb5KKgI0OA+ymmlMOPve2OPkDJD1QMoEc
        wHExY2ukmyvSihewJy3SgNo=
X-Google-Smtp-Source: AK7set+19pqr8/y9ubNSplyC7cf7XHx6hU2Vu2cNjGAXjaba5cU+//XkQwnFU53KyDoTDs9e/vKLzw==
X-Received: by 2002:a05:6402:34d5:b0:4ab:dde:dea7 with SMTP id w21-20020a05640234d500b004ab0ddedea7mr1028667edc.2.1676747464376;
        Sat, 18 Feb 2023 11:11:04 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y102-20020a50bb6f000000b004acb3026af2sm3960958ede.59.2023.02.18.11.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 11:11:03 -0800 (PST)
Message-ID: <5de7b776-4fbe-f6f8-ffa9-fdef337c9c20@gmail.com>
Date:   Sat, 18 Feb 2023 20:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Staging: r8188eu: Fixed block comment
Content-Language: en-US
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org
References: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 08:17, Khadija Kamran wrote:
> Fixed block comment by adding '*' in each line. The Check message was
> shown by using checkpatch.pl script.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index a7c67014dde0..03025dc89533 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -36,15 +36,16 @@
>   #define WAIT_TIME_PPPOE	5	/*  waiting time for pppoe server in sec */
>   
>   /*-----------------------------------------------------------------
> -  How database records network address:
> -	   0    1    2    3    4    5    6    7    8    9   10
> -	|----|----|----|----|----|----|----|----|----|----|----|
> -  IPv4  |type|                             |      IP addr      |
> -  IPX   |type|      Net addr     |          Node addr          |
> -  IPX   |type|      Net addr     |Sckt addr|
> -  Apple |type| Network |node|
> -  PPPoE |type|   SID   |           AC MAC            |
> ------------------------------------------------------------------*/
> + * How database records network address:
> + *	    0    1    2    3    4    5    6    7    8    9   10
> + *	 |----|----|----|----|----|----|----|----|----|----|----|
> + * IPv4  |type|                             |      IP addr      |
> + * IPX   |type|      Net addr     |          Node addr          |
> + * IPX   |type|      Net addr     |Sckt addr|
> + * Apple |type| Network |node|
> + * PPPoE |type|   SID   |           AC MAC            |
> + * ----------------------------------------------------------------
> + */
>   
>   /* Find a tag in pppoe frame and return the pointer */
>   static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned short type)

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
