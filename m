Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD250639B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0Opg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiK0Opd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:45:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25AF583
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:45:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m19so11083006edj.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVJk3qEaUc/rcmLQxIcSGjFuecC7PxvDe1/aZEEm9h8=;
        b=O+dKfA018cBRltgdnZ0kfHMokyhqUvAHSz8GMsGY5FjFA+ODkR20n4Jvbq8sDuCQtp
         0B0wDKaFGzDyFf2n+td41rYD/qKqHpHattAto4+tpoxvKiwhN5wWxM4wnpS6TRbkBoF9
         GujqQuEQPJouLcFU0MfD88Q8y2SmO3jn9RrBk2kIu3elDsmNizIpXuZrw3QtZipHJEA1
         qRRodPuHGj4pw5rkrizjHZfmg+yM51JLPYBTpCYo8WCFAUT42/wYS9UpJVIlyHkP7j+n
         +Mu7GtZFr+mGjdOI1UPJfpumEOjW30TgCla15W5Fi7fnsH9P9wI6j0SXzvnVWmqT5vex
         Pkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVJk3qEaUc/rcmLQxIcSGjFuecC7PxvDe1/aZEEm9h8=;
        b=ijGXiFFH4MUCSUxWd2d1m38mwBYg/DGXBvptTvnSUKnH5YniTm36vDnGpdCb9HkZOx
         P+ZH/nlOK2h1++/qJBwnXSFePrqOqgdxAq4IEsB+ZDw+Sbd6ZjDroz6eBRlU1ULVzOyE
         i2JgBUQGT63aMU5G5uKu0uTdUfOIDnxpWs9ccR8uzCS2+/Bt8PSR1NHaFurSFXbZo5R5
         faYoaq/ftUeS2LpcYB2uGnpGzwiXTsj4jW8xUCpKa8IxFCWnEu0ligYV/fz+Dy4iLmA6
         8HabZkkYmBX1a9jltLbWHe/wKh7IOJ+SYMZOPPnRRZAZBAgvywOEmL1IfLYIvEoRKp1I
         eAKw==
X-Gm-Message-State: ANoB5pnsnH21V1bdO5iPlFax0QOj/Aal+jiRzdGWPhMrtYxU60ER4/Ao
        YL6mJz43FGvkIweENgnG7Q8=
X-Google-Smtp-Source: AA0mqf6FVtSclvEAKJPMgfwKWB/HZcfp+eM2wYuj5fNx25DLgLUQhOICc11h7SQO7DmeijQOj8Z87g==
X-Received: by 2002:a05:6402:1c04:b0:462:6ace:c522 with SMTP id ck4-20020a0564021c0400b004626acec522mr42735926edb.91.1669560326886;
        Sun, 27 Nov 2022 06:45:26 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906190900b007bf988ce9f7sm441861eje.38.2022.11.27.06.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:45:26 -0800 (PST)
Message-ID: <64393639-cd1d-ec74-01e4-67f0b208d725@gmail.com>
Date:   Sun, 27 Nov 2022 15:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] staging: r8188eu: clean up OnBeacon
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221126160129.178697-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221126160129.178697-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/22 17:01, Martin Kaiser wrote:
> This series cleans up the OnBeacon function. It tries to replace
> driver-sepcific message parsing with ieee80211 helper functions.
> 
> Please apply this after the "another round of cleanups" series.
> 
> Martin Kaiser (10):
>    staging: r8188eu: replace one GetAddr3Ptr call
>    staging: r8188eu: read timestamp from ieee80211_mgmt
>    staging: r8188eu: replace GetAddr2Ptr calls
>    staging: r8188eu: pass only ies to process_p2p_ps_ie
>    staging: r8188eu: use ie buffer in update_beacon_info
>    staging: r8188eu: simplify update_sta_support_rate params
>    staging: r8188eu: exit if beacon is not from our bss
>    staging: r8188eu: stop beacon processing if kmalloc fails
>    staging: r8188eu: simplify error handling for missing station
>    staging: r8188eu: remove a variable
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 130 ++++++++----------
>   drivers/staging/r8188eu/core/rtw_p2p.c        |  11 +-
>   drivers/staging/r8188eu/core/rtw_wlan_util.c  |   9 +-
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |   3 +-
>   4 files changed, 66 insertions(+), 87 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
