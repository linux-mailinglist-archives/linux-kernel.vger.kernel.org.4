Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225A5E961C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiIYVGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIYVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:05:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D427170
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:05:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd10so10405375ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=a4qcMZXDxN4eP7v1btEoZe17jDw7PgjqyrZUAWz1Vwk=;
        b=g4zMkvgshqqI4hTH/sym59ZjJkU/SYj4qcZ0CzJWY0Rz0/6dgz5AzMWBISEev0Tj8h
         kkfSiKENjq53RXVM/oEtyJlnJ8df/k+PtZgg48d70xwXKVxGBNylY0XPQlHhvvysQruj
         9B46heVszRxkS6FXlzHMt95vF2Q+eJBQV06qtJDD9eiExMThJDqJ56mh2vghGOQeT6SU
         OrAje5rjvcSnMA1KFSiYNl6Ap1oc55+TYbXaQjjwiJ0pQ3gcWuhvgPxo9husNfXVMO6l
         Ihs5naWC3P3LF+DII+29CsJvWKF1EeSjUokM4VlkU3hThkHyPeXyVnfVD8Ykkkj/CytY
         hZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=a4qcMZXDxN4eP7v1btEoZe17jDw7PgjqyrZUAWz1Vwk=;
        b=1zx0uhOqR0ZtvUboD6XsjYGje8ZpuD1psKAkQhHHn7u8gS1uv4axTsZGnMay9f0l/e
         G7neT8kzaamzMmjbNEzvVATa0GyDsdUeP3GxB1wszSSYH1fOpxBpxRelrqbZwIn8zOwt
         mL+nRYhk9zhhjHxd9QJJ3RWT7VoKnUROKhHTTdkJX1afD7BtTLg448/QHHIiGfgsqR5h
         UxvmfWEd/0uj7GWBtwcO9bkrQypA+L3v3/8vNjwlueWdxzD4ZWcA/hbcjEH+Tgkstzz3
         jU5FzFcT0IaL+xVMru1HQBxbkooquikYXjUyxZeSACeqWGe/cTLfcRKK1V+OTtlKMntk
         845A==
X-Gm-Message-State: ACrzQf1qxrtQPZfJ4ldjZ7KavI2czQLrXPZw9PNXpZqF4SFYr0ghI0x/
        L4Taebsrxc+WDDey1JP6drs=
X-Google-Smtp-Source: AMsMyM5hcUZAHyDhsGV2je/Axq/RhxGNyeQ8VJ7u+8AUBu+qtiK3zVotYkCuQGIVLY9HH5cS4a3sgA==
X-Received: by 2002:a17:907:75f7:b0:77b:4579:2aee with SMTP id jz23-20020a17090775f700b0077b45792aeemr15386515ejc.529.1664139954591;
        Sun, 25 Sep 2022 14:05:54 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b007813968e154sm6933846ejc.86.2022.09.25.14.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 14:05:54 -0700 (PDT)
Message-ID: <c6677024-0c7f-65c6-f7d0-5916840c9a4f@gmail.com>
Date:   Sun, 25 Sep 2022 23:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: drop some stop/removed checks in
 the led layer
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220925140406.112991-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220925140406.112991-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 16:04, Martin Kaiser wrote:
> Here's two small patches that remove unnecessary checks of
> bSurpriseRemoved and bDriverStopped in the led layer.
> 
> Martin Kaiser (2):
>    staging: r8188eu: don't check bSurpriseRemoved in SwLedOff
>    staging: r8188eu: don't check for stop/removal in the blink worker
> 
>   drivers/staging/r8188eu/core/rtw_led.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Quick download test is working.
Observed LED is working fine

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
