Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B1612A29
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJ3Kj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3Kjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:39:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBDE2BB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:39:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so23035418ejd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYqTXO3cxaJyUvj4QsU8V2dteTiq/1Q+Qyd/LuGBD/Q=;
        b=g+g0bR9Pob12K1+TXDVYIb0y8WqOuxq46Ri2bEkdYn6sti7ZWfMvr81jHAj/v1Wn/y
         vJbw3nPFsVmru1/DgeHVkkNPFjrcqbPULYnPjEAzvj/MunLr1oMTPOV38ZvEQPG93fsn
         XbgfCHvNw2bpJCf0KkM62CH5laynSZ2qs8akGqwkIUWRAwoRdvQ2wrozlsnIq4uZIOB7
         8XAo4xr5Lh9IdUr1xlOFJavLVG6kWbWQsaav6sRR5FFgrj6xcXaqK0VIdnsQHzbLsiQ4
         pCl62vbanVntTL7Tar6fQLjl/MaFC0Cz8WG3+jl8mvE8jxtIM+u4h/m5ACiSurvvlT6u
         gYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYqTXO3cxaJyUvj4QsU8V2dteTiq/1Q+Qyd/LuGBD/Q=;
        b=kbf7tXzH/CASnlVsv0thdEyjrFvG7ZmBVfhrcyFAfUJqp0Mr/95o1ZXebU3O0/Llhh
         RfCUVI+koYA9N8FnGuUkcF6AnFG1BuropIfwYX+a4FYTSKGExt8lGXIZb0J5xfCdbVRZ
         obTyyUYiiRVcN+yDnblfD+0lZ7O6/jLS4jE8QQQjFdVqfrneJeYnv1A2gzDztDOSG+14
         J5bUjQrreBdgK53INrkd9hXJQjUrHddiirrSdwhWUchLzbZiPG9UzyF3d15gx7jL83kH
         bBGvd64Dld3ppb7ch+d1aohqTRu86htqXEASKxzksCkpp/XU0ll48AgPmlgM7ummDOKg
         FsIQ==
X-Gm-Message-State: ACrzQf1IsAqixoLHrlSfOuNA3Ze7C3ApPPD4fZuP41HkfCQ4CDf/CaEO
        7itLn0yBxktrrksdqG7kewk=
X-Google-Smtp-Source: AMsMyM5xPiy5dGPlv3OzudlM6a1HixLr4tzn4Pizdou/xnRCgAyHntBsVi+PlhThG2O0x1gBuFrkGg==
X-Received: by 2002:a17:907:7da5:b0:78e:2c3b:55a2 with SMTP id oz37-20020a1709077da500b0078e2c3b55a2mr7521387ejc.96.1667126393164;
        Sun, 30 Oct 2022 03:39:53 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906538e00b007262a5e2204sm1706272ejo.153.2022.10.30.03.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:39:52 -0700 (PDT)
Message-ID: <cfe7c682-53b9-f30c-c423-8a6c551ac966@gmail.com>
Date:   Sun, 30 Oct 2022 11:39:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: remove the last get_da calls
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221029171011.1572091-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221029171011.1572091-1-martin@kaiser.cx>
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

On 10/29/22 19:10, Martin Kaiser wrote:
> Replace the remaining two get_da calls with ieee80211_get_DA and
> remove get_da.
> 
> Martin Kaiser (2):
>    staging: r8188eu: replace get_da with ieee80211_get_DA
>    staging: r8188eu: remove get_da
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  3 ++-
>   drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  3 ++-
>   drivers/staging/r8188eu/include/wifi.h        | 22 -------------------
>   3 files changed, 4 insertions(+), 24 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
