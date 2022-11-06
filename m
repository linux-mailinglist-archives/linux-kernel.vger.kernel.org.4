Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595261E0E1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKFIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKFIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:35:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993BD139
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:35:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f7so13258333edc.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8VESBKh1KMoZOvtg0ZXq27EnrJxCWZC/qS4aZqyj6E=;
        b=ckK656tMCZn6XdNyIdpwTuvuc78qcLTit148z0817frs3Lu9U8ibpVJOHuwzuhKteo
         KISbgXg6rdFNPl7WKZMr76PxqxzBTQSCcOYHeXz0g7Gmbo7cocxbefWpjjLPxUdIA9+z
         U6pal+7Wo9FJjtgwgXDQRf5ju2KXZ+7KILzbFoWL2j+W8ftA0sFd8QVT7lZJxPh1/pXP
         ubC67zvY85c1uf0+5fOhJG7IteFg2gRmIHY/ru2pwUYuv1NfyON+cRg7xiXHiB4YSy6H
         9L7vkIf1QxylvC+9MTHKE+bZ180Y7lFbfWceDY/QEQJX5B135Z7oUEl43cb7iAW7Vz9Q
         lCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8VESBKh1KMoZOvtg0ZXq27EnrJxCWZC/qS4aZqyj6E=;
        b=w1OIJ1YOfb4bAoviDlkXrBxte1cGwsn+/f9RavnA6UpW0kNJU0kUMfkHTMa/xBOzS5
         tnI6EDZKIu798SBZgceRo5GdafMAbr3vjrEHU8G1njylGEp11b4ecdMatYrQ95W3eCZ8
         KeEf94f/+D4AY0FexusLdawX+iuq0Q99Qr6d4BYyzHk/qvCZD+tVwlh8nXNAYKw6lNNH
         LST/TTYD6/vdq8Oed7NM2WRkpMEaJ1l1Qa7yq6VVwaLKrktLh8p3CZwmFc6S3iqHEYrs
         Wqkhn5gTfa+ctCeUi8MKgcfpmKQQnnx99eeBN9akOjH15tlLntT6A2oVZxwKW69DpLbw
         iMuA==
X-Gm-Message-State: ACrzQf2gTtCbDYLz1jKSiQYIK1d4mVgm+wmy4hSXx4+od5RF0qwWXpqn
        d/s0IxtpkAyYNO70IjGsP6J+fTecWgQ=
X-Google-Smtp-Source: AMsMyM5xQd8XIQIdDn9rJugZguTohqD5xQiQajGEtAeexVP9/CA70pQvYS69d7Z5EXfJhKr4v9a2RA==
X-Received: by 2002:aa7:cf0b:0:b0:461:2271:8559 with SMTP id a11-20020aa7cf0b000000b0046122718559mr44462387edy.92.1667723753732;
        Sun, 06 Nov 2022 01:35:53 -0700 (PDT)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id i28-20020a1709067a5c00b00781dbdb292asm1858629ejo.155.2022.11.06.01.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:35:53 -0700 (PDT)
Message-ID: <f3b1a309-f7bc-a225-90ac-90838a89acfa@gmail.com>
Date:   Sun, 6 Nov 2022 09:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: simplify complex pointer casting
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y2dvmdGxQfmK4O6F@qemulion>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2dvmdGxQfmK4O6F@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 09:26, Deepak R Varma wrote:
> Pointers to structures udphdr and dhcpMessage are derived by casting
> adjacent pointers with size_t. Such typecast of pointer using size_t
> is not preferred. The code looks complex and delicate. Simplify such
> casting by utilizing generic "void *" casting.
> While at this change, remove the unnecessary __be32 casting for member
> variable "cookie".
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index a23f7df373ed..e9b0906d0d74 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -610,13 +610,15 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>   			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
> 
>   			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
> -				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));
> +				struct udphdr *udph = (void *)iph + (iph->ihl << 2);
> 
>   				if ((udph->source == htons(CLIENT_PORT)) &&
>   				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */
> -					struct dhcpMessage *dhcph =
> -						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> +					u32 cookie;
> +					struct dhcpMessage *dhcph;
> +
> +					dhcph = (void *)udph + sizeof(struct udphdr);
> +					cookie = be32_to_cpu(dhcph->cookie);
> 
>   					if (cookie == DHCP_MAGIC) { /*  match magic word */
>   						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
> --
> 2.34.1
> 
> 
> 
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
