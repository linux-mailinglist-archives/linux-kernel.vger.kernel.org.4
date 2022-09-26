Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17605EB20E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIZU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:27:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11AA2638
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so16513844ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hlnrz4yCnvX1M7hPStALLLhNjhON2Run8LllG3n3u0g=;
        b=FwYk9nWMFGZT9RjTc2BcrFGikfbyKs1Wdc5OCBr3Ul8vUtW0Uinl/2WxKuX1NGa1aH
         7V01nwObDC5kQhgIPrW9pHZU874MKssNlBZgfOnk8QvpxLiPk/1pS4IaCmOY6qdP1N0t
         ii5mNm/agFrysSFErePQlNpx+YHf1eftvk8eqyEw7PSe6dcNA9KjTi/wncX7Y97qX7mC
         /IuIAO9+Tak79D5BAt10K3L17etLVEhT6T59IFReZ2GiCOWCf1bu/R+hWpQ9FvcNv9FU
         mr1YdQqm5wUgLuM8bGiNo3FODCj+2t3MCx7a9IMvVTvSOJ7Q6P3wNlbQkUdl6m1sU1/C
         uSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hlnrz4yCnvX1M7hPStALLLhNjhON2Run8LllG3n3u0g=;
        b=AmVkScM2FWsQTWVZm+XaCZfzQzK14ucfJ+r1PQpLnM+77k05/j1L2KK2CsH5+9c1xv
         hiyOIvnrM5fWv8KlJHSQx7U6jrgbAAdJFssAC/HpwTO/T/teaUHgGUPeN9IN7QCtqTD8
         ZB+eu22YUxnGHUIZJYwNGpDqE1ShqV3C4h7iVAIds2nJNapFIQydr7t1068H6u7f1WNY
         EY/JXE/uRbsUC7pxz82mw8wumNlnN2QZ2nF7vQTeAG3+KviaqlhDrXJdzdcQlzhw42Kl
         IyNnCzqO/vUq4a3gFPUml0lRUeueTWNBuOCWUqcTeFJAILO7V3tc9UFdcEdo5CeNY6T+
         /gvQ==
X-Gm-Message-State: ACrzQf0TJrO93audYwfnkoHMyviebnlDtnarZABENC4PtJWUp8Sk4mL/
        SCzqJKETR2l2mZpCHeCoUTQ=
X-Google-Smtp-Source: AMsMyM6/Gs5TP5XodNNXW2Uc0XhOB9aaScjlfrznq+SqGA3d+Q5GtatXkNu9DfHLmac0yAvZqIi/kw==
X-Received: by 2002:a17:907:75e3:b0:77a:2378:91ba with SMTP id jz3-20020a17090775e300b0077a237891bamr19642832ejc.738.1664224039681;
        Mon, 26 Sep 2022 13:27:19 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906830100b0072b33e91f96sm8832547ejx.190.2022.09.26.13.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 13:27:18 -0700 (PDT)
Message-ID: <7849153c-f973-8a31-49ba-37e07e81a773@gmail.com>
Date:   Mon, 26 Sep 2022 22:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: remove odm_RegConfig8188E.c
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220926173243.8767-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220926173243.8767-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 19:32, Michael Straube wrote:
> This series removes hal/odm_RegConfig8188E.c and its header
> odm_RegConfig8188E.h by making the functions defined in that file
> static.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (3):
>    staging: r8188eu: make odm_ConfigMAC_8188E() static
>    staging: r8188eu: make odm_ConfigRF_RadioA_8188E() static
>    staging: r8188eu: remove hal/odm_RegConfig8188E.c
> 
>   drivers/staging/r8188eu/Makefile              |  1 -
>   .../staging/r8188eu/hal/HalHWImg8188E_BB.c    | 50 +++++++++++
>   .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  5 ++
>   .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 30 +++++++
>   .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 89 -------------------
>   .../r8188eu/include/odm_RegConfig8188E.h      | 21 -----
>   .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
>   7 files changed, 85 insertions(+), 112 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
>   delete mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
