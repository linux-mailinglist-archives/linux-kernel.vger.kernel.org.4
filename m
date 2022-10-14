Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471405FF2AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJNQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJNQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:56:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B291CC75F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:56:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y14so11750026ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ycRi29HNGzJsYqIV0PQZFjUg4SSWnYtQKjFXj41VIU=;
        b=q6OUZOBAYpZhF0HMURyGKoC2Dbf8GVUt4hr7xNspUKQlGUEEh5y4L+3ql8om/lrR3R
         JBlA5po0rKArSFNyKfeeuP1roO2Hog+2FibtdZDfUXNtwagGJnQ16t+J/8I0mX8ohAQd
         bsukgtvcc03VC6TVA2ASWsN543lOuWV1TcFNsEh7XRegpmcvlNHFqXk9Ee6jvze2HSMQ
         da5k1z1EenZr1re3UXyYOek2lKN0xIJYe21w4VFAmQ38xriuytucPD3zw6070Z3jZCeK
         q+NqSjaoFy9byj45fmekRO4cgbqBKvi7FXPad29GbX19SB2CwSCPtx4wdmQjHOeAJI7Y
         a09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ycRi29HNGzJsYqIV0PQZFjUg4SSWnYtQKjFXj41VIU=;
        b=G/fqnVlyueYenyv+L+jDmrUNLvT5FbKWG5yXKAQiJ4rToZTheNDKGTroxt2/OY21uO
         CbsW/KksbMFsY5+JcrGMgnrC6Jr++pW8dT1mVil7z8Rccq9xzc33CSYWSWWjMwsJMuJC
         4Ist1L6kALR12LSc0qiYSA7C1d09DJqk/O17QOVIsZipaVk6r54i/XhZODHJkyXeIkkD
         CIHd7VfrqdSnM29Wv5OvfmI/TEwlYT7IMqrB7mHWU4jO6ESpL1qTtYfsDVVGMDew4up+
         1/9dWTG7XJZXFc6PvXPmBHEr8oVgDUfC+TIZ56GmwriqtA9dKFMksVM/jP04gBXDdePJ
         whcg==
X-Gm-Message-State: ACrzQf3F88ZnDalsJSw7z1IhF4O61mvb6M2NsUI0zBW660Zut/HiOGxY
        9UkLIG6A3Y/E5sWhrD8c4B0=
X-Google-Smtp-Source: AMsMyM6Gtop/ipLAmL+w9SYX5VT78bZu7hhlyg2cE/p7KwrM52FSicwlEtbya4Fc4go6g5AFQ/qjXg==
X-Received: by 2002:a17:907:1deb:b0:78d:4a0e:f654 with SMTP id og43-20020a1709071deb00b0078d4a0ef654mr4260694ejc.757.1665766569596;
        Fri, 14 Oct 2022 09:56:09 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906155600b007081282cbd8sm1784257ejd.76.2022.10.14.09.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:56:09 -0700 (PDT)
Message-ID: <08887454-0ea8-107d-196d-b21b46e357da@gmail.com>
Date:   Fri, 14 Oct 2022 18:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Staging: rtl8192e: fix a brace style issue
Content-Language: en-US
To:     Rigel Di Scala <zedr@zedr.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        rigeld@gmail.com
References: <20221012211612.75871-1-zedr@zedr.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221012211612.75871-1-zedr@zedr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 23:16, Rigel Di Scala wrote:
> Fixed a coding style issue affecting a conditional if statement.
> 
> Signed-off-by: Rigel Di Scala <zedr@zedr.com>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 19d13b3fc..e932ad1a9 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -180,11 +180,10 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
>   
>   	skb = rtllib_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ);
>   
> -	if (skb) {
> +	if (skb)
>   		softmac_mgmt_xmit(skb, ieee);
> -	} else {
> +	else
>   		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
> -	}
>   }
>   
>   static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

