Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562985FFB1D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJOP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJOP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:56:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8B33A18
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:56:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c22so7962388lja.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noQRZN2ZP8lry0vAqiwCpeRdos+Kq8TILTVK4c4gvCM=;
        b=Dn2I5KA/tXhbk6IPGYja0JueYiCVPHmc9XJF8sv2B4ZOR2uI56gdYEcP7oMUBA689i
         R12OGsTjS42kVQkRRn60Lg4LuSNCOcer3lCRPLSnHCrK7vA3AuiE9zsL36EeVdVjhkoR
         xKgIgHrsEFflpvX5fL2RTAmzKdgzeBL4cDwkTxdqSfnicaSaX40DHmV5+KQTha1K9xi7
         Wqcu1csoVWPvq6Tj8bqGhYiApkX5VODi24Icvo+fLQhvQrUPRBqGB8C2xphRaint993U
         0ieUV41M1pPo8loP68hlu4egW3NNUsYAOi0OZel7X/m5U8WUJ3W0l7vUJTXBH36yhQuC
         VoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noQRZN2ZP8lry0vAqiwCpeRdos+Kq8TILTVK4c4gvCM=;
        b=6F3G28zjHqsEi6H62i1+wJZQI2LgbK4P0kGHLiHTul5dcMQNmET/PEds6BeypZbAp5
         x3WDzhKaPuXuUJu81J7PX5VRpamcCtkGVazzSB3ou3LoH2nIEWnSw/Ym0ShMe2Yz5V6d
         iyuPp9d1CS0xC5cWDo3DdTmu9Ibekka10aNBNiweqZQYZ7PM5ysN3W75D7vAn5UX/uCv
         Xko4bwawiOXDeg8E3jds9A2/Su/aPdqL0egUvKaNpnxziNA83TlPICugPGF+kITZexrn
         zhbOjzTS9kS0oc78pJOkpz53cP/Z+7vSnUTP2uJfg2PNhApM3gbqd90MO9zPaGrGypgR
         I+1g==
X-Gm-Message-State: ACrzQf1QDdGzrP6nmtwpY0+OsKcezJsH6OT+GLwbf6m7mRUAW3TrUorB
        SJ9Q9i8k+LVZC6+zR2ONPcQ=
X-Google-Smtp-Source: AMsMyM406ccu+N2C8OduWfAYER8yoPabSe/u4U/PZNrjPtvci8S6XoseM3boGZEbsnrOFKhL3BqSyw==
X-Received: by 2002:a05:651c:1542:b0:26d:bf29:8cd5 with SMTP id y2-20020a05651c154200b0026dbf298cd5mr1127663ljp.304.1665849369613;
        Sat, 15 Oct 2022 08:56:09 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.224.165])
        by smtp.gmail.com with ESMTPSA id i11-20020ac2522b000000b00499bf7605afsm779667lfl.143.2022.10.15.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:56:09 -0700 (PDT)
Message-ID: <a1aec6a3-a8d1-41c2-b127-0799e10e5f13@gmail.com>
Date:   Sat, 15 Oct 2022 18:56:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/9] staging: r8188eu: clean up the OnDeAuth function
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221015152440.232281-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20221015152440.232281-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> This series cleans up the OnDeAuth function and tries to replace
> driver-specific parsing code with helpers from ieee80211.h.
> 
> Martin Kaiser (9):
>    staging: r8188eu: replace one GetAddr3Ptr call
>    staging: r8188eu: get reason code from mgmt struct
>    staging: r8188eu: clarify the bBusyTraffic assignment
>    staging: r8188eu: use sa instead of Addr2
>    staging: r8188eu: get bssid from mgmt struct
>    staging: r8188eu: exit for deauth from unknown station
>    staging: r8188eu: remove unnecessary return
>    staging: r8188eu: summarize two flags checks
>    staging: r8188eu: ignore_received_deauth is a boolean
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 45 ++++++++++-----------
>   1 file changed, 21 insertions(+), 24 deletions(-)
> 

works for me, thanks

Acked-by: Pavel Skripkin <paskripkin@gmail.com>




With regards,
Pavel Skripkin
