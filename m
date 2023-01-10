Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB946648EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjAJSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjAJSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:15:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84207BC9C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:13:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bf43so19781553lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCZf2WBtLOTzXQBQ7XL3tPVhljw9HN1j93u/AI/ooGU=;
        b=hsGwcxLTBy8JsyzvX7SpW1KxU3v3zO7ly8b3RA7P15lyLvkkDS0PZRlQqLRCevWKZf
         y2u8Nca0SKXw8ajqOT2FcKja3Lv8ou3Trbkacp5C3noLb4QXdgI3u4dwTcYa+OKboPMV
         4bx65BnpIuzjLdi29q554zSyH/01IyRASWA6OESbSaDgSyc+khb4XGE6dt1/IdyIVidG
         oyEH5W8gyC0+grXRzmsYSVOu8Uvlq6BisrFoFw+4Y5Lg4EcF1x93az0ZEYsBOxynG2nI
         yNSA6Vuox2sHbvjxH3aQxl91zD4AlEPn2nq4s/Xqt9xlqpUHhHx/aeGkdnF5ZrvqmnnY
         s1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCZf2WBtLOTzXQBQ7XL3tPVhljw9HN1j93u/AI/ooGU=;
        b=Ut9GeThgRqJuUUx+Ko1cg4usLjixxkguyVnZo9PcQflZivoVYkUfRvQkElZ6skZ5za
         4YSGJXm2J2STrUDz377PKRHwc5BY+zv9vkoJ82rARAYf08KNnD5wSwGDf0wM1Iw6YKia
         ghg4lJXTvd/DGt3hF4RdFpvw5mU4jDpS7q5hHdgNVezC8t8pKvQHXGo4FKYT9dB3jXoK
         CZyXK6B587TPQWwGYOnbh9wSrZatg6AJil1X+r4CQ3VRQPWn/lAlW1N1/c1g8WWuxYx6
         WvToE1FjFGnfiMcZNmiA7GLJno+doBC2adHwj+Mdw+e5Zn3luIL4hTWgnZG73x/kpFYQ
         YRuQ==
X-Gm-Message-State: AFqh2kqq15lbpIZpq0GYVTXCEH1i95hvjwMt+Gh6XecXFswAs+FEEXmF
        /3XNDh4rB+Hsp7iJel/2cyU=
X-Google-Smtp-Source: AMrXdXvXEtU7t4AC5z7RCDWsq9N1wc4iWBhzX+kpPsHssr2olORkbVGcLPLQiSaicheR88HnGs42/w==
X-Received: by 2002:ac2:5088:0:b0:4b5:688e:ee10 with SMTP id f8-20020ac25088000000b004b5688eee10mr20534317lfm.16.1673374424759;
        Tue, 10 Jan 2023 10:13:44 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e94d0000000b00283f2ddc308sm1034431ljh.137.2023.01.10.10.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:13:44 -0800 (PST)
Message-ID: <af7482cf-c92e-fba7-45bf-c9f89e120638@gmail.com>
Date:   Tue, 10 Jan 2023 21:13:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 00/12] staging: r8188eu: some more xmit cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230108185738.597105-1-martin@kaiser.cx>
 <20230109212852.75612-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20230109212852.75612-1-martin@kaiser.cx>
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

Hi Martin,

Martin Kaiser <martin@kaiser.cx> says:
> Here's another set of xmit cleanups, based on my previous patches.
> 
> changes in v2:
> - drop "make rtl8188eu_inirp_init a void function" patch
>    (we should relay the return value instead of discarding it)
> 
> Martin Kaiser (12):
>    staging: r8188eu: beq_cnt is write-only
>    staging: r8188eu: bkq_cnt is write-only
>    staging: r8188eu: viq_cnt is write-only
>    staging: r8188eu: voq_cnt is write-only
>    staging: r8188eu: replace switch with if
>    staging: r8188eu: dir_dev is unused
>    staging: r8188eu: remove unused hal_xmit_handler define
>    staging: r8188eu: txirp_cnt is write-only
>    staging: r8188eu: remove unused QSLT defines
>    staging: r8188eu: xmit_priv's vcs_type is not used
>    staging: r8188eu: xmit_priv's vcs is not used
>    staging: r8188eu: xmit_priv's vcs_setting is not used
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c       |  5 ---
>   drivers/staging/r8188eu/core/rtw_xmit.c       | 42 -------------------
>   drivers/staging/r8188eu/include/drv_types.h   |  1 -
>   .../staging/r8188eu/include/rtl8188e_xmit.h   | 11 -----
>   drivers/staging/r8188eu/include/rtw_xmit.h    | 10 -----
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 --
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    | 23 +---------
>   7 files changed, 1 insertion(+), 94 deletions(-)
> 

Acked-by: Pavel Skripkin <paskripkin@gmail.com>

Thanks for the update!



With regards,
Pavel Skripkin
