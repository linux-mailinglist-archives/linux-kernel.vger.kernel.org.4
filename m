Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26B61EADF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKGGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKGGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:22:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28FCEE2A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:22:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f27so27406727eje.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnpRV+RKEKi831sEC3+boeMrq5kKsgR7b+4traW7Org=;
        b=LTio5AnZiJ2/ECwsKEgwzly/F/6/pPkpSNvRDR84K1GY8nYgYtl+Y0lecthSm1sL/z
         vMTPFVBXb25gibDplG0tti8QNrydsABbz0YBWaft8cDnQtLNed3I5zFQf5HkfXiaXIRZ
         ZNeAWQbQlT5pf/KyX0+lsxNkm6kcW17wVRVj9AlLhD8aIQ9D6ZO07XWUtwNjE0BifgIW
         aST8fyXyLX2xtAchYtC03bOfzX8ff1QMC9ZDES5npnnqrDjPfQBzQxDs/t+ni1lfZVjO
         4p+g86n0oILL4/vheWb4ao7Tn3gqV+w4jMsn+35AigsdD50SATt2YmN0z0X5IzdUHT4m
         K70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnpRV+RKEKi831sEC3+boeMrq5kKsgR7b+4traW7Org=;
        b=PXLsLJc5NyTaHApMP3yXZzJ3aD2jPvtqjIsf2sW9wAWhJ+fyISUsmUuJin8ZJxCITR
         2nAf6vuQlMfbX5O5mBpJn3R/dIBFy6fPLJnI5KsXC836uexBmKIWitSIzoxf/NVWtUDD
         WVbEsy5k9N8QAIBrjgNea3m+Bn74eBcgpKRUZp5hNPLU5VhLP7RdIa8YMjPV/aYjkwCQ
         1ZhutWPclw8jGy4POy//kamWUf/tQsk/Ab7DtI36KtIrl9cERpVCaIPilO7W4t1JP8NL
         PiuKnxsbr6qz7y5BjLk7If7U8Y5Py2nsNUZSSjB7jyjixkZAvYuBdGeZMCe4JjFCbwFj
         Gh9w==
X-Gm-Message-State: ACrzQf2BP9709nj7bh9INfnPkBq4SI1uhbquu/vNGmnAE6aHJFMSbp0x
        JzV/KBufEJ34MeBhm0LkZjA=
X-Google-Smtp-Source: AMsMyM6NnAjqds3G9LPHWrxbJamVxExt9r9JQadQSnok2snF/zjbOghyJoO3Aif0t6lax3wZMlOK+g==
X-Received: by 2002:a17:907:25c5:b0:782:978d:c3da with SMTP id ae5-20020a17090725c500b00782978dc3damr44530343ejc.623.1667802158385;
        Sun, 06 Nov 2022 22:22:38 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b007919ba4295esm2917783ejb.216.2022.11.06.22.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 22:22:38 -0800 (PST)
Message-ID: <e6fc2b31-146c-b5bc-dd7a-17ce95f8ed07@gmail.com>
Date:   Mon, 7 Nov 2022 07:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/9] staging: r8188eu: another round of cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221106124901.720785-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221106124901.720785-1-martin@kaiser.cx>
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

On 11/6/22 13:48, Martin Kaiser wrote:
> Here's another patch set with several cleanups throughout the driver.
> 
> Martin Kaiser (9):
>    staging: r8188eu: don't store addba request
>    staging: r8188eu: remove some obsolete comments
>    staging: r8188eu: reorder assignments, clarify the header format
>    staging: r8188eu: reformat a function header
>    staging: r8188eu: remove state checks in rtw_led_control
>    staging: r8188eu: clean up rtw_hal_init
>    staging: r8188eu: remove get_fwstate
>    staging: r8188eu: merge two rtw_free_network_nolock functions
>    staging: r8188eu: remove checks in dump_mgntframe
> 
>   drivers/staging/r8188eu/core/rtw_led.c        |  3 +-
>   drivers/staging/r8188eu/core/rtw_mlme.c       | 23 ++++++---------
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 28 ++++++++-----------
>   drivers/staging/r8188eu/core/rtw_recv.c       |  2 --
>   drivers/staging/r8188eu/hal/hal_intf.c        | 19 +++++--------
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  6 +---
>   drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 15 ++++------
>   drivers/staging/r8188eu/include/rtw_mlme.h    |  7 -----
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  4 +--
>   drivers/staging/r8188eu/include/wifi.h        |  8 ------
>   10 files changed, 36 insertions(+), 79 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
