Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383E16C01FA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCSNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:20:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186313507
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:20:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so37219233edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar1R9+4Me/VMurp1fLp3U5SpNwGcoPZ7zOElSyFmz2I=;
        b=Xb/7/NBknPzIHDY+6GhGmdeMMjxj50m4Hcw32K4k0OVbvddxRXTltldlzfN/XdqcrV
         VoJ2dWdjw+tiID3JvNXa4FWwIjXleUFsq7d3kz2fhCxXHadY3/JFSxag6B7EBiUVsthB
         E9KstruA4PjRAP1etyb3+VzEFcW45lMuKqcZkV80hgEMCdRcIX6GbkoXdPeL9hjkZSdm
         ObfNT/D9xYeLEEgqH3vJo8wOB2KJd3L85XBVZyUcMQo3utK0P7YmAgOvliRL3Qy1U5JP
         semc6dZFLOjepNESmhLb5oOO75BZW2gLcQTgpwxfdVrG/tqvyDjPByzAPPPwR0pCQFQf
         JgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ar1R9+4Me/VMurp1fLp3U5SpNwGcoPZ7zOElSyFmz2I=;
        b=wk7HclvYGjOcjWOnmNDigwUX/Z75EIxpU2EeOHQNemo7rnyT0H17qJsVzorVg3Q0dX
         8ardB1DnkllIuAqMZDmGT84tb0lClP4Oirgvrf/sigQ34EemMsDXsfLMatpvVcRlkRVL
         7RgQNeGEy4XFxAAARV/AefB5Vhiyb6LIcReEQxiU+8CZb816WgbV/EljdrlvdpkQB9c/
         LpkVvV7Jho80bb28KwEY0sEEdnIEoUlxAkRSUksV+HA2KVECMitbEF2QUvTeHiFN/jYx
         SchaOBBKAhDc60eWUEnzA7uDBEr+eQ/S2sqHfCZqzl+gTCjD7yKL6K1XrQT1f+5xiGv3
         QliQ==
X-Gm-Message-State: AO0yUKVwJgCTayVhmTdDA4NkxXLdSj8PAv67F1ld+7YyWT9NAFvll4z7
        IyxXKMeWvzxg8KzAP7dnsu4=
X-Google-Smtp-Source: AK7set/NpR8kXxxtvmVOSZNu6X1LNczUB6SJCXh9Ek5Bw78cpzFWnYUhW6rq+Up7SECfdVjHljESag==
X-Received: by 2002:a17:906:bce1:b0:86f:b99c:ac8d with SMTP id op1-20020a170906bce100b0086fb99cac8dmr5568995ejb.44.1679232032649;
        Sun, 19 Mar 2023 06:20:32 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709060f0f00b009313da4e471sm3241110eji.41.2023.03.19.06.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 06:20:32 -0700 (PDT)
Message-ID: <7ec03abe-40e8-c56d-d178-20e57b859d0c@gmail.com>
Date:   Sun, 19 Mar 2023 15:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: add blank line after struct
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230319114155.42148-1-eng.mennamahmoud.mm@gmail.com>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <20230319114155.42148-1-eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

I am sorry, I resend this patch by mistake. please drop it.

Menna

On ١٩‏/٣‏/٢٠٢٣ ١٣:٤١, Menna Mahmoud wrote:
> add blank line after struct for readability as
> reported by checkpatch script
>
> " CHECK: Please use a blank line after function/struct/union/enum
> declarations"
>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>   drivers/staging/greybus/gbphy.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index d4a225b76338..1de510499480 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,6 +15,7 @@ struct gbphy_device {
>   	struct list_head list;
>   	struct device dev;
>   };
> +
>   #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>   
>   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> @@ -43,6 +44,7 @@ struct gbphy_driver {
>   
>   	struct device_driver driver;
>   };
> +
>   #define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>   
>   int gb_gbphy_register_driver(struct gbphy_driver *driver,
