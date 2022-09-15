Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6605B9598
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIOHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIOHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:42:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC392F5D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:42:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so1304557plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date;
        bh=quLbesHK1sclIUgYAXvNPWiEr9BuvEDuzROq3QVsdiA=;
        b=TLWJoMPWO4QOdq+abuIlVjwq045uGgoff/nYx8t1moo3ZErq+y6Ytw3niCJ7tp4WfG
         ImwzE+k2zQ+B2KPJ+ygHyWd6J7qSgGwRIa/1l1PxFeZ1GN94TBinF0nyTQ1/lMLxlxYL
         LyTDBUZs2behva7+Zpbv7HvaH6a2GcnsMYXKI2xO5Hrfle3klChj2qoqbam7K/33KH04
         MG8HbzwOtgkQXizjQFKu03px0q84gzm1X0StkRA8SJxostEKCR8f7DHozz+yiIrnofFI
         dqZKHFQds4H+aJFoqaZ71SUkT0qoUjuJMxkn2hGKb5DwyiGa9ZWcLgOxDCkfecK9ZeoU
         olvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date;
        bh=quLbesHK1sclIUgYAXvNPWiEr9BuvEDuzROq3QVsdiA=;
        b=SpiTKRtXwTzThyjB+wh54h73y5+KtVYGve5w3lj+frrCVSYId3rnfGgAAuvuRY8085
         tOZ2l1zmYaHyl7A+JvHDUj8jaubhvloC2v/hciKceplyYLKbV71etGiqJ8DDc/dhvwbs
         IoaSlnr9J7HT6pzFn6qitDd22osCLB0zN5NYzOTnJqY6qDO3tNTgv/SenO/tTv3hBAf4
         HvvTd6lWc86Qy0O5XMyWF/s4rhu7pAfw5kVYESt3QS4GQ8jo9muqM7mUpcRPcbLKk1lL
         NldkD6I9Xiuagmgl6JiSy80k7aJvg9F2a58TFxR1uyZyUituY2C1BZgHkkomSLinG/o8
         vj8A==
X-Gm-Message-State: ACrzQf3e3rJzxFdEnlBburHM/nnSFy2VE5ot/hbXMFjo6TXxDnB3us9r
        ckjfjYMugYnGxZRqK1wqu4Pt30uzPos=
X-Google-Smtp-Source: AMsMyM6UwY22j+sGWugER6jLNc5tapANAV8AQ4gMs7BwXgPT1my8OySqrIcWSAB7281PRCbLYwkV+w==
X-Received: by 2002:a17:903:32c1:b0:176:d67b:cf70 with SMTP id i1-20020a17090332c100b00176d67bcf70mr3119169plr.117.1663227742259;
        Thu, 15 Sep 2022 00:42:22 -0700 (PDT)
Received: from [10.1.1.24] (122-58-18-24-fibre.sparkbb.co.nz. [122.58.18.24])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b0054097cb2da6sm11597154pfk.38.2022.09.15.00.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 00:42:21 -0700 (PDT)
Subject: Re: [PATCH] m68k: fix the comments of via_rtc_send
To:     Deming Wang <wangdeming@inspur.com>, funaho@jurai.org,
        geert@linux-m68k.org
References: <20220915014737.1620-1-wangdeming@inspur.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1e8ed681-9a73-d45a-97bd-9d75d2323f82@gmail.com>
Date:   Thu, 15 Sep 2022 19:42:17 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220915014737.1620-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we go again ...

In the interest of avoiding further patches of this nature, can we 
please change the comment to read:

'The bits of the byte go into the RTC in MSB order'

That ought to make it abundantly clear the duplicate 'in' isn't. (As 
would have looking at comment in the the function just before 
via_rtc_send() ...)

Cheers,

	Michael

Am 15.09.2022 um 13:47 schrieb Deming Wang:
> remove the double word of 'in'.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  arch/m68k/mac/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index 4fab34791758..29a4cb46af01 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
>
>  	reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
>
> -	/* The bits of the byte go in in MSB order */
> +	/* The bits of the byte go in MSB order */
>
>  	for (i = 0 ; i < 8 ; i++) {
>  		bit = data & 0x80? 1 : 0;
>
