Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780515BC0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISB0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:26:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C299F13DC7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:26:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y5so1613550wrh.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ynf8BM6jjzQ9N1WdDWsGUi9EYZkeBJTfNCxpMRxxtVg=;
        b=l6Zh62E7E0CCyeOR8JA7IrYXRyvSOhl/r/xQUJGZvgf2UqTqp5ArtH+ltTpUKweWUC
         yblBmA54t8aLhA0JBBvuhFsH4cc6Ili3IPeW9WRNPLYurSivGQjIeiYnJYDO66l6xW60
         xOnfbzEZrXqOSXnZYMjAnCxYLpFFIU72wRqF6+VLPi6la+R/J5+OHXnEP4fGf+B2uXaU
         BfhVDGDLVoEn6A3RP91DQgAdQxJTNDjqFQi4VEpyqJ07dpL0Fsf5wbnQJj7sOaj0ney0
         y3Yg6KvKqvfqJs/8cuwX8ZYM2QkMuWdvw1zcWJnt1l/gVN28q3HAX3kJr0dbFK6BVltV
         NlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ynf8BM6jjzQ9N1WdDWsGUi9EYZkeBJTfNCxpMRxxtVg=;
        b=rKwqPsz6JaMuIHJKRoPA3ZADpCLBHvzvCRW5PYB5gCJ+KiXi81Y14jsr6OBbl8eyX7
         UEPCVCdPufLOUwvlRlNxQLUfX1bDvfJqDI/RgBkIWJU+ppIPeNUdbWg60v0jTbSLa6Jo
         AtJMC/gywI2fjG6B6FE9r9qF/vTJ8uuVlMLmhmWWbNvOcV0Ca0FS7LyGvO0RzUzBVBlX
         8PJj///ezJ5aAPOPmVqSAjlF0Vp8dcWQi+9gU/Jw+4vQU6aL+Hk63qAY/XYc+H4DjO6s
         Ff5J2mr8GWfDLs6WuUyLqGV+lNzbtQNbEUvIgI4TrW4eaSPzSN2tv+EPpjGu/y+uC/cu
         /TSA==
X-Gm-Message-State: ACrzQf1bagTrxTqBSp+l+lMhebbrmEXilY+i+ioHU1gjHqwKfqCQbly2
        xU+MYxV/mRB0YwGrEN9HKzM=
X-Google-Smtp-Source: AMsMyM7/zm7nz1X3dBIo4qt+eHp+pJYQXAizm8vqcQCVfBLpicGhmrb8J9DwomTsBYe7NSWD1CVdBw==
X-Received: by 2002:a5d:6e8e:0:b0:21d:ea5:710f with SMTP id k14-20020a5d6e8e000000b0021d0ea5710fmr9314867wrz.48.1663550774283;
        Sun, 18 Sep 2022 18:26:14 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003b31c560a0csm12533675wmq.12.2022.09.18.18.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 18:26:13 -0700 (PDT)
Message-ID: <5d963f53-f4df-a019-b9da-fb266977e034@gmail.com>
Date:   Mon, 19 Sep 2022 03:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] staging: r8188eu: another round of led layer cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220918175700.215170-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220918175700.215170-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 19:56, Martin Kaiser wrote:
> Here's some more cleanups for the led layer. This series should be applied
> on top of the "staging: r8188eu: more led cleanups" series I sent on Sep
> 11th.
> 
> Martin Kaiser (6):
>    staging: r8188eu: cancel blink_work during wps stop
>    staging: r8188eu: update status before wps success blinking
>    staging: r8188eu: remove bLedNoLinkBlinkInProgress
>    staging: r8188eu: remove BlinkingLedState
>    staging: r8188eu: remove duplicate bSurpriseRemoved check
>    staging: r8188eu: remove two unused enum entries
> 
>   drivers/staging/r8188eu/core/rtw_led.c    | 104 +++-------------------
>   drivers/staging/r8188eu/include/rtw_led.h |   8 --
>   2 files changed, 12 insertions(+), 100 deletions(-)
> 

Observed LED. All OK

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
