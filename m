Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACC68CF5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBGGN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBGGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:13:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088472ED45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:13:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so12451216wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YY7Kcr6rAneK9CMNK+O4hEjjmplK1sr7DU24Zfh32bg=;
        b=UFdloNJd6gQTwPHrZRaMPwgbknatR/+iuXoJYVLS8NDSvYJ/aw/KhsvqFwDFBVy8Pk
         xztHdpQWdMKT8N87z5rsyiQdsthZSKkxmBaAmTDBjc9Tn4QB/wAHgae9qmSHBSwBJK3n
         XD7HgZv+opIXQUJ0GRl9X2/kExW1/OiUAENHQKlPoFHqDUD7cM/HLyUgcWVEE4PGjZIq
         Td34qZAhx/cs39LdMYOCmlaM4Jb/6Y1ZG63FlzQsB3t92rwYT9sLMIknKwv4WKQ17e/R
         ktK9WSnAmIOT9qNCpVBY4/b2/C9YZjcyYMrJnL/nwWzNxbmYS841rUOy3zbUleT9yyzm
         iLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY7Kcr6rAneK9CMNK+O4hEjjmplK1sr7DU24Zfh32bg=;
        b=2bGEjb1s6eM8VrsDgi9ZXWBkekRnXnqEVZd3jcnObG8Hxu8ijr6xrlPR8bBtPMytUG
         xL2d6s0HG3lHY/QSHPORGUkIcEXFfN3zQSFyaAXK/Uvd/+WvKeb1d/qokt6BP2TpDGtj
         n5iUfoD8wjVSxgYRYFkzg/DXgJKmw1ASOZLnt6ToA3KjBfxlS+AIhqjfRdrnmuIz7sWL
         bUff+p29cpgQDpANiWIwfywUTgfpiV4SJeH+XGqJ5FjAMuggukKui4SRE4JUWfSMvie2
         dtbC1r++zaxHwY7nqhU/RSCvP6lGxZ62IjuXhah2yJZH9R/1WiSVhSaSntkMR4OFqnmZ
         Id8A==
X-Gm-Message-State: AO0yUKVzm0RQWD4XEQ/PhMGf4K3pYuO6u5vHozkU37yrjShk2+E+d4X7
        LpI+8BbfioqgcU/ULBMgx06zUNm16m0=
X-Google-Smtp-Source: AK7set+pRBN4TreCHPmOYsJFumWVa1TgociKpWQMwXxNjdjVldReN8MGxox0Ea6/mtzlerbrXvC+ag==
X-Received: by 2002:adf:f586:0:b0:2bf:d52a:2f39 with SMTP id f6-20020adff586000000b002bfd52a2f39mr949180wro.5.1675750432429;
        Mon, 06 Feb 2023 22:13:52 -0800 (PST)
Received: from [192.168.1.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d4c8c000000b002bfc2d0eff0sm10484831wrs.47.2023.02.06.22.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 22:13:51 -0800 (PST)
Message-ID: <bed49e26-bebe-bcd9-e69d-45981b86bf4e@gmail.com>
Date:   Tue, 7 Feb 2023 07:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/6] staging: r8188eu: remove intf_start and intf_stop
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230206201800.139195-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230206201800.139195-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 21:17, Martin Kaiser wrote:
> Remove the two pointers to media-specific start and stop functions. The
> r8188eu driver supports only usb.
> 
> Update some of the functions in the start and stop paths to return
> standard error codes instead of _SUCCESS and _FAIL.
> 
> Martin Kaiser (6):
>    staging: r8188eu: pass a struct recv_buf to rtw_read_port
>    staging: r8188eu: use standard error codes in rtw_read_port
>    staging: r8188eu: use standard error codes in rtl8188eu_inirp_init
>    staging: r8188eu: remove intf_start pointer
>    staging: r8188eu: handle rtl8188eu_inirp_init errors
>    staging: r8188eu: remove intf_stop pointer
> 
>   drivers/staging/r8188eu/hal/usb_halinit.c   | 16 ++++++--------
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 20 ++++++++---------
>   drivers/staging/r8188eu/include/drv_types.h |  2 --
>   drivers/staging/r8188eu/include/hal_intf.h  |  2 +-
>   drivers/staging/r8188eu/include/rtw_io.h    |  2 +-
>   drivers/staging/r8188eu/os_dep/os_intfs.c   | 12 +++++------
>   drivers/staging/r8188eu/os_dep/usb_intf.c   | 24 +++------------------
>   7 files changed, 26 insertions(+), 52 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
