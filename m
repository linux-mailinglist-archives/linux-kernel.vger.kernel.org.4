Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4EE61404C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJaWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:01:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173E140F1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:01:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n12so32732644eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHO3++iCZaM9dl+qOlhIzyeoPvBu+xAAp7dKYAWyoHk=;
        b=jS2WTs2+y11Y1213da7iIpPNmNbAIyuag1zHt2xBmLP9j3e9U8QqkUdrtmpTPWqkns
         o5OOzlXL1cytyPWtdE/kfR/JHxocrZdwy3J/sGKSNd3zfKCtCNLs1Dd4ap3sLDI5dTvx
         cwn2tL+IDstSXgVCvigsSLxafMABFLCnBIVMqUouAO44a+KZxO1LRamFP1OWbGNTUD/6
         AYpVRzbn9Mr8vhsO4W0BF0k1EBzOwO6r5uQE5/PXSwuswwxzFmjipKAhjlpQr9Oo8ZmV
         WyYlw9lmj/JAOyyRVVUcw+5Ir3sS3XgiEbw1OZdeMn5tCbNXJD5J4snD7W4tfv3598P/
         nDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHO3++iCZaM9dl+qOlhIzyeoPvBu+xAAp7dKYAWyoHk=;
        b=HP6o5X8J/kx/gwDHa/g+he3ATdlK7gf7l/2yyHRTD/2BwKGp3vONW5bm3kDDY4vvmS
         zg8mBebfwMVqrZu/Hv9dv9ZWUQAqeQNWS5E1JWd6+YkKInt5K0PokC0DflhylRg6erQg
         HVEl1ttUb9nxVyImNuL7jM9NBuNP3isa8YMbctLHLz7j51VbCcUWwtsg5EjSzYQxNoOp
         1oiYpU1/2NZuWbEnY16C0/X16ABTiAjH5XJsY21sLIurSt6OADHIwghzOKcf7wc9/rCF
         KGWCPWrgXUEt/vz//pAOmdngNch0XnLaaZfmY3fpLUxXjC5z3/XaL20LcikyrUgGTcUh
         AuQw==
X-Gm-Message-State: ACrzQf3M4jGtn65LW1ao9n/bPERYgzi+Wv66SOXIJloBvoNEvEisZ4fj
        rCBmJYua3GviFyR+uN3pLig=
X-Google-Smtp-Source: AMsMyM5P6MmwqkKSPM9M+x1tK/wnVylg/gHshyeXVJE4B+AJeXbYWTSoxXevEvh4cePHeeD6R6vo9w==
X-Received: by 2002:a17:907:7704:b0:780:da38:4480 with SMTP id kw4-20020a170907770400b00780da384480mr15389478ejc.64.1667253693342;
        Mon, 31 Oct 2022 15:01:33 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b007402796f065sm3454893ejr.132.2022.10.31.15.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 15:01:32 -0700 (PDT)
Message-ID: <8bfd6953-a083-5dfc-e333-b8f979e6fcd7@gmail.com>
Date:   Mon, 31 Oct 2022 23:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: clean up
 update_recvframe_phyinfo_88e
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221031205412.124871-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221031205412.124871-1-martin@kaiser.cx>
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

On 10/31/22 21:54, Martin Kaiser wrote:
> Here's three simple cleanups in the update_recvframe_phyinfo_88e function.
> 
> Martin Kaiser (3):
>    staging: r8188eu: use ether_addr_equal for address comparison
>    staging: r8188eu: use hdr->frame_control instead of fc
>    staging: r8188eu: use ieee80211_get_SA
> 
>   drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
